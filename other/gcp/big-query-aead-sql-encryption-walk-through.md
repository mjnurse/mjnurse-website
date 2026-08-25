---
title: GCP AEAD SQL Encryption
---

A walk through using the AEAD SQL encryption functions (Private Beta as off Nov 2018)

In this example I encrypt some PPI data (person name).  I encrypt each name twice.  

-  The first encryption uses a key which is unique to the person and is stored in a parallel person key table.  This type of encryption is a great way to implement the GDPR "right to be forgotten" rule.  To forget a person we don't need to locate and delete all PPI records in all tables, we just need to delete the person key record.  The renders all the person data encrypted using the person key unreadable.

-  The second encryption uses a key unique to the field in the person record.  This key is passed as a parameter into the read / write SQL.  This key can be stored outside of GCP (or in a different project).  If this key is protected using a different authentication process, this gives cryptographically secured two factor authentication.

## Step 1: Create a keyset JSON string to use in following queries to encrypt the column

Exporting the key as a JSON document means we can pass this as a text parameter into BigQuery SQL queries.

```
> bq query --use_legacy_sql=false \
           "SELECT KEYS.KEYSET_TO_JSON(KEYS.NEW_KEYSET('AEAD_AES_GCM_256'))"

Waiting on bqjob_r711c9125fb3c8635_00000166f7fcd20e_1 ... (0s) Current status: DONE

+----------------------------------------------------------------------------------------------------------------+
| f0_                                                                                                            |
+----------------------------------------------------------------------------------------------------------------+
| {"key":[{"keyData":{"keyMaterialType":"SYMMETRIC","typeUrl":"type.googleapis.com/google.crypto.tink.AesGcmKey" |
| ,"value":"GiCUh160exVnX5GBZNsPAzeHamcuxMqIlzmzBAhcDg/mtQ=="}                                                   |
| ,"keyId":3252846060,"outputPrefixType":"TINK","status":"ENABLED"}],"primaryKeyId":3252846060}                  |
+----------------------------------------------------------------------------------------------------------------+
```

## Step 2: Drop the person_source table if it exists, then create the person_source table

The person_source table is the un-encrypted version of the table which is only here as part of the example.  The protected table is called person_encrypted and is created below.

```
> bq query --use_legacy_sql=false \
           "DROP TABLE test.person_source"

Waiting on bqjob_r4f94c6b837a63b6d_00000166f7fce4b6_1 ... (0s) Current status: DONE

> bq query --use_legacy_sql=false \
           "CREATE TABLE test.person_source (id INT64, name STRING)"

Waiting on bqjob_r2a101370e655b92d_00000166f7fcf1cf_1 ... (0s) Current status: DONE
```

## Step 3: Load names into the person_source table

```
> bq query --use_legacy_sql=false \
           "INSERT test.person_source (id, name) VALUES (1, 'Jacob'), (2, 'Michael'), (3, 'Joshua') \
                                                      , (4, 'Matthew'), (5, 'Christopher'), (6, 'Andrew') \
                                                      , (7, 'Daniel'), (8, 'Ethan'), (9, 'Joseph') \
                                                      , (10, 'William')"

Waiting on bqjob_r275805bf8882b248_00000166f7fd0090_1 ... (0s) Current status: DONE
```

## Step 4: Query the person_source table

```
> bq query --use_legacy_sql=false \
           "SELECT id
                 , name
            FROM   test.person_source"

Waiting on bqjob_ra54130d4805ac55_00000166f7fd12c5_1 ... (0s) Current status: DONE

+----+-------------+
| id | name        |
+----+-------------+
|  4 | Matthew     |
|  8 | Ethan       |
|  3 | Joshua      |
|  7 | Daniel      |
|  9 | Joseph      |
|  5 | Christopher |
| 10 | William     |
|  1 | Jacob       |
|  2 | Michael     |
|  6 | Andrew      |
+----+-------------+
```

## Step 5:  Drop the person_keys table if it exists, then create the person_keys table

```
bq query --use_legacy_sql=false \
         "DROP TABLE test.person_keys"

Waiting on bqjob_r6df2b79bd19fadb8_00000166f7fd2875_1 ... (0s) Current status: DONE

bq query --use_legacy_sql=false \
         "CREATE TABLE test.person_keys (id INT64, keyset BYTES)"

Waiting on bqjob_r3f0247c2f3912181_00000166f7fd3598_1 ... (0s) Current status: DONE
```

## Step 6:  Insert into the person_keys table a keyset for each record in the person_source table

Each person key is unique to the person.

```
bq query --use_legacy_sql=false \
         "INSERT INTO test.person_keys (id, keyset)
          SELECT id
               , KEYS.NEW_KEYSET('AEAD_AES_GCM_256')
          FROM   test.person_source"

Waiting on bqjob_r2ae1b537b3e743f3_00000166f7fd42b6_1 ... (0s) Current status: DONE
```

## Step 7:  Query the person_keys table

