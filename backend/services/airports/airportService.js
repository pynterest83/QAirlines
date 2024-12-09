const {Flight, Airport} = require("../../models/schemas");
const {Op} = require("sequelize");
const getRelatedAirports = async (airportID) => {
    const flights = await Flight.findAll({
        where: {
            [Op.or]: [
                { DepID: airportID },
                { DestID: airportID }
            ],
            Status: {
                [Op.in]: ['Scheduled', 'Delayed']
            }
        },
        attributes: ['DepID', 'DestID'],
        raw: true
    });

    // Tập hợp thông tin loại chuyến bay cho mỗi sân bay
    const airportTypeMap = {};

    flights.forEach(flight => {
        console.log('DepID:', flight.DepID, 'DestID:', flight.DestID);
        if (flight.DepID === airportID) {
            airportTypeMap[flight.DestID] = airportTypeMap[flight.DestID] === undefined
                ? 'Destination'
                : 'Both';
            console.log('Airport type map:', airportTypeMap[flight.DestID]);
        }

        if (flight.DestID === airportID) {
            airportTypeMap[flight.DepID] = airportTypeMap[flight.DepID] === undefined
                ? 'Departure'
                : 'Both';
            console.log('Airport type map:', airportTypeMap[flight.DepID]);
        }
    });

    // console.log('Airport type map:', airportTypeMap);

    // Lấy danh sách các sân bay liên quan
    const relatedAirports = await Airport.findAll({
        where: {
            AirportID: {
                [Op.in]: Object.keys(airportTypeMap)
            }
        },
        attributes: ['AirportID', 'AirportName', 'City', 'Country']
    });

    // Thêm loại chuyến bay vào kết quả
    return relatedAirports.map(airport => ({
        Type: airportTypeMap[airport.AirportID],
        AirportID: airport.AirportID,
        AirportName: airport.AirportName,
        City: airport.City,
        Country: airport.Country
    }));
};

module.exports = {
    getRelatedAirports
};