class UsersController < ApplicationController
  set :views, File.expand_path('../../views/users', __FILE__)

	before do
		pass if ["signup", "login"].include? request.path_info.split('/')[1]
		content_type :json
	end

	get '/signup' do
		erb :signup
	end

	# 
	post '/signup' do
		p User.find_by(email: params[:email]).nil?
		if User.find_by(email: params[:email]).nil?
			@user = User.new(email: params[:email])
			@user.password_salt = BCrypt::Engine.generate_salt
			@user.password_hash = BCrypt::Engine.hash_secret(params[:password], @user.password_salt)
			@user.token = SecureRandom.hex
			if @user.save
				session[:user] = @user.token
				status 201
				@user.to_json
				redirect '/'
			else
				status 507
			end
		else
			status 403
		end
	end

	get '/login' do
		erb :login
	end

	post '/login' do
		if @user = User.find_by(email: params[:email])
			if @user.password_hash == BCrypt::Engine.hash_secret(params[:password], @user.password_salt)
				session[:user] = @user.token
				status 202
				@user.to_json
				redirect '/'
			else
				status 401
			end
		else
			status 404
		end
	end

	get '/logout' do
		session[:user] = nil
		redirect '/'
	end

	delete '/delete' do
	end

	put '/update' do
	end
end
