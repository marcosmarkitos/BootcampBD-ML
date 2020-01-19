# Bitfana

Please run:
```
docker run -d -p 8086:8086 -v $PWD:/var/lib/influxdb influxdb
docker run -d --name=grafana -p 3000:3000 grafana/grafana
virtualenv .venv
source .venv/bin/activate
pip install -r requirements.txt
python run.py
```
Go to http://localhost:3000

User: admin
pass: admin
