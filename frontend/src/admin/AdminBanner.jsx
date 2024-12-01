import React, { useState, useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { Server } from '../Server';
import AdminNavigation from './components/AdminNavigation';

const AdminBanner = () => {
    return (
        <div className='relative'>
          <AdminNavigation />
        </div>
      );
};

export default AdminBanner;