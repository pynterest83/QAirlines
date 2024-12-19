import {useEffect, useState} from "react";
import {Server} from "../Server.js";
import Info from "../components/Aircrafts/Info.jsx";
import Navigation from "../components/Navigation.jsx";
import ScrollToTop from "../scroll.jsx";

function Aircrafts() {
    const [aircrafts, setAircrafts] = useState([])
    useEffect(() => {
        fetch(Server + "aircrafts/list").then(r => {
            if (r.ok) r.json().then(data => {
                setAircrafts(data)
            })
        })
    }, []);
    return (
        <div className="relative">
            <ScrollToTop/>
            <Navigation selecting="help"/>
            {aircrafts.map(aircraft =>
                <Info info={aircraft} key={aircraft.AircraftID}/>
            )}
        </div>
    )
}

export default Aircrafts