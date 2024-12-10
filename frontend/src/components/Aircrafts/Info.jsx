import {useState} from "react";
import PlaneMap from "./PlaneMap.jsx";
import {AiOutlineClose} from "react-icons/ai";

function Info(props) {
    const [hidden, hide] = useState(true)
    return (
        <div className="shadow-[rgba(0,0,0,0.24)_0px_3px_8px] rounded-xl mx-auto bg-white md:w-[80%] mb-5 md:h-96 my-2 py-5 flex flex-col md:flex-row justify-evenly items-stretch">
            <div className="md:h-full w-full flex-1 pl-10 flex flex-col justify-evenly">
                <div className="be-vietnam-pro-bold text-xl">
                    <div className="be-vietnam-pro-medium text-base">ID</div>
                    {props.info.AircraftID}
                </div>
                <div className="be-vietnam-pro-bold text-xl">
                    <div className="be-vietnam-pro-medium text-base">Model</div>
                    {props.info.Model}
                </div>
                <div className="be-vietnam-pro-bold text-xl">
                    <div className="be-vietnam-pro-medium text-base">Manufacturer</div>
                    {props.info.Manufacturer}
                </div>
                <div className="be-vietnam-pro-bold text-xl">
                    <div className="be-vietnam-pro-medium text-base">Capacity</div>
                    {props.info.Capacity}
                </div>
            </div>
            <div className="md:h-full px-6 relative">
                <img
                     className="h-full object-cover"
                     alt={props.info.Model}
                     src={props.info.RelatedImages}/>
                    <div className="text-transparent hover:text-white flex flex-col transition-opacity hover:bg-black hover:bg-opacity-50 absolute inset-[0_24px_0_24px] z-[5]">
                        <div className="mt-auto text-xl text-center">See the seat map</div>
                        <div onClick={() => hide(false)}
                            className="mx-auto text-xl mb-auto w-fit pointer-events-auto cursor-pointer underline text-center">Details</div>
                    </div>
            </div>
            {!hidden &&
                <div className="z-20 fixed top-[75px] w-[100vw] h-[90vh] overflow-y-scroll bg-white">
                    <PlaneMap
                        json={props.info.JsonPath}
                        image={props.info.ImagePath}/>
                    <button onClick={() => hide(true)} className="fixed top-[85px] right-5 p-3 hover:bg-[#e6e6e6]">
                        <AiOutlineClose/>
                    </button>
                </div>
        }
        </div>
    )
}

export default Info