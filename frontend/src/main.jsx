import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import {createBrowserRouter, RouterProvider} from "react-router-dom";
import Homepage from "./pages/Homepage.jsx";
import Admin from "./admin/Admin.jsx";
import './index.css'
const router = createBrowserRouter([
    {
        path: "/",
        element: <Homepage/>,
    },
    {
        path: "/admin",
        element: <Admin/>
    }
])
createRoot(document.getElementById('root')).render(
  <StrictMode>
    <RouterProvider router={router}/>
  </StrictMode>,
)
