const Flight = require('../models/Flight');
const TicketClass = require('../models/TicketClass');
const { Op } = require('sequelize');
const sequelize = require('../db');
const moment = require('moment-timezone'); // Import moment-timezone

// Hàm chuyển đổi thời gian theo múi giờ mong muốn
function convertToTimeZone(date, timeZone = 'Asia/Ho_Chi_Minh') {
    return moment(date).tz(timeZone).format();
}

// Hàm truy vấn chuyến bay khứ hồi
async function queryRoundTrip(departure, destination, departure_date, return_date) {
    try {
        // Truy vấn chuyến bay đi
        const outboundFlights = await Flight.findAll({
            where: {
                DepID: departure,
                DestID: destination,
                Status: 'Scheduled',
                [Op.and]: [
                    sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), departure_date)
                ]
            },
            include: [
                {
                    model: TicketClass,
                    as: 'ticketClasses',
                    attributes: ['ClassName', 'Price']
                }
            ]
        });

        // Truy vấn chuyến bay về
        const returnFlights = await Flight.findAll({
            where: {
                DepID: destination,
                DestID: departure,
                Status: 'Scheduled',
                [Op.and]: [
                    sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), return_date)
                ]
            },
            include: [
                {
                    model: TicketClass,
                    as: 'ticketClasses',
                    attributes: ['ClassName', 'Price']
                }
            ]
        });

        return { outboundFlights, returnFlights };
    } catch (error) {
        console.error('Error fetching round-trip flights:', error);
        throw error;
    }
}

// Hàm xử lý kết quả chuyến bay khứ hồi
function handleRoundTripResults(outboundFlights, returnFlights) {
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

// Controller cho chuyến bay khứ hồi
exports.getRoundTripFlights = async (req, res) => {
    const { departure, destination, departure_date, return_date } = req.query;
    try {
        const { outboundFlights, returnFlights } = await queryRoundTrip(departure, destination, departure_date, return_date);

        // Kiểm tra xem cả chiều đi và chiều về có tồn tại không
        if (outboundFlights.length === 0 || returnFlights.length === 0) {
            return res.status(404).json({ error: 'Không tìm thấy chuyến bay khứ hồi phù hợp' });
        }

        res.json(handleRoundTripResults(outboundFlights, returnFlights));
    } catch (error) {
        res.status(500).json({ error: 'Lỗi khi truy vấn cơ sở dữ liệu' });
    }
};

// Hàm truy vấn chuyến bay một chiều
async function queryOneWay(departure, destination, departure_date) {
    try {
        const flights = await Flight.findAll({
            where: {
                DepID: departure,
                DestID: destination,
                Status: 'Scheduled',
                [Op.and]: [
                    sequelize.where(sequelize.fn('DATE', sequelize.col('DepTime')), departure_date)
                ]
            },
            include: [
                {
                    model: TicketClass,
                    as: 'ticketClasses',
                    attributes: ['ClassName', 'Price']
                }
            ]
        });

        return flights;
    } catch (error) {
        console.error('Error fetching one-way flights:', error);
        throw error;
    }
}

// Hàm xử lý kết quả chuyến bay một chiều
function handleOneWayResults(flights) {
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

// Controller cho chuyến bay một chiều
exports.getOneWayFlights = async (req, res) => {
    const { departure, destination, departure_date } = req.query;
    try {
        const flights = await queryOneWay(departure, destination, departure_date);
        res.json(handleOneWayResults(flights));
    } catch (error) {
        res.status(500).json({ error: 'Lỗi khi truy vấn cơ sở dữ liệu' });
    }
};
