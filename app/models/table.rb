class Table < ActiveRecord::Base
  belongs_to :club
  has_many :order
  #validate :orders_cannot_intersect, on: :add_order

  def status time
    orders = self.order
    order = orders.find{|o| time < o.until}
    return :free if not order or order.since > time.tomorrow.midnight
    return :busy if order.since < time
    return :booked if order.since > time
  end

  def add_order new_order
    self.order << new_order
  end

end
