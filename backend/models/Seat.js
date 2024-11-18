// models/Seat.js
const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const Seat = sequelize.define('Seat', {
    AircraftID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    SeatNo: {
        type: DataTypes.STRING(5),
        primaryKey: true,
    },
    Class: {
        type: DataTypes.ENUM('Economy', 'Business', 'First'),
        allowNull: false,
    },
}, {
    timestamps: false,
    tableName: 'Seat',
});

module.exports = Seat;
