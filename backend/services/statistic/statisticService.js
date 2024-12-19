require('dotenv').config({
    path: './../../../.env'
});

const {literal, col, Op, fn} = require("sequelize");
const {Ticket, TicketClass, Seat, FlightSeat} = require("../../models/schemas");

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

const getMonthlyIncomeStatistic = async (year) => {
    try {
        const startDate = new Date(`${year}-01-01`);
        const endDate = new Date(`${parseInt(year) + 1}-01-01`);

        // Step 1: Get all tickets with associated flight seats and classes for the specified year
        const ticketData = await FlightSeat.findAll({
            where: {
                TicketID: { [Op.not]: null },
            },
            include: [
                {
                    model: Ticket,
                    attributes: ['TicketID', 'FlightID', 'CancellationDeadline'],
                    where: {
                        CancellationDeadline: {
                            [Op.between]: [startDate, endDate],
                        },
                    },
                },
                {
                    model: Seat,
                    as: 'seatDetails',
                    attributes: ['Class'],
                },
            ],
        });

        console.log('Ticket Data:', JSON.stringify(ticketData, null, 2));

        // Step 2: Map ticket classes to their prices
        const ticketClasses = await TicketClass.findAll({
            attributes: ['ClassName', 'FlightID', 'Price'],
        });

        console.log('Ticket Classes:', JSON.stringify(ticketClasses, null, 2));

        const classPriceMap = ticketClasses.reduce((acc, item) => {
            acc[`${item.ClassName}-${item.FlightID}`] = parseFloat(item.Price);
            return acc;
        }, {});

        console.log('Class Price Map:', classPriceMap);

        const monthlyIncomeMap = {};

        ticketData.forEach((seat) => {
            const ticket = seat.Ticket;
            const seatDetails = seat.seatDetails;

            if (!ticket || !seatDetails) return;

            const flightID = ticket.FlightID;
            const className = seatDetails.Class;

            const cancellationDate = new Date(ticket.CancellationDeadline);
            const month = cancellationDate.getUTCMonth() + 1; // Months are zero-based

            const priceKey = `${className}-${flightID}`;
            const price = classPriceMap[priceKey] || 0;

            monthlyIncomeMap[month] = (monthlyIncomeMap[month] || 0) + price;
        });

        console.log('Monthly Income Map:', monthlyIncomeMap);

        // Step 3: Format the result for all 12 months
        const result = Array.from({ length: 12 }, (_, i) => ({
            month: i + 1,
            totalIncome: monthlyIncomeMap[i + 1] || 0,
        }));

        console.log('Final Result:', result);

        return result;
    } catch (error) {
        console.error('Error calculating monthly income statistics:', error.message);
        throw new Error('Failed to calculate monthly income statistics');
    }
};

module.exports = {
    getMonthlyBookingStatistic,
    getMonthlyIncomeStatistic,
};