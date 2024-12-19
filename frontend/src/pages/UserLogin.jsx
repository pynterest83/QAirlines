import React from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { jwtDecode } from 'jwt-decode'; // Use named import
import { Server } from '../Server';
import ScrollToTop from "../scroll.jsx";

const UserLogin = () => {
    const navigate = useNavigate();

    const handleLogin = async (e) => {
        e.preventDefault();
        const username = e.target.username.value;
        const password = e.target.password.value;

        const response = await fetch(Server + 'auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username, password })
        });

        const data = await response.json();
        if (response.ok) {
            const decodedToken = jwtDecode(data.token);
            console.log('Decoded token:', decodedToken);
            if (decodedToken.Role !== 'User') {
                console.error('Access denied: Not a user');
                return;
            }
            // Store the token in localStorage
            localStorage.setItem('token', data.token);
            // Handle successful login
            console.log('User login successful:', data);
            navigate('/');
        } else {
            // Handle login error
            console.error('User login error:', data.error);
        }
    };

    return (
        <div className="flex items-center justify-center min-h-screen bg-gray-50">
            <ScrollToTop />
            <div className="z-10 w-full max-w-md bg-white rounded-lg shadow-md p-6">
                {/* Image Section */}
                <div className="mb-6">
                    <img
                        src="logo.png"
                        className="w-full"
                    />
                </div>
                {/* Login Form Section */}
                <form onSubmit={handleLogin} className="space-y-4">
                    <div>
                        <label
                            htmlFor="member-info"
                            className="block text-gray-700 font-medium"
                        >
                            Username
                        </label>
                        <input
                            type="text"
                            name="username"
                            className="w-full border-b border-gray-300 focus:border-blue-500 focus:outline-none py-2"
                            placeholder="Enter your username"
                        />
                    </div>
                    <div>
                        <label htmlFor="password" className="block text-gray-700 font-medium">
                            Password
                        </label>
                        <div className="relative">
                            <input
                                type="password"
                                name="password"
                                className="w-full border-b border-gray-300 focus:border-blue-500 focus:outline-none py-2 pr-10"
                                placeholder="Enter your password"
                            />
                            <button
                                type="button"
                                className="absolute inset-y-0 right-0 flex items-center pr-2"
                            >
                            </button>
                        </div>
                    </div>
                    <div className="flex justify-between text-sm text-[#6d24cf]">
                        <Link to="/signup" className="hover:underline">
                            Sign-up
                        </Link>
                        <a href="#" className="hover:underline">
                            Forgot your password
                        </a>
                    </div>
                    <button
                        type="submit"
                        className="w-full bg-yellow-400 text-black py-2 rounded-lg font-semibold hover:bg-yellow-500 transition"
                    >
                        LOGIN
                    </button>
                </form>
            </div>
        </div>
    );
};

export default UserLogin;