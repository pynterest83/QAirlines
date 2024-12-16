import {useEffect, useRef, useState} from "react";
import {Server} from "../../Server.js";

export function BinarySearch(element, array) {
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
function PlaneMap(props) {
    const [mapData, setMapData] = useState([])
    const rawCoords = useRef([])
    const mapDescription = useRef(null)
    const PlaneImage = useRef(null)
    const scale = useRef(1)
    const [availableSeat, setAvailable] = useState([])
    const [seatList, setList] = useState([])
    const [links, setLinks] = useState({image: "", json: ""})
    function ScaleMap() {
        let temp = rawCoords.current.slice()
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
    function SetMap() {
        scale.current = PlaneImage.current.width / PlaneImage.current.naturalWidth
        ScaleMap()
        props.load(false)
    }
    useEffect(() => {
        setAvailable([])
        old.current = PlaneImage.current.width
        const resizeObserver = new ResizeObserver(() => {
            if (old.current !== PlaneImage.current.width) {
                setShow(null)
                scale.current = PlaneImage.current.width / PlaneImage.current.naturalWidth
                old.current = PlaneImage.current.width
                ScaleMap()
            }
        });
        resizeObserver.observe(PlaneImage.current);

        fetch(Server + "aircrafts/list?aircraftIds=" + props.info.AircraftID).then(r => r.json().then(_data => {
            setLinks({
                image: _data[0].ImagePath,
                json: _data[0].JsonPath
            })
        }))
        fetch(Server + "seats/available?" + new URLSearchParams({
            flightID: props.info.FlightID,
            class: props.info.ClassType
        })).then(r => {
            if (r.ok) r.json().then(_data => {
                setList(_data.availableSeats)
            })
        })
        document.onclick = () => {
            setShow(null)
        }
        return () => resizeObserver.disconnect()
    }, [props.info]);
    useEffect(() => {
        if (!links.json) return
        fetch(links.json).then(r => {
            if (r.ok) r.json().then(_data => {
                rawCoords.current = Array.from(_data, (e) => e[0])
                mapDescription.current = Array.from(_data, e => [e[1], e[2]])
            })
        })
    }, [links]);
    const [isShowing, setShow] = useState(null)
    const ImageContainer = useRef(null)
    const [mousePos, setMousePos] = useState({x:0, y:0})
    const info = useRef("")
    const allowed = useRef(false)
    function Show(e, index) {
        setShow(mapDescription.current[index][0])
        let positions = mapData[index].split(",")
        setMousePos({
            x: Number(positions[0]),
            y: Number(positions[1]),
            z: Number(positions[2]),
            t: Number(positions[3])
        })
        e.stopPropagation()
        e.preventDefault()
        info.current = mapDescription.current[index]
        allowed.current = BinarySearch(mapDescription.current[index][0], availableSeat) !== null;
    }

    useEffect(() => {
        if (props.select.allowed)
            setAvailable(seatList.slice())
        else setAvailable([])
    }, [props.select]);
    function ChooseSeat(e) {
        e.preventDefault()
        e.stopPropagation()
        if (!BinarySearch(isShowing, availableSeat)) return
        props.choose(isShowing)
        setList(seatList.filter(e => e !== isShowing))
        allowed.current = false
        setAvailable([])
    }
    return (
        <div ref={ImageContainer} className="relative mx-auto bg-white w-full lg:w-1/2">
            <img onLoad={SetMap} ref={PlaneImage} className="w-full h-auto"
                 draggable="false"
                 src={links.image}
                 useMap="#seatmap" alt=""/>
            <map name="seatmap">
                {mapData.map((rect, index) =>
                    <area className="cursor-pointer" key={index} alt="" shape="rect" coords={rect}
                          onClick={(e) => Show(e, index)}
                    />)}
            </map>
            {isShowing &&
                <div className={
                    (allowed.current ? "border-green-500 " : "border-[#af4b41] ") +
                    "border-[5px] absolute rounded-[4px]"}
                     style={{
                         left: mousePos.x,
                         top: mousePos.y,
                         width: mousePos.z - mousePos.x,
                         height: mousePos.t - mousePos.y
                     }}
                />}
            {isShowing &&
                <div onClick={(e) => {
                    e.preventDefault()
                    e.stopPropagation()
                }}
                     className="absolute border-black border rounded-2xl p-4 bg-white"
                     style={{left: mousePos.z + 10, top: mousePos.y + 5}}>
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
    )
}

export default PlaneMap