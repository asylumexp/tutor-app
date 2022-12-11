const jsonWebToken = require("jsonwebtoken");
const db = require("../models");
var Bcrypt=require("bcryptjs")
const User = db.users;
const SECRET_JWT_CODE="JKLkdijI2JKLD33JD3kldkdk87JKDLI37838jlkDjsk73kjdidjkjsamuelHheinz"
console.log(User)

exports.create = (req, res) => {
    // Validate request
    console.log(req.body)
    if (!req.body.name) {
      res.status(400).send({ message: "Content can not be empty!" });
      return;
    }

    const user = new User({
      name: req.body.name,
      email: req.body.email,
      password: req.body.password
    });

    user
      .save(user)
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the user."
        });
      });
  };


  exports.findAll = (req, res) => {
    const name = req.query.name;
    var condition = name ? { name: { $regex: new RegExp(name), $options: "i" } } : {};
  
    User.find(condition)
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving users"
        });
      });
  };

  exports.signUp = (req,res) => {
    if (!req.body.name || !req.body.email || !req.body.password) {
      res.json({success: false, error: "Send needed Params"})
      return
    }
    
    const user = new User({
      name: req.body.name,
      email: req.body.email,
      password: Bcrypt.hashSync(req.body.password, 10)
    });

    user
      .save(user)
      .then((user) => {
        const token = jsonWebToken.sign({ id: user._id, email:user.email}, SECRET_JWT_CODE)
        res.json({success: true, token: token})

      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the user."
        });
      });

  }