User = require '../models/user'
# signup
exports.showSignup = (req, res) ->
	res.render 'signup', {
		title: '注册界面'
		# users: users
	}

exports.signup = (req, res) ->
	_user = req.body.user
	# req.param 'user'也能拿到user的信息
	User.find({name: _user.name}, (err, user) ->
		console.log err if err
		if user.length
			return res.redirect '/signin'
		else
			user = new User _user
			user.save (err, user) ->
				console.log err if err

				req.session.user = user
				res.redirect '/'
	)

#signin
exports.showSignin = (req, res) ->
	res.render 'signin', {
		title: '登录界面'
		# users: users
	} 

exports.signin = (req, res) ->
	_user = req.body.user
	name = _user.name
	password = _user.password

	User.findOne name: name, (err, user) ->
		console.log err if err

		return res.redirect '/signup' if !user

		user.comparePassword password, (err, isMatch) ->
			console.log err if err

			if isMatch
				req.session.user = user
				return res.redirect '/'
			else
				return res.redirect '/signin'
				console.log 'password is not match'
		return	

# logout
exports.logout = (req, res) ->
	delete req.session.user
	# delete app.locals.user
	res.redirect '/'

# userlist
exports.userlist = (req, res) ->
	User.fetch (err, users) ->
		console.log err if err
		res.render 'userlist', {
			title: 'imooc 用户列表'
			users: users
		}
