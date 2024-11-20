// app.js
const express = require('express');
const app = express();
const sequelize = require('./db');

// Import models
const Aircraft = require('./models/schemas/Aircraft');
const Airport = require('./models/schemas/Airport');
const Flight = require('./models/schemas/Flight');
const FlightSeat = require('./models/schemas/FlightSeat');
const Passenger = require('./models/schemas/Passenger');
const Seat = require('./models/schemas/Seat');
const Ticket = require('./models/schemas/Ticket');
const TicketClass = require('./models/schemas/TicketClass');
const Promotion = require('./models/schemas/Promotion');
const Users = require('./models/schemas/Users');

// Import associations
require('./models/schemas/associations');

// Import routes
const apiRoutes = require('./routes');

app.use(express.json());
app.use('/api', apiRoutes);

// Kết nối và đồng bộ cơ sở dữ liệu
sequelize.sync({ alter: true }) // Bạn có thể thay 'alter: true' thành 'force: true' để reset DB trong quá trình phát triển
    .then(() => {
        console.log('Database & tables created!');
        app.listen(3000, () => {
            console.log('Server is running on port 3000');
        });
    })
    .catch(err => {
        console.error('Unable to connect to the database:', err);
    });
