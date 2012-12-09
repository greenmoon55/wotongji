# -*- encoding : utf-8 -*-
module SessionsHelper

	def sign_in(user)
	  session[:current_user_id] = user.id
	  self.current_user = user
	end

	def signed_in?
	  !current_user.nil?
	end

  def sign_out
    self.current_user = nil
    session.delete(:current_user_id)
  end

  # setter
	def current_user=(user)
	  @current_user = user
	end

  # getter
	def current_user
	  @current_user ||= User.find_by_id(session[:current_user_id])
	end

  # store current url
  def store_location
    session[:return_to] = request.url
  end
  
  def store_previous_location  
    session[:return_to] = request.referer
  end

  # redirect to stored location (see store_location fuction) or default
	def redirect_back_or(default = root_url)
	  redirect_to(session[:return_to] || default)
	  session.delete(:return_to)
	end

  def require_signin
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "请先登录"
    end
  end
end
