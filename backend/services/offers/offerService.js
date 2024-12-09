const Flight = require('../../models/schemas/Flight');
const TicketClass = require('../../models/schemas/TicketClass');
const { Op, fn, col} = require('sequelize');
const sequelize = require('../../db');
// const { convertToTimeZone } = require('../../utils/utils');
const {Aircraft, FlightSeat, Seat} = require("../../models/schemas");

// Hàm truy vấn chuyến bay khứ hồi
async function queryRoundTrip(departure, destination, departure_date, return_date) {
    const outboundFlights = await Flight.findAll({
        where: {
            DepID: departure,
            DestID: destination,
            [Op.and]: [
                sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), departure_date)
            ]
        },
        include: [
            {
                model: TicketClass,
                as: 'ticketClasses',
                attributes: ['ClassName', 'Price']
            },
            {
                model: Aircraft,
                attributes: ['AircraftID', 'Model', 'Capacity']
            }
        ]
    });

    const returnFlights = await Flight.findAll({
        where: {
            DepID: destination,
            DestID: departure,
            [Op.and]: [
                sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), return_date)
            ]
        },
        include: [
            {
                model: TicketClass,
                as: 'ticketClasses',
                attributes: ['ClassName', 'Price']
            },
            {
                model: Aircraft,
                attributes: ['AircraftID', 'Model', 'Capacity']
            }
        ]
    });

    for (const flight of outboundFlights) {
        for (const ticketClass of flight.ticketClasses) {
            const availableSeats = await FlightSeat.findAll({
                where: {
                    FlightID: flight.FlightID,
                    TicketID: null
                },
                include: [{
                    model: Seat,
                    as: 'seatDetails',
                    where: {
                        Class: ticketClass.ClassName
                    },
                    attributes: ['SeatNo']
                }],
                attributes: []
            });
            ticketClass.dataValues.AvailableSeats = availableSeats.length;
        }
    }

    for (const flight of returnFlights) {
        for (const ticketClass of flight.ticketClasses) {
            const availableSeats = await FlightSeat.findAll({
                where: {
                    FlightID: flight.FlightID,
                    TicketID: null
                },
                include: [{
                    model: Seat,
                    as: 'seatDetails',
                    where: {
                        Class: ticketClass.ClassName
                    },
                    attributes: ['SeatNo']
                }],
                attributes: []
            });
            ticketClass.dataValues.AvailableSeats = availableSeats.length;
        }
    }

    return { outboundFlights, returnFlights };
}

function formatFlightResults(flights) {
    return flights.map(flight => ({
        FlightID: flight.FlightID,
        Status: flight.Status,
        DepID: flight.DepID,
        DestID: flight.DestID,
        // DepTime: convertToTimeZone(flight.DepTime),
        // ArrTime: convertToTimeZone(flight.ArrTime),
        // BoardingTime: convertToTimeZone(flight.BoardingTime),
        // OriginalDepTime: flight.OriginalDepTime ? convertToTimeZone(flight.OriginalDepTime) : null,
        // OriginalArrTime: flight.OriginalArrTime ? convertToTimeZone(flight.OriginalArrTime) : null,
        // OriginalBoardingTime: flight.OriginalBoardingTime ? convertToTimeZone(flight.OriginalBoardingTime) : null,
        DepTime: flight.DepTime,
        ArrTime: flight.ArrTime,
        BoardingTime: flight.BoardingTime,
        OriginalDepTime: flight.OriginalDepTime ? flight.OriginalDepTime : null,
        OriginalArrTime: flight.OriginalArrTime ? flight.OriginalArrTime : null,
        OriginalBoardingTime: flight.OriginalBoardingTime ? flight.OriginalBoardingTime : null,
        ticketClasses: flight.ticketClasses.map(tc => ({
            ClassName: tc.ClassName,
            Price: tc.Price,
            AvailableSeats: tc.dataValues.AvailableSeats || 0
        })),
        Aircraft: {
            AircraftID: flight.Aircraft.AircraftID,
            Model: flight.Aircraft.Model,
            Capacity: flight.Aircraft.Capacity
        }
    }));
}