To show the list of unique person keys.

```
bq query --use_legacy_sql=false \
         "SELECT id
               , key
          FROM   test.person_keys"

Waiting on bqjob_r126311790a1faa8e_00000166f82de588_1 ... (0s) Current status: DONE

+----+----------------------------------------------------------------------------------------------------------+
| id | keyset                                                                                                   |
+----+----------------------------------------------------------------------------------------------------------+
|  1 | CMbb5eYIEmQKWAowdHlwZS5nb29nbGVhR2NtS2V5EiIaIGQQtS9JhdBiWYlZ0lL/NuJkQ23Yh8VGuVsb7X+Gu/d7GAEQARjG2+XmCCAB |
|  7 | CJeR0f0BEmQKWAowdHlwZS5nb29nbGVhR2NtS2V5EiIaIPt8RBW3P8NfOY8qL8l/mIfjjuUdzqHvwQ33NfX0iTTcGAEQARiXkdH9ASAB |
|  9 | CPH1jbwKEmQKWAowdHlwZS5nb29nbGVhR2NtS2V5EiIaIC5aRPGITVaHszgWsuMoCVBn2jVGzmyvgC0Zy8tCuZPmGAEQARjx9Y28CiAB |
|  4 | CJbb7KcPEmQKWAowdHlwZS5nb29nbGVhR2NtS2V5EiIaIDGtQyKAkM7rf4HNYELpb7gPdbMnS32Qsm/AmXkJacWlGAEQARiW2+ynDyAB |
|  2 | CPWcxLgOEmQKWAowdHlwZS5nb29nbGVhcGlzL2V5EiIaIBd9fsTUu2/CtdahrlUv8gl57DHv/1K2WWE+oMcToQ6MGAEQARj1nMS4DiAB |
|  8 | CIGquPkEEmQKWAowdHlwZSRpbmsuQWVzR2NtS2V5EiIaIH01l1QYjACelMLlFfLXoYI1gXFUUr0Ct/gkRHb9pSr0GAEQARiBqrj5BCAB |
|  3 | CMyWxb0IEmQKWAowdHlwZS5nb29nbGVhcGlzLmNvbS9nb29KBN8U7XfOwyh63hTzc2iOqD6FiZOQr2UF7FW791OVGAEQARjMlsW9CCAB |
| 10 | CNro++sFEmQKWAowdHlwZS5nb29nbGVhcGlzLmNvbS9nb29nbGUuY3J5cHRvLG9Cr4QzamKkVWAQwl0HWqMYBpVQGAEQARja6PvrBSAB |
|  5 | CKbPvJQGEmQKWAowdHlwZS5nb29nbGVhcGlzLmNvbS9nb29nbGUuY3J5cHRvLfqjE5mJcbcOdM5nH08jCj2lvepSGAEQARimz7yUBiAB |
|  6 | CO/I2K8CEmQKWAowdHlwZS5nb29nbGVhcGlzLmNvbS9nb29nbGUuY3J5PyumQg+ac2LW/PNyI7mteVNtWQu+mfB6GAEQARjvyNivAiAB |
+----+----------------------------------------------------------------------------------------------------------+
```

## Step 8:  Drop the person_encrypted table if it exists, then create the person_encrypted table

```
bq query --use_legacy_sql=false \
         "DROP TABLE test.person_encrypted"

Waiting on bqjob_r65d6e288d1b49fe9_00000166f7fd602b_1 ... (0s) Current status: DONE

bq query --use_legacy_sql=false \
         "CREATE TABLE test.person_encrypted (id INT64, name BYTES)"

Waiting on bqjob_r61cb90a9bc9bfc2a_00000166f7fd6eaf_1 ... (0s) Current status: DONE
```

## Step 9:  Use the Column keyset JSON string as a parameter to encrypt the data

We pass in the column encryption key JSON text as a parameter to BigQuery.  I'm assume this is safe as bq utility will encrypt the data in transit to GCP.  person_source records are encrypted and stored in the person_encrypted table.

```
bq query --use_legacy_sql=false \
         --parameter=pKeysetJSON:string:{"key":[{"keyData":{"keyMaterialType":"SYMMETRIC","typeUrl":"type.googleapis.com/google.crypto.tink.AesGcmKey","value":"GiBwYd/0Nq59woCCMf7s1msmKFhMIfSceoHUX0Fl3LiNWw=="},"keyId":1869443697,"outputPrefixType":"TINK","status":"ENABLED"}],"primaryKeyId":1869443697} \
         "INSERT INTO test.person_encrypted (id, name)
          SELECT ps.id
               , AEAD.ENCRYPT(ck.keyset, AEAD.ENCRYPT(pk.keyset, ps.name, ''), ck.keyset)
          FROM   test.person_source ps
          JOIN   test.person_keys pk ON (s.id = ps.id)
          JOIN   (SELECT KEYS.KEYSET_FROM_JSON(@pKeysetJSON) AS keyset) ck ON person_enc(1=1)"

Waiting on bqjob_r5f7c1d15a55c1a4d_00000166f7fd7be1_1 ... (0s) Current status: DONE
```

