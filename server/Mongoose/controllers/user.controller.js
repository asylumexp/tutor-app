const jsonWebToken = require("jsonwebtoken");
const db = require("../models");
var Bcrypt = require("bcryptjs");
const { users } = require("../models");
const User = db.users;
const SECRET_JWT_CODE =
  "JKLkdijI2JKLD33JD3kldkdk87JKDLI37838jlkDjsk73kjdidjkjsamuelHheinz";
console.log(User);

function fetchUserByToken(req) {
  return new Promise((resolve, reject) => {
    if (req.headers && req.headers.authorization) {
      let authorization = req.header.authorization;
      let decoded;
      try {
        decoded = jsonWebToken.verify(authorization, SECRET_JWT_CODE);
      } catch (e) {
        reject("Token not valid");
        return;
      }
      let userId = decoded.id;
      User.findById(userId)
        .then((userreturned) => {
          resolve(userreturned);
        })
        .catch((err) => {
          reject("Token error");
        });
    } else {
      reject("No token found");
    }
  });
}

exports.create = (req, res) => {
  // Validate request
  console.log(req.body);
  if (!req.body.name) {
    res.status(400).send({ message: "Content can not be empty!" });
    return;
  }

  const user = new User({
    name: req.body.name,
    email: req.body.email,
    password: req.body.password,
  });

  user
    .save(user)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      res.status(500).send({
        message: err.message || "Some error occurred while creating the user.",
      });
    });
};

exports.findAll = (req, res) => {
  const name = req.query.name;
  var condition = name
    ? { name: { $regex: new RegExp(name), $options: "i" } }
    : {};

  User.find(condition)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      res.status(500).send({
        message: err.message || "Some error occurred while retrieving users",
      });
    });
};

exports.signUp = (req, res) => {
  if (!req.body.name || !req.body.email || !req.body.password) {
    res.json({ success: false, error: "Send needed Params" });
    return;
  }
  const user = new User({
    name: req.body.name,
    email: req.body.email,
    password: Bcrypt.hashSync(req.body.password, 10),
  });
  // User.find({
  //   email: req.body.email
  // }).then(data => {
  //   let numOfAccs = data.length
  //   if (numOfAccs > 0){
  //     res.json({success: false, error: "Email Already Exists"})
  //     return
  //   }
  // })
  // hot ass lookin code that is so big brane but also doesnt catch any errors LMFAOOOOOOOOOOO welll it do but i be using try and catch so dat shit don count

  User.find({
    email: req.body.email,
  }).then((data) => {
    if (data.length > 0) {
      res.json({ success: false, error: "Email Already Exists" });
      return;
    } else {
      user
        .save(user)
        .then((user) => {
          const token = jsonWebToken.sign(
            { id: user._id, email: user.email },
            SECRET_JWT_CODE
          );
          res.json({ success: true, token: token });
        })
        .catch((err) => {
          res.status(500).send({
            message:
              err.message || "Some error occurred while creating the user.",
          });
        });
    }
  });
};

exports.signIn = (req, res) => {
  if (!req.body.email || !req.body.password) {
    res.json({ success: false, error: "Send needed Params" });
    return;
  }

  User.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) {
        res.json({ success: false, error: "User does not exist" });
      } else {
        if (!Bcrypt.compareSync(req.body.password, user.password)) {
          res.json({ success: false, error: "Wrong password" });
        } else {
          const token = jsonWebToken.sign(
            { id: user._id, email: user.email },
            SECRET_JWT_CODE
          );
          res.json({ success: true, token: token });
        }
      }
    })
    .catch((err) => {
      res.json({ success: false, error: err });
    });
};
