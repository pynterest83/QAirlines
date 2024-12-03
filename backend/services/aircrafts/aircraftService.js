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

async function createAircraft(aircraft, seats) {
    const existingAircraft = await Aircraft.findByPk(aircraft.AircraftID);
    if (existingAircraft) {
        throw new Error('Aircraft already exists');
    }

    // Start transaction
    const transaction = await Aircraft.sequelize.transaction();
    try {
        // Create Aircraft
        await Aircraft.create(
            {
                AircraftID: aircraft.AircraftID,
                Model: aircraft.Model,
                Manufacturer: aircraft.Manufacturer,
                Capacity: aircraft.Capacity
            },
            { transaction }
        );

        // Create Seats
        const seatData = seats.map(seat => ({
            AircraftID: aircraft.AircraftID,
            SeatNo: seat.SeatNo,
            Class: seat.Class
        }));

        await Seat.bulkCreate(seatData, { transaction });

        // Commit transaction
        await transaction.commit();
    } catch (error) {
        await transaction.rollback();
        throw error;
    }
}



module.exports = {
    getAllAircraft,
    createAircraft
}
