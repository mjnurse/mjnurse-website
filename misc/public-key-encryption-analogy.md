---
title: Public Key Encryption Analogy
---



# What is Public Private Key Encryption?

This process uses an algorithm that can encrypt data using a public key however, the data can only be decrypted using a private key.  

I share my public key with everyone and they use it to encrypt data they send to me.  Only I can decrypt and read that data.

# The Analogy

As an analogy to public, private key encryption, consider a secure, locked post-box which contains a slot through which notes can be posted.  Notes posted in to the post-box cannot be read (as with encryption).  To read the notes (decrypt the data) the post-box must first be unlocked.

The post-box will be identified by an id number / key.  The post-box is one of a billion billion billion (or more) identical post-boxes stored in a shared location.  The only means of identifying the correct post-box is by the post-box Id. When a note is posted into the locked post-box, the note can't be read and is secure.  

The process of posting a note into the post-box is synonymous to encrypting the data using the post-box id (public key).  

The only way to access notes in the post-box is by unlocking the post-box.   This means unlocking the post-box using the lock code (private key).  The notes can then be read which is synonymous to decrypting the data.

The analogy fails because the notes have to be taken to the shared location for the post-box and posted.  Notes will also need to be taken from shared location to the location of the individual who wants to read the notes.  Whilst the notes are in transit, the contents are insecure.   

# We can extend the analogy to solve this issue.  

Let's say we can request a new post-box each time we need to post a note (encrypt data).  We state the post-box Id and the post-box comes locked using the same unlock code (private key) as used in other post-boxes with the same Id / Key.

Once we have a post-box, we post the note(s) into the locked post-box, and then send the post-box to a shared location.  The note is secure during transit.

When we want to access and read the notes, we request that all the post-boxes with my public Id / Key are sent to our location (the notes will be secure in transit).  We can then un-lock the post-boxes and read the notes (decrypt the data).  Before the post-boxes are sent to us a copy will be made of the post-boxes without unlocking them (simple with software - impossible with our physical post-boxes).
<hr>
