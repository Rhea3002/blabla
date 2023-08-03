const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
      required: true,
      type: String,
      trim: true,
    },
    email: {
      required: true,
      type: String,
      trim: true,
      validate: {
        validator: (value) => {
          const re =
            /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
          return value.match(re);
        },
        message: "Please enter a valid email address",
      },
    },
    password: {
      required: true,
      type: String,
      validate: {
        validator: (value) => {
          const se =  /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})/;
          return value.match(se);
        },
        message: "Please enter a valid password"
      },
    },
    address: {
      type: String,
      default: "",
    },
    type: {
      required: true,
      type: String,
      enum: ["admin", "user"],        // Allow only "admin" or "user" as values
      default: "user",
    },
});

const User = mongoose.model("User", userSchema);
module.exports = User;