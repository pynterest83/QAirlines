import json
import psycopg2
conn = psycopg2.connect("dbname=qairline user=postgres password=password")
conn.autocommit = True
cur = conn.cursor()
reader = open("D:/B787.json","r",encoding="utf-8")
data = json.loads(reader.read())
for seat in data:
    name = seat[1]
    description = seat[2]
    if "First Class" in description:
        cur.execute("INSERT INTO \"Seat\" values(%s, %s, %s);", ('B787', name, 'First'))
    elif "Business" in description:
        cur.execute("INSERT INTO \"Seat\" values(%s, %s, %s);", ('B787', name, 'Business'))
    else:
        cur.execute("INSERT INTO \"Seat\" values(%s, %s, %s);", ('B787', name, 'Economy'))
    cur.execute("INSERT INTO \"FlightSeat\" values(%s, %s, %s);", ('VN114', 'B787', name))
reader.close()