import React from "react";
import { useNavigate } from "react-router-dom";
import { BannerData } from "../assets/data/BannerData";
import Navigation from "../components/Navigation.jsx";
import bg1 from '../assets/images/bg1.jpg';

const Discounts = () => {
  const navigate = useNavigate();

  const handleDetailsClick = (banner) => {
    navigate("/banner", { state: { data: banner } });
  };

  console.log(BannerData);

  return (
    <div className="relative">
      <Navigation selecting="info" />
      {/* Hero Section */}
      <div className="relative">
        <img
          src={bg1}
          alt="Airplane wing view with clouds"
          className="w-full h-auto object-cover"
        />
      </div>

      {/* Breadcrumb */}
      <div className="max-w-7xl mx-auto px-4 py-3 flex items-center text-gray-500 space-x-2 text-sm">
        <i className="fas fa-home"></i>
        <span>/</span>
        <a href="#" className="hover:text-purple-600">
          Discounts
        </a>
      </div>

      {/* Content Section */}
      <div className="max-w-7xl mx-auto px-4 py-6">
        <h1 className="text-2xl font-semibold text-purple-900 mb-4">Discounts</h1>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {BannerData.map((banner, index) => (
            <div
              key={index}
              className="relative w-full h-[300px] overflow-hidden rounded-lg shadow-lg"
            >
              <img
                src={banner.image}
                alt={banner.alt}
                className="w-full h-full object-cover"
              />
              <div className="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-50 text-white p-6">
                <p className="text-xl font-bold text-center">{banner.discount_title}</p>
                <p className="text-sm mt-2 text-center">{banner.discount_description}</p>
                <button
                  onClick={() => handleDetailsClick(banner)}
                  className="mt-4 bg-white text-purple-600 font-semibold text-lg px-6 py-3 rounded-md shadow-md hover:bg-purple-600 hover:text-white transition duration-300"
                >
                  Details &rarr;
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Discounts;
