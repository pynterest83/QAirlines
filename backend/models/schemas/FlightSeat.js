// models/FlightSeat.js
const { DataTypes } = require('sequelize');
const sequelize = require('../../db');

const FlightSeat = sequelize.define('FlightSeat', {
    FlightID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    AircraftID: {
        type: DataTypes.STRING(10),
        allowNull: false,
    },
    SeatNo: {
        type: DataTypes.STRING(5),
        primaryKey: true,
    },
    TicketID: {
        type: DataTypes.STRING(10),
        allowNull: true,
    },
}, {
    timestamps: false,
    tableName: 'FlightSeat',
});

module.exports = FlightSeat;
