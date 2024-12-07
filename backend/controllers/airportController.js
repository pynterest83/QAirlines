const {getRelatedAirports} = require("../services/airports/airportService");
exports.getRelatedAirports = async (req, res) => {
    try {
        const { airportId } = req.query;

        const relatedAirports = await getRelatedAirports(airportId);

        if (relatedAirports.length === 0) {
            return res.status(404).json({ message: "No related airports found." });
        }

        res.status(200).json({
            airportID: airportId,
            relatedAirports
        });
    } catch (error) {
        console.error("Error fetching related airports:", error.message);
        res.status(500).json({ error: "Failed to fetch related airports." });
    }
};