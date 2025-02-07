import mysql from 'mysql2';

// Buat koneksi ke database
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'file_explorer_yuda'
});

// Promisify untuk penggunaan async/await
const promisePool = pool.promise();

export default promisePool;
