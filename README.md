
# QAirlines

## Overview

QAirlines is a comprehensive flight management platform designed to streamline the booking process for customers and provide administrative tools for managing flights efficiently.

---

## Key Features

### Customer Features
- **View Flight Information**: Access detailed and up-to-date flight schedules and details.  
- **Search Flights**: Easily find flights based on preferences such as destination, date, and time.  
- **Book Tickets**: Securely reserve tickets for available flights.  
- **Cancel Tickets**: Cancel tickets within the allowed cancellation period.  
- **Track Booked Flights**: View and monitor details of all previously booked flights.  

### Admin Features
- **Post Information**: Publish announcements regarding flights and updates.  
- **Manage Aircraft Data**: Input and update aircraft details.  
- **Manage Flight Data**: Add, update, or remove flight information as required.  
- **View and Analyze Bookings**: Monitor customer bookings and generate booking statistics.  
- **Modify Flight Schedules**: Adjust departure times or reschedule flights when necessary.  

---

## How to Run

### Prerequisites
- Node.js and npm installed on your system.  
- PostgreSQL set up for the database.  
- Redis (optional for caching if enabled).  

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/qairlines.git
   cd qairlines
   ```
2. Set up the environment variables:
   Create a `.env` file in the root directory and config as the `.env.example`

3. Follow the instructions at `backend/README.md`

4. Follow the instructions at `frontend/README.md`

5. Start the server:
   ```bash
   npm start
   ```
6. Open the application in your browser:
   ```
   http://localhost:<PORT>
   ```

---

## Demo

Check out the live demo of QAirlines here: [Demo Link](https://qairlines.vercel.app/)  

Note for the project here: [Working Note](https://boiling-rodent-bb9.notion.site/QAirline-project-12e2b2b5f06d8028ac9bf117dd4aec11?pvs=4)

> **Note:** The demo is for demonstration purposes only and may not include all features or real-time updates.

---  
