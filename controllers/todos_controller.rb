class TodosController < ApplicationController
	post '/create' do
		todo = Todo.new(subject: params[:subject], user: current_user, assigned_to: current_user.email, status: "new")
		p params[:subject]
		p todo
		todo.save
	end

	put '/done' do
		todo = Todo.where(_id: params[:id]).first
		p todo
		todo.update_attribute(:status, "done")
		p params
	end

	get '/' do
		if current_user
			current_user.todos.to_json
		else
			{}
		end
	end
end
