import airports from '../../airports.json';

export const AirportData = airports.reduce((acc, airport) => {
    acc[airport[0]] = airport[2];
    return acc;
}, {});