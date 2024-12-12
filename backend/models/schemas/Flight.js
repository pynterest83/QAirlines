const { DataTypes } = require('sequelize');
const sequelize = require('../../db');

const Flight = sequelize.define('Flight', {
    FlightID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    Status: {
        type: DataTypes.STRING(20),
        allowNull: false,
    },
    DepTime: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    ArrTime: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    BoardingTime: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    DepID: {
        type: DataTypes.CHAR(3),
        allowNull: false,
    },
    DestID: {
        type: DataTypes.CHAR(3),
        allowNull: false,
    },
    AircraftID: {
        type: DataTypes.STRING(10),
        allowNull: false,
    },
    OriginalDepTime: {
        type: DataTypes.DATE,
        allowNull: true,
    },
    OriginalArrTime: {
        type: DataTypes.DATE,
        allowNull: true,
    },
    OriginalBoardingTime: {
        type: DataTypes.DATE,
        allowNull: true,
    },
}, {
    timestamps: false,
    tableName: 'Flight',
});


module.exports = Flight;
