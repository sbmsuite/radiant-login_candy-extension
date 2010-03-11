module LoginSystemExtension
  def self.included(base)

  end
   
  protected
   
    def current_user
      @current_user ||= (login_from_session || login_from_cookie || login_from_api_key || login_from_http)
    end

    def login_from_api_key
      self.current_user = User.find_by_api_key(params[:api_key]) unless params[:api_key].nil?
    end 
end
