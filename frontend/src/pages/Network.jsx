import React from "react";
import { useNavigate } from "react-router-dom";
import { BannerData } from "../assets/data/BannerData";
import Navigation from "../components/Navigation.jsx";
import bg2 from '../assets/images/bg2.jpg';
import international from '../assets/images/international.png';
import regional from '../assets/images/regional.png';
import ScrollToTop from "../scroll.jsx";

const Network = () => {
  return (
    <div className="relative">
      <ScrollToTop />
      <Navigation selecting="info" />
      {/* Hero Section */}
      <div className="relative">
        <img
          src={bg2}
          alt="Airplane wing view with clouds"
          className="w-full h-auto object-cover"
        />
      </div>

      {/* Breadcrumb */}
      <div className="max-w-7xl mx-auto px-4 py-3 flex items-center text-gray-500 space-x-2 text-sm">
        <i className="fas fa-home"></i>
        <span>/</span>
        <a href="#" className="hover:text-purple-600">
          Flight Network
        </a>
      </div>

      {/* Content Section */}
      <div className="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-2 gap-8">
        {/* International Section */}
        <div className="flex flex-col items-center text-center">
          <img src={international} alt="International" className="h-auto mb-4" />
          <h2 className="text-xl font-semibold mb-2">International Network</h2>
          <p className="text-gray-600">
            Explore our extensive international flight network, connecting you to
            destinations across the globe.
          </p>
        </div>

        {/* Regional Section */}
        <div className="flex flex-col items-center text-center">
          <img src={regional} alt="Regional" className="h-auto mb-4" />
          <h2 className="text-xl font-semibold mb-2">Regional Network</h2>
          <p className="text-gray-600">
            Discover our regional flight services, providing seamless
            connectivity within your local area.
          </p>
        </div>
      </div>
    </div>
  );
};

export default Network;
