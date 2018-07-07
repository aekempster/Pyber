# Dependencies
import os
import tweepy
import time
import json
from datetime import datetime

# Twitter API Keys
try:
    from config import (consumer_key,
                        consumer_secret,
                        access_token,
                        access_token_secret)
except:
    consumer_key = os.environ['CONSUMER_KEY']
    consumer_secret = os.environ['CONSUMER_SECRET']
    access_token = os.environ['ACCESS_TOKEN']
    access_token_secret = os.environ['ACCESS_TOKEN_SECRET']

# Setup Tweepy API Authentication
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())

# Create a function that tweets
def TweetOut(minutes):
    api.update_status(
        f"Can't stop. Won't stop. I've been tweeting for {minutes} minutes!")

# Declare a 'beginning'
then = datetime(2018, 7, 5, 15, 17, 25)

# Infinitely loop
while(True):

    # Make something to tweet to avoid duplicates
    now  = datetime.now()
    duration = now - then
    seconds = duration.total_seconds()
    minutes = round(divmod(seconds, 60)[0])

    # Call the TweetQuotes function and specify the tweet number
    TweetOut(minutes)

    # Once tweeted, wait 60 seconds before doing anything else
    time.sleep(60)
