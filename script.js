const express = require('express');
const mysql = require('mysql2');
const app = express();
const path = require('path');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'MySQLAyush@24042003',
  database: 'inventory',
});

connection.connect();

app.get('/', (req, res) => {
    // Use the `path` module to join the directory path and the filename.
    const filePath = path.join(__dirname, 'index.html');
    
    // Serve the HTML file when accessing the root path.
    res.sendFile(filePath);
  });

  app.get('/api/data', (req, res) => {
    const userQuery = req.query.query;
  
    if (!userQuery) {
      res.status(400).json({ error: 'Please provide a valid SQL query.' });
      return;
    }
  
    const query = `${userQuery}`; // Modify the query as needed
  
    connection.query(query, (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error' });
        return;
      }
  
      res.json(results);
    });
  });

app.listen(3000, () => {
  console.log('Server listening on port 3000');
});
