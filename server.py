from flask import Flask, redirect, url_for
import json
import sqlite3

app = Flask(__name__)


@app.route("/")
def hello():
    return redirect('static/m.html')


@app.route("/list")
def hello2():
    result = []
    conn = sqlite3.connect('test.db')
    cur = conn.cursor()
    cur.execute("select * from Facebook")
    for row in cur:
        temp = {
            "ID": row[0],
            "name": row[1],
            "latitude": row[2],
            "longitude": row[3]
        }
        result.append(temp)
    conn.close()
    return json.dumps(result)

if __name__ == "__main__":
    app.run()



