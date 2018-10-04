FROM python:3-alpine

RUN apk update && \
    apk add git

WORKDIR /opt/app

COPY . ./

RUN pip3 install -r requirements.txt

ENV PYTHONUNBUFFERED 1
ENV SAILSD_HOST 'localhost'
ENV SAILSD_PORT 3333

ENTRYPOINT ["/bin/sh", "-c", "python3 sails-ui-web"]
