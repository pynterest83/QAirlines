import { useState, useEffect } from "react";
import PlaneMap from "./PlaneMap.jsx";
import { AiOutlineClose } from "react-icons/ai";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation, Autoplay, EffectFade } from "swiper/modules";

import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/autoplay";
import "swiper/css/effect-fade";

function Info(props) {
    const [hidden, hide] = useState(true);
    const [relatedImages, setRelatedImages] = useState([]);

    useEffect(() => {
        if (props.info.RelatedImages) {
            const images = props.info.RelatedImages.split(",").map((img) => img.trim());
            setRelatedImages(images);
        }
    }, [props.info.RelatedImages]);

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

            {relatedImages.length > 0 && (
                <div className="md:h-full px-6 relative w-full md:w-[50%]">
                    <Swiper
                        modules={[Navigation, Autoplay, EffectFade]}
                        spaceBetween={0}
                        slidesPerView={1}
                        autoplay={{ delay: 3000 }}
                        loop
                        effect="fade"
                        fadeEffect={{ crossFade: true }}
                        className="h-full rounded-lg overflow-hidden"
                    >
                        {relatedImages.map((image, index) => (
                            <SwiperSlide key={index}>
                                <img
                                    src={image}
                                    alt={`Related ${props.info.Model} ${index}`}
                                    className="h-full w-full object-cover"
                                />
                            </SwiperSlide>
                        ))}
                    </Swiper>

                    <div className="text-transparent hover:text-white flex flex-col transition-opacity hover:bg-black hover:bg-opacity-50 absolute inset-[0_24px_0_24px] z-[5]">
                        <div className="mt-auto text-xl text-center">See the seat map</div>
                        <div
                            onClick={() => hide(false)}
                            className="mx-auto text-xl mb-auto w-fit pointer-events-auto cursor-pointer underline text-center"
                        >
                            Details
                        </div>
                    </div>
                </div>
            )}

            {!hidden && (
                <div className="z-20 fixed top-[75px] w-[100vw] h-[90vh] overflow-y-scroll bg-white">
                    <PlaneMap json={props.info.JsonPath} image={props.info.ImagePath} />
                    <button onClick={() => hide(true)} className="fixed top-[85px] right-5 p-3 hover:bg-[#e6e6e6]">
                        <AiOutlineClose />
                    </button>
                </div>
            )}
        </div>
    );
}

export default Info;