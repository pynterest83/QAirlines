// models/Promotion.js
const { DataTypes } = require('sequelize');
const sequelize = require('../../db');

const Promotion = sequelize.define('Promotion', {
    PromotionID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    Content: {
        type: DataTypes.TEXT,
        allowNull: false,
    },
    Title: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
    Amount: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
}, {
    timestamps: false,
    tableName: 'Promotion',
});

module.exports = Promotion;
