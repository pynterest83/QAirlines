import React from 'react';
import { Navigate } from 'react-router-dom';
import { jwtDecode } from 'jwt-decode';

const ProtectedRoute = ({ children, role }) => {
    const token = localStorage.getItem('token'); // Retrieve the token from local storage

    if (!token) {
        return <Navigate to="/adminLogin" />;
    }

    try {
        const decodedToken = jwtDecode(token); // Decode the token
        if (decodedToken.Role !== role) {
            return <Navigate to="/adminLogin" />;
        }
    } catch (error) {
        console.error('Invalid token:', error);
        return <Navigate to="/adminLogin" />;
    }

    return children;
};

export default ProtectedRoute;