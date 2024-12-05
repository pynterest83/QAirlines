const { getAllAircraft, createAircraft } = require("../services/aircrafts/aircraftService");

exports.handleGetAircrafts = async (req, res) => {
    const aircraftIds = req.query.aircraftIds ? req.query.aircraftIds.split(',') : [];
    try {
        const aircrafts = await getAllAircraft(aircraftIds);
        res.json(aircrafts);
    } catch (error) {
        console.error('Error fetching aircrafts:', error.message);
        res.status(500).json({ error: error.message });
    }
}

exports.handleCreateAircraft = async (req, res) => {
    try {
        const { seats, ...aircraft } = req.body;
        const svgFile = req.files?.svg;
        const jsonFile = req.files?.json;

        // Xử lý seats (convert từ chuỗi JSON nếu cần)
        const parsedSeats = typeof seats === 'string' ? JSON.parse(seats) : seats;

        // Gọi service tạo aircraft
        await createAircraft(aircraft, parsedSeats, svgFile, jsonFile);

        res.status(201).json({
            message: 'Aircraft created successfully',
        });
    } catch (error) {
        console.error('Error creating aircraft:', error.message);
        res.status(400).json({ error: error.message });
    }
};