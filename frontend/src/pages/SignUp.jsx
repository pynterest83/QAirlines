// frontend/src/pages/SignUp.jsx
import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { Server } from '../Server';

const SignUp = () => {
    const navigate = useNavigate();
    const [passwordError, setPasswordError] = useState('');

    const handleSignUp = async (e) => {
        e.preventDefault();
        const username = e.target.username.value;
        const password = e.target.password.value;
        const confirmPassword = e.target.confirmPassword.value;

        if (password !== confirmPassword) {
            setPasswordError('Passwords do not match');
            return;
        }

        const response = await fetch(Server + 'auth/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username, password })
        });

        const data = await response.json();
        if (response.ok) {
            // Handle successful registration
            console.log('User registration successful:', data);
            navigate('/login');
        } else {
            // Handle registration error
            console.error('User registration error:', data.error);
        }
    };

    return (
        <div className="flex items-center justify-center min-h-screen bg-gray-50">
            <div className="z-10 w-full max-w-md bg-white rounded-lg shadow-md p-6">
                {/* Image Section */}
                <div className="mb-6">
                    <img
                        src="logo.png"
                        className="w-full"
                    />
                </div>
                {/* Sign Up Form Section */}
                <form onSubmit={handleSignUp} className="space-y-4">
                    <div>
                        <label
                            htmlFor="username"
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
                        </div>
                    </div>
                    <div>
                        <label htmlFor="confirmPassword" className="block text-gray-700 font-medium">
                            Confirm Password
                        </label>
                        <div className="relative">
                            <input
                                type="password"
                                name="confirmPassword"
                                className="w-full border-b border-gray-300 focus:border-blue-500 focus:outline-none py-2 pr-10"
                                placeholder="Confirm your password"
                            />
                        </div>
                        {passwordError && <p className="text-red-500 text-sm">{passwordError}</p>}
                    </div>
                    <div className="flex justify-between text-sm text-[#6d24cf]">
                        <Link to="/login" className="hover:underline">
                            Login
                        </Link>
                        <a href="#" className="hover:underline">
                            Forgot your password
                        </a>
                    </div>
                    <button
                        type="submit"
                        className="w-full bg-yellow-400 text-black py-2 rounded-lg font-semibold hover:bg-yellow-500 transition"
                    >
                        SIGN UP
                    </button>
                </form>
            </div>
        </div>
    );
};

export default SignUp;