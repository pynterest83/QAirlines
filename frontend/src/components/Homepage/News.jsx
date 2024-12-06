import React from "react";
import { BannerData } from "../../assets/data/BannerData";

const News = () => {
  return (
    <div className="bg-gray-100 p-6">
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
        {/* Left Large Block */}
        <div className="lg:col-span-2 bg-white shadow-md rounded-lg overflow-hidden relative">
          <img
            src={BannerData[1].image}
            className="w-full h-auto"
          />
          <div className="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-50 text-white p-4">
            <p className="text-2xl font-bold">{BannerData[1].discount_title}</p>
            <p className="text-sm mt-2">{BannerData[1].discount_description}</p>
            <button className="mt-4 bg-white text-purple-600 font-semibold text-lg px-6 py-3 rounded-md shadow-md hover:bg-purple-600 hover:text-white transition duration-300">
              Details &rarr;
            </button>
          </div>
        </div>

        <div className="flex flex-col gap-4">
          {/* Right Top Block */}
          <div className="bg-white shadow-md rounded-lg overflow-hidden relative">
            <img
              src={BannerData[2].image}
              alt="Travel promotion from Ho Chi Minh to Bangkok with luggage included."
              className="w-full h-[300px] object-cover"
            />
            <div className="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-50 text-white p-4">
              <p className="text-xl font-bold">{BannerData[2].discount_title}</p>
              <p className="text-sm mt-2">{BannerData[2].discount_description}</p>
              <button className="mt-4 bg-white text-purple-600 font-semibold text-lg px-6 py-3 rounded-md shadow-md hover:bg-purple-600 hover:text-white transition duration-300">
                Details &rarr;
              </button>
            </div>
          </div>

          {/* Right Bottom Block */}
          <div className="bg-white shadow-md rounded-lg overflow-hidden relative">
            <img
              src={BannerData[0].image}
              alt="Food offer with a bonus coffee on advance booking."
              className="w-full h-[300px] object-cover"
            />
            <div className="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-50 text-white p-4">
              <p className="text-xl font-bold">{BannerData[0].discount_title}</p>
              <p className="text-sm mt-2">{BannerData[0].discount_description}</p>
              <button className="mt-4 bg-white text-purple-600 font-semibold text-lg px-6 py-3 rounded-md shadow-md hover:bg-purple-600 hover:text-white transition duration-300">
                Details &rarr;
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default News;