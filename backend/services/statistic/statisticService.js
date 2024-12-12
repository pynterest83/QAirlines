require('dotenv').config({
    path: './../../../.env'
});
const {Ticket} = require("../../models/schemas");
const {Op, fn, col, literal} = require("sequelize");

const getMonthlyBookingStatistic = async (year) => {
    const command = process.env.DB_TYPE === 'postgres'
        ? 'EXTRACT(MONTH FROM "CancellationDeadline")'
        : 'MONTH(CancellationDeadline)';
    const statistics = await Ticket.findAll({
        attributes: [
            [literal(command), 'month'],
            [fn('COUNT', col('TicketID')), 'bookingCount']
        ],
        where: {
            CancellationDeadline: {
                [Op.between]: [
                    new Date(year, 0, 1), 
                    new Date(year, 11, 31) 
                ],
            },
        },
        group: [literal(command)],
        order: [[literal(command), 'ASC']]
    });

    const monthlyStatistics = Array.from({ length: 12 }, (_, i) => ({
        month: i + 1,
        bookingCount: 0
    }));

    statistics.forEach(stat => {
        const monthIndex = stat.dataValues.month - 1;
        monthlyStatistics[monthIndex].bookingCount = parseInt(stat.dataValues.bookingCount, 10);
    });

    return monthlyStatistics;
};

module.exports = {
    getMonthlyBookingStatistic
};