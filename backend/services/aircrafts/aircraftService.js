const { Aircraft, Seat } = require("../../models/schemas");
const supabase = require("../supabase/supabaseClient");

async function getAllAircraft(aircraftIds) {
    if (aircraftIds.length === 0) {
        return await Aircraft.findAll({
            include: [{
                model: Seat,
                attributes: ['SeatNo', 'Class'],
                order: [['SeatNo', 'ASC']]
            }]
        });
    }
    return await Aircraft.findAll({
        where: {
            AircraftID: aircraftIds
        },
        include: [{
            model: Seat,
            attributes: ['SeatNo', 'Class'],
            order: [['SeatNo', 'ASC']]
        }]
    });
}

async function createAircraft(aircraft, seats, svgFile, jsonFile, relatedImages) {
    const existingAircraft = await Aircraft.findByPk(aircraft.AircraftID);
    if (existingAircraft) {
        throw new Error('Aircraft already exists');
    }

    const transaction = await Aircraft.sequelize.transaction();
    try {
        let svgUrl = null;
        let jsonUrl = null;

        // Upload SVG nếu có
        if (svgFile) {
            const svgPath = `${aircraft.AircraftID}/${svgFile.name}`;
            const svgUpload = await supabase.storage
                .from('aircraft-files')
                .upload(svgPath, svgFile.data, {
                    contentType: 'image/svg+xml',
                    upsert: true,
                });
            if (svgUpload.error) throw svgUpload.error;
            svgUrl = supabase.storage.from('aircraft-files').getPublicUrl(svgPath).data.publicUrl;
        }

        // Upload JSON nếu có
        if (jsonFile) {
            const jsonPath = `${aircraft.AircraftID}/${jsonFile.name}`;
            const jsonUpload = await supabase.storage
                .from('aircraft-files')
                .upload(jsonPath, jsonFile.data, {
                    contentType: 'application/json',
                    upsert: true,
                });
            if (jsonUpload.error) throw jsonUpload.error;
            jsonUrl = supabase.storage.from('aircraft-files').getPublicUrl(jsonPath).data.publicUrl;
        }

        // Upload các ảnh liên quan
        let relatedImageUrls = "";
        for (const image of relatedImages) {
            const imagePath = `${aircraft.AircraftID}/related-images/${image.name}`;
            const imageUpload = await supabase.storage
                .from('aircraft-files')
                .upload(imagePath, image.data, {
                    contentType: image.mimetype,
                    upsert: true,
                });
            if (imageUpload.error) throw imageUpload.error;

            const imageUrl = supabase.storage.from('aircraft-files').getPublicUrl(imagePath).data.publicUrl;
            relatedImageUrls += imageUrl + ",";
        }
        if (relatedImageUrls.length === 0) relatedImageUrls = null;
        else relatedImageUrls = relatedImageUrls.slice(0, -1);

        // Tạo Aircraft
        await Aircraft.create(
            {
                AircraftID: aircraft.AircraftID,
                Model: aircraft.Model,
                Manufacturer: aircraft.Manufacturer,
                Capacity: aircraft.Capacity,
                ImagePath: svgUrl,
                JsonPath: jsonUrl,
                RelatedImages: relatedImageUrls
            },
            { transaction }
        );

        // Tạo Seats
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
