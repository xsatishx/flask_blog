from flask import Flask, request, escape

app = Flask(__name__)


@app.route('/')
def hello():
    return 'Hello, World!'


@app.route('/greet')
def greet():
    name = request.args['name']
    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <h1>Hi {}</h1>
    </body>
    </html>'''.format(escape(name))


if __name__ == '__main__':
        app.run(host='0.0.0.0')
