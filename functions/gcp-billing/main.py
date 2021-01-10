from urllib.request import Request, urlopen
import os
import json


def main(request):
    try:
        data = request.get_json()
    except AttributeError:
        data = request

    ret = "test"

    print(ret)
    return ret


if __name__ == '__main__':
    main({})
