import express from 'express';
import db from './database'; // Impor modul database
import cors from 'cors'; // Import CORS

const app = express();
const port = 3000; // Port yang digunakan untuk server

// Aktifkan CORS untuk semua permintaan
app.use(cors());

// Middleware untuk parsing JSON
app.use(express.json());

// Route GET untuk menampilkan semua folder root
app.get('/folders', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM folders WHERE parent_id IS NULL');
        res.json(rows);
    } catch (error) {
        res.status(500).json({ message: "Error retrieving data", error });
    }
});

// Route GET untuk menampilkan subfolders berdasarkan ID folder
app.get('/folders/:id/subfolders', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await db.query('SELECT * FROM folders WHERE parent_id = ?', [id]);
        res.json(rows);
    } catch (error) {
        res.status(500).json({ message: "Error retrieving data", error });
    }
});

// Menangani 404
app.use((req, res) => {
    res.status(404).send('404: Page not found');
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
