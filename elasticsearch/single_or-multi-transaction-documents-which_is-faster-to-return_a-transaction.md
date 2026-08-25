---
title: Single Transaction or Multi Transaction Documents - Which is Faster To Return a Transaction 
---
# Single Transaction or Multi Transaction Documents - Which is Faster To Return a Transaction 

### The Question

If we are using Elastic Search to store transactions (bank account transactions), is it more performant to bundle transactions together and create fewer documents, or create a document for each transaction?

For the purpose of this test, a transaction is:
```
[transaction_id, account_number, date, payee, amount]
```
Where:
- **transaction_id** - A unique number constructed from month, account number and transaction number.
- **account_number** - 100000000000 + integer in range 1 - 100,000 (100,000 accounts).
- **date** - yyyymmdd.  With a range of 36 months.
- **payee** - 3 random words, circa 30 characters length in total.
- **amount** - A number in the range -10,000.00 to 10,000.00.

As I alluded to above, I generated transactions for 36 months and 100,000 accounts.  For each month I generated between 40 and 60 transactions per account.

I'm comparing 3 indexing options:

- A document per transaction.
- A document per account per month.
- A document containing 10 accounts transactions per month.

I'll compare time to index, size of index and time to return a set of random transactions.

Before running the retrieval operations I'll run a force merge to reduce the index segments to 1 per shard to ensure this doesn't impact on performance.  My index is split of 5 shards.  Elastic Search service has 0.5GB memory and an Intel i7 CPU, running Windows 10.

## Results

### One Document Per Transaction:
 
| **Build Time**                      | 278s per month               |
| **Index Size**                      | 19.6gb                       |
| **Number of Documents**             | 163,466,856                  |
| **Query 1,000 random transactions** | 1.33s (average over 25 runs) |

### One Document Per Month For Each Account:

| **Build Time**                      | 94.0s per month              |
| **Index Size**                      | 16gb                         |
| **Number of Documents**             | 36,000,000                   |
| **Query 1,000 random transactions** | 1.38s (average over 25 runs) |

### Each document Contains Transactions For 10 Accounts Per Month:

| **Build Time**                      | 99.7s per month              |
| **Index Size**                      | 13gb                         |
| **Number of Documents**             | 3,600,000                    |
| **Query 1,000 random transactions** | 2.38s (average over 25 runs) |

## Summary

Indexing 1 document per account per month was almost 3x quicker than 1 document per transaction and used circa 20% less space.  Query times between the two were very similar.

Moving up to 1 document for 10 accounts transactions per month, took about the same time to index as 1 accounts transaction per month and saved a further 18% in space but took 70% longer to query.  I suspect it was due to the volume of data returned.  I got very close to 1 document returned for each transaction in both multi transaction per document tests.  However, in the multiple accounts per document per month test, the documents returned were 10x larger.

This test suggest that it is best in terms of space used, index build time and random transaction query time to use 1 document per account per month.
<hr>
