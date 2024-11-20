// models/Aircraft.js
const { DataTypes } = require('sequelize');
const sequelize = require('../../db');

const Aircraft = sequelize.define('Aircraft', {
    AircraftID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    Model: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    Manufacturer: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    Capacity: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
}, {
    timestamps: false,
    tableName: 'Aircraft',
});

module.exports = Aircraft;
