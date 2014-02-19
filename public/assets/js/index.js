$(function() {
		window.Todo = Backbone.Model.extend({
			idAttribute: "_id",
			toggle: function() {}
			});

		window.TodoList = Backbone.Collection.extend({
			model: Todo,
			url: '/todos',

		});

		window.Todos = new TodoList;

		window.TodoCurrentView = Backbone.View.extend({
			initialize: function() {},

			render: function() {
				alert(this.model.toJSON());
				var template = _.template($('#todo-current').html(), this.model.toJSON());
				this.$el.html(template);
			},
		});

		window.IndexView = Backbone.View.extend({

			el: '#todo-index',
			initialize: function() {
				Todos.bind('add', this.addOne, this);
				Todos.bind('set', this.addAll, this);

				Todos.fetch();
			},
			events: {
				"click #to-do-submit": "createTodo"
			},
			createTodo: function(e) {
				alert("test");
			},

			addOne: function(todo) {
				alert("addone");
				var view = new TodoCurrentView({model: todo});
				this.$("#todos-current").append(view.render());
			},

			addAll: function() {
				alert(Todos);
				Todos.each(this.addOne);
			},
		});

		window.Index = new IndexView;
		});
