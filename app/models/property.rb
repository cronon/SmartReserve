class Property < ActiveRecord::Base
  has_and_belongs_to_many :clubs

  def kind
    self.send(('kind_'+I18n.locale.to_s).to_sym)
  end
  def name
    self.send(('name_'+I18n.locale.to_s).to_sym)
  end
end