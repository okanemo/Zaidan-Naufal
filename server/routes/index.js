const express = require('express');
const { getnab } = require('../db');

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
  //  mengupdate NAB
  router.post("/ib/updateTotalBalance", async (req, res,  next) =>{
    let currBalance = req.body.current_balance;

    try {
      let total_unit = await db.gettotalamount();
      var nab = 1.0;
      if(total_unit[0].total_amount != 0 && total_unit && total_unit[0].total_amount != undefined){
        nab = currBalance / total_unit[0].total_amount;
      }
      let result = await db.insertnab(nab); 
      res.json({nab_amount:nab});
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
  // mendapatkan semua list NAB
  router.get("/ib/listNAB", async (req, res,  next) =>{
    try {
      let results = await db.getnab();
      res.send(results);
    } catch (e) {
      console.log(e);
      res.sendStatus(5000);
    }
  });
  // melakukan topup
  router.post("/ib/topup", async (req, res,  next) =>{
    let user_id  = req.body.user_id;
    let amount_rupiah = req.body.amount_rupiah;
    try {
      let nab = 1.0;
      let nabres = await db.getnabnow()
      if (nabres[0].nab !=0 && nab && nabres[0].nab != undefined){
        nab = nabres[0].nab
      }
      let unit = amount_rupiah / nab;
      let result = await db.topup(user_id,unit);
      let unitinsert = await db.getspecifictrans(result.insertId);
      let saldo = await db.getusersaldo(user_id);
      res.json({"id_user":result.insertId,"nilai_unit_hasil_topup":unitinsert[0].unit,
        "nilai_unit_total":saldo[0].total_amount,"saldo_rupiah_total":saldo[0].rupiah_per_uid});
    } catch (e) {
      console.log(e);
      res.sendStatus(5000);
    }
  });
  // melakukan withdraw
  router.post("/ib/withdraw", async (req, res,  next) =>{
    let user_id  = req.body.user_id;
    let amount_rupiah = req.body.amount_rupiah;
    try {
      let nab = 1.0;
      let saldoawal = await db.getusersaldo(user_id);
      let nabres = await db.getnabnow()
      if (saldoawal && saldoawal[0].rupiah_per_uid != undefined && saldoawal[0].rupiah_per_uid >= amount_rupiah){
        if (nabres[0].nab !=0 && nab && nabres[0].nab != undefined){
          nab = nabres[0].nab
        }
        let unit = amount_rupiah / nab;
        let result = await db.withdraw(user_id,unit);
        let unitinsert = await db.getspecifictrans(result.insertId);
        let saldo = await db.getusersaldo(user_id);
        res.json({"id_user":result.insertId,"nilai_unit_setelah_withdraw":unitinsert[0].unit,
          "nilai_unit_total":saldo[0].total_amount,"saldo_rupiah_total":saldo[0].rupiah_per_uid});
      }else {
        res.json({"error":"saldo tidak cukup"});
      }
      
    } catch (e) {
      console.log(e);
      res.sendStatus(5000);
    }
  });
  // mendapatkan semua info member
  router.get("/ib/member", async (req, res,  next) =>{
    try {
      let result;
      let page = 0;
      let limit = 20;
      if (req.query.userid){
        let user_id = req.query.userid;
        result = await db.getusersaldo(user_id);
      } else{
        if(req.query.page){
          let page = req.query.page;
        }
        if(req.query.limit){
          let page = req.query.limit;
        }
        result = await db.getallusersaldo(page,limit);
      }
      res.send(result);
    } catch (e) {
      console.log(e);
      res.sendStatus(5000);
    }
  });
  
module.exports = router;