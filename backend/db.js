const { Sequelize } = require('sequelize');
require('dotenv').config({
    path: './../.env'
});

// Khởi tạo Sequelize với cấu hình cơ sở dữ liệu của bạn
const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD || '', {
    host: process.env.DB_HOST,
    dialect: process.env.DB_DIALECT || 'postgres',
    define: {
        timestamps: false
    },
    port: process.env.DB_PORT,
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    },
});

module.exports = sequelize;