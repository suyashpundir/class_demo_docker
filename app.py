# app.py

from flask import Flask

# The Flask application instance must be named 'app' for Gunicorn to easily find it.
app = Flask(__name__)

@app.route('/')
def hello_world():
    """A simple route that returns a greeting."""
    return "Hello from the Dockerized Flask App!:" \
    "this is for INT363 class activity."

if __name__ == '__main__':
    # This is for local development only. Gunicorn runs the app in the container.
    app.run(debug=True, host='0.0.0.0', port=5000)
