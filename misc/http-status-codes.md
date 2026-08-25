---
title: HTTP Status Codes
description: 
layout: default
---

# 1xx Informational Response

An informational response indicates that the request was received and understood and is being processed. It alerts the client to wait for a final response.

Code | Name | Description
---- | ---- | -----------
100 | Continue | The server has received the request headers and the client should proceed to send the request body.
101 | Switching Protocols | The requester has asked the server to switch protocols and the server has agreed to do so.
102 | Processing | A WebDAV request may contain many sub-requests involving file operations, requiring a long time to complete the request. This code indicates that the server has received and is processing the request, but no response is available yet.
103 | Early Hints | Used to return some response headers before final HTTP message.

# 2xx Success

A success status indicates that the action requested by the client was received, understood, and accepted.

Code | Name | Description
---- | ---- | -----------
200 | OK | Standard response for successful HTTP requests.
201 | Created | The request has been fulfilled, resulting in the creation of a new resource.
202 | Accepted | The request has been accepted for processing, but the processing has not been completed.
203 | Non-Authoritative Information | The server is a transforming proxy (e.g. a Web accelerator) that received a 200 OK from its origin, but is returning a modified version of the origin's response.
204 | No Content | The server successfully processed the request, and is not returning any content.
205 | Reset Content | The server successfully processed the request, asks that the requester reset its document view, and is not returning any content.
206 | Partial Content | The server is delivering only part of the resource (byte serving) due to a range header sent by the client.
207 | Multi-Status | The message body that follows is by default an XML message and can contain a number of separate response codes, depending on how many sub-requests were made.
208 | Already Reported | The members of a DAV binding have already been enumerated in a preceding part of the (multistatus) response, and are not being included again.
226 | IM Used | The server has fulfilled a request for the resource, and the response is a representation of the result of one or more instance-manipulations applied to the current instance.

# 3xx Redirection

A 3xx status indicates that the client must take additional action, generally URL redirection, to complete the request. A user agent may carry out the additional action with no user interaction if the method used in the additional request is GET or HEAD. A user agent should prevent cyclical redirects.

Code | Name | Description
---- | ---- | -----------
300 | Multiple Choices | Indicates multiple options for the resource from which the client may choose (via agent-driven content negotiation). For example, this code could be used to present multiple video format options, to list files with different filename extensions, or to suggest word-sense disambiguation.
301 | Moved Permanently | The link target was moved such that the request and future similar requests should be redirected to the given URI.
302 | Found | Indicates that the resource is accessible via an alternate URL indicated in the Location header field.
303 | See Other  | If a server responds to a POST or other non-idempotent request with this code and a location header field, the client is expected to issue a GET request to the specified location.
304 | Not Modified | Indicates that the resource has not been modified since the version specified by the request headers If-Modified-Since or If-None-Match. In such case, there is no need to retransmit the resource.
305 | Use Proxy  | The requested resource is available only through a proxy, the address for which is provided in the response. For security reasons, many HTTP clients (such as Mozilla Firefox and Internet Explorer) do not obey this status code.
306 | Switch Proxy | No longer used. Originally meant "Subsequent requests should use the specified proxy".
307 | Temporary Redirect  | In this case, the request should be repeated with another URI; however, future requests should still use the original URI.
308 | Permanent Redirect | This and all future requests should be directed to the given URI.

# 4xx Client Error

A 4xx status code is for situations in which an error seems to have been caused by the client.

