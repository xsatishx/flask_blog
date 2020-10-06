FROM python:3.7-alpine

RUN mkdir /app

WORKDIR /app

ADD requirements.txt /app

COPY . /app

RUN pip3 install -r requirements.txt

USER root

RUN mkdir /data

#ENTRYPOINT ["python", "app.py"]
CMD ["gunicorn", "-w 4", "-b", "0.0.0.0:8000", "wsgi:app"]
