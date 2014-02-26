class Club < ActiveRecord::Base
  has_many :table, dependent: :destroy
<<<<<<< HEAD
  before_save :create_tables

  validates :tables_count, :name, presence: true
	validates :tables_count, numericality: { grater_than_or_equal: 1 }
	validates :tables_count, presence: true
=======
  after_validation :create_tables

  validates :tables_count, :name, presence: true
	validates :tables_count, numericality: { grater_than_or_equal: 1 }
>>>>>>> fd0e28b899ec9a625996f1248eb52d8265706134

  protected
    def create_tables
      self.tables_count.times do
        self.table << Table.new
<<<<<<< HEAD
    end
  end
=======
      end
    end
>>>>>>> fd0e28b899ec9a625996f1248eb52d8265706134
end
