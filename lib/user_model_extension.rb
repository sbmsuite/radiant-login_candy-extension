module UserModelExtension
  def self.included(base)
    base.class_eval do
      before_create :generate_api_key
    end
  end

  def generate_api_key
    begin
      self.api_key = self.sha1(Time.now + Radiant::Config['session_timeout'].to_i) 
    rescue 
      "login_candy not migrated"
    end
  end  
end
