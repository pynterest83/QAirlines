import Navigation from "../components/Navigation.jsx";
import {useEffect, useRef, useState} from "react";
import {Server} from "../Server.js";
import {useLocation} from "react-router-dom";
function BinarySearch(element, array) {
    let start = 0;
    let end = array.length - 1;

    while (start <= end) {
        let middle = Math.floor((start + end) / 2);
        if (array[middle] === element) {
            return array[middle];
        } else if (array[middle] < element) {
            start = middle + 1;
        } else {
            end = middle - 1;
        }
    }
    return null;
}
function Booking() {
    const props = useLocation().state.trip
    const [mapData, setMapData] = useState([])
    const rawData = useRef([])
    const [mapDescription, setDescription] = useState(null)
    const PlaneImage = useRef(null)
    const scale = useRef(1)
    const availableSeat = useRef([])
    function ScaleMap() {
        let temp = rawData.current.slice()
        temp.forEach((el, index) => {
            let coords = el.split(",")
            temp[index] = Math.round(coords[0] * scale.current)
                + "," + Math.round(coords[1] * scale.current)
                + "," + Math.round(coords[2] * scale.current)
                + "," + Math.round(coords[3] * scale.current)
        })
        setMapData(temp)
    }
    const old = useRef(0)
    useEffect(() => {
        old.current = PlaneImage.current.width
        scale.current = PlaneImage.current.width / PlaneImage.current.naturalWidth
        const resizeObserver = new ResizeObserver(() => {
            if (old.current !== PlaneImage.current.width) {
                scale.current = PlaneImage.current.width / PlaneImage.current.naturalWidth
                old.current = PlaneImage.current.width
                ScaleMap()
            }
        });
        resizeObserver.observe(PlaneImage.current);

        fetch("maps/" + props[0].AircraftID + ".json").then(r => r.json().then(_data => {
            rawData.current = _data
            ScaleMap()
        }))
        fetch("maps/" + props[0].AircraftID + "_d.json").then(r => r.json().then(_data => {
            setDescription(_data)
        }))
        fetch(Server + "seats/available?" + new URLSearchParams({
            flightID: props[0].FlightID,
            class: props[0].ClassType
        })).then(r => {
            if (r.ok) r.json().then(_data => {
                availableSeat.current = _data.availableSeats
            })
        })
        document.onclick = () => setShow(false)
        return () => resizeObserver.disconnect()
    }, []);
    const [isShowing, setShow] = useState(false)
    const ImageContainer = useRef(null)
    const [mousePos, setMousePos] = useState({x:0, y:0})
    const info = useRef("")
    const allowed = useRef(false)
    function Show(e, index) {
        if (!isShowing) setShow(true)
        let positions = mapData[index].split(",")
        setMousePos({
            x: Number(positions[2]) + 5,
            y: Number(positions[1]) + 10
        })
        e.stopPropagation()
        e.preventDefault()
        info.current = mapDescription[index]
        allowed.current = BinarySearch(mapDescription[index][0], availableSeat.current) !== null;
    }
    function ChooseSeat(e) {
        e.preventDefault()
        e.stopPropagation()
    }

    return (
        <div className="relative">
            <Navigation selecting={"booking"}/>
            <div ref={ImageContainer} className="relative mx-auto bg-white w-full lg:w-1/2">
                <img ref={PlaneImage} className="w-full h-auto" src={"/maps/"+ props[0].AircraftID + ".svg"} useMap="#seatmap" alt=""/>
                <map name="seatmap">
                    {mapData.map((rect, index) =>
                        <area className="cursor-pointer" key={rect} alt="" shape="rect" coords={rect} onClick={(e) =>Show(e, index)}/>)}
                </map>
                {isShowing &&
                    <div onClick={(e) => {
                        e.preventDefault()
                        e.stopPropagation()
                    }}
                        className="absolute border-black border rounded-2xl p-4 bg-white"
                         style={{left: mousePos.x, top: mousePos.y}}>
                        <div className="be-vietnam-pro-bold">
                            {info.current[0]}
                        </div>
                        <hr className="border border-black my-2"/>
                        <div>
                            {info.current[1]}
                        </div>
                        <button disabled={!allowed.current}
                            onClick={ChooseSeat}
                                className={(allowed.current ? "hover:bg-[#6d24cf] " : "opacity-60 ") +
                            "mt-2 p-3 bg-[#812af5] text-white rounded-xl be-vietnam-pro-bold"}>
                            {allowed.current ? "Confirm" : "Not available"}
                        </button>
                    </div>
                }
            </div>
        </div>
    )
}

export default Booking