# Check Three D Secure

## OpenAPI Specification

```yaml
openapi: 3.0.1
info:
  title: ''
  description: ''
  version: 1.0.0
paths:
  /check-three-d-secure:
    post:
      summary: Check Three D Secure
      deprecated: false
      description: >
        Endpoint for H2H merchants to check 3D Secure eligibility on a credit
        card. Returns an authentication URL used to redirect the consumer to the
        3DS challenge page.


        Environment

        Sandbox - https://api-sandbox.doku.com

        Production - https://api.doku.com
      operationId: checkThreeDSecure
      tags:
        - Cards Payment/Host-to-Host Payment
        - Three D Secure
      parameters:
        - name: Client-Id
          in: header
          description: Merchant Client ID registered in DOKU
          required: true
          example: MCH-0001-12345678901234
          schema:
            type: string
            maxLength: 32
        - name: Request-Id
          in: header
          description: Unique identifier for each request (UUID v4 recommended)
          required: true
          example: a1b2c3d4-e5f6-7890-abcd-ef1234567890
          schema:
            type: string
            maxLength: 128
        - name: Request-Timestamp
          in: header
          description: Request timestamp in ISO 8601 format
          required: true
          example: '2024-01-15T10:30:00Z'
          schema:
            type: string
            format: date-time
        - name: Signature
          in: header
          description: HMAC-SHA256 signature for request authentication
          required: true
          example: HMACSHA256=base64encodedSignature==
          schema:
            type: string
            maxLength: 100
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CheckThreeDSecureRequest'
            examples:
              sale_transaction:
                value:
                  order:
                    amount: 150000
                    currency: MYR
                    invoice_number: INV-2024-001
                    descriptor: DOKU Payment
                  card:
                    number: '4111111111111111'
                    expiry: '1225'
                    cardholder_name: John Doe
                    cardholder_email_address: john.doe@example.com
                    cardholder_phone_number: '081234567890'
                  three_d_secure:
                    callback_url_success: https://merchant.com/payment/success
                    callback_url_failed: https://merchant.com/payment/failed
                  payment:
                    type: SALE
                  customer:
                    id: CUST-001
                    name: John Doe
                    email: john.doe@example.com
                    phone: '081234567890'
                summary: SALE
              authorize_transaction:
                value:
                  order:
                    amount: 150000
                    currency: MYR
                    invoice_number: INV-2024-001
                    descriptor: DOKU Payment
                  card:
                    number: '4111111111111111'
                    expiry: '1225'
                    cardholder_name: John Doe
                    cardholder_email_address: john.doe@example.com
                    cardholder_phone_number: '081234567890'
                  three_d_secure:
                    callback_url_success: https://merchant.com/payment/success
                    callback_url_failed: https://merchant.com/payment/failed
                  payment:
                    type: AUTHORIZE
                  customer:
                    id: CUST-001
                    name: John Doe
                    email: john.doe@example.com
                    phone: '081234567890'
                summary: AUTHORIZE
              installment_transaction:
                value:
                  order:
                    amount: 1200000
                    currency: MYR
                    invoice_number: INV-2024-002
                  card:
                    number: '5200000000000007'
                    expiry: '0326'
                    cardholder_name: Jane Smith
                    cardholder_email_address: jane.smith@example.com
                  three_d_secure:
                    callback_url_success: https://merchant.com/payment/success
                    callback_url_failed: https://merchant.com/payment/failed
                  payment:
                    type: INSTALLMENT
                    tenor: '12'
                    acquirer: BCA
                  customer:
                    id: CUST-002
                    name: Jane Smith
                    email: jane.smith@example.com
                summary: INSTALLMENT
      responses:
        '200':
          description: Success - returns authentication URL for the 3DS challenge
          content:
            application/json:
              schema: &ref_0
                $ref: '#/components/schemas/CheckThreeDSecureResponse'
              examples:
                success:
                  summary: Successful response
                  value:
                    order:
                      amount: 150000
                      currency: MYR
                      invoice_number: INV-2024-001
                    three_d_secure:
                      authentication_id: AUTH-20240115-001
                      authentication_url: https://3ds.doku.com/authenticate?id=AUTH-20240115-001
                      three_ds_version: '2.0'
          headers: {}
          x-apidog-name: ''
        '400':
          description: Bad Request - validation failed or invalid input data
          content:
            application/json:
              schema: *ref_0
              examples:
                validation_error:
                  summary: Validation failed
                  value:
                    error:
                      code: INVALID_FIELD
                      message: Card number is invalid
          headers: {}
          x-apidog-name: ''
        '409':
          description: >-
            Conflict - idempotent request, returns result from the previous
            request
          content:
            application/json:
              schema: *ref_0
          headers: {}
          x-apidog-name: ''
        '412':
          description: Precondition Failed - pre-condition not met
          content:
            application/json:
              schema: *ref_0
              examples:
                merchant_not_configured:
                  summary: Merchant has not configured 3DS
                  value:
                    error:
                      code: MERCHANT_NOT_CONFIGURED
                      message: Merchant does not have Three D Secure configuration
          headers: {}
          x-apidog-name: ''
      security: []
      x-apidog-folder: Cards Payment/Host-to-Host Payment
      x-apidog-status: released
      x-run-in-apidog: https://app.apidog.com/web/project/1033353/apis/api-42667316-run
components:
  schemas:
    CheckThreeDSecureRequest:
      type: object
      required:
        - order
        - card
        - three_d_secure
        - payment
        - customer
      properties:
        order:
          $ref: '#/components/schemas/OrderRequest'
        card:
          $ref: '#/components/schemas/CardRequest'
        three_d_secure:
          $ref: '#/components/schemas/ThreeDSecureRequest'
        payment:
          $ref: '#/components/schemas/PaymentCheckThreeDs'
        customer:
          $ref: '#/components/schemas/CheckThreeDSCustomer'
        transaction:
          $ref: '#/components/schemas/HostToHostTransactionDetail'
        promo:
          $ref: '#/components/schemas/PromoDetail'
        payment_plan_code:
          type: string
          description: Payment plan code from Get Payment Options
      x-apidog-orders:
        - order
        - card
        - three_d_secure
        - payment
        - customer
        - transaction
        - promo
        - payment_plan_code
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    PromoDetail:
      type: object
      required:
        - application_id
        - list
      properties:
        application_id:
          type: string
          description: Promo application ID
          examples:
            - PROMO-APP-001
        list:
          type: array
          description: List of applied promos
          items:
            $ref: '#/components/schemas/ListPromo'
      x-apidog-orders:
        - application_id
        - list
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    ListPromo:
      type: object
      properties:
        promo_code:
          type: string
          description: Promo code
          examples:
            - DISC10
        discount_type:
          type: string
          description: Discount type
          enum:
            - PERCENTAGE
            - NOMINAL
          examples:
            - PERCENTAGE
        discount_value:
          type: number
          description: Discount value
          examples:
            - 10
      x-apidog-orders:
        - promo_code
        - discount_type
        - discount_value
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    HostToHostTransactionDetail:
      type: object
      properties:
        amount_details:
          $ref: '#/components/schemas/AmountDetail'
      x-apidog-orders:
        - amount_details
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    AmountDetail:
      type: object
      properties:
        paid_amount:
          type: number
          format: decimal
          description: Amount already paid
          examples:
            - 150000
      x-apidog-orders:
        - paid_amount
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    CheckThreeDSCustomer:
      type: object
      properties:
        id:
          type: string
          maxLength: 50
          description: Unique customer ID in the merchant's system
          examples:
            - CUST-001
        name:
          type: string
          minLength: 1
          maxLength: 50
          description: Customer full name
          examples:
            - John Doe
        email:
          type: string
          maxLength: 128
          format: email
          description: Customer email address
          pattern: ^[A-Za-z0-9+_.%-]+@[A-Za-z0-9.-]+\.[a-zA-Z]{2,24}$
          examples:
            - john.doe@example.com
        phone:
          type: string
          minLength: 7
          maxLength: 16
          description: Customer phone number
          examples:
            - '081234567890'
        country:
          type: string
          minLength: 1
          maxLength: 3
          description: Customer country code (ISO 3166-1 alpha-2 or alpha-3)
          examples:
            - ID
        address:
          type: string
          maxLength: 512
          description: Customer full address
          examples:
            - Jl. Sudirman No. 1
        city:
          type: string
          maxLength: 40
          description: Customer city
          examples:
            - Jakarta
        zip_code:
          type: string
          maxLength: 16
          description: Customer postal code. Alphanumeric with spaces and hyphens allowed.
          pattern: ^[A-Za-z0-9][- A-Za-z0-9]*$
          examples:
            - '12190'
        state:
          type: string
          maxLength: 32
          description: Customer state or province
          examples:
            - DKI Jakarta
      x-apidog-orders:
        - id
        - name
        - email
        - phone
        - country
        - address
        - city
        - zip_code
        - state
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    PaymentCheckThreeDs:
      type: object
      properties:
        type:
          type: string
          description: Transaction type
          enum:
            - SALE
            - AUTHORIZE
            - AUTHORIZE_CAPTURE
            - INSTALLMENT
          examples:
            - SALE
        tenor:
          type: string
          maxLength: 2
          description: >-
            Installment tenor in months. Only applicable for INSTALLMENT type.
            Must contain digits only.
          pattern: ^\d*$
          examples:
            - '12'
        acquirer:
          type: string
          maxLength: 32
          description: Acquirer product code
          examples:
            - BCA
      x-apidog-orders:
        - type
        - tenor
        - acquirer
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    ThreeDSecureRequest:
      type: object
      required:
        - callback_url_success
        - callback_url_failed
      properties:
        callback_url_success:
          type: string
          format: uri
          maxLength: 2048
          description: Redirect URL after successful 3DS authentication
          examples:
            - https://merchant.com/payment/success
        callback_url_failed:
          type: string
          format: uri
          maxLength: 2048
          description: Redirect URL after failed 3DS authentication
          examples:
            - https://merchant.com/payment/failed
      x-apidog-orders:
        - callback_url_success
        - callback_url_failed
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    CardRequest:
      type: object
      properties:
        number:
          type: string
          description: >
            Credit card number. Must be 15, 16, or 19 digits and pass Luhn
            algorithm validation. Required if `token` is not provided.
          pattern: ^\d{15}$|^\d{16}$|^\d{19}$
          examples:
            - '4111111111111111'
        expiry:
          type: string
          minLength: 4
          maxLength: 4
          description: Card expiry date in MMYY format
          pattern: ^\d{4}$
          examples:
            - '1225'
        token:
          type: string
          description: Tokenized card token (alternative to `number`)
          examples:
            - TOKEN-ABCD1234
        cardholder_email_address:
          type: string
          maxLength: 128
          format: email
          description: Cardholder email address
          examples:
            - john.doe@example.com
        cardholder_name:
          type: string
          maxLength: 255
          description: Cardholder full name
          examples:
            - John Doe
        cardholder_phone_number:
          type: string
          minLength: 7
          maxLength: 15
          description: Cardholder phone number
          examples:
            - '081234567890'
        cardholder_billing_address_state:
          type: string
          maxLength: 32
          description: State or province of the cardholder's billing address
          examples:
            - DKI Jakarta
        cardholder_billing_address_line:
          type: string
          maxLength: 512
          description: Street line of the cardholder's billing address
          examples:
            - Jl. Sudirman No. 1
        cardholder_billing_address_city:
          type: string
          maxLength: 40
          description: City of the cardholder's billing address
          examples:
            - Jakarta
        cardholder_billing_address_postal_code:
          type: string
          maxLength: 16
          description: >-
            Postal code of the cardholder's billing address. Alphanumeric with
            spaces and hyphens allowed.
          pattern: ^[A-Za-z0-9][- A-Za-z0-9]*$
          examples:
            - '12190'
        can_reprovision:
          type: boolean
          description: Indicates whether the card can be re-provisioned
          default: false
          examples:
            - false
      x-apidog-orders:
        - number
        - expiry
        - token
        - cardholder_email_address
        - cardholder_name
        - cardholder_phone_number
        - cardholder_billing_address_state
        - cardholder_billing_address_line
        - cardholder_billing_address_city
        - cardholder_billing_address_postal_code
        - can_reprovision
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    OrderRequest:
      type: object
      required:
        - amount
      properties:
        amount:
          type: number
          format: decimal
          minimum: 1
          multipleOf: 0.01
          description: Transaction amount. Maximum 10 digits with up to 2 decimal places.
          examples:
            - 150000
        discount_amount:
          type: number
          format: decimal
          description: Discount amount. Must be a whole number (no decimals).
          examples:
            - 10000
        invoice_number:
          type: string
          description: Merchant invoice number
          examples:
            - INV-2024-001
        currency:
          type: string
          maxLength: 3
          description: Currency code (ISO 4217)
          examples:
            - MYR
        descriptor:
          type: string
          maxLength: 22
          description: Transaction description that appears on the cardholder's statement
          examples:
            - DOKU Payment
      x-apidog-orders:
        - amount
        - discount_amount
        - invoice_number
        - currency
        - descriptor
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    CheckThreeDSecureResponse:
      type: object
      properties:
        order:
          $ref: '#/components/schemas/OrderResponse'
        three_d_secure:
          $ref: '#/components/schemas/ThreeDSecureResponse'
        error:
          $ref: '#/components/schemas/ErrorDetail'
      x-apidog-orders:
        - order
        - three_d_secure
        - error
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    ErrorDetail:
      type: object
      properties:
        code:
          type: string
          description: Error code
          examples:
            - INVALID_FIELD
        message:
          type: string
          description: Error message describing the cause of failure
          examples:
            - Card number is invalid
      x-apidog-orders:
        - code
        - message
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    ThreeDSecureResponse:
      type: object
      properties:
        authentication_id:
          type: string
          description: Unique identifier for the 3DS authentication process
          examples:
            - AUTH-20240115-001
        authentication_url:
          type: string
          format: uri
          description: URL for the consumer to proceed with 3DS authentication
          examples:
            - https://3ds.doku.com/authenticate?id=AUTH-20240115-001
        three_ds_version:
          type: string
          description: 3DS version used
          examples:
            - '2.0'
        auth_jwt:
          type: string
          description: JWT token for authentication purposes (used in specific flows)
          examples:
            - eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...
      x-apidog-orders:
        - authentication_id
        - authentication_url
        - three_ds_version
        - auth_jwt
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    OrderResponse:
      type: object
      properties:
        amount:
          type: number
          format: decimal
          description: Transaction amount after discount or promo is applied
          examples:
            - 150000
        currency:
          type: string
          maxLength: 3
          description: Currency code (ISO 4217)
          examples:
            - MYR
        invoice_number:
          type: string
          description: Invoice number
          examples:
            - INV-2024-001
        discount_amount:
          type: number
          format: decimal
          description: Discount amount applied to the transaction
          examples:
            - 10000
      x-apidog-orders:
        - amount
        - currency
        - invoice_number
        - discount_amount
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
  securitySchemes:
    bearerAuth:
      type: jwt
      scheme: bearer
      bearerFormat: JWT
servers: []
security: []

```