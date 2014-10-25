mongoose = require 'mongoose'
bcrypt = require 'bcrypt'
SALT_WORK_FACTOR = 10

UserSchema = new mongoose.Schema({
	name: 
		type: String
		unique: true
	password: String
	role: 
		type: Number
		default: 0
	meta: 
		createAt:
			type: Date
			default: Date.now()
		updateAt:
			type: Date
			default: Date.now()
})	

UserSchema.pre 'save', (next) ->
	user = this

	if @isNew
		@meta.createAt = @meta.updateAt = Date.now()
	else
		@meta.updateAt = Date.now()

	bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
		return next(err) if err

		bcrypt.hash user.password, salt, (err, hash) ->
			return next(err) if err

			user.password = hash

			next()

UserSchema.methods = 
	comparePassword: (_password, cb) ->
		bcrypt.compare _password, this.password, (err, isMatch) ->
			return cb(err) if err

			cb null, isMatch

UserSchema.statics = 
	fetch: (cb) ->
		@find({})
		.sort('meta.updateAt')
		.exec cb
	findById: (id, cb) ->
		@findOne({_id: id})
		.sort('meta.updateAt')
		.exec cb

module.exports = UserSchema