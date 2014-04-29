class Order < ActiveRecord::Base
  belongs_to :table
  belongs_to :user
  #attr_reader :table

  validate :cannot_book_at_the_past,
          :orders_should_not_intersect,
          :validate_code

  validates :phone, format: { with: /\A\+\d{12}\z/,
    message: "is invalid" }
  validates :table_id, presence: true, :numericality => {greater_than: 0}

  class << self
    
    def prepare params 
      result = Table.find(params[:table_id] || Table.last.id).new_order_at params[:time]
      result.attributes = params
      token = generate_token    
      result.token = token.hash.to_s
      result.confirmation = token
      if result.valid?
        send_sms(params[:phone], token)
      end
      puts result.serializable_hash
      puts result.errors.to_json
      result
    end

    def send_sms phone, token
      puts '########', phone, token
    end

    def generate_token
      (Time.now.nsec*rand() % 10000000).floor.to_s
    end

    #start from Time.now
    def per_today
      interval = @@intervals[:today]
      per_interval interval.first, interval.second
    end

    #example date_start: 12.04.2014 
    def per_interval (date_start, date_end)
      Order.where('time > ?', date_start).where('time < ?',date_end)
    end

    def intervals
      @@intervals
    end

    #max columns on lower order stat table for clubs/:id/orders
    MAX_COLUMNS = 30

    #Calculate parameters lower tables for clubs/:id/orders
    #per start and end time; parameters: array with DateTimes for 
    #columns
    def calculate_params_lower_stat_table(start_date, end_date)
      minutes_intervals = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
      diff_in_sec = (end_date - start_date).abs
      minutes_granularity = (diff_in_sec/60 / MAX_COLUMNS).ceil
      puts "calculate_params_lower_stat_table: minutes_granularity = #{minutes_granularity}
      minutes_intervals = #{minutes_intervals}"
      minutes_intervals.each do |gran|
        if minutes_granularity <= gran
          minutes_granularity = gran
          break
        end
      end

      count_columns = 0
      hours_minutes = []

      #паранойя меня взяла под ночь, потом сие удалить
      start = [start_date, end_date].min
      real_end =  [start_date, end_date].max

      while start < real_end
        hours_minutes << start
        start += minutes_granularity.minute
        count_columns += 1   
      end 

      hours_minutes
    end

    #PRIVATE!!!
    private

    def today_start
      ymd = DateTime.now.strftime("%Y.%m.%d")
      DateTime.parse("#{ymd} 00:00:00")
    end

    def yesterday_start
      ymd = DateTime.yesterday.strftime("%Y%m%d%H")
      DateTime.parse("#{ymd} 00:00:00")
    end

  end

  #intervals for clubs/:id/orders
  @@intervals = 
  {
    :yesterday  => [yesterday_start.utc, (yesterday_start+ 24.hour).utc], 
    :today      => [today_start, DateTime.tomorrow], 
    :week       => [today_start - 7.day, DateTime.tomorrow], 
    :month      => [today_start - 1.month, DateTime.tomorrow], 
    :three_months => [today_start - 3.month, DateTime.tomorrow], 
    :year       => [today_start - 1.year, DateTime.tomorrow]
  }

  def cannot_book_at_the_past
    errors.add(:time, "cannot be in the past") if self.time+TIMEOUT<Time.now
  end

  def intersects? other_order
    self.until.between? other_order.since, other_order.until or \
      self.since.between? other_order.since, other_order.until
  end

  def validate_code
    puts self.confirmation.hash, self.token
    if self.confirmation.hash.to_s != self.token
      errors.add(:code, "is invalid")
    end
  end

  def until_cannot_be_in_the_past
    if self.until + TIMEOUT < Time.now 
      errors.add(:until, "can't be in the past")
    end
  end

  def since_cannot_be_in_the_past
    if self.since + TIMEOUT < Time.now
      errors.add(:since, "can't be in the past")
    end
  end
 
  def until_should_be_later_than_since
    if self.until < self.since
      errors.add(:until, "can't be later than since")
    end
  end

  def orders_should_not_intersect
    return true if not self.table
    if self.table.order.find{|o| (self.intersects? o) and (not o==self)}
      errors.add(:base, "Time #{self.until} is already booked!")
    end
  end

end
