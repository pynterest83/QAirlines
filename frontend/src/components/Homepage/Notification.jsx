import React from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Autoplay } from "swiper/modules";
import "swiper/css";
import { Server } from "../../Server.js";

const NotificationBar = () => {
  // Array of news items
  const newsItems = [
    {
      id: 1,
      date: "02/10/2024",
      title: "Thông báo về việc làm thủ tục trực tuyến từ sân bay Phù Cát (Quy Nhơn)",
      link: "#",
    },
    {
      id: 2,
      date: "01/10/2024",
      title: "Khuyến mãi đặc biệt cho vé máy bay tháng 11",
      link: "#",
    },
    {
      id: 3,
      date: "30/09/2024",
      title: "Cập nhật lịch trình bay mới nhất từ hãng hàng không",
      link: "#",
    },
  ];

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
              <SwiperSlide key={news.id}>
                <div className="relative flex items-center justify-between p-4 h-full">
                  {/* Date and Notification */}
                  <div className="flex-1 ml-4">
                    <p className="text-sm text-gray-500 mb-1">{news.date}</p>
                    <a
                      href={news.link}
                      className="text-[#6d24cf] font-medium text-sm hover:underline"
                    >
                      {news.title}
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

export default NotificationBar;