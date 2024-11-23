const { DataTypes } = require('sequelize');
const sequelize = require('../../db');

const User = sequelize.define('User', {
    UserID: {
        type: DataTypes.STRING,
        primaryKey: true // Khóa chính
    },
    Username: {
        type: DataTypes.STRING(50),
        allowNull: false
    },
    Password: {
        type: DataTypes.STRING,
        allowNull: false
    },
    Role: {
        type: DataTypes.STRING,
        allowNull: false,
        defaultValue: 'User' // Mặc định là User
    }
});

module.exports = User;
