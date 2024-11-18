# API documentation

## Offers

### Get Round Trip Flights
- **Endpoint:** `/api/offers/round-trip`
- **Method:** `GET`
- **Parameters:** `departure`, `destination`, `departure_date`, `return_date`
- **Description:** Retrieves round trip flight offers.
- **Response:** JSON array of round trip flight offers.
- **Example:** `/api/offers/round-trip?departure=HAN&destination=LAX&departure_date=2024-12-09&return_date=2024-12-17`
```json
{
  "type": "Round-trip",
  "outboundFlights": [
    {
      "FlightID": "VN102",
      "Status": "Scheduled",
      "DepTime": "2024-12-09T03:00:00+07:00",
      "ArrTime": "2024-12-09T07:00:00+07:00",
      "BoardingTime": "2024-12-09T02:30:00+07:00",
      "ticketClasses": [
        {
          "ClassName": "Economy",
          "Price": "700.00"
        },
        {
          "ClassName": "Business",
          "Price": "1000.00"
        },
        {
          "ClassName": "First",
          "Price": "1500.00"
        }
      ]
    }
  ],
  "returnFlights": [
    {
      "FlightID": "VN103",
      "Status": "Scheduled",
      "DepTime": "2024-12-17T15:00:00+07:00",
      "ArrTime": "2024-12-17T23:00:00+07:00",
      "BoardingTime": "2024-12-17T14:30:00+07:00",
      "ticketClasses": [
        {
          "ClassName": "Economy",
          "Price": "700.00"
        },
        {
          "ClassName": "Business",
          "Price": "1000.00"
        },
        {
          "ClassName": "First",
          "Price": "1500.00"
        }
      ]
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
          "Price": "100.00"
        },
        {
          "ClassName": "Business",
          "Price": "300.00"
        },
        {
          "ClassName": "First",
          "Price": "500.00"
        }
      ]
    }
  ]
}
```

## Seats

### Get All Seats
- **Endpoint:** `/api/seats/all`
- **Method:** `GET`
- **Parameters:** `flightId`
- **Description:** Retrieves all seats for a flight.
- **Response:** JSON array of all seats.
- **Example:** `/api/seats/all?flightId=VN100`
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
- **Parameters:** `flightId`, `class`
- **Description:** Retrieves available seats by class for a flight.
- **Response:** JSON array of available seats.
- **Example:** `/api/seats/available?flightId=VN100&class=Business`
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
- **Parameters:** `flightId`, `passengers`
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
- **Description:** Cancels a booked ticket.
- **Request Body:** JSON object with cancellation details.
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