// Hàm xử lý kết quả chuyến bay khứ hồi
function formatRoundTripResults(outboundFlights, returnFlights) {
    return {
        type: "Round-trip",
        outboundFlights: formatFlightResults(outboundFlights),
        returnFlights: formatFlightResults(returnFlights)
    };
}


// Hàm truy vấn chuyến bay một chiều
async function queryOneWay(departure, destination, departure_date) {
    const flights = await Flight.findAll({
        where: {
            DepID: departure,
            DestID: destination,
            [Op.and]: [
                sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), departure_date)
            ]
        },
        include: [
            {
                model: TicketClass,
                as: 'ticketClasses',
                attributes: ['ClassName', 'Price']
            },
            {
                model: Aircraft,
                attributes: ['AircraftID', 'Model', 'Capacity']
            }
        ],
        order: [['DepTime', 'ASC']],
    });

    for (const flight of flights) {
        for (const ticketClass of flight.ticketClasses) {
            const availableSeats = await FlightSeat.findAll({
                where: {
                    FlightID: flight.FlightID,
                    TicketID: null
                },
                include: [{
                    model: Seat,
                    as: 'seatDetails',
                    where: {
                        Class: ticketClass.ClassName
                    },
                    attributes: ['SeatNo']
                }],
                attributes: []
            });

            ticketClass.dataValues.AvailableSeats = availableSeats.length;
        }
    }

    return flights;
}

// Hàm xử lý kết quả chuyến bay một chiều
function formatOneWayResults(flights) {
    return {
        type: "One-way",
        flights: formatFlightResults(flights)
    };
}

// Hàm truy vấn chuyến bay trong khoảng thời gian. Sắp xêp theo thời gian khởi hành.
async function queryFlightsWithinRange(departure, destination, start_date, end_date, ticket_class) {
    const flights = await Flight.findAll({
        where: {
            DepID: departure,
            DestID: destination,
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
        // const depDate = convertToTimeZone(flight.DepTime).split('T')[0];
        console.log(flight.DepTime);
        const depDate = flight.DepTime.toISOString().split('T')[0];
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
            // DepTime: convertToTimeZone(flight.DepTime).split('T')[0],
            DepTime: flight.DepTime.toISOString().split('T')[0],
            MinPrice: flight.ticketClasses[0].Price
        }))
    };
}

// Hàm lấy tất cả chuyến bay trong ngày
async function queryFlightsByDate(date) {
    const flights = await Flight.findAll({
        where: {
            [Op.and]: [
                sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), date)
            ]
        },
        include: [
            {
                model: TicketClass,
                as: 'ticketClasses',
                attributes: ['ClassName', 'Price']
            },
            {
                model: Aircraft,
                attributes: ['AircraftID', 'Model', 'Capacity']
            }
        ],
        order: [['DepTime', 'ASC']],
    });

    for (const flight of flights) {
        for (const ticketClass of flight.ticketClasses) {
            const availableSeats = await FlightSeat.findAll({
                where: {
                    FlightID: flight.FlightID,
                    TicketID: null
                },
                include: [{
                    model: Seat,
                    as: 'seatDetails',
                    where: {
                        Class: ticketClass.ClassName
                    },
                    attributes: ['SeatNo']
                }],
                attributes: []
            });

            ticketClass.dataValues.AvailableSeats = availableSeats.length;
        }
    }

    return flights;
}

// Hàm xử lý kết quả chuyến bay trong ngày
function formatFlightsByDateResults(flights) {
    return {
        type: "By-date",
        flights: formatFlightResults(flights)
    };
}

module.exports = {
    queryRoundTrip,
    formatRoundTripResults,
    queryOneWay,
    formatOneWayResults,
    queryFlightsWithinRange,
    formatFlightsWithinRangeResults,
    queryFlightsByDate,
    formatFlightsByDateResults
};
