ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :phone, :name, :owner_clubs

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User details" do
      f.input :name
      f.input :phone
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :owner_clubs
    end
    f.actions
  end
  
end
