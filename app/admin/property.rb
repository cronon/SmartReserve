ActiveAdmin.register Property do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  permit_params do
   permitted = [:kind_en,:kind_ru,:name_en,:name_ru]
   permitted
  end
  
end
