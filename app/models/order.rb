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
    :today      => [today_start , today_start + 24.hour], 
    :week       => [today_start - 7.day,    today_start], 
    :month      => [today_start - 1.month,  today_start], 
    :tree_month => [today_start - 3.month,  today_start], 
    :year       => [today_start - 1.year,   today_start]
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
