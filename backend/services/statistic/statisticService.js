const {Ticket} = require("../../models/schemas");
const {Op, fn, col} = require("sequelize");

const getMonthlyBookingStatistic = async (year) => {
    const statistics = await Ticket.findAll({
        attributes: [
            [fn('MONTH', col('CancellationDeadline')), 'month'],
            [fn('COUNT', col('TicketID')), 'bookingCount']
        ],
        where: {
            CancellationDeadline: {
                [Op.between]: [
                    new Date(year, 0, 1), // Ngày đầu năm
                    new Date(year, 11, 31) // Ngày cuối năm
                ],
            },
        },
        group: [fn('MONTH', col('CancellationDeadline'))],
        order: [[fn('MONTH', col('CancellationDeadline')), 'ASC']]
    });

    // Chuẩn hóa kết quả để đảm bảo đủ 12 tháng, kể cả khi không có dữ liệu
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