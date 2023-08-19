const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../models/product"); 
// const user = require("../middleware/auth");

adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {
      const {name, description, images, quantity, price, category, keywordlist, os, ram, rom, screentech, userId } = req.body;
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
        userId
      });
      product = await product.save();
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });


  //Get all your products
  adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try { 
      const products = await Product.find({});
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    } 
  });

  

  // Delete the product
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Update products
adminRouter.post("/admin/update-product", admin, async (req, res) => {
  try {
    const { id, name, price, description, quantity, images, ram, rom, screentech, os, keywordlist } = req.body;
    const updatedProduct = await Product.findByIdAndUpdate(
      id,
      { name, price, description, quantity, images, ram, rom, screentech, os, keywordlist },
      { new: true } // Return the updated product
    );

    if (!updatedProduct) {
      return res.status(404).json({ error: "Product not found" });
    }

    res.json(updatedProduct);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports = adminRouter;