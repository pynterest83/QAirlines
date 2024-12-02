import requests
import json
from bs4 import BeautifulSoup
URL = "https://www.seatguru.com/airlines/Emirates_Airlines/Emirates_Airlines_Airbus_A380.php"
page = requests.get(URL)

OutputDirectory = "D:/"

soup = BeautifulSoup(page.content, "html.parser")
areas = soup.findAll('area')
json_array = []
image =  requests.get(soup.find('img', class_="plane")["src"])
with open(OutputDirectory + "out.svg", 'wb') as f:
    f.write(image.content)
for area in areas:
    title = json.loads(area['title'])
    description = title["seats"]["description"].split(" ")
    array = [area['coords'], ''.join((title["seats"]["number"]).split(" ")), ' '.join(description[:2]) + ' '.join(description[2:])]
    json_array.append(array)
    
with open(OutputDirectory + "out.json", 'w', encoding='utf-8') as f:
    json.dump(json_array, f, ensure_ascii=False, separators=(',', ':'))