const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../models/product"); 
// const user = require("../middleware/auth"); 

const Order = require("../models/order");

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

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const userId = req.query.userId;
    console.log(userId);
    const orders = await Order.find({
      "products.product.userId": userId,
    });
    let totalEarnings = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }
    // CATEGORY WISE ORDER FETCHING
    let mobileEarnings = await fetchCategoryWiseProduct(userId,"Mobiles");
    let LaptopEarnings = await fetchCategoryWiseProduct(userId,"Laptops");

    let earnings = {
      totalEarnings,
      mobileEarnings,
      LaptopEarnings,
    };

    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProduct(userId, category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    "products.product.userId": userId,
    "products.product.category": category,
  });

  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earnings +=
        categoryOrders[i].products[j].quantity *
        categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;
}

module.exports = adminRouter;