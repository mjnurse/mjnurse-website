---
title: ssh
---

## Storing SSH Connection / Config details

Store SSH connection details in a config file in the .ssh directory.  File `~/.ssh/config`

Contents

	Host dev
    	HostName dev.example.com
    	Port 22
    	User martin
    Host test
    	HostName test.example.com
    	Port 22
    	User martin

## SSH Login Without Password

1)  Generate a public/private RSA key pair.  Save this to default location `/home/<username>/.ssh/id_rsa`

    $ ssh-keygen

Your public key will be saved in `/home/user/.ssh/id_rsa.pub`

2)  Copy the SSH Public Key to the Remote Host

    $ ssh-copy-id <username>@remoteserver

<hr>
