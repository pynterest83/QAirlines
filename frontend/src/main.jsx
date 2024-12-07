import { createRoot } from 'react-dom/client';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';
import Homepage from './pages/Homepage.jsx';
import MyFlight from './pages/MyFlight.jsx';
import Admin from './admin/Admin.jsx';
import AdminLogin from './admin/AdminLogin.jsx';
import UserLogin from './pages/UserLogin.jsx';
import SignUp from './pages/SignUp.jsx';
import './index.css';
import Search from './pages/Search.jsx';
import Booking from './pages/Booking.jsx';
import ProtectedRoute from './admin/ProtectedRoute.jsx';
import MyFlights from './pages/MyFlights.jsx';
import FlightStatus from './pages/FlightStatus.jsx';
import AdminAirCraft from './admin/AdminAirCraft.jsx';
import AdminNotification from './admin/AdminNotification.jsx';
import AdminFlights from './admin/AdminFlights.jsx';
import AdminBanner from './admin/AdminBanner.jsx';
import Aircrafts from "./pages/Aircrafts.jsx";

const router = createBrowserRouter([
    {
        path: '/',
        element: <Homepage />,
    },
    {
        path: '/search',
        element: <Search />,
    },
    {
        path: '/booking',
        element: <Booking />,
    },
    {
        path: '/admin',
        element: (
            <ProtectedRoute role="admin">
                <Admin />
            </ProtectedRoute>
        ),
    },
    {
        path: '/adminLogin',
        element: <AdminLogin />,
    },
    {
        path: '/login',
        element: <UserLogin />,
    },
    {
        path: '/signup',
        element: <SignUp />,
    },
    {
        path: '/myflight',
        element: <MyFlight />,
    },
    {
        path: '/myflights',
        element: <MyFlights />,
    },
    {
        path: '/flightstatus',
        element: <FlightStatus />,
    },
    {
        path: '/aircrafts',
        element: <Aircrafts/>
    },
    {
        path: '/admin/aircraft',
        element: (
            <ProtectedRoute role="admin">
                <AdminAirCraft />
            </ProtectedRoute>
        ),
    },
    {
        path: '/admin/notification',
        element: (
            <ProtectedRoute role="admin">
                <AdminNotification />
            </ProtectedRoute>
        ),
    },
    {
        path: '/admin/flights',
        element: (
            <ProtectedRoute role="admin">
                <AdminFlights />
            </ProtectedRoute>
        ),
    },
    {
        path: '/admin/banner',
        element: (
            <ProtectedRoute role="admin">
                <AdminBanner />
            </ProtectedRoute>
        ),
    },
]);

createRoot(document.getElementById('root')).render(
    <div className="thin-scrollbar">
        <div className="z-0 fixed top-0 left-0 bottom-0 right-0 bg-[#f2f4f7]"/>
        <RouterProvider router={router}/>
    </div>
);