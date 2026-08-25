---
title: 19-02-14 - JWT - JSON Web Tokens
section: Misc
---

Today I was looking at authentication for a web-service.  It was using JSON Web Tokens.

# What are JWTs?  How do they work?

A JWT is a cryptographically signed JSON token used to authenticate users making calls to an application.  A JWT is sent to a user when they authenticate with an authentication Service.  The user can send this token with requests to an application (web-service or other) as proof of identity.  The application talks to the authentication server and is told the how the token was cryptographically signed and the key used.  This allows the application to be sure that the token is valid and originated from the authentication service.

Two types of cryptographic signatures can be used:

- Symmetric hash algorythm - where the same key is used to sign and assure the JWT.
- Asymmetric hash algorythm (public/private key) - Where a private key is used to sign the JWT and a public key is used to assure the JWT.

Symmetric hashes are much quicker to compute than Asymmetric hashes, but mean the secret key will need to be shared with all applications which need to authenticate users.

# The contents of a JWT

A JWT is made up from 3 components:

## Header

The header describes how the JWT was computed.  A typical header will contain:

```
{ "typ" : "JWT"
, "alg" : "HS256" }
```
The key:value 'typ' specifies that this is a JWT.  The key:value 'alg' specifies that this JWT was signed using the symmetric HMAC-SHA256 algorithm.  The header JSON is converted to a url encoded string using base64urlEncode.  

## Payload (also called the 'Claims')

The payload contains the information which is asserted / claimed to be true.  This could contain:
```
{ "userId" : "martin-98999394"
, "exp" : 15634343 }
```
The free form key:value 'userId' could specify the Id of the user which the JWT asserts is authorised.  A request from that userId, along with the JWT, would authenticate that user.  The key:value 'exp' (which is one of a set of standard keys) specifies when the JWT expires.  The payload JSON is converted to a url encoded string using base64urlEncode.

## Signature

The signature is created by appending the payload url encoded string to the header url encoded string (separated by a '.') and then hashing this value using the specified algorithm and secret.  The hash value is then also converted to a url encoded string using base64urlEncode and then append to the header.payload string (again separated by a '.').

# Creating the JWT (using a symmetric hash algorithm)

As pseudo we have:
```
body = base64urlEncode( headerJSON ) + '.' + base64urlEncode( payloadJSON );

signature = base64urlEncode( hash_algorithm( body, secret_key ) );

JWT = body + '.' + signature;
```
The JWT will look something like:
```
eyJ0eXAiOiJKV1QGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiJiMDhmODZhZi0zNWRhLTQ4ZjItO.GZhYi1jZWYzOTA0NjYwYmQifQ
```
NOTE: 
- The payload is **NOT** encrypted, it is simply converted to base64url encoding and can be reversed.
- If the contents of the JWT are modified in anyway then the signature will not longer match the contents.

# Assuring the JWT

The application to which the JWT is passed to authenticate the user will:
```
split( JWT ) => header, payload, signature;

body = header + '.' + payload;

new_signature = base64urlEncode( hash_algorithm( body, secret_key ) );

if new_signature matches signature then JWT is valid;
```
NOTE:
- The JWT assurance process recomputes the hash of header and payload using the **same** secret key as the process that created the JWT.
- The payload can now be converted back to JSON to allow the application to check it has not expired and to get the authenticated userId.
- If the secret key is known by a third party, the third party can also create valid JWTs so the secret must not be shared.

# Using an Asymmetric Hash Algorithm

When symmetric hash algorithms are used, the authentication service needs to share the secret key used to create the signature with the applications / services which need to assure the JWT.  This is a security risk as the key could be maliciously use to create new JWTs.

An Asymmetric encryption algorithm allows the signature to be created (encrypted) using a private key when the JWT is created.  To assure the JWT, the application / service can decrypt the signature using the public key.  The application can then compare this to the header and payload to assure the JWT is valid.

As pseudo code:

**Creating a JWT**

```
body = base64urlEncode( headerJSON ) + '.' + base64urlEncode( payloadJSON );

signature = base64urlEncode( hash_algorithm_encode( body, private_key ) );

JWT = body + '.' + signature;
```

**Assuring the JWT**

```
split( JWT ) => header, payload, signature;

body = header + '.' + payload;

decoded_signature = hash_algorithm_decode( base64urlDecode( signature ), public_key );

if decoded_signature matches the body then JWT is valid;
```

In this case we can be sure that the service which created the JWT knows the private key.  For the signature to be successfully decrypted using the public key it MUST of be created using the private key.

<hr>
