const { getAllAircraft, createAircraft } = require("../services/aircrafts/aircraftService");

exports.handleGetAircrafts = async (req, res) => {
    const aircraftIds = req.query.aircraftIds ? req.query.aircraftIds.split(',') : [];
    try {
        const aircrafts = await getAllAircraft(aircraftIds);
        return res.json(aircrafts);
    } catch (error) {
        console.error('Error fetching aircrafts:', error.message);
        return res.status(500).json({ error: error.message });
    }
}

exports.handleCreateAircraft = async (req, res) => {
    try {
        const { seats, ...aircraft } = req.body;
        const svgFile = req.files?.svg;
        const jsonFile = req.files?.json;
        const relatedImages = req.files?.images;
        const imageArray = Array.isArray(relatedImages) ? relatedImages : relatedImages ? [relatedImages] : [];
        await createAircraft(aircraft, svgFile, jsonFile, imageArray);

        return res.status(201).json({
            message: 'Aircraft created successfully',
        });
    } catch (error) {
        console.error('Error creating aircraft:', error.message);
        return res.status(400).json({ error: error.message });
    }
};
