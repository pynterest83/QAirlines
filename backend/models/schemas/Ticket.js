// models/Ticket.js
const { DataTypes } = require('sequelize');
const sequelize = require('../../db');

const Ticket = sequelize.define('Ticket', {
    TicketID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    FlightID: {
        type: DataTypes.STRING(10),
        allowNull: false,
    },
    AircraftID: {
        type: DataTypes.STRING(10),
        allowNull: false,
    },
    SeatNo: {
        type: DataTypes.STRING(5),
        allowNull: false,
    },
    PassID: {
        type: DataTypes.STRING(10),
        allowNull: false,
    },
    CancellationDeadline: {
        type: DataTypes.DATE,
        allowNull: false,
    },
}, {
    timestamps: false,
    tableName: 'Ticket',
});

module.exports = Ticket;
