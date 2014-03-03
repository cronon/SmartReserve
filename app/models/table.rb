class Table < ActiveRecord::Base
  belongs_to :club
  has_many :order
  after_save :save_orders
  after_initialize :set_orders

  class Time
    def now?
      self.between? Time.now - TIMEOUT, Time.now + TIMEOUT
    end
  end

  def status time
    return :busy if self.status_now == :busy and  time < self.updated_at + self.club.time_after
    order = @orders.find{|o| time < o.until and time > o.since}
    return :free if not order
    if order.since - time > 30.minutes and time.now?
      return :free
    else
      return :booked
    end
    return :free if self.status_now == :busy and  time > self.updated_at + self.club.time_after
  end

  def add_order new_order
    new_order.table = self
    @orders << new_order
  end

  def will_free(time)
    orders = self.order.select{|o| o.until > time}.
                        sort{|a,b| a.since<=>b.since}
    return 0 if orders.empty?

    result = orders.first.since < time ? orders.first.until : orders.first.since
    begin
      order = orders.shift
      return result - time if order.nil? or (result + self.club.time_after + self.club.time_before) < order.since 
      result = order.until
    end while true
    result - time
  end

  private
    def save_orders
      @orders.each do |o|
        o.table_id = self.id
        if not o.save
          errors.add(:order, o.errors)
          raise ActiveRecord::RecordInvalid.new(self)
        end
      end
    end
    def set_orders
      @orders = self.order
    end
end
