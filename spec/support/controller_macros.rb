module ControllerMacros
  # # only for controllers that inherits from Devise's
  # def user_devise_mapping
  #   before :each do
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #   end
  # end
  def login_user(email, role = '')
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.where(email: email).first
      unless user
        user = FactoryGirl.build(:user, email: email, roles: [role])
        user.save!
      end
      sign_in user
    end
  end

  def login_admin
    login_user('admin@local.ru', 'admin')
  end

  def login_editor
    login_user('editor@local.ru', 'editor')
  end

  def mock_item(model_class, stubs = {}, null_object = false)
    before(:each) do
      @mock_item ||= {}
      model_index = model_class.name.underscore
      @mock_item[model_index] ||= mock_model(model_class, stubs)
      @mock_item[model_index] = @mock_item[model_class.name].as_null_object if null_object
    end
  end
end


# module ControllerMacros
#   def user_devise_mapping
#     before :each do
#       @request.env["devise.mapping"] = Devise.mappings[:user]
#     end
#   end

#   def set_current_user
#     before :each do
#       controller.stub!(:current_user).and_return(current_user)
#     end
#   end
# end
