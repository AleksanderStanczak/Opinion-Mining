import requests, re
from bs4 import BeautifulSoup
from Links_Generator import generator

generator()

text = "downloaded"

# What to search
file = open("C://Users//aleks//OneDrive//Pulpit//OpinionMining//links_list.txt", "r")
urls = []
for line in file:
    urls.append(line)
file.close()

# Searching tags
list = ["review-content__text"]

with open(str(text) + '.txt', 'w', encoding='utf-8') as outfile:
    for url in urls:
        website = requests.get(url)
        soup = BeautifulSoup(website.content, "html5lib")
        tags = soup.find_all("p", class_=list)
        text = [' '.join(s.findAll(text=True)) for s in tags]
        text_len = len(text)

        for item in text:
            print(item, file=outfile)

        print("Done! File is saved where you have your scrape-website.py")
