var express = require('express');
var users = require("../Mongoose/controllers/user.controller.js");
var router = express.Router();

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });
router.post("/",users.create);
router.get("/",users.findAll);

module.exports = router;
