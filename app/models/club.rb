class Club < ActiveRecord::Base
  has_many :table, dependent: :destroy
  before_save :create_tables

  validates :tables_count, :name, presence: true
	validates :tables_count, numericality: { grater_than_or_equal: 1 }
	validates :tables_count, presence: true

  protected
    def create_tables
      self.tables_count.times do
        self.table << Table.new
    end
  end
end
