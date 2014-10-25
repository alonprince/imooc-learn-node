Movie = require '../models/movie'
Comment = require '../models/comment'
_ = require 'underscore'

# detail
exports.detail = (req, res) ->
	id = req.params.id

	Movie.findById id, (err, movie) ->
		Comment.find(movie: id).populate('from', 'name').exec (err, comments) ->
			res.render 'detail', {
				title: "imooc #{movie.title}"
				movie: movie,
				comments: comments
			}

# admin
exports.new = (req, res) ->
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
exports.update = (req, res) ->
	id = req.params.id
	if id 
		Movie.findById id, (err, movie) ->
			res.render 'admin', {
				title: 'imooc 后台更新页'
				movie: movie
			}

# admin post movie
exports.save = (req, res) ->
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
exports.list = (req, res) ->
	Movie.fetch (err, movies) ->
		console.log err if err
		res.render 'list', {
			title: 'imooc 列表页'
			movies: movies
		}

# list delete movie
exports.del = (req, res) ->
	id = req.query.id

	if id
		Movie.remove {_id: id}, (err, movie) ->
			if err then console.log err else res.json(success: 1)
