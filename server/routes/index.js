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
/* menambahkan nama dan username */
router.post("/user/add", async (req, res,  next) =>{
    let name = req.body.name;
    let username = req.body.username;
    try {
      let results = await db.register(name,username);
      res.json({"id_user":results.insertId}) ;
    } catch (e) {
      if (
        e.code === "ER_DUP_ENTRY" &&
        e.sqlMessage.split(" ").slice(-1)[0] === "'userdata.username'"
        ) {
        res.send({ error: "Username has been taken" });
        } else{
            console.log(e);
            res.sendStatus(5000);
        }
    }
  });

  
module.exports = router;