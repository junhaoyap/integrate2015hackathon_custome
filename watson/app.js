'use strict';

var express = require('express'),
  app       = express(),
  watson    = require('watson-developer-cloud'),
  bodyParser= require('body-parser');

// Configure Express
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var credentials = require('./credentials.json');
/*

{
    "version": "v1",
    "url": "https://gateway.watsonplatform.net/tone-analyzer-experimental/api",
    "username": <usename>,
    "password": <password>
}
*/

// Create the service wrapper
var toneAnalyzer = watson.tone_analyzer(credentials);

app.post('/tone', function(req, res, next) {
  toneAnalyzer.tone(req.body, function(err, data) {
    if (err)
      return next(err);
    else
      return res.json(data);
  });
});

app.get('/synonyms', function(req, res, next) {
  toneAnalyzer.synonym(req.query, function(err, data) {
    if (err)
      return next(err);
    else
      return res.json(data);
  });
});

app.get('/scorecards', function(req, res, next) {
  toneAnalyzer.scorecards(req.query, function(err, data) {
    if (err)
      return next(err);
    else
      return res.json(data);
  });
});


var port = 5000;
app.listen(port);
console.log('listening at:', port);
