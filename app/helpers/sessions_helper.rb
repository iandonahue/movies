module SessionsHelper
  
#comment just to ceate new commit
    
  def sign_in(user)
    # user.remember_me!
    # cookies[:remember_token] = { :value   => user.remember_token,
    #                              :expires => 20.years.from_now.utc }
    # self.current_user = user
     cookies.permanent.signed[:remember_token] = [user.id, user.salt]
     current_user = user
    end

  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
    #@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end
  
  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    
end