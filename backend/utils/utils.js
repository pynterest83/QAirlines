const moment = require("moment-timezone");

function convertToTimeZone(date, timeZone = 'Asia/Ho_Chi_Minh') {
    return moment(date).tz(timeZone).format();
}

module.exports = {convertToTimeZone};