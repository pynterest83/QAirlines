const authService = require('../services/auth/authService');

exports.login = async (req, res) => {
    const { username, password } = req.body;

    try {
        const result = await authService.loginUser(username, password);
        res.json(result);
    } catch (error) {
        console.error('Error during login:', error.message);
        res.status(401).json({ error: error.message });
    }
};

exports.register = async (req, res) => {
    const { username, password, role } = req.body;

    try {
        const result = await authService.registerUser(username, password, role);
        res.status(201).json(result);
    } catch (error) {
        if (error.message === 'Tên đăng nhập đã tồn tại') {
            return res.status(400).json({ error: error.message });
        }
        console.error('Lỗi trong quá trình đăng ký:', error);
        res.status(500).json({ error: 'Đã xảy ra lỗi trong quá trình đăng ký' });
    }
};