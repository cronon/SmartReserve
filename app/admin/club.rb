ActiveAdmin.register Club do
  permit_params(:name, :mon_opens, :mon_closes, :phone,
    :user_id, :avatar, :city, :address, :site, :email, :property_ids)

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :user_id
    column :phone
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :user

  form do |f|
    f.inputs "Club details" do
      f.input :name
      f.input :phone
      f.input :email
      f.input :site
      f.input :address
      f.input :city
      f.input(:user_id, :as => :select, 
        :collection => Hash[User.where(:owner_clubs => true).map{|b| [b.name + ' ' + b.email,b.id]}]
        )
      f.input(:properties, :as => :check_boxes, 
        :collection => Hash[Property.all.map{|b| [b.name,b.id]}]
        )
      f.input :avatar
    end
    f.actions
  end
  
end
