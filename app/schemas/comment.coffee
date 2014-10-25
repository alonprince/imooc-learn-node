mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId


CommentSchema = new Schema({
	movie:
		type: ObjectId
		ref: 'Movie'
	from:
		type: ObjectId
		ref: 'User'
	to:
		type: ObjectId
		ref: 'User'
	content: String
	meta: 
		createAt:
			type: Date
			default: Date.now()
		updateAt:
			type: Date
			default: Date.now()
})	

CommentSchema.pre 'save', (next) ->
	if @isNew
		@meta.createAt = @meta.updateAt = Date.now()
	else
		@meta.updateAt = Date.now()

	next()

CommentSchema.statics = 
	fetch: (cb) ->
		@find({})
		.sort('meta.updateAt')
		.exec cb
	findById: (id, cb) ->
		@findOne({_id: id})
		.sort('meta.updateAt')
		.exec cb

module.exports = CommentSchema