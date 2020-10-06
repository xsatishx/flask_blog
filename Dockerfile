FROM python:3.7-alpine

RUN mkdir /app

WORKDIR /app

ADD requirements.txt /app

COPY . /app
USER root

RUN apk update && apk add apache2-dev && apk add gcc && apk add musl-dev

RUN pip3 install -r requirements.txt


RUN mkdir /data

CMD ["gunicorn", "-w 4", "-b", "0.0.0.0:8000", "wsgi:app"]
