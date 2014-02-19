require 'sinatra/base'
require './helpers/application_helper.rb'
require './controllers/application_controller.rb'

Dir.glob('./{helpers,controllers,models}/*.rb').each {|file| require file}

map('/users') { run UsersController }
map('/todos') { run TodosController }
map('/') { run ApplicationController }
