from urllib.request import Request, urlopen
import os
import json
from flask import abort

def main(request):
    if request.method == 'GET':
        return 'test', 200
    else:
        return abort(405)


if __name__ == '__main__':
    main({})
