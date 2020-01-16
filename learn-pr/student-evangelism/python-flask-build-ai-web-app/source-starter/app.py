from flask import Flask, render_template

app = Flask(__name__)

# Define route for the app's one and only page
@app.route("/")
def index():
    return render_template("index.html")