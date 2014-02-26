class Club < ActiveRecord::Base
  has_many :table, dependent: :destroy
  #Тут закомменченно из-за того, что валидация не работает
  #after_validation :create_tables

  validate :tables_count, :name, presence: true
	validate :tables_count, numericality: { grater_than_or_equal: 1 }
	validate :tables_count, presence: true

 # protected
    #def create_tables
   #   self.tables_count.times do
  #      self.table << Table.new
 #     end
#    end
end
