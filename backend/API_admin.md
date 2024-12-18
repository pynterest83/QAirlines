# API (Admin) documentation

- Use **Bearer `<token>`** for authentication.
- You can get the token by [logging in](API.md#login) as an admin.

## Table of Contents
- [Promotions](#promotions)
  - [Create Promotion](#create-promotion)
  - [Update Promotion](#update-promotion)
  - [Delete Promotion](#delete-promotion)
- [Flight](#flight)
  - [Update Flight](#update-flight)
  - [Create Flight](#create-flight)
  - [Get flight's passengers details](#get-flights-passengers-details)
- [Aircraft](#aircraft)
  - [Create Aircraft](#create-aircraft)
- [Statistics](#statistics)
  - [Tickets booked monthly in a year](#tickets-booked-monthly-in-a-year)
  - [Income monthly in a year](#income-monthly-in-a-year)
- [Banner](#banner)
  - [Create Banner](#create-banner)
  - [Get Banners](#get-banners)
  - [Delete Banner](#delete-banner)

## Promotions
### Create Promotion
- **Endpoint:** `/api/promotions/create`
- **Method:** `POST`
- **POST Body:** JSON object with promotion details.
- **Description:** Creates a promotion.
- **Response:** Confirmation of promotion creation.
- **Example:** `/api/promotions/create`
- **Request Body:**
```json
{
  "Title": "Khuyến mãi tháng 12",
  "Content": "Giảm giá 50% cho tất cả các chuyến bay",
  "Amount": 50
}
```
- **Response:**
```json
{
  "message": "Thông tin đã được tạo thành công",
  "promotion": {
    "PromotionID": "PR001",
    "Title": "Khuyến mãi tháng 12",
    "Content": "Giảm giá 50% cho tất cả các chuyến bay",
    "Amount": 50
  }
}
```

### Update Promotion
- **Endpoint:** `/api/promotions/update/:PromotionID`
- **Method:** `PUT`
- **PUT Body:** JSON object with promotion details.
- **Description:** Updates a promotion.
- **Response:** Confirmation of promotion update.
- **Example:** `/api/promotions/update/PR001`
- **Request Body:**
```json
{
  "Title": "Khuyến mãi tháng 12",
  "Content": "Giảm giá 50% cho tất cả các chuyến bay",
  "Amount": 60
}
```

### Delete Promotion
- **Endpoint:** `/api/promotions/delete/:PromotionID`
- **Method:** `DELETE`
- **Description:** Deletes a promotion.
- **Response:** Confirmation of promotion deletion.
- **Example:** `/api/promotions/delete/PR001`
- **Response:**
```json
{
  "message": "Thông tin đã được xóa thành công"
}
```

## Flight
### Update Flight
- **Endpoint:** `/api/flights/update`
- **Method:** `PUT`
- **PUT Body:** JSON object with flight details.
- **Description:** Delays a flight.
- **Response:** Confirmation of flight delay.
- **Example:** `/api/flights/update`
- **Request Body:**
```json
{
  "flightID": "VN103",
  "DepTime": "2024-12-10T02:00:00.000Z",
  "BoardingTime": "2024-12-10T01:30:00.000Z",
  "Status": "Delayed",
  "DestID": "LAX"
}
```
- **Response:**
```json
{
  "message": "Flight delayed successfully",
  "flight": {
    "FlightID": "VN103",
    "Status": "Delayed",
    "DepTime": "2024-12-10T02:00:00.000Z",
    "ArrTime": "2024-12-08T16:00:00.000Z",
    "BoardingTime": "2024-12-10T01:30:00.000Z",
    "DepID": "HAN",
    "DestID": "LAX",
    "AircraftID": "A380",
    "OriginalDepTime": "2024-12-10T02:00:00.000Z",
    "OriginalArrTime": null,
    "OriginalBoardingTime": "2024-12-10T01:30:00.000Z"
  }
}
```

### Create Flight
- **Endpoint:** `/api/flights/create`
- **Method:** `POST`
- **POST Body:** JSON object with flight details.
- **Description:** Creates a flight.
- **Response:** Confirmation of flight creation.
- **Example:** `/api/flights/create`
- **Request Body:**
```json
{
  "Status": "Scheduled",
  "DepTime": "2024-12-13T10:00:00.000Z",
  "ArrTime": "2024-12-13T14:00:00.000Z",
  "BoardingTime": "2024-12-13T09:30:00.000Z",
  "DepID": "SGN",
  "DestID": "HAN",
  "AircraftID": "A400",
  "ticketPrices": {
    "Economy": 100,
    "Business": 500,
    "First": 1000
  }
}
```
- **Response:**
```json
{
  "message": "Flight created successfully",
  "flight": {
    "Status": "Scheduled",
    "DepTime": "2024-12-13T10:00:00.000Z",
    "ArrTime": "2024-12-13T14:00:00.000Z",
    "BoardingTime": "2024-12-13T09:30:00.000Z",
    "DepID": "SGN",
    "DestID": "HAN",
    "AircraftID": "A400",
    "FlightID": "EK371"
  }
}
```

### Get flight's passengers details
- **Endpoint:** `/api/flights/:flightId/passengers`
- **Method:** `GET`
- **Description:** Get passengers details of a flight.
- **Response:** List of passengers details of the flight.
- **Example:** `/api/flights/VN101/passengers`
- **Response:**
```json
[
  {
    "TicketID": "T746697",
    "Passenger": {
      "DOB": "2024-12-02",
      "PassID": "P249209",
      "FirstName": "Quang",
      "LastName": "Chu",
      "Gender": "M",
      "Email": "quangdtm2004@gmail.com",
      "PhoneNumber": "0986168118",
      "Passport": "01234567890123456789",
      "SSN": "123456789012",
      "GuardianID": null
    },
    "SeatClass": "Economy"
  },
  {
    "TicketID": "T502580",
    "Passenger": {
      "DOB": "2024-12-02",
      "PassID": "P736650",
      "FirstName": "Quang",
      "LastName": "Chu",
      "Gender": "M",
      "Email": "q@gmail.com",
      "PhoneNumber": "0987654321",
      "Passport": "09876543210987654321",
      "SSN": "098765432109",
      "GuardianID": null
    },
    "SeatClass": "Economy"
  },
  {
    "TicketID": "T825696",
    "Passenger": {
      "DOB": "2024-12-02",
      "PassID": "P686902",
      "FirstName": "Quang",
      "LastName": "Phuc",
      "Gender": "M",
      "Email": "p@gmail.com",
      "PhoneNumber": "0987654321",
      "Passport": "09876543210987654321",
      "SSN": "098765432109",
      "GuardianID": null
    },
    "SeatClass": "Economy"
  },
  {
    "TicketID": "T761919",
    "Passenger": {
      "DOB": "2024-12-01",
      "PassID": "P178666",
      "FirstName": "a",
      "LastName": "b",
      "Gender": "M",
      "Email": "abc@gmail.com",
      "PhoneNumber": "0987654321",
      "Passport": "09876543210987654321",
      "SSN": "098765432109",
      "GuardianID": null
    },
    "SeatClass": "Economy"
  },
  {
    "TicketID": "T76623",
    "Passenger": {
      "DOB": "1985-07-23",
      "PassID": "P547889",
      "FirstName": "John",
      "LastName": "Doe",
      "Gender": "M",
      "Email": "johndoe@example.com",
      "PhoneNumber": "123445789",
      "Passport": "J12345678",
      "SSN": "123457869012",
      "GuardianID": null
    },
    "SeatClass": "Business"
  }
]
```

### Get passengers of a flight
- **Endpoint:** `/api/flights/:flightId/details`
- **Method:** `GET`
- **Description:** Get passengers of a flight.
- **Response:** List of passengers of the flight.
- **Example:** `/api/flights/VN101/details`
- **Response:**
```json
[
  {
    "TicketID": "T328760",
    "Passenger": {
      "DOB": "2015-05-01",
      "PassID": "P16444",
      "FirstName": "Jane",
      "LastName": "Doe",
      "Gender": "F"
    }
  },
  {
    "TicketID": "T372183",
    "Passenger": {
      "DOB": "1985-07-23",
      "PassID": "P001",
      "FirstName": "John",
      "LastName": "Doe",
      "Gender": "M"
    }
  }
]
```

## Aircraft
### Create Aircraft
- **Endpoint:** `/api/aircrafts/create`
- **Method:** `POST`
- **Description:** Creates an aircraft.
- **Response:** Confirmation of aircraft creation.
- **Example:** `/api/aircrafts/create`  
![img.png](img.png)

## Statistics
### Tickets booked monthly in a year
- **Endpoint:** `/api/statistics/monthly`
- **Method:** `GET`
- **Description:** Get the number of tickets booked monthly in a year.
- **Response:** Number of tickets booked monthly in a year.
- **Example:** `/api/statistics/booking/monthly?year=2024`
- **Response:**
```json
{
  "year": "2024",
  "monthlyStatistics": [
    {
      "month": 1,
      "bookingCount": 0
    },
    {
      "month": 2,
      "bookingCount": 0
    },
    {
      "month": 3,
      "bookingCount": 0
    },
    {
      "month": 4,
      "bookingCount": 0
    },
    {
      "month": 5,
      "bookingCount": 0
    },
    {
      "month": 6,
      "bookingCount": 0
    },
    {
      "month": 7,
      "bookingCount": 0
    },
    {
      "month": 8,
      "bookingCount": 0
    },
    {
      "month": 9,
      "bookingCount": 0
    },
    {
      "month": 10,
      "bookingCount": 0
    },
    {
      "month": 11,
      "bookingCount": 0
    },
    {
      "month": 12,
      "bookingCount": 2
    }
  ]
}
```

### Income monthly in a year
- **Endpoint:** `/api/statistics/income/monthly`
- **Method:** `GET`
- **Query:** `year`
- **Description:** Get the income monthly in a year.
- **Response:** Income monthly in a year.
- **Example:** `/api/statistics/income/monthly?year=2024`
- **Response:**
```json
{
  "year": "2024",
  "monthlyStatistics": [
    {
      "month": 1,
      "totalIncome": 0
    },
    {
      "month": 2,
      "totalIncome": 0
    },
    {
      "month": 3,
      "totalIncome": 0
    },
    {
      "month": 4,
      "totalIncome": 0
    },
    {
      "month": 5,
      "totalIncome": 0
    },
    {
      "month": 6,
      "totalIncome": 0
    },
    {
      "month": 7,
      "totalIncome": 0
    },
    {
      "month": 8,
      "totalIncome": 0
    },
    {
      "month": 9,
      "totalIncome": 0
    },
    {
      "month": 10,
      "totalIncome": 0
    },
    {
      "month": 11,
      "totalIncome": 0
    },
    {
      "month": 12,
      "totalIncome": 3700
    }
  ]
}
```

## Banner
### Create Banner
- **Endpoint:** `/api/banners/create`
- **Method:** `POST`
- **POST Body:** JSON object with banner details.
- **Description:** Creates a banner.
- **Response:** Confirmation of banner creation.
- **Example:** `/api/banners/create`  
![img_1.png](img_1.png)

### Get Banners
- **Endpoint:** `/api/banners/list`
- **Method:** `GET`
- **Query:** `bannerIds` (optional)
- **Description:** Get all banners.
- **Response:** List of banners.
- **Example:** `/api/banners/list?bannerIds=BNV5FK8UAU,BNI5MC7EMB`
- **Response:**
```json
{
  "banners": [
    {
      "BannerID": "BNV5FK8UAU",
      "Title": "Beijing",
      "Description": "Beijing Desc",
      "ImageURL": "https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/banner-files/BNV5FK8UAU/Screenshot%20from%202023-12-13%2001-47-28.png",
      "DiscountTitle": "Discover Beijing with 20% off",
      "DiscountDescription": "Auth 20%"
    },
    {
      "BannerID": "BNI5MC7EMB",
      "Title": "Beijing2",
      "Description": "Beijing Desc",
      "ImageURL": "https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/banner-files/BNI5MC7EMB/Screenshot%20from%202024-12-13%2001-47-28.png",
      "DiscountTitle": "Discover Beijing with 20% off",
      "DiscountDescription": "Auth 20%"
    }
  ]
}
```

### Delete Banner
- **Endpoint:** `/api/banners/delete/:BannerID`
- **Method:** `DELETE`
- **Description:** Deletes a banner.
- **Response:** Confirmation of banner deletion.
- **Example:** `/api/banners/delete/BNV5FK8UAU`
- **Response:**
```json
{
  "message": "Banner deleted successfully"
}
```