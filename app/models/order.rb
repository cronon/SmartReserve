class Order < ActiveRecord::Base
  belongs_to :table

  validate :until_should_be_later_than_since,
          :since_cannot_be_in_the_past,
          :until_cannot_be_in_the_past,
          :orders_should_not_intersect

  def intersects? other_order
    self.until.between? other_order.since, other_order.until or \
      self.since.between? other_order.since, other_order.until
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
    if self.table.order.find{|o| self.intersects? o}
      errors.add(:base, "Time #{self.until} is already booked!")
    end
  end
end
