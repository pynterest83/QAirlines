const {Aircraft, Seat} = require("../../models/schemas");

async function getAllAircraft() {
    return await Aircraft.findAll({
        include: [{
            model: Seat,
            attributes: ['SeatNo', 'Class'],
            order: [['SeatNo', 'ASC']]
        }]
    });
}

module.exports = {
    getAllAircraft
}
