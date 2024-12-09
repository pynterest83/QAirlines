// models/Passenger.js
const { DataTypes } = require('sequelize');
const sequelize = require('../../db');

const Passenger = sequelize.define('Passenger', {
    PassID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    FirstName: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    LastName: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    DOB: {
        type: DataTypes.DATEONLY,
        allowNull: false,
        get() {
            const dobValue = this.getDataValue('DOB');
            return dobValue ? new Date(dobValue).toISOString().split('T')[0] : null;
        },
    },
    Gender: {
        type: DataTypes.CHAR(1),
        allowNull: false,
    },
    Email: {
        type: DataTypes.STRING(100),
        allowNull: true,
    },
    PhoneNumber: {
        type: DataTypes.STRING(15),
        allowNull: true,
    },
    Passport: {
        type: DataTypes.STRING(20),
        allowNull: true,
    },
    SSN: {
        type: DataTypes.CHAR(12),
        allowNull: true,
    },
    GuardianID: {
        type: DataTypes.STRING(10),
        allowNull: true,
    },
}, {
    timestamps: false,
    tableName: 'Passenger',
});

module.exports = Passenger;
