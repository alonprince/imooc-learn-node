Index = require '../app/controllers/index'
User = require '../app/controllers/user'
Movie = require '../app/controllers/movie'
Comment = require '../app/controllers/comment'

module.exports = (app) ->
	# pre handle user
	app.use (req, res, next) ->
		_user = req.session.user
		app.locals.user = _user
		
		return next()

	# index page
	app.get '/', Index.index

	# user
	app.post '/user/signup', User.signup
	app.post '/user/signin', User.signin
	app.get '/logout', User.logout
	app.get '/signin', User.showSignin
	app.get '/signup', User.showSignup
	app.get '/admin/user/list', User.signinRequired, User.adminRequired, User.list

	# Movie
	app.get '/movie/:id', Movie.detail
	app.get '/admin/movie/new', User.signinRequired, User.adminRequired, Movie.new
	app.get '/admin/movie/update/:id', User.signinRequired, User.adminRequired, Movie.update
	app.post '/admin/movie', User.signinRequired, User.adminRequired, Movie.save
	app.get '/admin/movie/list', User.signinRequired, User.adminRequired, Movie.list
	app.delete '/admin/movie/list', User.signinRequired, User.adminRequired, Movie.del


	# Comment
	app.post '/user/comment', User.signinRequired, Comment.save
