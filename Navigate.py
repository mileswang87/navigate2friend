__author__ = 'sricharan'

import sqlite3
from facepy import GraphAPI
import datetime

today = str(datetime.datetime.now()).split(" ")[0]
conn = sqlite3.connect('Facebook.db')
conn.execute("DROP TABLE IF EXISTS Facebook")
conn.execute("CREATE TABLE Facebook(Id TEXT, Name TEXT, Lati TEXT, Longi TEXT)")
token = 'YOUR_TOKEN HERE'
graph = GraphAPI(token)
temp1 = graph.get('me?fields=friendlists.list_type(current_city).fields(members)')
for data in temp1['friendlists']['data']:
    if 'members' in data:
        for name in  data['members']['data']:
            for item in  graph.get(name['id']+'/feed?fields=place&limit=1')['data']:
                if 'place' in item:
                    if today == str(item['created_time'].split('T')[0]):
                        if 'latitude' in item['place']['location']:
                            id = name['id']
                            print id
                            name1 = name['name']
                            lat = item['place']['location']['latitude']
                            long = item['place']['location']['longitude']
                            conn.execute("INSERT INTO Facebook VALUES('%s','%s', '%s', '%s')" %(id, name1,lat, long))
                            conn.commit()
conn.close()