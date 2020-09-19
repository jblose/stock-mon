FROM python:3.8.5-alpine3.12
ADD requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt
ENV FLASK_APP=/app/ticker-pull.py 
ENV FLASK_ENV=development
ADD api-key.json /app/api-key.json
ADD ticker-pull.py /app/ticker-pull.py
ADD data.json /app/data.json
CMD flask run