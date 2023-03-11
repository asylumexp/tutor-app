const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema(
  {
    username: {
      type: String,
      require: true,
      min: 3,
      max: 20,
      unique: true,
    },

    email: {
      type: String,
      required: true,
      max: 50,
      unique: true,
    },

    password: {
      type: String,
      required: true,
      min: 6,
    },

    profilePicture: {
      type: String,
      default: "",
    },

    isTutor: {
      type: Boolean,
      default: false,
    },

    isAdmin: {
      type: Boolean,
      default: false,
    },

    tutors: {
      type: Array,
      default: [],
    },

    students: {
      type: Array,
      default: [],
    },

    //description
    desc: {
      type: String,
      max: 50,
    },

    city: {
      type: String,
      max: 50,
    },

    interestTopics: {
      type: Array,
      default: ["All"],
    },
  },

  { timestamps: true }
);

module.exports = mongoose.model("User", UserSchema);
