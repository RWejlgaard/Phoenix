from urllib.request import Request, urlopen
import os
import json
import flask
from flask import abort


def main(request):
    if request.method == 'GET':
        return 'pong', 200
    else:
        return abort(405)


if __name__ == '__main__':
    main({})
