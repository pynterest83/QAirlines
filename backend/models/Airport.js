// models/Airport.js
const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const Airport = sequelize.define('Airport', {
    AirportID: {
        type: DataTypes.CHAR(3),
        primaryKey: true,
    },
    AirportName: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
    City: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    Country: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
}, {
    timestamps: false,
    tableName: 'Airport',
});

module.exports = Airport;
