ActiveAdmin.register Invite do
  
  permit_params :email, :phone, :name
  form do |f|
    f.inputs "User details" do
      f.input :name
      f.input :phone
      f.input :email
    end
    f.actions
  end
  
end
