# Sample Code

Here is the sample code to generate the `Global Signature`:

> <Icon icon="material-outline-info"/> **SAMPLE ONLY!**
> 
> This is just a sample code to demonstrate how to generate the Signature on different programming language. Kindly adjust the code to suited your project's structure.


<Tabs>
  <Tab title="JAVA">
  ```js
import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class GlobalSignature {

 public static final String CLIENT_ID = "Client-Id";
 public static final String REQUEST_TIMESTAMP = "Request-Timestamp";
 public static final String REQUEST_TARGET = "Request-Target";
 public static final String DIGEST = "Digest";
 public static final String NEW_LINE = "\n";
 
 // Generate Digest
 public static String generateDigest(String requestBody) throws NoSuchAlgorithmException {
     MessageDigest md = MessageDigest.getInstance("SHA-256");
     md.update(requestBody.getBytes(StandardCharsets.UTF_8));
     byte[] digest = md.digest();
     return Base64.getEncoder().encodeToString(digest);
 }
 
 private static String generateSignature(String clientId, String requestId, String requestTimestamp, String requestTarget, String digest, String secret) throws InvalidKeyException, NoSuchAlgorithmException {
     // Prepare Signature Component
     System.out.println("----- Component Signature -----");
     StringBuilder component = new StringBuilder();
     component.append(clientId);
     component.append(NEW_LINE);
     component.append(requestTimestamp);
     component.append(NEW_LINE);
     component.append(requestTarget);
     // If body not send when access API with HTTP method GET/DELETE
     if(digest != null && !digest.isEmpty()) {
         component.append(NEW_LINE);
         component.append(digest);
     }

     System.out.println(component.toString());
     System.out.println();

     // Calculate HMAC-SHA256 base64 from all the components above
     byte[] decodedKey = secret.getBytes();
     SecretKey originalKey = new SecretKeySpec(decodedKey, 0, decodedKey.length, "HmacSHA256");
     Mac hmacSha256 = Mac.getInstance("HmacSHA256");
     hmacSha256.init(originalKey);
     hmacSha256.update(component.toString().getBytes());
     byte[] HmacSha256DigestBytes = hmacSha256.doFinal();
     String signature = Base64.getEncoder().encodeToString(HmacSha256DigestBytes);
     // Prepend encoded result with algorithm info HMACSHA256=
     return "HMACSHA256="+signature;
 }
 
 // Sample of Usage
 public static void main(String[] args) throws NoSuchAlgorithmException, InvalidKeyException {
      String jsonBody = new JSONObject()
                       .put("order", new JSONObject()
                         .put("invoice_number", "INV-20210124-0001")
                         .put("amount", 15000)
                       )
                       .put("virtual_account_info", new JSONObject()
                         .put("expired_time", 60)
                         .put("amount", 15000)
                       )
                       .toString();

     // Generate Digest from JSON Body, For HTTP Method GET/DELETE don't need generate Digest
     System.out.println("----- Digest -----");
     String digest = generateDigest(jsonBody);
     System.out.println(digest);
     System.out.println();

     // Generate Signature
     String headerSignature = generateSignature(
             "yourClientId",
             "yourRequestId",
             "2020-10-21T03:38:28Z",
             "/request-target/goes-here", // For merchant request to DOKU, use DOKU path here. For HTTP Notification, use merchant path here
             digest, // Set empty string for this argumentes if HTTP Method is GET/DELETE
             "secret-key-from-DOKU-back-office");

     System.out.println("----- Header Signature -----");
     System.out.println(headerSignature);
 }
}
  ```
  </Tab>
  <Tab title="PHP">
  ```js
<?php

$clientId = "yourClientId";
$requestDate = "2020-10-21T03:38:28Z";
$targetPath = "/request-target/goes-here"; // For merchant request to Jokul, use Jokul path here. For HTTP Notification, use merchant path here
$secretKey = "secret-key-from-jokul-back-office";
$requestBody = array (
'order' => array (
  'amount' => 15000,
  'invoice_number' => 'INV-20210124-0001',
),
'virtual_account_info' => array (
  'expired_time' => 60,
  'reusable_status' => false,
  'info1' => 'Merchant Demo Store',
),
'customer' => array (
  'name' => 'Taufik Ismail',
  'email' => 'taufik@example.com',
),
);

// Generate Digest
$digestValue = base64_encode(hash('sha256', json_encode($requestBody), true));
echo "Digest: " . $digestValue;
echo "\r\n\n";

// Prepare Signature Component
$componentSignature = "$clientId . "\n" . 
                "$requestDate . "\n" . 
                "$targetPath . "\n" .
                "$digestValue;
echo "Component Signature: \n" . $componentSignature;
echo "\r\n\n";

// Calculate HMAC-SHA256 base64 from all the components above
$signature = base64_encode(hash_hmac('sha256', $componentSignature, $secretKey, true));
echo "Signature: " . $signature;
echo "\r\n\n";

// Sample of Usage
$headerSignature =  "Client-Id:" . $clientId ."\n". 
              "Request-Id:" . $requestId . "\n".
              "Request-Timestamp:" . $requestDate ."\n".
              // Prepend encoded result with algorithm info HMACSHA256=
              "Signature:" . "HMACSHA256=" . $signature;
echo "your header request look like: \n".$headerSignature;
echo "\r\n\n";
  ```
  </Tab>
  <Tab title="Python">
  ```js
import hashlib
import hmac
import base64

# Generate Digest
def generateDigest(jsonBody):  
return base64.b64encode(hashlib.sha256(jsonBody.encode('utf-8')).digest()).decode("utf-8")

def generateSignature(clientId, requestTimestamp, requestTarget, digest, secret):
# Prepare Signature Component
print("----- Signature Component -----")
componentSignature = clientId
componentSignature += "\n"
componentSignature += requestTimestamp
componentSignature += "\n"
componentSignature += requestTarget
# If body not send when access API with HTTP method GET/DELETE
if digest:
    componentSignature += "\n"
    componentSignature += "Digest:" + digest
 
print(componentSignature)
message = bytes(componentSignature, 'utf-8')
secret = bytes(secret, 'utf-8')

# Calculate HMAC-SHA256 base64 from all the components above
signature = base64.b64encode(hmac.new(secret, message, digestmod=hashlib.sha256).digest()).decode("utf-8")

# Prepend encoded result with algorithm info HMACSHA256=
return "HMACSHA256="+signature 

# Sample of usage

# Generate Digest from JSON Body, For HTTP Method GET/DELETE don't need generate Digest
print("----- Digest -----")
jsonBody = '{\"order\":{\"invoice_number\":\"INV-20210124-0001\",\"amount\":150000},\"virtual_account_info\":{\"expired_time\":60,\"reusable_status\":false,\"info1\":\"Merchant Demo Store\"},\"customer\":{\"name\":\"Taufik Ismail\",\"email\":\"taufik@example.com\"}}'
digest = generateDigest(jsonBody)
print(digest)
print("")

# Generate Signature
headerSignature = generateSignature(
    "yourClientId",
    "2020-10-21T03:38:28Z",
    "/request-target/goes-here", # For merchant request to Jokul, use Jokul path here. For HTTP Notification, use merchant path here
    digest, # Set empty string for this argumentes if HTTP Method is GET/DELETE
    "secret-key-from-jokul-back-office")
print("----- Header Signature -----")
print(headerSignature)
  ```
  </Tab>
  <Tab title="Ruby">
  ```js
require 'openssl'
require 'base64'
require 'digest'

# Generate Digest
def generateDigest(jsonBody)
return Base64.encode64(Digest::SHA256.digest(jsonBody)).strip()
end

def generateSignature(clientId, requestTimestamp, requestTarget, digest, secret)
# Prepare Signature Component
puts "----- Component Signature -----"
componentSignature = (clientId)
componentSignature.concat("\n")
componentSignature.concat(requestTimestamp)
componentSignature.concat("\n")
componentSignature.concat(requestTarget)
# If body not send when access API with HTTP method GET/DELETE
unless digest.to_s.strip.empty?
    componentSignature.concat("\n")
    componentSignature.concat(digest)
end
puts componentSignature
puts "\n"  

# Calculate HMAC-SHA256 base64 from all the components above
hash = OpenSSL::HMAC.digest("sha256", secret, componentSignature)
signature = Base64.encode64(hash).strip()

# Prepend encoded result with algorithm info HMACSHA256=
return "HMACSHA256="+signature 
end

# Sample of Usage

# Generate Digest from JSON Body, For HTTP Method GET/DELETE don't need generate Digest
puts "----- Digest -----"
jsonBody = '{\"order\":{\"invoice_number\":\"INV-20210124-0001\",\"amount\":150000},\"virtual_account_info\":{\"expired_time\":60,\"reusable_status\":false,\"info1\":\"Merchant Demo Store\"},\"customer\":{\"name\":\"Taufik Ismail\",\"email\":\"taufik@example.com\"}}'
digest = generateDigest(jsonBody)
puts digest
puts "\n"

# Generate Header Signature
headerSignature = generateSignature(
    "yourClientId",
    "2020-10-21T03:38:28Z",
    "/request-target/goes-here", # For merchant request to Jokul, use Jokul path here. For HTTP Notification, use merchant path here
    digest, # Set empty string for this argumentes if HTTP Method is GET/DELETE
    "secret-key-from-jokul-back-office")
puts "----- Header Signature -----"
puts headerSignature
  ```
  </Tab>
  <Tab title="Go">
  ```js
package main

import (
"crypto/hmac"
"crypto/sha256"
"encoding/base64"
"fmt"
"strings"
)

// Generate Digest
func generateDigest(jsonBody string) string {
converted := []byte(jsonBody)
hasher := sha256.New()
hasher.Write(converted)
return (base64.StdEncoding.EncodeToString(hasher.Sum(nil)))
 
}

func generateSignature(clientId string, requestTimestamp string, requestTarget string, digest string, secret string) string {
// Prepare Signature Component
fmt.Println("----- Component Signature -----")
var componentSignature strings.Builder
componentSignature.WriteString(clientId)
componentSignature.WriteString("\n")
componentSignature.WriteString(requestTimestamp)
componentSignature.WriteString("\n")
componentSignature.WriteString(requestTarget) 
componentSignature.WriteString("\n")
componentSignature.WriteString(digest) 
// If body not send when access API with HTTP method GET/DELETE
if len(digest) > 0  {
    componentSignature.WriteString("\n")
    componentSignature.WriteString(digest)
}

fmt.Println(componentSignature.String())
fmt.Println("")

// Calculate HMAC-SHA256 base64 from all the components above
key := []byte(secret)
h := hmac.New(sha256.New, key)
h.Write([]byte(componentSignature.String()))
signature := base64.StdEncoding.EncodeToString(h.Sum(nil))
// Prepend encoded result with algorithm info HMACSHA256=
return "HMACSHA256="+signature
}

// Sample of Usage
func main() {

// Genreate Digest from JSON Body
var jsonBody = '{\"order\":{\"invoice_number\":\"INV-20210124-0001\",\"amount\":150000},\"virtual_account_info\":{\"expired_time\":60,\"reusable_status\":false,\"info1\":\"Merchant Demo Store\"},\"customer\":{\"name\":\"Taufik Ismail\",\"email\":\"taufik@example.com\"}}'
digest := generateDigest(jsonBody);
fmt.Println("----- Digest -----")
fmt.Println(digest)
fmt.Println("")

// Generate Signature
headerSignature := generateSignature(
    "yourClientId",
    "2020-10-21T03:38:28Z",
    "/request-target/goes-here", // For merchant request to DOKU, use DOKU path here. For HTTP Notification, use merchant path here
    digest, // Set empty string for this argumentes if HTTP Method is GET/DELETE
    "secret-key-from-DOKU-back-office")

fmt.Println("----- Header Signature -----")    
fmt.Println(headerSignature)
}
  ```
  </Tab>
  <Tab title="Node.js">
  ```js
const crypto = require('crypto');

// Generate Digest
function generateDigest(jsonBody) {
 let jsonStringHash256 = crypto.createHash('sha256').update(jsonBody,"utf-8").digest();
 
 let bufferFromJsonStringHash256 = Buffer.from(jsonStringHash256);
 return bufferFromJsonStringHash256.toString('base64'); 
}

function generateSignature(clientId, requestTimestamp, requestTarget, digest, secret) {
 // Prepare Signature Component
 console.log("----- Component Signature -----")
 let componentSignature = clientId;
 componentSignature += "\n";
 componentSignature += requestTimestamp;
 componentSignature += "\n";
 componentSignature += requestTarget;
 // If body not send when access API with HTTP method GET/DELETE
 if (digest) {
     componentSignature += "\n";
     componentSignature += "Digest:" + digest;
 }

 console.log(componentSignature.toString());
 console.log();

 // Calculate HMAC-SHA256 base64 from all the components above
 let hmac256Value = crypto.createHmac('sha256', secret)
                .update(componentSignature.toString())
                .digest();  
   
 let bufferFromHmac256Value = Buffer.from(hmac256Value);
 let signature = bufferFromHmac256Value.toString('base64');
 // Prepend encoded result with algorithm info HMACSHA256=
 return "HMACSHA256="+signature 
}

// Sample of Usage

// Generate Digest from JSON Body, For HTTP Method GET/DELETE don't need generate Digest
console.log("----- Digest -----");
let jsonBody = '{\"order\":{\"invoice_number\":\"INV-20210124-0001\",\"amount\":150000},\"virtual_account_info\":{\"expired_time\":60,\"reusable_status\":false,\"info1\":\"Merchant Demo Store\"},\"customer\":{\"name\":\"Taufik Ismail\",\"email\":\"taufik@example.com\"}}';
let digest = generateDigest(jsonBody);
console.log(digest);
console.log();

// Generate Header Signature
let headerSignature = generateSignature(
     "yourClientId",
     "2020-10-21T03:38:28Z",
     "/request-target/goes-here", // For merchant request to Jokul, use Jokul path here. For HTTP Notification, use merchant path here
     digest, // Set empty string for this argumentes if HTTP Method is GET/DELETE
     "secret-key-from-jokul-back-office")
console.log("----- Header Signature -----")
console.log(headerSignature)
  ```
  </Tab>
</Tabs>
