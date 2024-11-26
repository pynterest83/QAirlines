import { createRoot } from 'react-dom/client'
import {createBrowserRouter, RouterProvider} from "react-router-dom";
import Homepage from "./pages/Homepage.jsx";
import Admin from "./admin/Admin.jsx";
import './index.css'
import Booking from "./pages/Booking.jsx";
const router = createBrowserRouter([
    {
        path: "/",
        element: <Homepage/>,
    },
    {
        path: "/booking",
        element: <Booking/>
    },
    {
        path: "/admin",
        element: <Admin/>
    },
    {
        path: "/myflight",
        element: <Admin/>
    }
])
createRoot(document.getElementById('root')).render(
    <div>
        <div className="z-0 fixed top-0 left-0 bottom-0 right-0 bg-[#F5F5F5]"/>
        <RouterProvider router={router}/>
    </div>

)
