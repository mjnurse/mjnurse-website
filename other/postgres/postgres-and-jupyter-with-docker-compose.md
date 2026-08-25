---
title: Postgres and Jupyter with Docker Compose
contents-list: h1,h2
---

The following docker compose setup allows you to run a Postgres database and a Jupyter notebook server together.

```yaml
services:
  db:
    image: postgres:latest
    container_name: pg_test
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: postgres
    ports:
      - "5432:5432"
    volumes:
      - ./pgdata:/home/martin/mjnurse/postgres/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}"]
      interval: 5s
      timeout: 5s
      retries: 10

  jupyter:
    image: quay.io/jupyter/base-notebook:python-3.11
    container_name: jupyter_lab
    depends_on:
      db:
        condition: service_healthy
    ports:
      - "8888:8888"
    environment:
      DATABASE_URL: postgresql://postgres:postgres@db:5432/postgres
    volumes:
      - ./notebooks:/home/martin/mjnurse/postgres
    command: >
      start-notebook.py
      --ServerApp.token=my-token
      --ServerApp.password=
      --ServerApp.allow_origin=*
```