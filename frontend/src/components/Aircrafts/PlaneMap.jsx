import {useEffect, useRef, useState} from "react";

function PlaneMap(props) {
    const [mapData, setMapData] = useState([])
    const rawCoords = useRef([])
    const mapDescription = useRef(null)
    const PlaneImage = useRef(null)
    const scale = useRef(1)
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
        fetch(props.json).then(r => {
            if (r.ok) r.json().then(_data => {
                scale.current = PlaneImage.current.width / PlaneImage.current.naturalWidth
                old.current = PlaneImage.current.width
                rawCoords.current = Array.from(_data, (e) => e[0])
                ScaleMap()
                mapDescription.current = Array.from(_data, e => [e[1], e[2]])
            })
        })
    }
    useEffect(() => {
        const resizeObserver = new ResizeObserver(() => {
            if (old.current !== PlaneImage.current.width) {
                setShow(null)
                scale.current = PlaneImage.current.width / PlaneImage.current.naturalWidth
                old.current = PlaneImage.current.width
                ScaleMap()
            }
        });
        resizeObserver.observe(PlaneImage.current);
        document.onclick = () => {
            setShow(null)
        }
        return () => resizeObserver.disconnect()
    }, []);
    const [isShowing, setShow] = useState(null)
    const ImageContainer = useRef(null)
    const [mousePos, setMousePos] = useState({x:0, y:0})
    const info = useRef("")
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
    }
    return (
        <div ref={ImageContainer} className="relative mx-auto bg-white w-full lg:w-1/2">
            <img onLoad={SetMap} ref={PlaneImage} className="w-full h-auto"
                 draggable="false"
                 src={props.image}
                 useMap="#seatmap" alt=""/>
            <map name="seatmap">
                {mapData.map((rect, index) =>
                    <area className="cursor-pointer" key={index} alt="" shape="rect" coords={rect}
                          onClick={(e) => Show(e, index)}
                    />)}
            </map>
            {isShowing &&
                <div className="border-[#af4b41] border-[5px] absolute rounded-[4px]"
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
                </div>
            }
        </div>
    )
}

export default PlaneMap