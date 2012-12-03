# -*- encoding : utf-8 -*-
module SessionsHelper

	def sign_in(user)
	  session[:current_user_id] = user.id
	  self.current_user = user
	end

	def signed_in?
	  !current_user.nil?
	end

	def current_user=(user)
	  @current_user = user
	end

	def current_user
	  @current_user ||= User.find_by_id(session[:current_user_id])
	end

	def redirect_back_or(default)
	  redirect_to(session[:return_to] || default)
	  session.delete(:return_to)
	end

  def sign_out
    self.current_user = nil
    session.delete(:current_user_id)
  end

  def store_location
    session[:return_to] = request.url
  end

  def require_signin
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "请先登录"
    end
  end
end
