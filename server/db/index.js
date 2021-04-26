const mysql = require('mysql');
const dotenv = require("dotenv").config();
const pool = mysql.createPool({
    connectionLimit: 1000,
    connectTimeout: 60 * 60 * 1000,
    acquireTimeout: 60 * 60 * 1000,
    timeout: 60 * 60 * 1000,
    password: process.env.DATABASE_PASSWORD,
    user: process.env.DATABASE_USER,
    host: process.env.DATABASE_HOST,
    port: process.env.DATABASE_PORT,
    database: process.env.DATABASE_NAME,
})

let db = {};

db.all = () => {
    /*untuk mengecek koneksi ke DB*/
    return new Promise((resolve, reject) => {
      pool.query("SELECT * FROM userdata", (err, results) => {
        if (err) {
          return reject(err);
        }
        return resolve(results);
      });
    });
};


  module.exports = db;