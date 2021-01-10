import urllib.request as r
import os
import json


def weather():
    api_key = os.environ.get("openweathermap-api-key")

    req = r.Request(f'https://api.openweathermap.org/data/2.5/weather?q=London&appid={api_key}&units=metric')
    response = r.urlopen(req)
    data = json.loads(response.read())

    weather_main = data['weather'][0]['main']
    main_temp = data['main']['temp']
    main_feels_like = data['main']['feels_like']

    ret = f"""Today there will be {weather_main}
The current temperature is {main_temp} which feels like {main_feels_like}   
"""

    return ret


def main(request):
    try:
        data = request.get_json()
    except AttributeError:
        data = request

    ret = weather()

    print(ret)
    return ret


if __name__ == '__main__':
    main({})
