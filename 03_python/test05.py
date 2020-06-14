# Name        : test02.py
# Function    : get the history of 3D
# Version     : python3.6, mySql
# Table       : number(date, seqno, first, second, third)
# Date        : 2018-01-24
# Last Update : 2018-01-25

import re
import urllib.request, urllib.parse, http.cookiejar
from sqlalchemy import create_engine

# Function : get the html from the 3d web
def get_3d_html():
	# the max of sum = 238
	page_num = range(1, 2)
	b = ""
	for page in page_num:
		url = "http://kaijiang.zhcw.com/zhcw/html/3d/list_" \
				+ str(page_num[page - 1]) \
				+ ".html"
		html = urllib.request.urlopen(url).read()
		html = html.decode('utf-8')
		b += html
	return b

# Function : get the 3d numbers by regular
def get_3d_num():
	html = get_3d_html()
	reg = re.compile(r'<tr>.*?<td align="center">'
					r'(.*?)</td>.*?<td align="center">'
					r'(.*?)</td>.*?<td align="center" '
					r'style="padding-left:20px;">'
					r'<em>(.*?)</em>.*?<em>(.*?)</em>.*?'
					r'<em>(.*?)</em></td>', re.S)
	it = reg.findall(html)
	return it

# Function : execute the sql
def executeSql(sql):
	engine = create_engine("mysql+pymysql://root:000000@127.0.0.1:3306/pythonmysql")
	cur = engine.execute(sql)
	print("Insert Ok!!!")

if __name__ == "__main__":
	it = get_3d_num()
	for i in range(0, len(it)):
		#print(it[i][0], it[i][1], it[i][2], it[i][3], it[i][4])
		sql = "INSERT INTO number(date, seqno, first, second, third) VALUES" \
			+ "('%s', '%s', %s, %s, %s)" % (it[i][0], it[i][1], it[i][2], it[i][3], it[i][4])
		print(sql)
		#executeSql(sql)
	print("ok")

	
