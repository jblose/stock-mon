FROM python:3.8.5-alpine3.12
RUN mkdir /app
COPY ticker-pull.py /app
CMD python /app/ticker-pull.py