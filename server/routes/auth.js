const router = require("express").Router();
const User = require("../models/User");
const bcrypt = require("bcryptjs");
const { body, validationResult, check } = require("express-validator");

var RateLimit = require("express-rate-limit");
var limiter = RateLimit({
  windowMs: 1 * 60 * 1000, // 1 minute
  max: 30,
});

const loginValidate = [
  // Check Username
  check("email", ["email", "Username Must Be an Email Address"])
    .isEmail()
    .trim()
    .escape()
    .normalizeEmail(),
  // Check Password
  check("password")
    .isLength({ min: 8 })
    .withMessage(["password", "Password Must Be at Least 8 Characters"])
    .matches("[0-9]")
    .withMessage(["password", "Password Must Contain a Number"])
    .matches("[A-Z]")
    .withMessage(["password", "Password Must Contain an Uppercase Letter"])
    .trim()
    .escape(),
];

const registerValidate = [
  // Check Username
  check("email", ["email", "Username Must Be an Email Address"])
    .isEmail()
    .trim()
    .escape()
    .normalizeEmail(),
  // Check Password
  check("username")
    .isLength({ min: 4 })
    .withMessage(["user", "Username must be at least 4 characters!"])
    .trim(' []{}=+_",?)(*&^%$#@!~`|/,<>?:')
    .escape(),
  check("password")
    .isLength({ min: 8 })
    .withMessage(["password", "Password Must Be at Least 8 Characters"])
    .matches("[0-9]")
    .withMessage(["password", "Password Must Contain a Number"])
    .matches("[A-Z]")
    .withMessage(["password", "Password Must Contain an Uppercase Letter"])
    .trim()
    .escape(),
];

router.use(limiter);
//REGISTER
router.post("/register", registerValidate, async (req, res) => {
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
router.post("/login", loginValidate, async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    res.status(555).json(errors.array());
  } else {
    try {
      const user = await User.findOne({
        email: body("email").normalizeEmail().trim().escape(),
      });
      if (!user) {
        res.status(404).json("user not found");
      } else if (
        (await bcrypt.compare(req.body.password, user.password)) == false
      )
        res.status(400).json("wrong password");
      else {
        res.status(200).json({ userId: user._id });
      }
    } catch (err) {
      console.log(err);
      res.status(500).json(err);
    }
  }
});

module.exports = router;
