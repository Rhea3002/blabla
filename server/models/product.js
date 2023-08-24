const mongoose = require("mongoose");


const productSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  images: [
    {
      type: String,
      required: true,
    },
  ],
  quantity: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
  screentech: {
    type: String,
    required: true,
    trim: true,
  },
  os: {
    type: String,
    required: true,
    trim: true,
  },
  keywordlist: [
    {
      type: String,
      required: true,
    },
  ],
  ram: {
    type: Number,
    required: true,
  },
  rom: {
    type: Number,
    required: true,
  },

  userId:{
    type: String,
  },
  // ratings: [ratingSchema],
});

const Product = mongoose.model("Product", productSchema);
module.exports = { Product, productSchema };