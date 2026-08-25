---
title: GMail
---

|Operation|Operator|Example|
|---|---|---|
|Specify the sender|`From:`|`from:amy`|
|Specify a recipient|`To:`|`to:david`|
|Words in the subject line|`Subject:`|`subject:dinner`|
|Messages that match multiple terms|`OR or { }`|`from:amy OR from:david {from:amy from:david}`|
|Remove messages from your results|`-`|`dinner -movie`|
|Find messages with words near each other. Use the number to say how many words apart the words can be|`AROUND #`|`dinner AROUND 5 friday`|
|Messages that have a certain label|`Label:`|`label:friends`|
|Messages that have an attachment|`Has:attachment`|`has:attachment`|
|Messages from a mailing list|`List:`|`list:info@example.com`|
|Attachments with a certain name or file type|`Filename:`|`filename:pdf filename: homework.txt`|
|Search for an exact word or phrase|`" "`|`"dinner and movie tonight"`|
|Group multiple search terms together|`( )`|`subject:(dinner movie)`|
|Messages in any folder, including Spam and Trash|`In:anywhere`|`in:anywhere movie`|
|Search for messages that are marked as important|`is:important label: important`|`is:important`|
|Starred, unread, or read messages|`is:starred is:unread is:read`|`is:read is:starred`|
|Messages that include an icon of a certain color|`has:yellow-star has: blue-info`|`has:purple-star`|
|Recipients in the cc or bcc field|`cc: bcc:`|`cc:david Note: You can't find messages that you received on bcc.`|
|Search for messages sent during a certain time period|`after: before: older: newer:`|`after:2004/04/16 before:2004/04/18`|
|Search for messages older or newer than a time period using d (day), m (month), and y (year)|`older_than newer_than`|`newer_than:2d`|
|Chat messages|`Is:chat`|`is:chat movie`|
|Messages delivered to a certain email address|`Deliveredto:`|`deliveredto:username@gmail.com`|
|Messages in a certain category|`Category:`|`category:updates`|
|Messages larger than a certain size in bytes|`Size:`|`size:1000000`|
|Messages larger or smaller than a certain size in bytes|`larger: smaller:`|`larger:10M`|
|Results that match a word exactly|`+`|`+unicorn`|
|Messages with a certain message-id header|`Rfc822msgid:`|`rfc822msgid:200503292@example.com`|
|Messages that have or don't have a label|`has:userlabels has:nouserlabels`|`has:nouserlabels Note: Labels are only added to a message, and not an entire conversation.`|

<hr>
