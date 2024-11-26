import { useLocation } from "react-router-dom";
import Navigation from "../components/Navigation.jsx";

function MyFlight() {
    const props = useLocation().state
    console.log(props)
    return (
        <>
            <Navigation/>
        </>
    )
}

export default MyFlight