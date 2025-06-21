from flask import Flask, request, render_template_string, redirect
import requests, json

app = Flask(__name__)
CONFIG_FILE = 'config.json'

def load_config():
    try:
        with open(CONFIG_FILE, 'r') as f:
            return json.load(f)
    except:
        return {"webhook": "", "secret": "1234"}

def save_config(data):
    with open(CONFIG_FILE, 'w') as f:
        json.dump(data, f)

HTML = '''
<!DOCTYPE html><html><head><title>KRNL VPS Config</title></head><body>
<h2>KRNL VPS Server Config</h2>
<form method="POST">
  <label>Discord Webhook URL:</label><br>
  <input name="webhook" size="80" value="{{ webhook }}"><br><br>
  <label>Secret Token:</label><br>
  <input name="secret" value="{{ secret }}"><br><br>
  <input type="submit" value="Save Config">
</form><hr>
<p>KRNL หรือ Delta ใช้ URL: <b>http://&lt;VPS_IP&gt;:5000/report</b></p>
<p>Header ต้องใส่: <b>KRNL-Token: {{ secret }}</b></p>
</body></html>
'''

@app.route('/', methods=['GET', 'POST'])
def config():
    cfg = load_config()
    if request.method == 'POST':
        cfg['webhook'] = request.form['webhook']
        cfg['secret'] = request.form['secret']
        save_config(cfg)
        return redirect('/')
    return render_template_string(HTML, webhook=cfg['webhook'], secret=cfg['secret'])

@app.route('/report', methods=['POST'])
def report():
    cfg = load_config()
    token = request.headers.get('KRNL-Token')
    if token != cfg['secret']:
        return {"status": "unauthorized"}, 401
    data = request.json
    print("📡 Received:", data)
    try:
        r = requests.post(cfg['webhook'], json={"content": f"📱 KRNL Report:\n{data}"})
        return {"status": "Sent", "code": r.status_code}
    except Exception as e:
        return {"status": "Error", "msg": str(e)}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
  
