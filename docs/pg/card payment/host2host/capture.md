# Capture Authorized Payment

## OpenAPI Specification

```yaml
openapi: 3.0.1
info:
  title: ''
  description: ''
  version: 1.0.0
paths:
  /credit-card/capture:
    post:
      summary: Capture Authorized Payment
      deprecated: false
      description: |-
        Environment
        Sandbox - https://api-sandbox.doku.com
        Production - https://api.doku.com
      tags:
        - Cards Payment/Host-to-Host Payment
        - Authorize Capture
      parameters:
        - name: Request-Timestamp
          in: header
          description: Timestamp request on UTC time in ISO8601 UTC+0 format
          required: true
          example: '2020-12-21T07:56:11.000Z'
          schema:
            type: string
            format: utc timestamp
            examples:
              - '2020-12-21T07:56:11.000Z'
        - name: Signature
          in: header
          description: >-
            HMACSHA256 from signature components, to generate signature please
            refer to
            [this](https://doku-developers.apidog.io/signature-component-from-request-header-1387601m0)
            page.
          required: true
          example: HMACSHA256=+xey5+Yk8Jzzw5cOrbhArGMtmoDt26+/6KCgIdOiLVg=
          schema:
            type: string
            examples:
              - HMACSHA256=+xey5+Yk8Jzzw5cOrbhArGMtmoDt26+/6KCgIdOiLVg=
        - name: Client-Id
          in: header
          description: Unique ID for a partner (DOKU'S Client ID)
          required: true
          example: BRN-0205-1700537885721
          schema:
            type: string
            examples:
              - BRN-0205-1700537885721
        - name: Request-Id
          in: header
          description: >-
            Unique random string (max 128 characters) generated from merchant
            side to protect duplicate request
          required: true
          example: '418075533589'
          schema:
            type: string
            examples:
              - 418075533589
        - name: Request-Target
          in: header
          description: path of target request
          required: true
          example: /credit-card/v1/payment-page
          schema:
            type: string
            examples:
              - /credit-card/v1/payment-page
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                payment:
                  type: object
                  properties:
                    authorize_id:
                      type: string
                      description: >-
                        Authorize ID from the Charge API Response / HTTP
                        Notification
                      examples:
                        - '193869186391'
                    capture_amount:
                      type: integer
                      description: >-
                        The value of transactions which will be caputerd by the
                        customer. If undefined, capture full transaction.
                      examples:
                        - '1000'
                    currency:
                      type: string
                      description: Transaction Currency
                      examples:
                        - MYR
                  required:
                    - authorize_id
                  x-apidog-orders:
                    - authorize_id
                    - capture_amount
                    - currency
                  x-apidog-ignore-properties: []
              required:
                - payment
              x-apidog-orders:
                - payment
              x-apidog-ignore-properties: []
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                type: object
                properties:
                  customer:
                    type: object
                    properties:
                      id:
                        type: string
                    x-apidog-orders:
                      - id
                    x-apidog-ignore-properties: []
                  additional_info:
                    type: string
                  order:
                    type: object
                    properties:
                      invoice_number:
                        type: string
                      amount:
                        type: integer
                      currency:
                        type: string
                        description: Use MYR for MY merchant
                    required:
                      - currency
                    x-apidog-orders:
                      - invoice_number
                      - amount
                      - currency
                    x-apidog-ignore-properties: []
                  payment:
                    type: object
                    properties:
                      type:
                        type: string
                      request_id:
                        type: string
                        description: Request ID sent on merchant's request header
                      response_code:
                        type: string
                        description: Reponse code generated by DOKU / Acquirer
                      response_message:
                        type: string
                        description: Response message generated by DOKU / Acquirer
                      status:
                        type: string
                        description: 'Payment status Possible value: SUCCESS,FAILED, PENDING'
                      authorize_id:
                        type: string
                        description: Authorize ID for authorize transaction
                      approval_code:
                        type: string
                        description: >-
                          Approval code for success transaction generated by
                          acquirer
                    x-apidog-orders:
                      - type
                      - request_id
                      - response_code
                      - response_message
                      - status
                      - authorize_id
                      - approval_code
                    x-apidog-ignore-properties: []
                  card:
                    type: object
                    properties:
                      masked:
                        type: string
                        description: Card masked number
                      token:
                        type: string
                        description: Card token generated if use token when request
                      type:
                        type: string
                        description: 'Card typePossible value: CREDIT, DEBIT'
                      issuer:
                        type: string
                        description: Card issuer
                      brand:
                        type: string
                        description: Principal brand VISA, MASTER
                    x-apidog-orders:
                      - masked
                      - token
                      - type
                      - issuer
                      - brand
                    x-apidog-ignore-properties: []
                x-apidog-orders:
                  - customer
                  - additional_info
                  - order
                  - payment
                  - card
                x-apidog-ignore-properties: []
              example:
                order:
                  invoice_number: INV-0001
                  amount: 10000
                  descriptor: BIILING-INV-0001
                  currency: MY
                customer:
                  id: Test001
                  zip_code: '16455'
                  country: MY
                  name: DOKU Merchant
                  state: Malaysia
                  city: Selangor
                  address: Selangor, Malaysia
                  phone: '0282938478293'
                  email: merchant@doku.com
                payment:
                  type: CAPTURE
                  request_id: '418075533589'
                  response_code: '00'
                  response_message: Approved
                  status: SUCCES
                  authorize_id: '193869186391'
                  approval_code: '112233'
                card:
                  token: 536794906625cd02616510faa8460996
                  masked: 557338*******101
                  type: CREDIT
                  issuer: OCBC Berhad
                  brand: VISA
          headers: {}
          x-apidog-name: ''
        '400':
          description: Bad Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
              example:
                error:
                  code: INVALID_PARAMETER
                  message: '{field} Must Not Be Blank'
                  type: Invalid Parameter
          headers: {}
          x-apidog-name: ''
        '500':
          description: Internal Server Error
          content:
            application/json:
              schema:
                type: object
                properties:
                  timestamp:
                    type: string
                    examples:
                      - '2025-09-01T03:46:22.404+00:00'
                  status:
                    type: string
                    examples:
                      - '500'
                  error:
                    type: string
                    examples:
                      - Internal Server Error
                  path:
                    type: string
                    examples:
                      - /credit-card/v1/payment-page
                x-apidog-orders:
                  - timestamp
                  - status
                  - error
                  - path
                x-apidog-ignore-properties: []
          headers: {}
          x-apidog-name: ''
      security: []
      x-apidog-folder: Cards Payment/Host-to-Host Payment
      x-apidog-status: released
      x-run-in-apidog: https://app.apidog.com/web/project/1033353/apis/api-42667318-run
components:
  schemas:
    ErrorResponse:
      type: object
      properties:
        error:
          type: object
          properties:
            code:
              type: string
              examples:
                - Error message description code
            message:
              type: string
              examples:
                - Error message description
            type:
              type: string
              examples:
                - Error message type
          x-apidog-orders:
            - code
            - message
            - type
          x-apidog-ignore-properties: []
      x-apidog-orders:
        - error
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