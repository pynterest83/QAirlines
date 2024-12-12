const checkAdmin = (req, res, next) => {
    console.log('User in checkAdmin:', req.user);
    if (!req.user) {
        return res.status(401).json({ error: 'User not logged in' });
    }

    if (req.user.Role !== 'admin') {
        return res.status(403).json({ error: 'You do not have permission to access this API' });
    }

    next();
};

module.exports = checkAdmin;