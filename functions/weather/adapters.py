import json
import urllib.request as r

class ifttt_adapter:
    def post(self, title, message):
        payload = {
            "value1": title,
            "value2": message
        }

        url = "https://maker.ifttt.com/trigger/gp/with/key/d6bVq32ioOJtEmaO2AYSQK"

        params = json.dumps(payload).encode('utf8')
        req = r.Request(url, data=params, headers={'content-type': 'application/json'})
        r.urlopen(req)