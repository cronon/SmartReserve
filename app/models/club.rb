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
  has_many :photos
  has_many :news, dependent: :destroy
  mount_uploader :avatar, ImageUploader
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :properties
  belongs_to :user
  before_create :create_tables
  after_initialize :set_time_last
  attr_reader :schedule
  accepts_nested_attributes_for :photos, :allow_destroy => true

  validates :tables_count, :name, presence: true
  validates :tables_count, numericality: { grater_than_or_equal: 1 }

  ajaxful_rateable :stars => 5, :dimensions => [:rating]
  def will_free time
    self.table.map{|t| t.will_free(time)}.min
  end

  def whether_order? time
    time < schedule_at(time)[:closes] and \
      time > schedule_at(time)[:opens] and \
      convert_time(time) < convert_time(@time_last)
  end

  def schedule_at time
    result = {}
    day = time.to_date.abbr_dayname.downcase.to_sym
    result[:opens] = Time.parse(self.send(day.to_s+'_opens') || '8:00')
    result[:closes] = Time.parse(self.send(day.to_s+'_closes') || '23:00')
    result.each do |k,v|
      result[k] = Time.new(time.year,time.month,time.day,v.hour,v.min,v.sec)
    end
    result[:closes]+=1.day if result[:closes]<result[:opens]
    result
  end

  def set_time_last
    #почему это время существует одно, а не для каждого дня отдельно?
    #заказчик так пожелал
    @time_last = Time.parse(self.time_last) unless self.time_last.blank?
  end

  protected
    def create_tables
      self.tables_count.times{ self.table << Table.new } if self.tables_count
    end

    def convert_time time #converts datetime to time
      Time.at(time.hour * 60 * 60 + time.min * 60 + time.sec)
    end
  end

