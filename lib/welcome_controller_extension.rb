module WelcomeControllerExtension
  def self.included(base)
    base.class_eval { 
      def index
        if current_user
          begin
            if (current_user.access == 'both')
              redirect_to admin_pages_url and return
            end
            if (current_user.access == 'front')
              redirect_to "#{Radiant::Config['login.visitor_url']}" and return
            end
          rescue
            "login_candy not migrated"
          end      
        else
          redirect_to '/admin/login' and return
        end
      end
    }
  end
end
