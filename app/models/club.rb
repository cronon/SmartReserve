class Club < ActiveRecord::Base
  has_many :table, dependent: :destroy
  after_validation :create_tables


  protected
    def create_tables
      self.tables_count.times do
        self.table << Table.new
      end
    end
end
