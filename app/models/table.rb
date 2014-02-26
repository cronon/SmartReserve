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
    new_order.table = self
    if new_order.valid?
      self.order << new_order
    else
      errors.add(:order, new_order.errors)
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

end
