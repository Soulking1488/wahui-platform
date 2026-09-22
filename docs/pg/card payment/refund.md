# Request Refund

## OpenAPI Specification

```yaml
openapi: 3.0.1
info:
  title: ''
  description: ''
  version: 1.0.0
paths:
  /cancellation/credit-card/refund:
    post:
      summary: Request Refund
      deprecated: false
      description: >-
        Environment

        Sandbox - https://api-sandbox.doku.com

        Production - https://api.doku.com


        These are the possible Response Status:

        1. VOID: If the funds has not settled to your bank account. The
        refund.amount must equal to order.amount, otherwise will fail

        2. PARTIAL_REFUND: If the funds has settled to your bank account, and
        the refund.amount is less than order.amount

        3. FULL_REFUND: If the funds has settled to your bank account, and the
        refund.amount is equal to order.amount


        Notification will be sent to merchant's configured endpoint URL upon
        succesfull refund or void. Please refer to
        [this](https://doku-developers.apidog.io/sample-notification-cards-27446498e0)
        page.
      tags:
        - Cards Payment
      parameters:
        - name: Client-Id
          in: header
          description: Unique ID for a partner (DOKU'S Client ID)
          required: true
          example: '10791114622547'
          schema:
            type: string
        - name: Request-Id
          in: header
          description: >-
            Unique random string (max 128 characters) generated from merchant
            side to protect duplicate request
          required: true
          example: e71fe02a-bfef-4af9-a6f6-2cf1f03b00e7
          schema:
            type: string
        - name: Request-Timestamp
          in: header
          description: Timestamp request on UTC time in ISO8601 UTC+0 format
          required: true
          example: '2020-11-18T08:45:42Z'
          schema:
            type: string
        - name: Signature
          in: header
          description: >-
            HMACSHA256 from signature components, to generate signature please
            refer
            [here](https://doku-developers.apidog.io/signature-component-from-request-header-1950519m0).
          required: true
          example: HMACSHA256=vl9DBTX5KhEiXmnpOD0TSm8PYQknuHPdyHSTSc3W6Ps=
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                order:
                  type: object
                  properties:
                    invoice_number:
                      type: string
                      description: Invoice number of the transaction that being refunded
                  required:
                    - invoice_number
                  x-apidog-orders:
                    - invoice_number
                  x-apidog-ignore-properties: []
                payment:
                  type: object
                  properties:
                    original_request_id:
                      type: string
                      description: >-
                        Request ID from payment initiation of the transaction
                        that being refunded
                  required:
                    - original_request_id
                  x-apidog-orders:
                    - original_request_id
                  x-apidog-ignore-properties: []
                refund:
                  type: object
                  properties:
                    amount:
                      type: string
                      description: Transaction amount that wants to be refunded
                  required:
                    - amount
                  x-apidog-orders:
                    - amount
                  x-apidog-ignore-properties: []
              required:
                - order
                - payment
                - refund
              x-apidog-orders:
                - order
                - payment
                - refund
              x-apidog-ignore-properties: []
            example:
              order:
                invoice_number: INV-20210118-0001
              payment:
                original_request_id: b266c265-3d61-4708-9860-c0d5b9a98f8c
              refund:
                amount: 11
      responses:
        '200':
          description: ''
          content:
            application/json:
              schema:
                type: object
                properties:
                  order:
                    type: object
                    properties:
                      invoice_number:
                        type: string
                        description: Same as the request
                    required:
                      - invoice_number
                    x-apidog-orders:
                      - invoice_number
                    x-apidog-ignore-properties: []
                  payment:
                    type: object
                    properties:
                      original_request_id:
                        type: string
                        description: Same as the request
                    required:
                      - original_request_id
                    x-apidog-orders:
                      - original_request_id
                    x-apidog-ignore-properties: []
                  refund:
                    type: object
                    properties:
                      amount:
                        type: number
                        description: Same as the request
                      type:
                        type: string
                        description: |-
                          Refund type based on the transaction
                          Possible value: VOID, PARTIAL_REFUND, FULL_REFUND
                      status:
                        type: string
                        description: |-
                          Refund status
                          Possible value: SUCCESS, FAILED
                      message:
                        type: string
                        description: Refund message description
                      approval_code:
                        type: string
                        description: >-
                          Acquiring approval code for the refund transaction if
                          the refund.status = SUCCESS
                    required:
                      - amount
                      - type
                      - status
                    x-apidog-orders:
                      - amount
                      - type
                      - status
                      - message
                      - approval_code
                    x-apidog-ignore-properties: []
                required:
                  - order
                  - payment
                  - refund
                x-apidog-orders:
                  - order
                  - payment
                  - refund
                x-apidog-ignore-properties: []
              example:
                order:
                  invoice_number: INV-20210118-0001
                payment:
                  original_request_id: b266c265-3d61-4708-9860-c0d5b9a98f8c
                refund:
                  amount: 11
                  type: FULL_REFUND
                  status: SUCCESS
                  message: Approved
                  approval_code: '12321'
          headers: {}
          x-apidog-name: OK
        '400':
          description: Bad Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
              example:
                error:
                  code: INVALID_PARAMETER
                  message: Invalid Request
                  type: Invalid Parameter
          headers: {}
          x-apidog-name: Bad Request
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
                      - /cancellation/credit-card/refund
                x-apidog-orders:
                  - timestamp
                  - status
                  - error
                  - path
                x-apidog-ignore-properties: []
          headers: {}
          x-apidog-name: Server Error
      security: []
      x-apidog-folder: Cards Payment
      x-apidog-status: released
      x-run-in-apidog: https://app.apidog.com/web/project/1033353/apis/api-42667312-run
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