Code | Name | Description
---- | ---- | -----------
400 | Bad Request | The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax, size too large, invalid request message framing, or deceptive request routing).
401 | Unauthorized | Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided.
402 | Payment Required | Reserved for future use.
403 | Forbidden | The request was valid, but the server refuses action. This may be due to the user not having permission to a resource or needing an account of some sort, or attempting a prohibited action.
404 | Not Found | The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.
405 | Method Not Allowed | A request method is not supported for the requested resource (for example, a GET request on a form that requires data to be presented via POST, or a PUT request on a read-only resource).
406 | Not Acceptable | The requested resource is capable of generating only content not acceptable according to the Accept headers sent in the request. See Content negotiation.
407 | Proxy Authentication Required | The client must first authenticate itself with the proxy.
408 | Request Timeout | The server timed out waiting for the request. According to HTTP specifications: "The client did not produce a request within the time that the server was prepared to wait. The client MAY repeat the request without modiifcations at any later time".
409 | Conflict | Indicates that the request could not be processed because of conflict in the current state of the resource, such as an edit conflict between multiple simultaneous updates.
410 | Gone | Indicates that the resource requested was previously in use but is no longer available and will not be available again.
411 | Length Required | The request did not specify the length of its content, which is required by the requested resource.
412 | Precondition Failed | The server does not meet one of the preconditions that the requester put on the request header fields.
413 | Content Too Large | The request is larger than the server is willing or able to process. Previously called "Request Entity Too Large" and "Payload Too Large".
414 | URI Too Long | The URI provided was too long for the server to process. Often the result of too much data being encoded as a query-string of a GET request, in which case it should be converted to a POST request. Called "Request-URI Too Long".
415 | Unsupported Media Type | The request entity has a media type which the server or resource does not support.
416 | Range Not Satisfiable | The client has asked for a portion of the file (byte serving), but the server cannot supply that portion.
417 | Expectation Failed | The server cannot meet the requirements of the Expect request-header field.
418 | I'm a teapot | This code was defined in 1998 as one of the traditional IETF April Fools' jokes, in , Hyper Text Coffee Pot Control Protocol, and is not expected to be implemented by actual HTTP servers.
421 | Misdirected Request | The request was directed at a server that is not able to produce a response (for example because of connection reuse).
422 | Unprocessable Content | The request was well-formed (i.e., syntactically correct) but could not be processed.
423 | Locked | The resource that is being accessed is locked.
424 | Failed Dependency | The request failed because it depended on another request and that request failed (e.g., a PROPPATCH).
425 | Too Early | Indicates that the server is unwilling to risk processing a request that might be replayed.
426 | Upgrade Required | The client should switch to a different protocol such as TLS/1.3, given in the Upgrade header field.
428 | Precondition Required | The origin server requires the request to be conditional. Intended to prevent the 'lost update' problem, where a client GETs a resource's state, modifies it, and PUTs it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict.
429 | Too Many Requests | The user has sent too many requests in a given amount of time. Intended for use with rate-limiting schemes.
431 | Request Header Fields Too Large | The server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large.
451 | Unavailable For Legal Reasons | A server operator has received a legal demand to deny access to a resource or to a set of resources that includes the requested resource. The code 451 was chosen as a reference to the novel Fahrenheit 451.

# 5xx Server Error

5xx status indicates that the server is aware that it has encountered an error or is otherwise incapable of performing the request. Except when responding to a HEAD request, the server should include an entity containing an explanation of the error situation, and indicate whether it is a temporary or permanent condition. Likewise, user agents should display any included entity to the user. These response codes are applicable to any request method.

Code | Name | Description
---- | ---- | -----------
500 | Internal Server Error | A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.
501 | Not Implemented | The server either does not recognize the request method, or it lacks the ability to fulfil the request. Usually this implies future availability (e.g., a new feature of a web-service API).
502 | Bad Gateway | The server was acting as a gateway or proxy and received an invalid response from the upstream server.
503 | Service Unavailable | The server cannot handle the request (because it is overloaded or down for maintenance). Generally, this is a temporary state.
504 | Gateway Timeout | The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.
505 | HTTP Version Not Supported | The server does not support the HTTP version used in the request.
506 | Variant Also Negotiates | Transparent content negotiation for the request results in a circular reference.
507 | Insufficient Storage | The server is unable to store the representation needed to complete the request.
508 | Loop Detected | The server detected an infinite loop while processing the request (sent instead of 208 Already Reported).
510 | Not Extended | Further extensions to the request are required for the server to fulfil it.
511 | Network Authentication Required | The client needs to authenticate to gain network access. Intended for use by intercepting proxies used to control access to the network.
