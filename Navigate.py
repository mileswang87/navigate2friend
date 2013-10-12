__author__ = 'sricharan'

import sqlite3
from facepy import GraphAPI
from time import sleep
import datetime

conn = sqlite3.connect('Facebook.db')
try:
    conn.execute("CREATE TABLE Facebook(Id INT PRIMARY KEY, Name TEXT, Location TEXT, Lati TEXT, Longi TEXT)")
except sqlite3.OperationalError:
    print "Table exist"
while True:
    print "Running Data Server"
    today = str(datetime.datetime.now()).split(" ")[0]

    #TODO
    token = "CAACEdEose0cBACd8ZAuZCyzc71O9kmwjsbyUqjZBJpITY7pZBZB9n1sZBmyWYyNfd22rnown9pEEFrZAb4bfnfCqIgZBbUIJXiV22T1AWt3WxDvwiX3wZA8fLKY4TrxCIe29MbGuCu4FgZCMRynhswF2D8ZCgCvPjjza7kFiUakwZC75z6ZAtj7hAiiOF0IyoXtZB9thwZD"
    graph = GraphAPI(token)
    temp1 = graph.get('me?fields=friendlists.list_type(current_city).fields(members)')
    for data in temp1['friendlists']['data']:
        if 'members' in data:
            for name in  data['members']['data']:
                for item in  graph.get(name['id']+'/feed?fields=place&limit=1')['data']:
                    if 'place' in item:
                        if today == str(item['created_time'].split('T')[0]):
                            if 'latitude' in item['place']['location']:
                                print item
                                id = name['id']
                                name1 = name['name']
                                loca = item['place']['name']
                                lat = item['place']['location']['latitude']
                                long = item['place']['location']['longitude']
                                conn.execute("INSERT OR REPLACE INTO Facebook VALUES('%s','%s', '%s','%s', '%s')" %(id, name1,loca, lat, long))
                                conn.commit()
    #exit()
    sleep(10)
    print "Running Data Server"
conn.close()
