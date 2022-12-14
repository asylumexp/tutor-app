var express = require("express");
var users = require("../Mongoose/controllers/user.controller.js");
var router = express.Router();

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });
router.post("/", users.create);
router.get("/", users.findAll);
router.post("/signup", users.signUp);
router.post("/signin", users.signIn);
router.post("/refresh", users.refresh);

module.exports = router;
