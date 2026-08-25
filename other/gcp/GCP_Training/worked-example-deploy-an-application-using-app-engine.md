---
title: Worked Example - Deploy An Application Using App Engine
---

## 1. Create an App

| <img src="/GCP-G/GCP_Training/images/2022-12-23-14_27_35-create-app-–-app-engine-–-app-eng-mjn-–-google-cloud-console.png" width="800"> |

## 2. Create Service

Open a cloud shell.

Create a directory for the service: `mkdir service-1`

Within the directory, create 3 files:

`app.yaml` (Application configuration)

```yaml
runtime: python39
```

`main.py` (Python service)

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'App Service 1 - VERSION 1'
```

`requirements.txt` (Python dependencies)

```
Flask==2.0.2
```

## 3. Deploy Service

```bash
# Set the project

> gcloud projects list

PROJECT_ID: app-eng-mjn
NAME: app-eng-mjn
PROJECT_NUMBER: 999908460627

PROJECT_ID: lustrous-method-999999
NAME: My First Project
PROJECT_NUMBER: 999956012473

> gcloud config set project app-eng-mjn

Updated property [core/project].

# Deploy the app

> gcloud app deploy

descriptor:                  [/home/mjnlearnsgcp/service-1/app.yaml]
source:                      [/home/mjnlearnsgcp/service-1]
target project:              [app-eng-mjn]
target service:              [default]
target version:              [20221223t145157]
target url:                  [https://app-eng-mjn.uc.r.appspot.com]
target service account:      [App Engine default service account]

Do you want to continue (Y/n)?  y

Beginning deployment of service [default]...
Created .gcloudignore file. See `gcloud topic gcloudignore` for details.
Uploading 3 files to Google Cloud Storage
33%
67%
100%
File upload done.
Updating service [default]...done.     
Setting traffic split for service [default]...done.     
Deployed service [default] to [https://app-eng-mjn.uc.r.appspot.com]
```

Navigate to the URL: https://app-eng-mjn.uc.r.appspot.com

Browser will display **App Service 1 - VERSION 1**

Check what's deployed.

```
> gcloud app services list
SERVICE: default
NUM_VERSIONS: 1

> gcloud app versions list
SERVICE: default
VERSION.ID: 20221223t145157
TRAFFIC_SPLIT: 1.00
LAST_DEPLOYED: 2022-12-23T14:54:20+00:00
SERVING_STATUS: SERVING

> gcloud app instances list
SERVICE: default
VERSION: 20221223t145157
ID: 00c61b117ca953b7c54044eebe54eb87956b42bc1dc01cd9ab84dd5e80120b1a60533e859332fd1bcc4a4a3c5686eba83811d058d42673253d6b
VM_STATUS: N/A
VM_LIVENESS:
DEBUG_MODE:
```

## 4. Deploy A Second Version Of The Service

Edit file: `main.py`

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'App Service 1 - VERSION 2'
```

Deploy version 2.  Name the version this time.

```
> gcloud app deploy --version=v2

> gcloud app list versions
SERVICE: default
VERSION.ID: 20221223t145157
TRAFFIC_SPLIT: 0.00
LAST_DEPLOYED: 2022-12-23T14:54:20+00:00
SERVING_STATUS: SERVING

SERVICE: default
VERSION.ID: v2
TRAFFIC_SPLIT: 1.00
LAST_DEPLOYED: 2022-12-23T15:07:33+00:00
SERVING_STATUS: SERVING
```

Navigate to the URL: https://app-eng-mjn.uc.r.appspot.com

Browser will display **App Service 1 - VERSION 2**

Note: By default the URL now routes to the latest version however can still got to VERSION 1 using: https://20221223t145157-dot-app-eng-mjn.uc.r.appspot.com

(The version number assigned by default is datetime)

## 5. Split Traffic Between Version

Update `main.py` to display `App Service 1 - VERSION 3`.

Deploy new version BUT don't make this active.

```
> gcloud app deploy --version=v3 --no-promote
``` 

Split traffic between v2 and v3.

```
> gcloud app services set-traffic --splits=v2=.8,v3=.2A --split-by=random
Setting the following traffic allocation:
 - app-eng-mjn/default/v2: 0.8
 - app-eng-mjn/default/v3: 0.2
NOTE: Splitting traffic by random.
Any other versions of the specified service will receive zero traffic.
Do you want to continue (Y/n)?  y

Setting traffic split for service [default]...done.
```

Note: By default split will be by IP (the IP address of the requester - the browser).

Navigate to the URL: https://app-eng-mjn.uc.r.appspot.com

Browser will display version 2 and version 3 randomly in the split ration specified.

## 6. Naming A Service

To name a service, add the service name to the `app.yaml`

```yaml
runtime: python39
service: mjn-service
```


