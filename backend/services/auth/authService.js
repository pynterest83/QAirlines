const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const User = require('../../models/schemas/User');

function generateUserID() {
    const prefix = 'U';
    const randomPart = Math.random().toString(36).substring(2, 6).toUpperCase();
    const timestampPart = Date.now().toString().slice(-4);
    return `${prefix}${randomPart}${timestampPart}`;
}

async function loginUser(username, password) {
    const user = await User.findOne({ where: { Username: username } });
    if (!user) {
        throw new Error('Tên đăng nhập hoặc mật khẩu không đúng');
    }
    const isPasswordValid = await bcrypt.compare(password, user.Password);
    if (!isPasswordValid) {
        throw new Error('Tên đăng nhập hoặc mật khẩu không đúng');
    }
    const payload = {
        UserID: user.UserID,
        Username: user.Username,
        Role: user.Role
    };
    console.log('Payload khi tạo token:', payload);
    const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });
    return { message: 'Đăng nhập thành công', token };
}

async function registerUser(username, password, role = 'User') {
    const existingUser = await User.findOne({ where: { Username: username } });
    if (existingUser) {
        throw new Error('Tên đăng nhập đã tồn tại');
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    const userID = generateUserID();
    const newUser = await User.create({
        UserID: userID,
        Username: username,
        Password: hashedPassword,
        Role: role,
        CreatedAt: new Date()
    });
    return {
        message: 'Đăng ký thành công',
        user: {
            UserID: newUser.UserID,
            Username: newUser.Username,
            Role: newUser.Role
        }
    };
}

module.exports = {
    loginUser,
    registerUser
};
