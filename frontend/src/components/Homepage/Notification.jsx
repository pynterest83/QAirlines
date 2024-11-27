import React, { useEffect, useState } from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Autoplay } from "swiper/modules";
import "swiper/css";
import "swiper/css/autoplay"; // Ensure autoplay CSS is imported
import { Server } from "../../Server";

const Notification = () => {
  // Array of news items
  const [newsItems, setNewsItems] = useState([]);

  useEffect(() => {
    // Fetch news items from server
    fetch(Server + "/promotions/list")
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        setNewsItems(data);
      });
  }, []);

  return (
    <div className="max-w-4xl mx-auto mt-6 mb-6"> {/* Added mb-6 for margin bottom */}
      <div className="relative flex items-center justify-between p-4 bg-white shadow-sm rounded-lg border border-gray-200">
        {/* Static Left Section */}
        <div className="flex items-center gap-3 border-r border-gray-300 pr-4">
          <i className="fas fa-calendar-alt text-[#6d24cf] text-lg"></i>
          <span className="font-semibold text-[#6d24cf]">Tin tức</span>
        </div>
        {/* Scrolling Middle Section */}
        <div className="flex-1 mx-4">
          <Swiper
            modules={[Autoplay]}
            direction="vertical"
            spaceBetween={10}
            slidesPerView={1}
            autoplay={{ delay: 3000 }}
            loop={true}
            className="bg-white shadow-sm rounded-lg border border-gray-200"
            style={{ height: "100px" }}
          >
            {newsItems.map((news) => (
              <SwiperSlide key={news.PromotionID}>
                <div className="relative flex items-center justify-between p-4 h-full">
                  {/* Date and Notification */}
                  <div className="flex-1 ml-4">
                    <p className="text-sm text-gray-500 mb-1">{news.Title}</p>
                    <a
                      href="#"
                      className="text-[#6d24cf] font-medium text-sm hover:underline"
                    >
                      {news.Content}
                    </a>
                  </div>
                </div>
              </SwiperSlide>
            ))}
          </Swiper>
        </div>
        {/* Static Right Section */}
        <div className="flex items-center gap-3 border-l border-gray-300 pl-4">
          <a
            href="#"
            className="text-[#6d24cf] text-sm font-semibold hover:underline flex items-center"
          >
            Xem Thêm <i className="fas fa-arrow-right ml-1"></i>
          </a>
        </div>
      </div>
    </div>
  );
};

export default Notification;