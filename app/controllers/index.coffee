Movie = require '../models/movie'

exports.index = (req, res) ->
	console.log req.session.user
	
	Movie.fetch (err, movies) ->
		console.log err if err
		res.render 'index', {
			title: 'imooc 首页'
			movies: movies
		}
