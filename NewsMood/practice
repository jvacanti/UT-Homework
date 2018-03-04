# Dependencies
import tweepy
import numpy as np
import json
import pandas as pd

# Import and Initialize Sentiment Analyzer
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()

# Twitter API Keys
consumer_key = "0tIBNyPJJ2IxMNKMouQxJTAFy"
consumer_secret = "IOtTY5vnmTmBB688toZbE8FNx5Zt2vHYqDl5vvFpzBhPB5dXY0"
access_token = "109056014-JAdDs3jliSmaF7JgmBGtamTPnPBMtOVbMLsejyXb"
access_token_secret = "Em7DqDMsUbjs23sZKdepwBf66reriJGGPvcSttFNIj0IT"

# Setup Tweepy API Authentication
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())

target_terms = ("@BBCNews", "@CBS", "@CNN", "@FoxNews", "@nytimes")

# Counter
counter = 1

# Variables for holding sentiments
sentiments = []

for target in target_terms:

    # Variables for holding sentiments
    compound_list = []
    positive_list = []
    negative_list = []
    neutral_list = []


    # Loop through 5 pages of tweets (total 100 tweets)
    for x in range(5):

        # Get all tweets from home feed
        public_tweets = api.user_timeline(target)

        # Loop through all tweets 
        for tweet in public_tweets:


            # Run Vader Analysis on each tweet
            compound = analyzer.polarity_scores(tweet["text"])["compound"]
            pos = analyzer.polarity_scores(tweet["text"])["pos"]
            neu = analyzer.polarity_scores(tweet["text"])["neu"]
            neg = analyzer.polarity_scores(tweet["text"])["neg"]
            tweets_ago = counter
            
              # Add each value to the appropriate array
            compound_list.append(compound)
            positive_list.append(pos)
            negative_list.append(neg)
            neutral_list.append(neu)

            # Add sentiments for each tweet into an array
            sentiments = ({"Date": tweet["created_at"],
                               "User": target,
                               "Compound": compound_list,
                               "Positive": positive_list,
                               "Negative": neutral_list,
                               "Neutral": negative_list,
                               "Tweets Ago": counter})

            # Add to counter 
            counter = counter + 1