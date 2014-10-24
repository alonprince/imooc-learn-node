express = require 'express'
path = require 'path'
mongoose = require 'mongoose'
mongoStorage = require('connect-mongo')(express)
dbUrl = 'mongodb://localhost/imooc'

mongoose.connect dbUrl

port = process.env.PORT || 3000
app = module.exports = express()

app.set 'views','./views/pages'
app.set 'view engine','jade'
app.use express.bodyParser()
app.use(express.static(path.join(__dirname, 'public')))
app.use express.cookieParser()
app.use express.session {
	secret: 'imooc',
	store: new mongoStorage {
		url: dbUrl
		collection: 'sessions'
	}
}

require('./config/routes')(app)

app.locals.moment = require 'moment'
app.listen port

console.log "imooc is started on port #{port}"

