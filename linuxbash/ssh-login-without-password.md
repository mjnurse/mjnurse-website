---
title: SSH Login Without Password
---

# ssh Command Line

Create public and private keys using ssh-key-gen on local machine.

```bash
$> ssh-keygen

Generating public/private rsa key pair.
Enter file in which to save the key (/home/martin/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/martin/.ssh/id_rsa.
Your public key has been saved in /home/martin/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:sfuidygosifudyosiduygosidfuygosiduygisdyuiy martin@local
```

Copy the public key to remote-host using ssh-copy-id

```bash
$> ssh-copy-id -i ~/.ssh/id_rsa.pub martin@192.168.0.1

martin@192.168.0.1 password:

Number of key(s) added: 1
```

# PuTTY

## Generate PuTTY Key

Putty (for windows) doesn't support OpenSSH keys directly so we need to create a new ssh key for Putty.  The PuTTYgen tool can do this.

- Open PuTTYgen application

- Click `Conversions` from the PuTTY Key Generator menu and select `Import key`.

- Navigate to the OpenSSH private key and click `Open`.

- Under `Actions` / `Save the generated key`, select `Save private key`.

- Choose an optional passphrase to protect the private key.

- Save the private key as `id_rsa.ppk`.

## Add key to PuTTY

- Enter the remote server Host Name or IP address under `Session`.

- Navigate to `Connection` > `SSH` > `Auth`.

- Click `Browse...` under `Authentication parameters` / `Private key file for authentication`.

- Locate the `id_rsa.ppk` private key and click `Open`.

- Finally, go back to the `Session` on the menu and click `Save`


<hr>
