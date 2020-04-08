from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
import nltk.data
import re
import glob
from os import walk

def sentiment_scores(text, name):

    sid_obj = SentimentIntensityAnalyzer()
    sentences = text.split("\n\n")
    comp = pos = neg = neu = it = 0
    length = len(sentences)

    for sen in sentences:
        sentiment_dict = sid_obj.polarity_scores(sen)
        # if it % 10 == 0:
        #     print(str(it) + "/" + str(length))
        # it += 1
        comp += sentiment_dict['compound']
        neg += sentiment_dict['neg']
        pos += sentiment_dict['pos']
        neu += sentiment_dict['neu']

    print(name, "sentiment analysis")
    print("Text was rated as %5.2f percent negative" % (neg*100/length))
    print("Text was rated as %5.2f percent neutral" % (neu*100/length))
    print("Text was rated as %5.2f percent positive" % (pos*100/length))

    score = comp/length

    print("Text Overall Rated As", end = " ")

    if  score >= 0.05 :
        print("Positive")

    elif score <= -0.05 :
        print("Negative")

    else :
        print("Neutral")

    print("Compound:", score, '\n')


if __name__ == "__main__" :

    _, _, filenames = next(walk("Comments"), (None, None, [])) # needs the path to the documents

    for name in filenames:
        dir = "Comments/" + name
        with open(dir , "r", encoding="utf-8") as file:

            data = file.read()
            sentiment_scores(data, name)
