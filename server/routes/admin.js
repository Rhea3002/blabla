const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../models/product"); 


adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {
      const {name, description, images, quantity, price, category, keywordlist, os, ram, rom, screentech} = req.body;
      let product= new Product({
        name,
        description,
        images,
        quantity,
        price,
        category, 
        keywordlist,
        os,
        ram,
        rom,
        screentech,
        // userId
      });
      product = await product.save();
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

module.exports = adminRouter;