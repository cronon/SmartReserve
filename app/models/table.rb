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

    def will_free(time_from_which_assume)
    orders = sort_order_by_since(self.order)

    puts "ORDERS = #{orders.size} empty? = #{orders.empty?}"

    wrap_order = orders.find{ |order| time_from_which_assume < order.until}

    return 0 if wrap_order.empty?
    order = wrap_order.first

    result = order.until - time_from_which_assume
    if time_from_which_assume.between? order.since, order.until
      next_index = orders.index order
      if next_index < (orders.size - 1)
        order_next = orders[next_index]
        @interval = self.club.average_time
        if order_next.since - order.until < @interval
          result = order_next.until - time_from_which_assume
        end
      else
        return 24*60.minute
      end
    end
    result

  end

  private

    def sort_order_by_since(orders)
      arr_since = orders.map{ |order| order.since}.sort!
      sorting_orders = arr_since.map{|s| orders.}

    end

end
