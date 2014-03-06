class Order < ActiveRecord::Base
  belongs_to :table
  attr_accessor :confirmation_code

  validate :until_should_be_later_than_since,
          :since_cannot_be_in_the_past,
          :until_cannot_be_in_the_past,
          :orders_should_not_intersect
  validates :confirm_code, presence: :true, :if => Proc.new { |a| a.confirm_code.hash == a.token }
  validates :phone, format: { with: /\A\+\d{12}\z/,
    message: "%{value} Invalid phone number" }

  def prepare params
    
    result = Order.new params
    token = generate_token
    send_sms(params[:phone], token)
    result.token = generate_token.hash
    result
  end

  def send_sms phone, token
    puts '########', phone, token
  end

  def generate_token
    (Time.now.nsec*rand() % 10000000).floor
  end

  def intersects? other_order
    self.until.between? other_order.since, other_order.until or \
      self.since.between? other_order.since, other_order.until
  end

  def confirm_code
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
