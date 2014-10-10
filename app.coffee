express = require 'express'
path = require 'path'
mongoose = require 'mongoose'
Movie = require './models/movie'
User = require './models/user'
_ = require 'underscore'


mongoose.connect 'mongodb://localhost/imooc'

port = process.env.PORT || 3000
app = module.exports = express()

app.set 'views','./views/pages'
app.set 'view engine','jade'
app.use(express.bodyParser())
app.use(express.static(path.join(__dirname, 'public')))
app.locals.moment = require 'moment'
app.listen port

console.log "imooc is started on port #{port}"

# index page
app.get '/', (req, res) ->
	Movie.fetch (err, movies) ->
		console.log err if err
		res.render 'index', {
			title: 'imooc 首页'
			movies: movies
		}

# signup
app.post '/user/signup', (req, res) ->
	_user = req.body.user
	# req.param 'user'也能拿到user的信息
	User.find({name: _user.name}, (err, user) ->
		console.log err if err
		if user
			return res.redirect '/'
		else
			user = new User _user
			user.save (err, user) ->
				console.log err if err

				res.redirect '/admin/userlist'
	)

#signin 
app.post '/user/signin', (req, res) ->
	_user = req.body.user
	name = _user.name
	password = _user.password

	User.findOne name: name, (err, user) ->
		console.log err if err

		return res.redirect '/' if !user

		console.log user
		user.comparePassword password, (err, isMatch) ->
			console.log err if err

			if isMatch
				console.log 'password is match'
				return res.redirect '/'
			else
				console.log 'password is not match'
		return	

# detail
app.get '/movie/:id', (req, res) ->
	id = req.params.id

	Movie.findById id, (err, movie) ->
		res.render 'detail', {
			title: "imooc #{movie.title}"
			movie: movie
		}

# admin
app.get '/admin/movie', (req, res) ->
	res.render 'admin', {
		title: 'imooc 后台录入'
		movie: 
			title: ''
			doctor: ''
			country: ''
			year: ''
			poster: ''
			flash: ''
			summary: ''
			language: ''
	}

# admin update movie
app.get '/admin/update/:id', (req, res) ->
	id = req.params.id
	if id 
		Movie.findById id, (err, movie) ->
			res.render 'admin', {
				title: 'imooc 后台更新页'
				movie: movie
			}

# admin post movie
app.post '/admin/movie/new', (req, res) ->
	id = req.body.movie._id
	movieObj = req.body.movie
	_movie = null

	if 'undefined' isnt id
		Movie.findById id, (err, movie) ->
			console.log err if err

			_movie = _.extend(movie, movieObj)
			_movie.save (err, movie) ->
				console.log err if err
				res.redirect "/movie/#{movie._id}"
	else
		_movie = new Movie({
			doctor: movieObj.doctor
			title: movieObj.title
			country: movieObj.country
			language: movieObj.language
			year: movieObj.year
			poster: movieObj.poster
			flash: movieObj.flash
			summary: movieObj.summary
		})

		_movie.save (err, movie) ->
			console.log err if err
			res.redirect "/movie/#{movie._id}"

# list
app.get '/admin/list', (req, res) ->
	Movie.fetch (err, movies) ->
		console.log err if err
		res.render 'list', {
			title: 'imooc 列表页'
			movies: movies
		}

# userlist
app.get '/admin/userlist', (req, res) ->
	User.fetch (err, users) ->
		console.log err if err
		res.render 'userlist', {
			title: 'imooc 用户列表'
			users: users
		}

# list delete movie
app.delete '/admin/list', (req, res) ->
	id = req.query.id

	if id
		Movie.remove {_id: id}, (err, movie) ->
			if err then console.log err else res.json(success: 1)
