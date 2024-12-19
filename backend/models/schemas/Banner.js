const { DataTypes } = require('sequelize');
const sequelize = require('../../db');

const Banner = sequelize.define('Banner', {
    BannerID: {
        type: DataTypes.STRING(10),
        primaryKey: true,
    },
    Title: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
    Description: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    ImageURL: {
        type: DataTypes.STRING(255),
        allowNull: false,
    },
    DiscountTitle: {
        type: DataTypes.STRING(50),
        allowNull: true,
    },
    DiscountDescription: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
}, {
    timestamps: false,
    tableName: 'Banner',
})

module.exports = Banner;