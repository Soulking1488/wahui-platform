# Check Status

## OpenAPI Specification

```yaml
openapi: 3.0.1
info:
  title: ''
  description: ''
  version: 1.0.0
paths:
  /orders/v1/status/order.invoice_number:
    get:
      summary: Check Status
      deprecated: false
      description: >-
        Environment

        Sandbox - https://api-sandbox.doku.com

        Production - https://api.doku.com


        Hit Check Status after 60 seconds after payment completion!

        Please ensure your application is already hit after 60 seconds after
        payment completion.


        Input your order.invoice_number or Request-Id as an identifier

        To get the status of your refund, please use refund.request_id as an
        identifier
      tags:
        - Cards Payment
      parameters:
        - name: Client-Id
          in: header
          description: Unique ID for a partner (DOKU'S Client ID)
          required: true
          example: MCH-0001-10791114622547
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
          description: Client's current local time in yyyy-MM- ddTHH:mm:ssTZD format
          required: true
          example: '2020-11-18T08:45:42Z'
          schema:
            type: string
        - name: Signature
          in: header
          description: >-
            HMACSHA256 from signature components, please refer
            [here](https://doku-developers.apidog.io/signature-component-from-request-header-1950519m0).
          required: true
          example: HMACSHA256=vl9DBTX5KhEiXmnpOD0TSm8PYQknuHPdyHSTSc3W6Ps=
          schema:
            type: string
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
                        description: >-
                          Same as the request that merchant sent on the payment
                          initiation
                      amount:
                        type: number
                        description: >-
                          Same as the request that merchant sent on the payment
                          initiation
                    x-apidog-orders:
                      - invoice_number
                      - amount
                    required:
                      - invoice_number
                      - amount
                  transaction:
                    type: object
                    properties:
                      status:
                        type: string
                        description: >-
                          The transaction status to be use to update the status
                          on merchant side

                          Possible value: SUCCESS, FAILED, PENDING, REFUNDED
                      date:
                        type: string
                        description: >-
                          The date when the transaction is completed by the
                          customer in ISO 8601 format (UTC + 0)
                      type:
                        type: string
                        description: >-
                          Type for Credit Card Transaction.

                          Mandatory if transaction.status value SUCCESS or
                          FAILED.


                          Possible value: SALE, INSTALLMENT, MOTO, AUTHORIZE,
                          CAPTURE, RECURRING, REFUND
                      original_request_id:
                        type: string
                        description: The request ID that sent when initiate the payment
                    x-apidog-orders:
                      - status
                      - date
                      - type
                      - original_request_id
                    required:
                      - status
                      - date
                      - original_request_id
                  service:
                    type: object
                    properties:
                      id:
                        type: string
                        description: The service that is used for the transaction
                    x-apidog-orders:
                      - id
                    required:
                      - id
                  acquirer:
                    type: object
                    properties:
                      id:
                        type: string
                        description: |-
                          The acquirer that processed the transaction.
                          Mandatory if transaction.status value SUCCESS.
                      name:
                        type: string
                        description: The acquirer that processed the transaction.
                    x-apidog-orders:
                      - id
                      - name
                    required:
                      - name
                  channel:
                    type: object
                    properties:
                      id:
                        type: string
                        description: The channel of the transaction
                    x-apidog-orders:
                      - id
                    required:
                      - id
                  card_payment:
                    type: object
                    properties:
                      card_masked:
                        type: string
                        description: >-
                          The masked card number that charged for this
                          transaction.

                          Mandatory if transaction.status value SUCCESS or
                          FAILED
                      approval_code:
                        type: string
                        description: >-
                          Acquirer approval code for this transaction.

                          Mandatory if transaction.status value SUCCESS or
                          FAILED
                      response_code:
                        type: string
                        description: >-
                          Acquirer response code.

                          Mandatory if transaction.status value SUCCESS or
                          FAILED
                      response_message:
                        type: string
                        description: >-
                          Acquirer response code

                          Mandatory if transaction.status value SUCCESS or
                          FAILED
                      type:
                        type: string
                        description: >-
                          Type for Credit Card Transaction.

                          Mandatory if transaction.status value SUCCESS or
                          FAILED.


                          Possible value: SALE, INSTALLMENT, MOTO, AUTHORIZE,
                          CAPTURE, RECURRING, REFUND
                      acquiring_off_us_status:
                        type: string
                        description: |-
                          Payment acquiring_off_us_status
                          Possible value: true, false
                      request_id:
                        type: string
                        description: Request ID for transaction
                      card_type:
                        type: string
                        description: >-
                          Card type.

                          Mandatory if transaction.status value SUCCESS or
                          FAILED.


                          Possible value: CREDIT, DEBIT
                      three_dsecure_status:
                        type: string
                        description: |-
                          Three dsecure status
                          Possible value: TRUE, FALSE
                      issuer:
                        type: string
                        description: >-
                          Card issuer.

                          Mandatory if transaction.status value SUCCESS or
                          FAILED
                      transaction_status:
                        type: string
                        description: |-
                          Transaction status
                          Possible value: SUCCESS, FAILED, PENDING
                      brand:
                        type: string
                        description: >-
                          Card brand.

                          Mandatory if transaction.status value SUCCESS or
                          FAILED
                      date:
                        type: string
                        description: Transaction card date
                      authorize_id:
                        type: string
                        description: Transaction authorize ID
                      authentication_id:
                        type: string
                        description: Transaction authentication ID
                      token_id:
                        type: string
                        description: Token when customer save card
                    x-apidog-orders:
                      - card_masked
                      - approval_code
                      - response_code
                      - response_message
                      - type
                      - acquiring_off_us_status
                      - request_id
                      - card_type
                      - three_dsecure_status
                      - issuer
                      - transaction_status
                      - brand
                      - date
                      - authorize_id
                      - authentication_id
                      - token_id
                    required:
                      - acquiring_off_us_status
                      - request_id
                      - transaction_status
                x-apidog-orders:
                  - order
                  - transaction
                  - service
                  - acquirer
                  - channel
                  - card_payment
                required:
                  - order
                  - transaction
                  - service
                  - channel
                  - card_payment
              examples:
                '1':
                  summary: Example - Pending
                  value:
                    order:
                      invoice_number: INV-AD1755247176
                      amount: 2
                      currency: MYR
                    transaction:
                      status: PENDING
                      type: SALE
                      date: '2025-08-15T08:41:05Z'
                      original_request_id: 6602783a-ae56-442c-ac33-fa1c24964bde
                    service:
                      id: CREDIT_CARD
                    acquirer:
                      id: OCBC
                      name: OCBC BANK (MALAYSIA) BERHAD
                    channel:
                      id: CREDIT_CARD
                    card_payment:
                      card_masked: 444000******0010
                      request_id: 6602783a-ae56-442c-ac33-fa1c24964bde
                      card_type: VISA
                      issuer: OCBC BANK (MALAYSIA) BERHAD
                      transaction_status: REDIRECT
                      brand: VISA
                      date: '2025-08-15T08:41:05Z'
                '2':
                  summary: Example - Void
                  value:
                    order:
                      invoice_number: INV-E2E1756701074
                      amount: 2
                      status: ORDER_GENERATED
                      currency: MYR
                    transaction:
                      status: VOIDED
                      type: VOID
                      date: '2025-09-01T04:47:15Z'
                      original_request_id: '76389'
                      amount: '2'
                    service:
                      id: CREDIT_CARD
                    acquirer:
                      id: OCBC
                      name: OCBC BANK (MALAYSIA) BERHAD
                    channel:
                      id: CREDIT_CARD
                    card_payment:
                      card_masked: 444000******0014
                      response_code: '00'
                      response_message: Transaction Has Been Successfully Void
                      type: VOID
                      acquiring_off_us_status: 'FALSE'
                      request_id: '76389'
                      card_type: CREDIT
                      three_dsecure_status: 'FALSE'
                      issuer: OCBC BANK (MALAYSIA) BERHAD
                      transaction_status: SUCCESS
                      brand: VISA
                      date: '2025-09-01T04:47:15Z'
                      identifier:
                        - name: Acquirer
                          value: OCBC
                        - name: MID
                          value: TEST19999999988
                    refund:
                      amount: '2'
                '3':
                  summary: Example - Refund
                  value:
                    order:
                      invoice_number: INV-PL-20250828145938916
                      amount: 5
                      currency: MYR
                    transaction:
                      status: REFUNDED
                      type: FULL_REFUND
                      date: '2025-09-01T03:39:19Z'
                      original_request_id: '65350'
                      amount: '5'
                    service:
                      id: CREDIT_CARD
                    acquirer:
                      id: OCBC
                      name: OCBC BANK (MALAYSIA) BERHAD
                    channel:
                      id: CREDIT_CARD
                    card_payment:
                      card_masked: 512345******2346
                      response_code: '00'
                      response_message: Transaction Has Been Successfully Refund
                      type: FULL_REFUND
                      acquiring_off_us_status: 'TRUE'
                      request_id: '65350'
                      card_type: CREDIT
                      three_dsecure_status: 'FALSE'
                      issuer: BANK ISLAM MALAYSIA BERHAD
                      transaction_status: SUCCESS
                      brand: MASTER
                      date: '2025-09-01T03:39:19Z'
                      identifier:
                        - name: Acquirer
                          value: OCBC
                        - name: MID
                          value: TEST19999999988
                    refund:
                      amount: '5'
                '4':
                  summary: Example - Success
                  value:
                    order:
                      invoice_number: INV-AD1755245937
                      amount: 2
                      currency: MYR
                    transaction:
                      status: SUCCESS
                      type: SALE
                      date: '2025-08-15T08:20:52Z'
                      original_request_id: 5120f7b0-01f4-47f2-bfb4-58d9dcd66c8c
                    service:
                      id: CREDIT_CARD
                    acquirer:
                      id: OCBC
                      name: OCBC BANK (MALAYSIA) BERHAD
                    channel:
                      id: CREDIT_CARD
                    additional_info:
                      origin:
                        product: CHECKOUT
                        system: mid-jokul-checkout-system
                        api_format: JOKUL
                        source: direct
                      line_items:
                        - quantity: 1
                          price: '1'
                          image_url: 'https: //app-uat.doku.com/p-link/p/jeT0V6q'
                          name: Kemeja
                          sku: payment_link1
                          type: DOKUPaymentLink
                          category: others
                          url: 'https: //www.doku.com/id-ID/payment-link'
                        - quantity: 1
                          price: '1'
                          image_url: 'https: //app-uat.doku.com/p-link/p/jeT0V6q'
                          name: Celana
                          sku: payment_link1
                          type: DOKUPaymentLink
                          category: others
                          url: 'https: //www.doku.com/id-ID/payment-link'
                    card_payment:
                      card_masked: 444000******0010
                      approval_code: '067760'
                      response_code: '00'
                      response_message: Approved
                      type: SALE
                      acquiring_off_us_status: 'FALSE'
                      request_id: 5120f7b0-01f4-47f2-bfb4-58d9dcd66c8c
                      card_type: CREDIT
                      card_holder_name: John Doe
                      three_dsecure_status: 'TRUE'
                      issuer: OCBC BANK (MALAYSIA) BERHAD
                      transaction_status: SUCCESS
                      brand: VISA
                      date: '2025-08-15T08:20:52Z'
                      identifier:
                        - name: Acquirer
                          value: OCBC
                        - name: MID
                          value: TEST10711000023
                '5':
                  summary: Example - Failed
                  value:
                    order:
                      invoice_number: INV-E2E1756786540
                      amount: 2
                      status: ORDER_GENERATED
                      currency: MYR
                    transaction:
                      status: FAILED
                      type: SALE
                      date: '2025-09-02T04:17:07Z'
                      original_request_id: cb3958c1-3e7a-443c-ad5c-843e4bb02e12
                    service:
                      id: CREDIT_CARD
                    acquirer:
                      id: OCBC
                      name: OCBC BANK (MALAYSIA) BERHAD
                    channel:
                      id: CREDIT_CARD
                    additional_info:
                      origin:
                        product: CHECKOUT
                        system: mid-jokul-checkout-system
                        api_format: JOKUL
                        source: direct
                      line_items:
                        - quantity: 1
                          price: '1'
                          image_url: 'https: //app-uat.doku.com/p-link/p/jeT0V6q'
                          name: Celana
                          sku: payment_link1
                          type: DOKUPaymentLink
                          category: others
                          url: 'https: //www.doku.com/id-ID/payment-link'
                        - quantity: 1
                          price: '1'
                          image_url: 'https: //app-uat.doku.com/p-link/p/jeT0V6q'
                          name: Celana
                          sku: payment_link1
                          type: DOKUPaymentLink
                          category: others
                          url: 'https: //www.doku.com/id-ID/payment-link'
                    card_payment:
                      card_masked: 444000******0014
                      response_code: '05'
                      response_message: Do not honour
                      type: SALE
                      acquiring_off_us_status: 'FALSE'
                      request_id: cb3958c1-3e7a-443c-ad5c-843e4bb02e12
                      card_type: CREDIT
                      card_holder_name: John Doe
                      three_dsecure_status: 'TRUE'
                      issuer: OCBC BANK (MALAYSIA) BERHAD
                      transaction_status: FAILED
                      brand: VISA
                      date: '2025-09-02T04:17:07Z'
                      identifier:
                        - name: Acquirer
                          value: OCBC
                        - name: MID
                          value: TEST19999999988
          headers: {}
          x-apidog-name: Success
      security: []
      x-apidog-folder: Cards Payment
      x-apidog-status: released
      x-run-in-apidog: https://app.apidog.com/web/project/1033353/apis/api-42667314-run
components:
  schemas: {}
  securitySchemes:
    bearerAuth:
      type: jwt
      scheme: bearer
      bearerFormat: JWT
servers: []
security: []

```