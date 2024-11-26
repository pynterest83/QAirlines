const Flight = require('../../models/schemas/Flight');
const TicketClass = require('../../models/schemas/TicketClass');
const { Op, fn, col} = require('sequelize');
const sequelize = require('../../db');
const moment = require('moment-timezone');

// Hàm chuyển đổi thời gian theo múi giờ
function convertToTimeZone(date, timeZone = 'Asia/Ho_Chi_Minh') {
    return moment(date).tz(timeZone).format();
}

// Hàm truy vấn chuyến bay khứ hồi
async function queryRoundTrip(departure, destination, departure_date, return_date) {
    const outboundFlights = await Flight.findAll({
        where: {
            DepID: departure,
            DestID: destination,
            Status: 'Scheduled',
            [Op.and]: [
                sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), departure_date)
            ]
        },
        include: [{
            model: TicketClass,
            as: 'ticketClasses',
            attributes: ['ClassName', 'Price']
        }]
    });

    const returnFlights = await Flight.findAll({
        where: {
            DepID: destination,
            DestID: departure,
            Status: 'Scheduled',
            [Op.and]: [
                sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), return_date)
            ]
        },
        include: [{
            model: TicketClass,
            as: 'ticketClasses',
            attributes: ['ClassName', 'Price']
        }]
    });

    return { outboundFlights, returnFlights };
}

// Hàm xử lý kết quả chuyến bay khứ hồi
function formatRoundTripResults(outboundFlights, returnFlights) {
    return {
        type: "Round-trip",
        outboundFlights: outboundFlights.map(flight => ({
            FlightID: flight.FlightID,
            Status: flight.Status,
            DepTime: convertToTimeZone(flight.DepTime),
            ArrTime: convertToTimeZone(flight.ArrTime),
            BoardingTime: convertToTimeZone(flight.BoardingTime),
            ticketClasses: flight.ticketClasses.map(tc => ({
                ClassName: tc.ClassName,
                Price: tc.Price
            }))
        })),
        returnFlights: returnFlights.map(flight => ({
            FlightID: flight.FlightID,
            Status: flight.Status,
            DepTime: convertToTimeZone(flight.DepTime),
            ArrTime: convertToTimeZone(flight.ArrTime),
            BoardingTime: convertToTimeZone(flight.BoardingTime),
            ticketClasses: flight.ticketClasses.map(tc => ({
                ClassName: tc.ClassName,
                Price: tc.Price
            }))
        }))
    };
}

// Hàm truy vấn chuyến bay một chiều
async function queryOneWay(departure, destination, departure_date) {
    return await Flight.findAll({
        where: {
            DepID: departure,
            DestID: destination,
            Status: 'Scheduled',
            [Op.and]: [
                sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), departure_date)
            ]
        },
        include: [{
            model: TicketClass,
            as: 'ticketClasses',
            attributes: ['ClassName', 'Price']
        }]
    });
}

// Hàm xử lý kết quả chuyến bay một chiều
function formatOneWayResults(flights) {
    return {
        type: "One-way",
        flights: flights.map(flight => ({
            FlightID: flight.FlightID,
            Status: flight.Status,
            DepTime: convertToTimeZone(flight.DepTime),
            ArrTime: convertToTimeZone(flight.ArrTime),
            BoardingTime: convertToTimeZone(flight.BoardingTime),
            ticketClasses: flight.ticketClasses.map(tc => ({
                ClassName: tc.ClassName,
                Price: tc.Price
            }))
        }))
    };
}

// Hàm truy vấn chuyến bay trong khoảng thời gian. Sắp xêp theo thời gian khởi hành.
async function queryFlightsWithinRange(departure, destination, start_date, end_date, ticket_class) {
    const flights = await Flight.findAll({
        where: {
            DepID: departure,
            DestID: destination,
            Status: 'Scheduled',
            [Op.and]: [
                sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), {
                    [Op.between]: [start_date, end_date]
                })
            ]
        },
        include: [{
            model: TicketClass,
            as: 'ticketClasses',
            where: {
                ClassName: ticket_class
            },
            attributes: ['ClassName', 'Price']
        }],
        attributes: [
            'FlightID',
            'DepTime',
            'Status'
        ],
        order: [
            [fn('DATE', col('DepTime')), 'ASC'],
            [col('ticketClasses.Price'), 'ASC']
        ]
    });
    const filteredFlights = [];
    const datesSeen = new Set();

    for (const flight of flights) {
        const depDate = convertToTimeZone(flight.DepTime).split('T')[0];
        if (!datesSeen.has(depDate)) {
            filteredFlights.push(flight);
            datesSeen.add(depDate);
        }
    }

    return filteredFlights;
}


// Hàm xử lý kết quả chuyến bay trong khoảng thời gian
function formatFlightsWithinRangeResults(flights) {
    return {
        type: "In-range",
        flights: flights.map(flight => ({
            FlightID: flight.FlightID,
            Status: flight.Status,
            DepTime: convertToTimeZone(flight.DepTime).split('T')[0],
            MinPrice: flight.ticketClasses[0].Price
        }))
    };
}

module.exports = {
    queryRoundTrip,
    formatRoundTripResults,
    queryOneWay,
    formatOneWayResults,
    queryFlightsWithinRange,
    formatFlightsWithinRangeResults
};