## Step 10:  Query the person_encrypted Table

The table contents are unreadable.

```
bq query --use_legacy_sql=false \
         "SELECT id
               , name
          FROM   test.person_encrypted"

Waiting on bqjob_r72942984bbbbb556_00000166f7fd8e7f_1 ... (0s) Current status: DONE

+----+----------------------------------------------------------------------------------------------------------+
| id | name                                                                                                     |
+----+----------------------------------------------------------------------------------------------------------+
|  3 | AW9tcnED+aOoW5gjUBuzXY0zs5vmOagil3v8noyXAC0FD0X8bXrqjx2EhGv7KVsZjCrVNoTJuHRAh8ei0nimikhBCxFRxNdt         |
| 10 | AW9tcnEfTXAPOCCmO9TLjM3u/RAkoDLSW/RMaFxnU9OZ249CJUZ8sHBdYMvHKDNGbkx6Kx0YQxpf+lUZWUjRPLOy5rjbTypXYA==     |
|  4 | AW9tcnFQ/0s2NlmK/u+KT9aa/xGaqXzdj0DvoyKvdLz0jqxNesXqDdl3zWheaq5l40/ZZrZIbjQcI2s5cRYHaOq5/kMBJOVvug==     |
|  6 | AW9tcnG6hl1aZZh9clBw/VA5kts9CX0dXyplNrjkUmSU/vwTimvh5qXurX8/ipj94putjiP3GKDCxuGqZzEoUrAZ9pS7BsuK         |
|  1 | AW9tcnEnxzS/m57+E6vGBZuvDaTsNnrnzaGwFxfO+eAR89UZZB52fXv0syNMN/kDeFlcwKXSm/IN4KArKEj9yPI0LCCcmnQ=         |
|  2 | AW9tcnGap7569wRg7z9IS2TcGw0zY3mtkCmWPVhfSdmkDwg15oyq+C6ZL/vdxZaM5csr8SrV1ZXcHnkb7OAMG2eNNVgL3Sb7cQ==     |
|  9 | AW9tcnG9m7DBQFr+rOXBZ2V5YEs43sYEaGNK5Zy7IqFKtrzfbsSdWDm6xomnYRJ2dFE2j7W/x08c+48AJzBPT7CuIqQGZP+C         |
|  5 | AW9tcnHvwirdA8MNtMoBMk/RF671wPW+8gTDVeLJ4O1CKxYYiQ9via94YeNBAI9gJ6aDg3LfHajguAb86LBh8SfF4U9yujbkJouRcc0= |
|  7 | AW9tcnET849pBVdmbF+oq+PFAS4skW6e9S2cJU1EPF430TzHr/80E0NHfjHbngkFrZ7RWC4U/atDcdrCOLAzBK8n9WMl9pwp         |
|  8 | AW9tcnHX01SlHSstEs2OfNXGTVB4IT0ouXfKNMZuiwG7FkXPPkv1mfWKEPwUSZcbEkNQLr0+VUXXQj0SDYZURTiQPV0SYr8=         |
+----+----------------------------------------------------------------------------------------------------------+
```

## Step 11:  Query person_encrypted and decrypt at query time

We pass in the column encryption key JSON text as a parameter to BigQuery.  I'm assume this is safe as bq utility will encrypt the data in transit to GCP.

```
> bq query --use_legacy_sql=false \
           --parameter=pKeysetJSON:string:{"key":[{"keyData":{"keyMaterialType":"SYMMETRIC","typeUrl":"type.googleapis.com/google.crypto.tink.AesGcmKey","value":"GiBwYd/0Nq59woCCMf7s1msmKFhMIfSceoHUX0Fl3LiNWw=="},"keyId":1869443697,"outputPrefixType":"TINK","status":"ENABLED"}],"primaryKeyId":1869443697} \
           "SELECT pe.id
                 , AEAD.DECRYPT_STRING(s.keyset, AEAD.DECRYPT_BYTES(ck.keyset, pe.name, ck.keyset), '') AS name
            FROM   test.person_encrypted pe
            JOIN   test.person_keys pk ON (pk.id = pe.id)
            JOIN   (SELECT KEYS.KEYSET_FROM_JSON(@pKeysetJSON) AS keyset) ck ON (1=1)"

Waiting on bqjob_r7541af8cd788eab7_00000166f7fda0ef_1 ... (0s) Current status: DONE

+----+-------------+
| id | name        |
+----+-------------+
|  3 | Joshua      |
| 10 | William     |
|  4 | Matthew     |
|  6 | Andrew      |
|  1 | Jacob       |
|  2 | Michael     |
|  9 | Joseph      |
|  5 | Christopher |
|  7 | Daniel      |
|  8 | Ethan       |
+----+-------------+
```
<hr>
