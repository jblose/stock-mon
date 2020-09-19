import json
import requests
from flask import Flask
from flask import Response

# r = requests.get('https://finnhub.io/api/v1/quote?symbol=AAPL')
# print(r.json())

app = Flask(__name__)

@app.route('/pulltickers')
def apitickerpull():
    with open("/data/data.json","r") as read_file:
        tickerdata = json.load(read_file)
    results = pullnformat(tickerdata)
    # results = requests.get('https://finnhub.io/api/v1/quote?symbol=AAPL')
    # results = json.dumps(tickerdata)
    return Response(results, mimetype='text/plain')

def pullnformat( tickerdata ):
    results = ''
    for x in tickerdata['ticker']:
        results += requests.get('https://finnhub.io/api/v1/quote?symbol='+x)
      
    return results
        
if __name__ == 'main':
    app.run(debug=True, host='0.0.0.0')

