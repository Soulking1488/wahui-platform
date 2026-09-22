# Unbind Token

## OpenAPI Specification

```yaml
openapi: 3.0.1
info:
  title: ''
  description: ''
  version: 1.0.0
paths:
  /tokenization/v2/delete-token:
    post:
      summary: Unbind Token
      deprecated: false
      description: |-
        Environment
        Sandbox - https://api-sandbox.doku.com
        Production - https://api.doku.com

        You can retrieve your token from these:
        1. Payment Notification from DOKU
        2. Retrieve Payment Status API Response from DOKU
        3. Request Payment Response from DOKU
        4. Charge Payment Response from DOKU
      tags:
        - Cards Payment
      parameters:
        - name: Client-Id
          in: header
          description: Client ID retrieved from DOKU Back Office
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
          example: 071a6a32-6785-4011-833d-d2c2049cf744
          schema:
            type: string
        - name: Request-Timestamp
          in: header
          description: Timestamp request on UTC time in ISO8601 UTC+0 format
          required: true
          example: '2021-08-24T08:46:42Z'
          schema:
            type: string
        - name: Signature
          in: header
          description: >-
            HMACSHA256 from signature components, to generate signature please
            refer
            [here](https://doku-developers.apidog.io/signature-component-from-request-header-1950519m0).
          required: true
          example: HMACSHA256=9UPUFzOqJc47aJzD9ESOTcWg6TMsg3mqSP+DnUO8ENE=
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                token:
                  type: object
                  properties:
                    id:
                      type: string
                      description: Token ID that want to unbind or delete
                      x-apidog-mock: gateway-token
                  x-apidog-orders:
                    - id
                  required:
                    - id
              x-apidog-orders:
                - token
              required:
                - token
            example:
              token:
                id: 1614dc147e404f41f6d2de877fda1f94
      responses:
        '200':
          description: ''
          content:
            application/json:
              schema:
                type: object
                properties:
                  token:
                    type: object
                    properties:
                      id:
                        type: string
                        description: Token ID that want to unbind or delete
                        x-apidog-mock: gateway-token
                      status:
                        type: string
                        description: |-
                          Delete Process Status
                          Possible Value: INACTIVE
                        x-apidog-mock: INACTIVE
                    x-apidog-orders:
                      - id
                      - status
                    required:
                      - id
                      - status
                x-apidog-orders:
                  - token
                required:
                  - token
              example:
                token:
                  id: 1614dc147e404f41f6d2de877fda1f94
                  status: INACTIVE
          headers: {}
          x-apidog-name: Success
        '500':
          description: ''
          content:
            application/json:
              schema:
                title: ''
                type: object
                properties:
                  timestamp:
                    type: string
                  status:
                    type: string
                  error:
                    type: string
                  path:
                    type: string
                x-apidog-orders:
                  - timestamp
                  - status
                  - error
                  - path
          headers: {}
          x-apidog-name: Server Error
      security: []
      x-apidog-folder: Cards Payment
      x-apidog-status: released
      x-run-in-apidog: https://app.apidog.com/web/project/1033353/apis/api-42667313-run
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