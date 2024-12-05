import React from 'react';
import { AwardData } from '../../assets/data/AwardData';

const Footer = () => {
  return (
    <footer className="relative bg-white py-6 px-8 border-t">
      {/* Top section: Logo and Slogan */}
      <div className="flex flex-col md:flex-row items-center justify-center mb-6">
        {/* Logo */}
        <img
          src="./logo.png"
          alt="Q Airline Logo"
          className="h-12"
        />
        {/* Vertical Divider */}
        <div className="hidden md:block mx-4 h-10 w-px bg-gray-300"></div>
        {/* Slogan */}
        <span className="text-gray-600 text-lg font-semibold mt-4 md:mt-0">VUI TỪNG CHUYẾN BAY</span>
      </div>

      {/* Bottom section: Contact Info, Award Badges, and Social Media Links */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 items-center text-center">
        {/* Left Part: Contact Info */}
        <div className="text-gray-500 text-sm">
          <p>Email: <a href="mailto:contact@qairline.com" className="text-blue-500 hover:underline">contact@qairline.com</a></p>
          <p>Hotline: <a href="tel:+84123456789" className="text-blue-500 hover:underline">+84 123 456 789</a></p>
        </div>

        {/* Middle Part: Award Badges */}
        <div className="flex justify-center space-x-4">
          {AwardData.map((award, index) => (
            <img
              key={index}
              src={award.image}
              alt={award.alt}
              className="h-12"
            />
          ))}
        </div>

        {/* Right Part: Social Media Links */}
        <div className="flex justify-center space-x-4">
          <a href="https://www.facebook.com" target="_blank" rel="noopener noreferrer" className="text-gray-600 hover:text-blue-600">
            <i className="fab fa-facebook fa-lg"></i>
          </a>
          <a href="https://www.instagram.com" target="_blank" rel="noopener noreferrer" className="text-gray-600 hover:text-pink-500">
            <i className="fab fa-instagram fa-lg"></i>
          </a>
          <a href="https://www.tiktok.com" target="_blank" rel="noopener noreferrer" className="text-gray-600 hover:text-black">
            <i className="fab fa-tiktok fa-lg"></i>
          </a>
          <a href="https://www.youtube.com" target="_blank" rel="noopener noreferrer" className="text-gray-600 hover:text-red-600">
            <i className="fab fa-youtube fa-lg"></i>
          </a>
          <a href="https://www.twitter.com" target="_blank" rel="noopener noreferrer" className="text-gray-600 hover:text-blue-400">
            <i className="fab fa-x-twitter fa-lg"></i>
          </a>
        </div>
      </div>
    </footer>
  );
};

export default Footer;