Comment = require '../models/comment'
_ = require 'underscore'

# post comment
exports.save = (req, res) ->
	_comment = req.body.comment
	movieId = _comment.movie
	comment = new Comment _comment
	console.log _comment,22222222
	console.log comment,1111111111

	comment.save (err, comments) ->
		console.log err if err
		res.redirect "/movie/#{movieId}"
