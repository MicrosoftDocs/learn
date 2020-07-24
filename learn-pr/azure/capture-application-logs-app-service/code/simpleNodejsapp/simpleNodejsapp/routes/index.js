'use strict';
var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function (req, res) {
    res.render('index', { title: 'Contoso Fashions' });
});
router.get('/index', function (req, res) {
    res.render('index', { title: 'Contoso Fashions' });
});
router.get('/about', function (req, res) {
    res.render('about', { title: 'About Us' });
});
router.get('/contact', function (req, res) {
    res.render('contact', { title: 'Contact Us' });
});

module.exports = router;

console.log("Log from index.js");
console.error("Error from index.js");