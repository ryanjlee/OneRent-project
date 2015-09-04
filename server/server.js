var express = require('express');
var app = express();
var mongoose = require('mongoose');

app.listen(3000);

mongoose.connect('mongodb://root:happyday123@apollo.modulusmongo.net:27017/xi8hiHih');

var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function (callback) {
  console.log('connected');
});

var ListingSchema = new mongoose.Schema({
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







app.get('/', function (req, res) {
  res.send('GET request to the homepage');
});

app.post('/', function (req, res) {
  res.send('POST request to the homepage');
});
