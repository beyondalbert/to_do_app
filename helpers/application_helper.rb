module ApplicationHelper
	def current_user
		@current_user ||= User.find_by(token: session[:user]) if session[:user]
	end
end
