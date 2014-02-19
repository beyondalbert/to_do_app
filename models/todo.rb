#require_relative 'user'
class Todo
	include Mongoid::Document
	include Mongoid::Timestamps

	field :subject, type: String
	belongs_to :user
	field :assigned_to
	field :status, type: String
end
