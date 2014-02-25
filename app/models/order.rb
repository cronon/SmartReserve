class Order < ActiveRecord::Base
  belongs_to :table

  validate :until_should_be_later_than_since,
          :since_cannot_be_in_the_past
          :until_cannot_be_in_the_past

  def until_cannot_be_in_the_past
    if self.until < Time.now
      errors.add(:until, "can't be in the past")
    end
  end

  def since_cannot_be_in_the_past
    if self.since < Time.now
      errors.add(:since, "can't be in the past")
    end
  end
 
  def until_should_be_later_than_since
    if self.until < self.since
      errors.add(:until, "can't later than since")
    end
  end
end
