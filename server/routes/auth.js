const router = require("express").Router();
const User = require("../models/User");
const bcrypt = require("bcryptjs");
const { body, validationResult } = require('express-validator');

//REGISTER
router.post("/register", async (req, res) => {
  try {
    console.log("hi");
    //generate new password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt);

    //create new user
    const newUser = new User({
      username: req.body.username,
      email: req.body.email,
      password: hashedPassword,
    });

    //save user and respond
    const user = await newUser.save();
    res.status(200).json({ userId: user._id });
  } catch (err) {
    console.log(err);
    res.status(500).json(err);
  }
});

//LOGIN
router.post("/login", body('email').isEmail().normalizeEmail(), body('password').isStrongPassword(), async (req, res) => {
  try {
    const errors = validationResult(req);
    const user = await User.findOne({ email: body('email').isEmail().normalizeEmail() });
    if (errors.array) {
      res.status(555).json(errors.array())
    } else if (!user) {
      res.status(404).json("user not found");
    } else if (
      (await bcrypt.compare(body('password').isStrongPassword().unescape().trim(), user.password)) == false
    )
      res.status(400).json("wrong password");
    else {
      res.status(200).json({ userId: user._id });
    }
  } catch (err) {
    console.log(err);
    res.status(500).json(err);
  }
});

module.exports = router;
