# API (Admin) documentation

- Use **Bearer `<token>`** for authentication.
- You can get the token by [logging](API.md#login) in as an admin.

## Table of Contents
- [Promotions](#promotions)
  - [Create Promotion](#create-promotion)
  - [Get All Promotions](#get-all-promotions)
  - [Update Promotion](#update-promotion)
  - [Delete Promotion](#delete-promotion)

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