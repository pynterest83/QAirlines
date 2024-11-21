import React, { useRef } from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation, Autoplay, EffectFade } from "swiper/modules";

import { HiOutlineArrowSmLeft, HiOutlineArrowSmRight } from "react-icons/hi";

import "swiper/css";
import "swiper/css/autoplay";
import "swiper/css/effect-fade";

import { BannerData } from "../assets/data/BannerData";

const Banner = () => {
  const swiperRef = useRef(null);

  return (
    <div className="w-full h-screen relative">
      <Swiper
        ref={swiperRef}
        modules={[Navigation, Autoplay, EffectFade]}
        navigation={{
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        }}
        autoplay={{
          delay: 3000,
          disableOnInteraction: false,
        }}
        effect="fade"
        fadeEffect={{ crossFade: true }}
        slidesPerView={1}
        spaceBetween={0}
        speed={800}
        loop={true}
      >
        {BannerData.map((data, index) => (
          <SwiperSlide key={index} className="relative w-full h-full">
            <img
              src={data.image}
              alt={data.alt}
              className="w-full h-full object-cover"
            />
            <div className="absolute flex gap-2 bottom-4 right-4 z-10">
              <div
                className="w-[30px] h-[30px] border-[1px] border-white text-white flex justify-center items-center rounded-full hover:bg-white hover:text-black cursor-pointer transition duration-200 swiper-button-prev"
              >
                <HiOutlineArrowSmLeft size={20} />
              </div>
              <div
                className="w-[30px] h-[30px] border-[1px] border-white text-white flex justify-center items-center rounded-full hover:bg-white hover:text-black cursor-pointer transition duration-200 swiper-button-next"
              >
                <HiOutlineArrowSmRight size={20} />
              </div>
            </div>
          </SwiperSlide>
        ))}
      </Swiper>
    </div>
  );
};

export default Banner;