class User
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String
	field :full_name, type: String
	field :description, type: String
	field :email, type: String
	field :password_hash, type: String
	field :password_salt, type: String
	field :token, type: String

	has_many :todos

	def current_todos
		self.todos.select {|t| t.status == "new"}
	end

	def past_todos
		self.todos.select {|t| t.status == "done"}
	end

end
