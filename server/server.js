var express = require('express');
var fs = require('fs');
var path = require('path');
var bodyParser = require('body-parser');
var app = express();
var mongoose = require('mongoose');

app.listen(3000);

app.use('/', express.static(path.join(__dirname, '/../client')));
app.use('/bower_components',  express.static(__dirname + '/../bower_components'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

mongoose.connect('mongodb://root:happyday123@apollo.modulusmongo.net:27017/xi8hiHih');

var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function (callback) {
  console.log('Connected to database');
});

var ListingSchema = new mongoose.Schema({
  _id: {
    type: String
  },
  body: {
    type: String
  },
  type: {
    type: String
  },
  replyUrl: {
    type: String
  },
  url: {
    type: String
  },
  title: {
    type: String
  },
  price: {
    type: String
  },
  region: {
    type: String
  },
  location: {
    type: String
  },
  hasPic: {
    type: String
  },
  date: {
    type: String
  },
  id: {
    type: String
  },
  __v: {
    type: String
  }
});

var Listing = mongoose.model('newclscrape', ListingSchema);

app.get('/listings.json', function (req, res) {
  var page = +req.query.page;
  var size = +req.query.pageSize;
  Listing.find({}, function (err, listing) {
    if (err) return console.log(err);
  })
  .skip(page * size)
  .limit(size)
  .sort({_id: 1})
  .exec(function (err, listing) {
    if (err) console.log(err);
    res.send(listing);
  })
});

app.post('/', function (req, res) {
  res.send('POST request to the homepage');
});




// mongo apollo.modulusmongo.net:27017/xi8hiHih -u root -p happyday123
// show collections
// db.newclscrapes.find()

// {
//   "_id": ObjectId("559ed74d51bf99157960f08c"),
//   "body": "\n        Onsite Maintenance, Accepts Credit Cards, Cable Ready, Electronic Payments<br>\n<br>\nMeritage Apartments is  Meritage features a fitness studio, BBQ and picnic area, playground and heated pool. Only seconds away from the 680, 101 and 880 freeways, you&apos;ll whiz to the businesses and nightlife centers of either Oakland or San Francisco..<br>\n<br>\n555 South Park Victoria Dr 95035<br>\nEqual Housing Opportunity. Price and availability subject to change.<br>\nTo schedule a tour of your next home, call \n <a href=\"/fb/sfo/apa/5104286332\" class=\"showcontact\" title=\"click to show contact info\" rel=\"nofollow\">show contact info</a>\n<br>\n<br>\n\n    ",
//   "type": "OWNER",
//   "replyUrl": "https://sfbay.craigslist.org/reply/sby/apa/5104286332",
//   "url": "https://sfbay.craigslist.org/sby/apa/5104286332.html",
//   "title": "Onsite Maintenance, Electronic Payments, Cable Ready",
//   "price": "$2400",
//   "region": "sby",
//   "location": " 555 South Park Victoria Dr Milpitas 95035 CA US",
//   "hasPic": "true",
//   "date": "2015-07-09 12:45",
//   "id": "5104286332",
//   "__v": 0
// }

// var server = new mongodb.Server("127.0.0.1", 27017, {});
// var client = new mongodb.Db('test', server);
