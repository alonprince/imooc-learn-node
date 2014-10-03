express = require 'express'
path = require 'path'
port = process.env.PORT || 3000
app = module.exports = express()

app.set 'views','./views/pages'
app.set 'view engine','jade'
app.use(express.bodyParser())
app.use(express.static(path.join(__dirname, 'bower_components')))
app.listen port

console.log "imooc started on port #{port}"

# index page
app.get '/', (req, res) ->
	res.render 'index', {
		title: 'imooc 首页'
		movies: [{
			title: '机械战警'
			_id: 1
			poster: 'http://r3.ykimg.com/05160000530EEB63675839160D0B79D5'
		},{
			title: '机械战警'
			_id: 2
			poster: 'http://r3.ykimg.com/05160000530EEB63675839160D0B79D5'
		},{
			title: '机械战警'
			_id: 3
			poster: 'http://r3.ykimg.com/05160000530EEB63675839160D0B79D5'
		},{
			title: '机械战警'
			_id: 4
			poster: 'http://r3.ykimg.com/05160000530EEB63675839160D0B79D5'
		},{
			title: '机械战警'
			_id: 5
			poster: 'http://r3.ykimg.com/05160000530EEB63675839160D0B79D5'
		},{
			title: '机械战警'
			_id: 6
			poster: 'http://r3.ykimg.com/05160000530EEB63675839160D0B79D5'
		}]
	}

# detail
app.get '/movie/:id', (req, res) ->
	res.render 'detail', {
		title: 'imooc 详情页'
		movie: 
			doctor: 'person'
			country: 'USA'
			title: 'movieName'
			year: 2014
			poster: 'http://r3.ykimg.com/05160000530EEB63675839160D0B79D5'
			language: 'English'
			flash: 'http://player.youku.com/player.php/sid/XNjA1Njc0NTUy/v.swf'
			summary: 'asdfasdfasdfasdfasdfasdfadsfasdfasdfasdfasdfasf'
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

# list
app.get '/admin/list', (req, res) ->
	res.render 'list', {
		title: 'imooc list'
		movie: [{
			doctor: 'person'
			country: 'USA'
			title: 'movieName'
			year: 2014
			poster: 'http://r3.ykimg.com/05160000530EEB63675839160D0B79D5'
			language: 'English'
			flash: 'http://player.youku.com/player.php/sid/XNjA1Njc0NTUy/v.swf'
			summary: 'asdfasdfasdfasdfasdfasdfadsfasdfasdfasdfasdfasf'
		}]
	}