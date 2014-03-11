class Order < ActiveRecord::Base
  belongs_to :table
  attr_accessor :confirmation_code

  validate :cannot_book_at_the_past,
          :orders_should_not_intersect,
          :validate_code

  validates :phone, format: { with: /\A\+\d{12}\z/,
    message: "is invalid" }

  def self.prepare params  
    result = Table.find(params[:table_id]).new_order_at params[:time]
    result.attributes = params
    token = generate_token    
    result.token = token.hash.to_s
    result.confirmation_code = token
    if result.valid?
      send_sms(params[:phone], token)
    end
    puts result.serializable_hash
    puts result.errors.to_json
    result
  end

  def self.send_sms phone, token
    puts '########', phone, token
  end

  def self.generate_token
    (Time.now.nsec*rand() % 10000000).floor.to_s
  end

  def cannot_book_at_the_past
    errors.add(:time, "cannot be in the past") if self.time+TIMEOUT<Time.now
  end

  def intersects? other_order
    self.until.between? other_order.since, other_order.until or \
      self.since.between? other_order.since, other_order.until
  end

  def validate_code
    puts self.confirmation_code.hash, self.token
    if self.confirmation_code.hash.to_s != self.token
      errors.add(:code, "is invalid")
      false
      raise ArgumentError
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
