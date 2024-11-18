// models/TicketClass.js
const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const TicketClass = sequelize.define('TicketClass', {
    ClassName: {
        type: DataTypes.ENUM('Economy', 'Business', 'First'),
        primaryKey: true,
    },
    FlightID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    Price: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
}, {
    timestamps: false,
    tableName: 'TicketClass',
});

module.exports = TicketClass;
