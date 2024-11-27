const { Sequelize } = require('sequelize');

// Khởi tạo Sequelize với cấu hình cơ sở dữ liệu của bạn
const sequelize = new Sequelize('qairline', 'postgres', 'sqlpost644', {
    host: 'localhost',
    dialect: 'postgres',
    define: {
        timestamps: false
    },
    port: 5432,
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    },
    logging: console.log,
    timezone: "+07:00"
});

module.exports = sequelize;
