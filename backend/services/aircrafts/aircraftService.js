const { Aircraft, Seat } = require("../../models/schemas");
const supabase = require("../supabase/supabaseClient");

async function getAllAircraft() {
    return await Aircraft.findAll({
        include: [{
            model: Seat,
            attributes: ['SeatNo', 'Class'],
            order: [['SeatNo', 'ASC']]
        }]
    });
}

async function createAircraft(aircraft, seats, svgFile, jsonFile) {
    const existingAircraft = await Aircraft.findByPk(aircraft.AircraftID);
    if (existingAircraft) {
        throw new Error('Aircraft already exists');
    }

    // Start transaction
    const transaction = await Aircraft.sequelize.transaction();
    try {
        // Upload SVG
        const svgPath = `${aircraft.AircraftID}/${svgFile.name}`;
        const svgUpload = await supabase.storage
            .from('aircraft-files')
            .upload(svgPath, svgFile.data, {
                contentType: 'image/svg+xml',
                upsert: true,
            });
        if (svgUpload.error) throw svgUpload.error;

        // Upload JSON
        const jsonPath = `${aircraft.AircraftID}/${jsonFile.name}`;
        const jsonUpload = await supabase.storage
            .from('aircraft-files')
            .upload(jsonPath, jsonFile.data, {
                contentType: 'application/json',
                upsert: true,
            });
        if (jsonUpload.error) throw jsonUpload.error;

        const svgUrl = supabase.storage.from('aircraft-files').getPublicUrl(svgPath).data.publicUrl;
        const jsonurl = supabase.storage.from('aircraft-files').getPublicUrl(jsonPath).data.publicUrl;

        // Create Aircraft
        await Aircraft.create(
            {
                AircraftID: aircraft.AircraftID,
                Model: aircraft.Model,
                Manufacturer: aircraft.Manufacturer,
                Capacity: aircraft.Capacity,
                ImagePath: svgUrl,
                JsonPath: jsonurl,
            },
            { transaction }
        );

        // Create Seats
        const seatData = seats.map(seat => ({
            AircraftID: aircraft.AircraftID,
            SeatNo: seat.SeatNo,
            Class: seat.Class,
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
