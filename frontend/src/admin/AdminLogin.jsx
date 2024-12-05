import {useState} from 'react';
import { useNavigate } from 'react-router-dom';
import { jwtDecode } from "jwt-decode";
import { Server } from '../Server';

const AdminLogin = () => {
    const navigate = useNavigate();
    const [error, loginError] = useState(null)
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
            if (decodedToken.Role !== 'admin') {
                console.error('Access denied: Not an admin');
                return;
            }
            // Store the token in localStorage
            localStorage.setItem('token', data.token);
            // Navigate to /admin
            navigate('/admin');
        } else {
            loginError(data.error)
        }
    };

    return (
        <div className="flex items-center justify-center min-h-screen bg-gray-50">
            <div className="z-10 w-full max-w-md bg-white rounded-lg shadow-md p-6">
                <div className="mb-6">
                <img alt=""
                    src="/logo.png"
                    className="w-full"
                />
                </div>
                <form onSubmit={handleLogin} className="space-y-4">
                <div>
                    <label
                    htmlFor="member-info"
                    className="block text-gray-700 font-medium"
                    >
                    Username
                    </label>
                    <input onChange={() => {if(error) loginError(null)}}
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
                    <input onChange={() => {if(error) loginError(null)}}
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
                {error && <div className="text-red-600">{error}</div>}
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

export default AdminLogin;