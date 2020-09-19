FROM python:3.8.5-alpine3.12
RUN apk add build-base libffi-dev openssl-dev python3-dev
ADD requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt
ADD ticker-pull.py /app/ticker-pull.py
ENV FLASK_APP=/app/ticker-pull.py 
ENV FLASK_ENV=development
CMD flask run