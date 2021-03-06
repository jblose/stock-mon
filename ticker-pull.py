import json
import requests
from flask import Flask
from flask import Response

app = Flask(__name__)


@app.route('/pulltickers')
def apitickerpull():
    with open("/app/data.json", "r") as read_file:
        tickerdata = json.load(read_file)
    with open("/app/api-key.json", "r") as read_file:
        apikey = json.load(read_file)
    results = pullnformat(tickerdata, apikey)
    return Response(results, mimetype='text/plain')


def pullnformat(tickerdata, apikey):
    results = ''
    for x in tickerdata['ticker']:
        r = requests.get('https://finnhub.io/api/v1/quote?symbol=' +
                         x + '&token=' + apikey['api'])
        for y in r.json():
            out = y
            results += 'stock_mon_' + out + \
                '{ticker="' + x + '"} ' + json.dumps(r.json()[y]) + '\n'
    return results


if __name__ == 'main':
    app.run(debug=True, host='0.0.0.0')
