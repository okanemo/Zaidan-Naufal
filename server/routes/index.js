const express = require('express');

const router = express.Router();
const db = require("../db");
router.get("/", (req, res,  next) =>{
    res.json({test: 'test'});
});

router.get("/test", async (req, res,  next) =>{
  try {
    let results = await db.all();

    res.send(results);
  } catch (e) {
    console.log(e);
    res.sendStatus(5000);
  }
});
module.exports = router;