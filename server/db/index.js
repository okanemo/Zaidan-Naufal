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

db.register = (name, username) => {
    /*MySQL query untuk menambahkan user baru ke dalam tabel userdata */
    return new Promise((resolve, reject) => {
      pool.query(
        `INSERT INTO userdata(name, username) VALUES(?, ?)`,
        [name, username],
        (err, result) => {
          if (err) {
            return reject(err);
          }
          return resolve(result);
        }
      );
    });
  };

db.getnab = () => {
    /*untuk mendapatkan semua nab*/
    return new Promise((resolve, reject) => {
      pool.query("SELECT nab,date FROM nab ORDER BY date DESC", (err, results) => {
        if (err) {
          return reject(err);
        }
        return resolve(results);
      });
    });
};

db.getnabnow = () => {
  /*untuk mendapatkan nab saat ini*/
  return new Promise((resolve, reject) => {
    pool.query("SELECT * from nab_now", (err, results) => {
      if (err) {
        return reject(err);
      }
      return resolve(results);
    });
  });
};

db.insertnab = (nab) => {
  /*MySQL query untuk menambahkan user baru ke dalam tabel userdata */
  return new Promise((resolve, reject) => {
    pool.query(
      `INSERT INTO nab(nab) VALUES(?)`,
      [nab],
      (err, result) => {
        if (err) {
          return reject(err);
        }
        return resolve(result);
      }
    );
  });
};

db.gettotalamount = () => {
  /*untuk mendapatkan total unit yang ada*/
  return new Promise((resolve, reject) => {
    pool.query("SELECT SUM(total_unit_per_uid) as total_amount from total_trans", (err, results) => {
      if (err) {
        return reject(err);
      }
      return resolve(results);
    });
  });
};

db.topup = (id_user,unit) => {
  /*untuk melakukan topup */
  return new Promise((resolve, reject) => {
    pool.query(
      `INSERT INTO transaksi(id_user,tipe,unit) VALUES(?,'topup',?)`,
      [id_user,unit],
      (err, result) => {
        if (err) {
          return reject(err);
        }
        return resolve(result);
      }
    );
  });
};

db.withdraw = (id_user,unit) => {
  /* untuk melakukan withdraw */
  return new Promise((resolve, reject) => {
    pool.query(
      `INSERT INTO transaksi(id_user,tipe,unit) VALUES(?,'withdraw',?)`,
      [id_user,unit],
      (err, result) => {
        if (err) {
          return reject(err);
        }
        return resolve(result);
      }
    );
  });
};

db.getusersaldo = (id_user) => {
  /*mendapat saldo dari user */
  return new Promise((resolve, reject) => {
    pool.query("SELECT * FROM member where id_user =(?)", 
    [id_user],
    (err, results) => {
      if (err) {
        return reject(err);
      }
      return resolve(results);
    });
  });
};

db.getallusersaldo = (page,limit) => {
  /*mendapatkan semua saldo*/
  return new Promise((resolve, reject) => {
    pool.query("SELECT * FROM member ORDER BY id_user LIMIT ?,?",
    [page,limit], 
    (err, results) => {
      if (err) {
        return reject(err);
      }
      return resolve(results);
    });
  });
};

db.getspecifictrans = (id_trans) => {
  /*mendapatkan suatu transaksi*/
  return new Promise((resolve, reject) => {
    pool.query("SELECT unit FROM transaksi WHERE id_trans=(?);", 
    [id_trans],
    (err, results) => {
      if (err) {
        return reject(err);
      }
      return resolve(results);
    });
  });
};

module.exports = db;