const jwt = require('jsonwebtoken');

const authenticateUser = (req, res, next) => {
    const authHeader = req.headers.authorization;

    // Kiểm tra xem header có chứa token hay không
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ error: 'Không tìm thấy token Bearer' });
    }

    const token = authHeader.split(' ')[1]; // Lấy token từ header

    try {
        // Giải mã token
        req.user = jwt.verify(token, process.env.JWT_SECRET); // Gắn thông tin user vào req
        next(); // Chuyển sang middleware tiếp theo
    } catch (error) {
        console.error('Lỗi xác thực token:', error.message);
        res.status(401).json({ error: 'Token không hợp lệ hoặc đã hết hạn' });
    }
};

module.exports = authenticateUser;
