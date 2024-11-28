# API documentation

## Table of Contents
- [Authentication](#authentication)
  - [Register](#register)
  - [Login](#login)
- [Offers](#offers)
  - [Get Round Trip Flights](#get-round-trip-flights)
  - [Get One Way Flights](#get-one-way-flights)
  - [Get Flights Within Range](#get-flights-within-range)
- [Seats](#seats)
  - [Get All Seats](#get-all-seats)
  - [Get Available Seats](#get-available-seats)
- [Tickets](#tickets)
  - [Book Ticket](#book-ticket)
  - [Cancel Ticket](#cancel-ticket)
  - [Get My Tickets](#get-my-tickets)
- [Promotions](#promotions)
  - [Get All Promotions](#get-all-promotions)

## Authentication

### Register
- **Endpoint:** `/api/auth/register`
- **Method:** `POST`
- **POST Body:** JSON object with user details.
- **Description:** Registers a new user.
- **Request Body:** JSON object with user details.
- **Response:** Confirmation of registration.
- **Example:** `/api/auth/register`
- **Request Body:**
```json
{
  "username": "admin",
  "password": "admin",
  "role": "admin"
}
```
**Note: Leave `role` empty for normal users.**

- **Response:**
```json
{
  "message": "Đăng ký thành công",
  "user": {
    "UserID": "U1N7G5543",
    "Username": "user1",
    "Role": "User"
  }
}
```

### Login
- **Endpoint:** `/api/auth/login`
- **Method:** `POST`
- **POST Body:** JSON object with user credentials.
- **Description:** Logs in a user.
- **Request Body:** JSON object with user credentials.
- **Response:** JSON object with user details and token.
- **Example:** `/api/auth/login`
- **Request Body:**
```json
{
  "username": "admin",
  "password": "admin123"
}
```
- **Response:**
```json
{
  "message": "Đăng nhập thành công",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiJVV1hWMTg5NDYiLCJVc2VybmFtZSI6ImFkbWluIiwiUm9sZSI6ImFkbWluIiwiaWF0IjoxNzMyMjQ0ODU0LCJleHAiOjE3MzIyNDg0NTR9.T2u1-TI528snByz9LxpGdZD_rD-_K9fgonnPrk6GiV4"
}
```

## Offers

### Get Round Trip Flights
- **Endpoint:** `/api/offers/round-trip`
- **Method:** `GET`
- **Parameters:** `departure`, `destination`, `departure_date`, `return_date`
- **Description:** Retrieves round trip flight offers.
- **Response:** JSON array of round trip flight offers.
- **Example:** `/api/offers/round-trip?departure=HAN&destination=SGN&departure_date=2024-12-08&return_date=2024-12-09`
```json
{
  "type": "Round-trip",
  "outboundFlights": [
    {
      "FlightID": "VN100",
      "Status": "Scheduled",
      "DepTime": "2024-12-08T03:00:00+07:00",
      "ArrTime": "2024-12-08T07:00:00+07:00",
      "BoardingTime": "2024-12-08T02:30:00+07:00",
      "ticketClasses": [
        {
          "ClassName": "Economy",
          "Price": "100.00",
          "AvailableSeats": 4
        },
        {
          "ClassName": "Business",
          "Price": "300.00",
          "AvailableSeats": 2
        },
        {
          "ClassName": "First",
          "Price": "500.00",
          "AvailableSeats": 4
        }
      ],
      "Aircraft": {
        "AircraftID": "B787",
        "Model": "Boeing 787 Dreamliner",
        "Capacity": 242
      }
    },
    {
      "FlightID": "VN103",
      "Status": "Scheduled",
      "DepTime": "2024-12-08T15:00:00+07:00",
      "ArrTime": "2024-12-08T23:00:00+07:00",
      "BoardingTime": "2024-12-08T14:30:00+07:00",
      "ticketClasses": [
        {
          "ClassName": "Economy",
          "Price": "50.00",
          "AvailableSeats": 4
        },
        {
          "ClassName": "Business",
          "Price": "1000.00",
          "AvailableSeats": 4
        },
        {
          "ClassName": "First",
          "Price": "1500.00",
          "AvailableSeats": 4
        }
      ],
      "Aircraft": {
        "AircraftID": "A380",
        "Model": "Airbus A380",
        "Capacity": 500
      }
    }
  ],
  "returnFlights": [
    {
      "FlightID": "VN101",
      "Status": "Scheduled",
      "DepTime": "2024-12-09T08:00:00+07:00",
      "ArrTime": "2024-12-09T12:00:00+07:00",
      "BoardingTime": "2024-12-09T07:30:00+07:00",
      "ticketClasses": [
        {
          "ClassName": "Economy",
          "Price": "100.00",
          "AvailableSeats": 0
        },
        {
          "ClassName": "Business",
          "Price": "300.00",
          "AvailableSeats": 4
        },
        {
          "ClassName": "First",
          "Price": "500.00",
          "AvailableSeats": 4
        }
      ],
      "Aircraft": {
        "AircraftID": "B787",
        "Model": "Boeing 787 Dreamliner",
        "Capacity": 242
      }
    }
  ]
}
```

### Get One Way Flights
- **Endpoint:** `/api/offers/one-way`
- **Method:** `GET`
- **Parameters:** `departure`, `destination`, `departure_date`
- **Description:** Retrieves one way flight offers.
- **Response:** JSON array of one way flight offers.
- **Example:** `/api/offers/one-way?departure=HAN&destination=SGN&departure_date=2024-12-08`
```json
{
  "type": "One-way",
  "flights": [
    {
      "FlightID": "VN100",
      "Status": "Scheduled",
      "DepTime": "2024-12-08T03:00:00+07:00",
      "ArrTime": "2024-12-08T07:00:00+07:00",
      "BoardingTime": "2024-12-08T02:30:00+07:00",
      "ticketClasses": [
        {
          "ClassName": "Economy",
          "Price": "100.00",
          "AvailableSeats": 4
        },
        {
          "ClassName": "Business",
          "Price": "300.00",
          "AvailableSeats": 2
        },
        {
          "ClassName": "First",
          "Price": "500.00",
          "AvailableSeats": 4
        }
      ],
      "Aircraft": {
        "AircraftID": "B787",
        "Model": "Boeing 787 Dreamliner",
        "Capacity": 242
      }
    },
    {
      "FlightID": "VN103",
      "Status": "Scheduled",
      "DepTime": "2024-12-08T15:00:00+07:00",
      "ArrTime": "2024-12-08T23:00:00+07:00",
      "BoardingTime": "2024-12-08T14:30:00+07:00",
      "ticketClasses": [
        {
          "ClassName": "Economy",
          "Price": "50.00",
          "AvailableSeats": 4
        },
        {
          "ClassName": "Business",
          "Price": "1000.00",
          "AvailableSeats": 4
        },
        {
          "ClassName": "First",
          "Price": "1500.00",
          "AvailableSeats": 4
        }
      ],
      "Aircraft": {
        "AircraftID": "A380",
        "Model": "Airbus A380",
        "Capacity": 500
      }
    }
  ]
}
```
### Get Flights Within Range
- **Endpoint:** `/api/offers/in-range`
- **Method:** `GET`
- **Parameters:** `departure`, `destination`, `start_date`, `end_date`
- **Optional Parameters:** `ticket_class` (Economy, Business, First)
  - Default: Economy
- **Description:** Retrieves flight offers within a date range.
  - `start_date` and `end_date` are inclusive.
  - The result will be sorted by `DepTime`.
  - If two flights have the same `DepTime`, they will be sorted by `ticket_class`'s price.
- **Response:** JSON array of flight offers.
- **Example:** `/api/offers/in-range?departure=HAN&destination=SGN&start_date=2024-12-07&end_date=2024-12-09&ticket_class=First`
```json
{
  "type": "In-range",
  "flights": [
    {
      "FlightID": "VN102",
      "Status": "Scheduled",
      "DepTime": "2024-12-07",
      "MinPrice": "1500.00"
    },
    {
      "FlightID": "VN100",
      "Status": "Scheduled",
      "DepTime": "2024-12-08",
      "MinPrice": "500.00"
    }
  ]
}
```

## Seats

### Get All Seats
- **Endpoint:** `/api/seats/all`
- **Method:** `GET`
- **Parameters:** `flightID`
- **Description:** Retrieves all seats for a flight.
- **Response:** JSON array of all seats.
- **Example:** `/api/seats/all?flightID=VN100`
```json
{
    "flightID": "VN100",
    "allSeats": [
        {
            "seatNo": "10A",
            "class": "Business",
            "status": "not available"
        },
        {
            "seatNo": "10B",
            "class": "Business",
            "status": "available"
        },
        {
            "seatNo": "1A",
            "class": "First",
            "status": "available"
        },
        {
            "seatNo": "1B",
            "class": "First",
            "status": "available"
        },
        {
            "seatNo": "20A",
            "class": "Economy",
            "status": "available"
        },
        {
            "seatNo": "20B",
            "class": "Economy",
            "status": "available"
        }
    ]
}
```

### Get Available Seats
- **Endpoint:** `/api/seats/available`
- **Method:** `GET`
- **Parameters:** `flightID`, `class`
- **Description:** Retrieves available seats by class for a flight.
- **Response:** JSON array of available seats.
- **Example:** `/api/seats/available?flightID=VN100&class=Business`
```json
{
  "flightID": "VN100",
  "class": "Business",
  "availableSeats": [
    "10B"
  ]
}
```

## Tickets

### Book Ticket
- **Endpoint:** `/api/tickets/book-ticket`
- **Method:** `POST`
- **POST Body:** JSON object with passengers' details.
- **Description:** Books a ticket for a flight.
- **Request Body:** JSON object with booking details.
- **Response:** Confirmation of booking.
- **Example:** `/api/tickets/book-ticket`
- **Request Body:**
```json
{
  "flightID": "VN101",
  "passengers": [
    {
      "firstName": "John",
      "lastName": "Doe",
      "dob": "1985-07-23",
      "gender": "M",
      "email": "johndoe@example.com",
      "phoneNumber": "123456789",
      "passport": "B12345678",
      "ssn": "123456789012",
      "seatNo": "20A"
    },
    {
      "firstName": "Jane",
      "lastName": "Doe",
      "dob": "2015-05-01",
      "gender": "F",
      "guardianSSN": "123456789012",
      "seatNo": "20B"
    }
  ]
}
```
- **Response:**
```json
{
    "message": "Đặt vé thành công",
    "tickets": [
        {
            "TicketID": "T439906",
            "FlightID": "VN101",
            "AircraftID": "B787",
            "SeatNo": "20A",
            "PassID": "P623241",
            "CancellationDeadline": "2024-12-05T01:00:00.000Z"
        },
        {
            "TicketID": "T110855",
            "FlightID": "VN101",
            "AircraftID": "B787",
            "SeatNo": "20B",
            "PassID": "P202480",
            "CancellationDeadline": "2024-12-05T01:00:00.000Z"
        }
    ]
}
```

### Cancel Ticket
- **Endpoint:** `/api/tickets/cancel-ticket`
- **Method:** `DELETE`
- **Request Body:** JSON object with cancellation details.
- **Description:** Cancels a booked ticket.
- **Response:** Confirmation of cancellation.
- **Example:** `/api/tickets/cancel-ticket`
- **Request Body:**
```json
{
    "ticketID": "T439906"
}
```
- **Response:**
```json
{
    "message": "Hủy vé thành công"
}
```

### Get My Tickets
- **Endpoint:** `/api/tickets/my-tickets`
- **Method:** `GET`
- **Parameters:** `identifier` (SSN hoặc Passport)
- **Description:** Retrieves all tickets for a given passenger and their dependents based on SSN or Passport.
- **Example:** `/api/tickets/my-tickets?identifier=123456789012`
- **Response:**
```json
{
    "identifier": "123456789012",
    "tickets": [
        {
            "TicketID": "T328760",
            "FlightID": "VN101",
            "SeatNo": "20B",
            "AircraftID": "B787",
            "CancellationDeadline": "2024-12-05T01:00:00.000Z",
            "FlightDetails": {
                "FlightID": "VN101",
                "DepTime": "2024-12-08T01:00:00.000Z",
                "ArrTime": "2024-12-08T05:00:00.000Z",
                "DepID": "SGN",
                "DestID": "HAN"
            }
        },
        {
            "TicketID": "T372183",
            "FlightID": "VN101",
            "SeatNo": "20A",
            "AircraftID": "B787",
            "CancellationDeadline": "2024-12-05T01:00:00.000Z",
            "FlightDetails": {
                "FlightID": "VN101",
                "DepTime": "2024-12-08T01:00:00.000Z",
                "ArrTime": "2024-12-08T05:00:00.000Z",
                "DepID": "SGN",
                "DestID": "HAN"
            }
        }
    ]
}
```

### Get Ticket Details by Ticket ID
- **Endpoint:** `/api/tickets/by-id`
- **Method:** `GET`
- **Parameters:** `ticketId`
- **Description:** Retrieves ticket details by ticket ID.
- **Example:** `/api/tickets/by-id?ticketId=T328760`
- **Response:**
```json
{
    "TicketID": "T328760",
    "FlightID": "VN101",
    "SeatNo": "20B",
    "AircraftID": "B787",
    "Class": "Economy",
    "Price": "100.00",
    "CancellationDeadline": "2024-12-05T01:00:00.000Z",
    "Passenger": {
        "PassID": "P16444",
        "FirstName": "Jane",
        "LastName": "Doe",
        "DOB": "2015-05-01",
        "Gender": "F"
    },
    "Flight": {
        "FlightID": "VN101",
        "DepTime": "2024-12-08T01:00:00.000Z",
        "ArrTime": "2024-12-08T05:00:00.000Z",
        "BoardingTime": "2024-12-08T00:30:00.000Z",
        "DepID": "SGN",
        "DestID": "HAN",
        "AircraftID": "B787"
    }
}
```

## Promotions

### Get All Promotions
- **Endpoint:** `/api/promotions/list`
- **Method:** `GET`
- **Description:** Retrieves all promotions.
- **Response:** JSON array of all promotions.
- **Example:** `/api/promotions/list`
```json
[
  {
    "PromotionID": "PR001",
    "Title": "Khuyến mãi tháng 12",
    "Content": "Giảm giá 50% cho tất cả các chuyến bay",
    "Amount": 50
  }
]
```