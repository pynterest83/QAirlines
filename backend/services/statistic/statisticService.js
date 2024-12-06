const {Ticket} = require("../../models/schemas");
const {Op, fn, col, literal} = require("sequelize");

const getMonthlyBookingStatistic = async (year) => {
    const command = "EXTRACT(MONTH FROM `CancellationDeadline`)";
    const statistics = await Ticket.findAll({
        attributes: [
            [literal(command), 'month'],
            [fn('COUNT', col('TicketID')), 'bookingCount']
        ],
        where: {
            CancellationDeadline: {
                [Op.between]: [
                    new Date(year, 0, 1), // Start of the year
                    new Date(year, 11, 31) // End of the year
                ],
            },
        },
        group: [literal(command)],
        order: [[literal(command), 'ASC']]
    });

    // Normalize results to ensure all 12 months are included, even if there's no data
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