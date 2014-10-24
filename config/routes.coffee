Index = require '../app/controllers/index'
User = require '../app/controllers/user'
Movie = require '../app/controllers/movie'

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
	app.get '/admin/userlist', User.userlist

	# Movie
	app.get '/movie/:id', Movie.detail
	app.get '/admin/movie', Movie.new
	app.get '/admin/update/:id', Movie.update
	app.post '/admin/movie/new', Movie.save
	app.get '/admin/list', Movie.list
	app.delete '/admin/list', Movie.del
