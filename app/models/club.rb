class Date
  def dayname
     DAYNAMES[self.wday]
  end

  def abbr_dayname
    ABBR_DAYNAMES[self.wday]
  end
end

class Club < ActiveRecord::Base
  has_many :table, dependent: :destroy
  before_create :create_tables
  after_initialize :set_schedule
  attr_reader :schedule

  validates :tables_count, :name, :schedule, presence: true
  validates :tables_count, numericality: { grater_than_or_equal: 1 }
  validates :tables_count, presence: true

  def will_free time
    self.table.map{|t| t.will_free(time)}.min
  end

  def whether_order? time
    time < @schedule[time.to_date.abbr_dayname.downcase.to_sym][:closes] and \
      time > @schedule[time.to_date.abbr_dayname.downcase.to_sym][:opens] and \
      time < self.time_last
  end

  def set_schedule
    @schedule = {}
    [:mon,:tue,:wed,:thu,:fri,:sat,:sun].each do |day|
      @schedule[day] = {
        :opens => Time.parse(self.send(day.to_s+'_opens') || '8:00'),
        :closes => Time.parse(self.send(day.to_s+'_closes') || '23:00')
      }
    end
    @schedule
  end

  protected
    def create_tables
      self.tables_count.times{ self.table << Table.new } if self.tables_count
    end
  end

