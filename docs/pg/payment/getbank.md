# Get Bank List - FPX

## OpenAPI Specification

```yaml
openapi: 3.0.1
info:
  title: ''
  description: ''
  version: 1.0.0
paths:
  /v3/payments/internet-banking/banks:
    post:
      summary: Get Bank List - FPX
      deprecated: false
      description: |-
        Environment
        Sandbox - https://api-sandbox.doku.com
        Production - https://api.doku.com
      tags:
        - Payment
      parameters:
        - name: Authorization
          in: header
          description: User is API Key provided by DOKU
          required: true
          example: Base64(doku_ak_test_qblFNYngBkEdjEZ16jxxoWSM)
          schema:
            type: string
        - name: Client-Id
          in: header
          description: Unique merchant client identity that reproduce by DOKU
          required: true
          example: BRN-001-0000001
          schema:
            type: string
        - name: Request-Timestamp
          in: header
          description: Timestamp request on UTC time in ISO8601 UTC+0 format
          required: true
          example: '{{$date.isoTimestamp}}'
          schema:
            type: string
        - name: Idempotency-Id
          in: header
          description: >-
            Optional headers whenever merchant expect idempotency handling at
            DOKU
          required: false
          example: ''
          schema:
            type: string
        - name: Signature
          in: header
          description: >-
            Conditional headers for specific request to DOKU such a PayOut,
            Refund or any of immediate transaction. To calculate the signature
            please see signature section. This headers also required when DOKU
            webhook call to merchant, and recommended for merchant to verified.
            Learn more
            [here](https://doku-developers.apidog.io/signature-6389397f0).
          required: true
          example: ''
          schema:
            type: string
        - name: API-Version
          in: header
          description: >-
            This API Versioning will help manage changes and ensure backward
            compatibility, merchant must specify the desired API version in
            their requests.
          required: true
          example: arabica.2025-12-01
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                payment_channel:
                  type: string
                  examples:
                    - INTERNET_BANKING_FPX
                type:
                  type: string
                  enum:
                    - B2B
                    - B2C
                  examples:
                    - B2B
              required:
                - payment_channel
                - type
              x-apidog-orders:
                - payment_channel
                - type
              x-apidog-ignore-properties: []
            examples:
              '1':
                value:
                  payment_channel: INTERNET_BANKING_FPX
                  type: B2B
                summary: CCDC Payment Page Integration
      responses:
        '200':
          description: ''
          content:
            application/json:
              schema:
                type: object
                properties:
                  banks:
                    type: array
                    items:
                      type: object
                      properties:
                        bank_code:
                          type: string
                        bank_name:
                          type: string
                        status:
                          type: string
                        type:
                          type: string
                        image_url:
                          type: string
                      required:
                        - bank_code
                        - bank_name
                        - status
                        - type
                        - image_url
                      x-apidog-orders:
                        - bank_code
                        - bank_name
                        - status
                        - type
                        - image_url
                      x-apidog-ignore-properties: []
                  payment_channel:
                    type: string
                    examples:
                      - INTERNET_BANKING_FPX
                required:
                  - banks
                  - payment_channel
                x-apidog-orders:
                  - banks
                  - payment_channel
                x-apidog-ignore-properties: []
              example:
                banks:
                  - bank_code: '22'
                    bank_name: Affin Bank
                    status: ACTIVE
                    type: B2B
                    image_url: https://cdn-doku/test
                  - bank_code: '27'
                    bank_name: Alliance Bank Malaysia Berhad
                    status: INACTIVE
                    type: B2C
                    image_url: https://cdn-doku/test
                payment_channel: INTERNET_BANKING_FPX
          headers:
            Client-Id:
              required: true
              description: ''
              schema:
                type: string
          x-apidog-name: OK
        '400':
          description: ''
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    $ref: '#/components/schemas/error'
                required:
                  - error
                x-apidog-orders:
                  - error
                x-apidog-ignore-properties: []
          headers: {}
          x-apidog-name: Bad Request
        '401':
          description: ''
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/401'
          headers: {}
          x-apidog-name: Unauthorized
        '404':
          description: ''
          content:
            application/json:
              schema: &ref_0
                $ref: '#/components/schemas/408'
          headers: {}
          x-apidog-name: Record Not Found
        '408':
          description: ''
          content:
            application/json:
              schema: *ref_0
          headers: {}
          x-apidog-name: ''
        '409':
          description: ''
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/409'
          headers: {}
          x-apidog-name: ''
        '500':
          $ref: '#/components/responses/System/Internal Error'
          description: ''
          headers: {}
          x-apidog-name: Server Error
      security: []
      x-apidog-folder: Payment
      x-apidog-status: released
      x-run-in-apidog: https://app.apidog.com/web/project/1033353/apis/api-42667310-run
components:
  schemas:
    '401':
      type: object
      properties:
        error:
          type: object
          properties:
            code:
              type: string
              examples:
                - invalid_signature
            message:
              type: string
              examples:
                - Invalid Signature, please check the signature components
          required:
            - code
            - message
          x-apidog-orders:
            - code
            - message
          x-apidog-ignore-properties: []
      required:
        - error
      x-apidog-orders:
        - error
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    '408':
      type: object
      properties:
        error:
          type: object
          properties:
            code:
              type: string
              examples:
                - payment_timeout
            message:
              type: string
              examples:
                - Payment processing timed out. Please try again
          required:
            - code
            - message
          x-apidog-orders:
            - code
            - message
          x-apidog-ignore-properties: []
      required:
        - error
      x-apidog-orders:
        - error
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    '409':
      type: object
      properties:
        error:
          type: object
          properties:
            code:
              type: string
              examples:
                - idempotency_id_conflict
            message:
              type: string
              examples:
                - Duplicate request with the same idempotency id
          required:
            - code
            - message
          x-apidog-orders:
            - code
            - message
          x-apidog-ignore-properties: []
      required:
        - error
      x-apidog-orders:
        - error
      x-apidog-ignore-properties: []
      x-apidog-folder: ''
    error:
      type: object
      properties:
        code:
          type: string
          title: ''
          examples:
            - invalid_request
        message:
          type: string
          examples:
            - invalid field order.amount
      required:
        - code
        - message
      x-apidog-orders:
        - code
        - message
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