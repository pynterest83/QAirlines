const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const User = require('../../models/schemas/User');

// Hàm tạo UserID ngẫu nhiên
function generateUserID() {
    const prefix = 'U';
    const randomPart = Math.random().toString(36).substring(2, 6).toUpperCase();
    const timestampPart = Date.now().toString().slice(-4);
    return `${prefix}${randomPart}${timestampPart}`;
}

// Hàm đăng nhập
async function loginUser(username, password) {
    // Tìm người dùng trong cơ sở dữ liệu
    const user = await User.findOne({ where: { Username: username } });
    if (!user) {
        throw new Error('Tên đăng nhập hoặc mật khẩu không đúng');
    }

    // So sánh mật khẩu đã mã hóa
    const isPasswordValid = await bcrypt.compare(password, user.Password);
    if (!isPasswordValid) {
        throw new Error('Tên đăng nhập hoặc mật khẩu không đúng');
    }

    // Tạo payload cho token
    const payload = {
        UserID: user.UserID,
        Username: user.Username,
        Role: user.Role
    };

    console.log('Payload khi tạo token:', payload);

    // Tạo token với thời gian sống 1 giờ
    const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });

    return { message: 'Đăng nhập thành công', token };
}

// Hàm đăng ký
async function registerUser(username, password, role = 'User') {
    // Kiểm tra username đã tồn tại chưa
    const existingUser = await User.findOne({ where: { Username: username } });
    if (existingUser) {
        throw new Error('Tên đăng nhập đã tồn tại');
    }

    // Mã hóa mật khẩu
    const hashedPassword = await bcrypt.hash(password, 10);

    // Tạo UserID ngẫu nhiên
    const userID = generateUserID();

    // Tạo người dùng mới trong cơ sở dữ liệu
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
