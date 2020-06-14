# Name        : test01.py
# Function    : get the number of 3D today
# Version     : python3.6, mySql
# Table       : number(date, seqno, first, second, third)
# Date        : 2018-01-24
# Last Update : 2018-01-25

from bs4 import BeautifulSoup
import re
import urllib.request, urllib.parse, http.cookiejar

def get_3d_Html(url):
	cj = http.cookiejar.CookieJar()
	opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj))
	opener.addheaders = [('User-Agent',
	'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36'),
	('Cookie', '4564564564564564565646540')]
	urllib.request.install_opener(opener)
	html_bytes = urllib.request.urlopen(url).read()
	html_string = html_bytes.decode('utf-8')
	return html_string

def get_3d_Number():
	html_doc = get_3d_Html("http://zst.aicai.com/fc3d/openInfo/")
	soup = BeautifulSoup(html_doc, 'html.parser')
	tr = soup.find('tr',attrs={"onmouseout": "this.style.background=''"})
	tds = tr.find_all('td')
	aa = tds[1].get_text()
	opennum = tds[0].get_text()[13 : 20]
	fc3dnum = tds[1].get_text()[13 : 18]
	aa = [opennum +'期开奖号码：'+ fc3dnum]
	return aa, opennum, fc3dnum

if __name__ == "__main__":
	[aa, bb, cc] = get_3d_Number()
	print(aa)
	print("ok")

	
