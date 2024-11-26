import React, { useRef } from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation, Autoplay, EffectFade } from "swiper/modules";

import { HiOutlineArrowSmLeft, HiOutlineArrowSmRight } from "react-icons/hi";
import HomeBox from "./HomeBox";

import "swiper/css";
import "swiper/css/autoplay";
import "swiper/css/effect-fade";

import { BannerData } from "../../assets/data/BannerData";

const Banner = () => {
  const swiperRef = useRef(null);

  const handleNext = () => {
    swiperRef.current.swiper.slideNext();
  };

  const handlePrev = () => {
    swiperRef.current.swiper.slidePrev();
  };

  return (
    <div className="w-full h-[95vh] relative">
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
        className="w-full h-full hidden md:block"
      >
        {BannerData.map((data, index) => (
          <SwiperSlide key={index} className="relative w-full h-full">
            <div className="w-full h-full overflow-hidden">
              <img
                src={data.image}
                alt={data.alt}
                className="w-full h-full object-cover"
                style={{ objectFit: 'cover', width: '100%', height: '100%' }}
              />
            </div>
          </SwiperSlide>
        ))}
      </Swiper>

      {/* Custom navigation buttons */}
      <div
        onClick={handlePrev}
        className="absolute left-4 top-1/2 transform -translate-y-1/2 z-20 cursor-pointer w-[30px] h-[30px] border-[1px] border-white text-white flex justify-center items-center rounded-full hover:bg-white hover:text-black transition duration-200 hidden md:flex"
      >
        <HiOutlineArrowSmLeft size={20} />
      </div>
      <div
        onClick={handleNext}
        className="absolute right-4 top-1/2 transform -translate-y-1/2 z-20 cursor-pointer w-[30px] h-[30px] border-[1px] border-white text-white flex justify-center items-center rounded-full hover:bg-white hover:text-black transition duration-200 hidden md:flex"
      >
        <HiOutlineArrowSmRight size={20} />
      </div>

      {/* HomeBox positioned at the top on small screens and at the bottom on medium and larger screens */}
      <div className="absolute top-10 left-0 right-0 p-4 z-10 md:bottom-0 md:top-auto">
        <HomeBox />
      </div>
    </div>
  );
};

export default Banner;