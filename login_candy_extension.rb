# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
require_dependency "#{File.expand_path(File.dirname(__FILE__))}/lib/login_system_extension"
require_dependency "#{File.expand_path(File.dirname(__FILE__))}/lib/user_model_extension"
require_dependency "#{File.expand_path(File.dirname(__FILE__))}/lib/welcome_controller_extension"
class LoginCandyExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://github.com/crankin/radiant-login_candy-extension"

  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :login_candy
  #   end
  # end
  
  def activate
    # tab 'Content' do
    #   add_item "Login Candy", "/admin/login_candy", :after => "Pages"
    # end
    
    User.send(:include, UserModelExtension)
    ApplicationController.send(:include, LoginSystemExtension)
    Admin::WelcomeController.send(:include, WelcomeControllerExtension)
    
    Radiant::Config['login.visitor_url'] ||= '/visitors'
  end
end
