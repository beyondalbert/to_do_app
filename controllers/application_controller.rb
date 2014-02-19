require 'sinatra/base'
require 'json'
require 'bcrypt'
require 'mongoid'
require 'sinatra/reloader'

class ApplicationController < Sinatra::Base
	helpers ApplicationHelper

	set :static, true
  set :root, File.dirname(__FILE__)
	set :public_dir, 'public'
  set :views, File.expand_path('../../views', __FILE__)

	use Rack::Session::Cookie, :expire_after => 60*60*3

	configure :production do
		set :environment, :production
		Mongoid.load!("./mongoid.yml")
	end

	configure :development do
		register Sinatra::Reloader
		set :environment, :development
		Mongoid.load!("./mongoid.yml")
	end

	get '/' do
		#if current_user
		#	@current_todos = current_user.current_todos
		#	@past_todos = current_user.past_todos
		#end
		erb :index
	end
end
