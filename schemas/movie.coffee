mongoose = require 'mongoose'

MovieSchema = new mongoose.Schema({
	doctor: String
	title: String
	language: String
	country: String
	summary: String
	flash: String
	poster: String
	year: Number
	meta: 
		createAt:
			type: Date
			default: Date.now()
		updateAt:
			type: Date
			default: Date.now()
})	

MovieSchema.pre 'save', (next) ->
	if @isNew
		@meta.createAt = @meta.updateAt = Date.now()
	else
		@meta.updateAt = Date.now()

	next()

MovieSchema.statics = 
	fetch: (cb) ->
		@find({})
		.sort('meta.updateAt')
		.exec cb
	findById: (id, cb) ->
		@findOne({_id: id})
		.sort('meta.updateAt')
		.exec cb

module.exports = MovieSchema