const checkAdmin = (req, res, next) => {
    console.log('User in checkAdmin:', req.user);
    if (!req.user) {
        return res.status(401).json({ error: 'Người dùng chưa đăng nhập' });
    }

    if (req.user.Role !== 'admin') {
        return res.status(403).json({ error: 'Bạn không có quyền truy cập vào API này' });
    }

    next();
};

module.exports = checkAdmin;
