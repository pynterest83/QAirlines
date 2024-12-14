// app.js
const express = require('express');
const app = express();
const sequelize = require('./db');
const cors = require('cors');
app.use(cors());
require('dotenv').config({
    path: './../.env'
});
const host = process.env.HOST || 'localhost';
const port = process.env.PORT || 3000;

// Import models
require('./models/schemas/Aircraft');
require('./models/schemas/Airport');
require('./models/schemas/Flight');
require('./models/schemas/FlightSeat');
require('./models/schemas/Passenger');
require('./models/schemas/Seat');
require('./models/schemas/Ticket');
require('./models/schemas/TicketClass');
require('./models/schemas/Promotion');
require('./models/schemas/User');
require('./models/schemas/Banner');

// Import associations
require('./models/schemas/associations');

// Import routes
const apiRoutes = require('./routes');

app.use(express.json());
app.use('/api', apiRoutes);

// Kết nối và đồng bộ cơ sở dữ liệu
sequelize.sync({ alter: true })
    .then(() => {
        console.log('Database & tables created!');
        const server = app.listen(port, host, () => {
            console.log('Server is running on ' + host + ':' + port);
        });

        // Graceful shutdown
        process.on('SIGTERM', () => {
            console.log('SIGTERM signal received: closing HTTP server');
            server.close(() => {
                console.log('HTTP server closed');
                sequelize.close()
                    .then(() => {
                        console.log('Database connection closed');
                        process.exit(0);
                    })
                    .catch(err => {
                        console.error('Error closing database connection:', err);
                        process.exit(1);
                    });
            });
        });
    })
    .catch(err => {
        console.error('Unable to connect to the database:', err);
    });