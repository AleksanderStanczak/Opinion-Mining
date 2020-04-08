import nltk
import string
import re

from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
#from nltk.stem import LancasterStemmer

#nltk.download('stopwords')

stop_words = set(stopwords.words('english'))
print(stop_words)
file = open("C:/Users/aleks/OneDrive/Pulpit/OpinionMining/Comments/unlockboot.txt", encoding="utf8")


line = file.read()
line = line.lower()
line = line.translate(line.maketrans('','',string.digits))
line = line.translate(str.maketrans('', '', string.punctuation))
line = re.sub('[^.,a-zA-Z0-9 \n\.]', '', line)
line = ' '.join([w for w in line.split() if len(w) > 1])
porter = PorterStemmer()
#lancaster = LancasterStemmer()

words = line.split()
for r in words:
    if r not in stop_words:
        r=porter.stem(r)
        #r=lancaster.stem(r)
        appendFile = open("C:/Users/aleks/OneDrive/Pulpit/OpinionMining/Comments_formatted/unlockboot_formatted.txt", encoding="utf8", mode="a")
        appendFile.write(" " + r)
        appendFile.close()
        file.close()


