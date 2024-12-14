import React from "react";
import { useLocation, useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation.jsx";

const BannerPage = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { data } = location.state || {};

  // Function to handle button click and navigate to home
  const handleBookNow = () => {
    navigate("/");
  };

  return (
    <div className="relative">
      <Navigation selecting="info" />
      {data ? (
        <div>
          {/* Banner Section */}
          <div className="relative w-full h-[300px] md:h-[400px]">
            <img
              src={data.image}
              alt={data.alt}
              className="w-full h-full object-cover"
            />
            <div className="absolute inset-0 flex flex-col justify-center items-center text-white px-4">
              <h1 className="text-3xl md:text-5xl font-bold text-center">{data.title}</h1>
              {data.discount_title && (
                <div className="mt-4 bg-orange-400 px-4 py-2 text-white font-bold text-lg md:text-2xl rounded-lg">
                  {data.discount_title}
                </div>
              )}
            </div>
          </div>

          {/* Breadcrumb Navigation */}
          <nav className="bg-gray-100 px-4 py-3">
            <div className="flex items-center space-x-2 text-gray-500 text-sm md:text-base">
              <i className="fas fa-home text-gray-500"></i>
              <a href="/discount" className="hover:underline">
                Discount
              </a>
              <span>/</span>
              <a href="#" className="font-bold text-purple-500">
                {data.title}
              </a>
            </div>
          </nav>

          {/* Content Section */}
          <div className="p-4 md:p-12">
            <h2 className="text-xl md:text-3xl font-bold text-purple-700 mb-4 text-center md:text-left">
              {data.title}
            </h2>
            <p className="text-gray-700 leading-relaxed mb-6 text-justify">
              {data.description}
            </p>
            {data.discount_description && (
              <p className="text-lg md:text-xl font-bold text-purple-700 mb-6 text-center md:text-left">
                {data.discount_description}
              </p>
            )}

            {/* Book Now Button */}
            <div className="flex justify-center md:justify-start">
              <button
                onClick={handleBookNow}
                className="gradient-button text-white font-bold py-2 px-6 rounded w-full md:w-auto"
              >
                Book Now
              </button>
            </div>
          </div>
        </div>
      ) : (
        <p className="p-6 text-gray-500">No data available</p>
      )}
    </div>
  );
};

export default BannerPage;
