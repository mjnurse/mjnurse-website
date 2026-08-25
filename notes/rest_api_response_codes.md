---
title: REST API Response Codes
contents-list: h1,h2
---

Here is a list of the most common response codes:

| Code  | Meaning               | Description |
|-------|-----------------------|-------------|
| **200** | OK | The request was successful and the response contains the requested data. |
| **201** | Created | The request was successful, and a new resource was created. |
| **202** | Accepted | The request was accepted for processing but not completed yet. |
| **204** | No Content | The request was successful, but there is no response body. |
| **205** | Reset Content | The request was successful; the client should reset the document view. |
| **400** | Bad Request | The request is malformed or invalid (e.g., incorrect JSON, missing fields). |
| **401** | Unauthorized | Authentication is required but missing or invalid. |
| **403** | Forbidden | The request is understood, but the client is not allowed to access the resource. |
| **404** | Not Found | The requested resource does not exist. |
| **405** | Method Not Allowed | The HTTP method is not supported for this resource. |
| **408** | Request Timeout | The server timed out waiting for the client’s request. |
| **409** | Conflict | The request conflicts with the current state of the resource (e.g., duplicate record). |
| **415** | Unsupported Media Type | The request body format is unsupported (e.g., sending XML when JSON is required). |
| **429** | Too Many Requests | The client has sent too many requests in a short time (rate limiting). |
| **500** | Internal Server Error | A generic server-side error. |

