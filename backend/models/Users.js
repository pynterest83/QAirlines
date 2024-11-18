// models/Users.js
const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const Users = sequelize.define('Users', {
    UserID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    Username: {
        type: DataTypes.STRING(50),
        unique: true,
        allowNull: false,
    },
    PasswordHash: {
        type: DataTypes.STRING(255),
        allowNull: false,
    },
    Role: {
        type: DataTypes.ENUM('user', 'admin'),
        defaultValue: 'user',
        allowNull: false,
    },
    CreatedAt: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
        allowNull: false,
    },
}, {
    timestamps: false,
    tableName: 'Users',
});

module.exports = Users;
