
### Observations:

##### 1. The majority of tweets were in the neutral range from 0.5 to -0.5.
##### 2. CBS had the most positive compound score at 0.32 and Fox News the most negative score at -0.16
##### 3. All media sources had a wide range of tweet sentiments from highly positive to highly negative


```python
# Dependencies
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import json
import tweepy
import time
import seaborn as sns

# Import and Initialize Sentiment Analyzer
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()

# Twitter API Keys
consumer_key = ""
consumer_secret = ""
access_token = ""
access_token_secret = ""

# Setup Tweepy API Authentication
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())
```


```python
target_terms = ("@BBCNews", "@CBS", "@CNN", "@FoxNews", "@nytimes")
```


```python
# Counter
counter = 0

# Variables for holding sentiments
sentiments = []

for target in target_terms:

    # Variables for holding sentiments
    compound_list = []
    positive_list = []
    negative_list = []
    neutral_list = []

    counter = 0
    
    # Loop through 5 pages of tweets (total 100 tweets)
    for x in range(1):

        # Get all tweets from home feed
        public_tweets = api.user_timeline(target, count=100)
        
        

        # Loop through all tweets 
        for tweet in public_tweets:


            # Run Vader Analysis on each tweet
            compound = analyzer.polarity_scores(tweet["text"])["compound"]
            pos = analyzer.polarity_scores(tweet["text"])["pos"]
            neu = analyzer.polarity_scores(tweet["text"])["neu"]
            neg = analyzer.polarity_scores(tweet["text"])["neg"]
            
            
              # Add each value to the appropriate array
            compound_list.append(compound)
            positive_list.append(pos)
            negative_list.append(neg)
            neutral_list.append(neu)
            
            # Add to counter 
            counter = counter + 1

            # Add sentiments for each tweet into an array
            sentiments.append({"Date": tweet["created_at"],
                               "Media Source": target,
                               "Compound": compound,
                               "Positive": pos,
                               "Negative": neu,
                               "Neutral": neg,
                               "Tweets Ago": counter})
         
```


```python
sentiments_pd = pd.DataFrame.from_dict(sentiments)
sentiments_pd
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Compound</th>
      <th>Date</th>
      <th>Media Source</th>
      <th>Negative</th>
      <th>Neutral</th>
      <th>Positive</th>
      <th>Tweets Ago</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.0000</td>
      <td>Sun Mar 04 01:55:57 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.0000</td>
      <td>Sat Mar 03 22:49:57 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.0000</td>
      <td>Sat Mar 03 22:49:57 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-0.7717</td>
      <td>Sat Mar 03 22:49:57 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.394</td>
      <td>0.606</td>
      <td>0.000</td>
      <td>4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.7845</td>
      <td>Sat Mar 03 21:27:26 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.635</td>
      <td>0.000</td>
      <td>0.365</td>
      <td>5</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0.4019</td>
      <td>Sat Mar 03 18:36:14 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.748</td>
      <td>0.000</td>
      <td>0.252</td>
      <td>6</td>
    </tr>
    <tr>
      <th>6</th>
      <td>-0.6486</td>
      <td>Sat Mar 03 18:13:36 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.485</td>
      <td>0.515</td>
      <td>0.000</td>
      <td>7</td>
    </tr>
    <tr>
      <th>7</th>
      <td>-0.6808</td>
      <td>Sat Mar 03 17:56:55 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.703</td>
      <td>0.238</td>
      <td>0.059</td>
      <td>8</td>
    </tr>
    <tr>
      <th>8</th>
      <td>0.1280</td>
      <td>Sat Mar 03 17:52:18 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.824</td>
      <td>0.079</td>
      <td>0.097</td>
      <td>9</td>
    </tr>
    <tr>
      <th>9</th>
      <td>-0.0516</td>
      <td>Sat Mar 03 17:00:54 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.812</td>
      <td>0.098</td>
      <td>0.090</td>
      <td>10</td>
    </tr>
    <tr>
      <th>10</th>
      <td>0.0000</td>
      <td>Sat Mar 03 16:59:02 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>11</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.0000</td>
      <td>Sat Mar 03 16:57:36 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>12</td>
    </tr>
    <tr>
      <th>12</th>
      <td>-0.5719</td>
      <td>Sat Mar 03 16:57:32 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.821</td>
      <td>0.179</td>
      <td>0.000</td>
      <td>13</td>
    </tr>
    <tr>
      <th>13</th>
      <td>-0.9081</td>
      <td>Sat Mar 03 16:43:44 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.345</td>
      <td>0.655</td>
      <td>0.000</td>
      <td>14</td>
    </tr>
    <tr>
      <th>14</th>
      <td>0.0258</td>
      <td>Sat Mar 03 16:43:44 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.609</td>
      <td>0.191</td>
      <td>0.200</td>
      <td>15</td>
    </tr>
    <tr>
      <th>15</th>
      <td>0.0516</td>
      <td>Sat Mar 03 16:16:41 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.952</td>
      <td>0.000</td>
      <td>0.048</td>
      <td>16</td>
    </tr>
    <tr>
      <th>16</th>
      <td>0.0000</td>
      <td>Sat Mar 03 15:38:43 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>17</td>
    </tr>
    <tr>
      <th>17</th>
      <td>0.7430</td>
      <td>Sat Mar 03 15:05:29 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.657</td>
      <td>0.000</td>
      <td>0.343</td>
      <td>18</td>
    </tr>
    <tr>
      <th>18</th>
      <td>0.5859</td>
      <td>Sat Mar 03 14:22:50 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.863</td>
      <td>0.000</td>
      <td>0.137</td>
      <td>19</td>
    </tr>
    <tr>
      <th>19</th>
      <td>-0.7506</td>
      <td>Sat Mar 03 14:21:27 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.726</td>
      <td>0.274</td>
      <td>0.000</td>
      <td>20</td>
    </tr>
    <tr>
      <th>20</th>
      <td>-0.2263</td>
      <td>Sat Mar 03 14:04:54 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.836</td>
      <td>0.098</td>
      <td>0.066</td>
      <td>21</td>
    </tr>
    <tr>
      <th>21</th>
      <td>0.2023</td>
      <td>Sat Mar 03 12:58:10 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.816</td>
      <td>0.071</td>
      <td>0.112</td>
      <td>22</td>
    </tr>
    <tr>
      <th>22</th>
      <td>0.0000</td>
      <td>Sat Mar 03 12:46:36 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>23</td>
    </tr>
    <tr>
      <th>23</th>
      <td>0.0000</td>
      <td>Sat Mar 03 12:41:31 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>24</td>
    </tr>
    <tr>
      <th>24</th>
      <td>0.4215</td>
      <td>Sat Mar 03 12:40:04 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.877</td>
      <td>0.000</td>
      <td>0.123</td>
      <td>25</td>
    </tr>
    <tr>
      <th>25</th>
      <td>0.0000</td>
      <td>Sat Mar 03 12:26:53 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>26</td>
    </tr>
    <tr>
      <th>26</th>
      <td>-0.2960</td>
      <td>Sat Mar 03 11:54:33 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.905</td>
      <td>0.095</td>
      <td>0.000</td>
      <td>27</td>
    </tr>
    <tr>
      <th>27</th>
      <td>0.0000</td>
      <td>Sat Mar 03 11:53:35 +0000 2018</td>
      <td>@BBCNews</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>28</td>
    </tr>
    <tr>
      <th>28</th>
      <td>-0.2960</td>
      <td>Sat Mar 03 11:13:12 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.784</td>
      <td>0.216</td>
      <td>0.000</td>
      <td>29</td>
    </tr>
    <tr>
      <th>29</th>
      <td>-0.6705</td>
      <td>Sat Mar 03 10:52:33 +0000 2018</td>
      <td>@BBCNews</td>
      <td>0.303</td>
      <td>0.515</td>
      <td>0.182</td>
      <td>30</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>470</th>
      <td>0.5994</td>
      <td>Sat Mar 03 11:19:39 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.719</td>
      <td>0.000</td>
      <td>0.281</td>
      <td>71</td>
    </tr>
    <tr>
      <th>471</th>
      <td>-0.8225</td>
      <td>Sat Mar 03 11:03:06 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.664</td>
      <td>0.336</td>
      <td>0.000</td>
      <td>72</td>
    </tr>
    <tr>
      <th>472</th>
      <td>0.9183</td>
      <td>Sat Mar 03 10:36:20 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.581</td>
      <td>0.000</td>
      <td>0.419</td>
      <td>73</td>
    </tr>
    <tr>
      <th>473</th>
      <td>0.5106</td>
      <td>Sat Mar 03 10:19:53 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.845</td>
      <td>0.000</td>
      <td>0.155</td>
      <td>74</td>
    </tr>
    <tr>
      <th>474</th>
      <td>0.0000</td>
      <td>Sat Mar 03 10:03:05 +0000 2018</td>
      <td>@nytimes</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>75</td>
    </tr>
    <tr>
      <th>475</th>
      <td>0.0772</td>
      <td>Sat Mar 03 09:46:29 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.885</td>
      <td>0.000</td>
      <td>0.115</td>
      <td>76</td>
    </tr>
    <tr>
      <th>476</th>
      <td>0.0000</td>
      <td>Sat Mar 03 09:46:05 +0000 2018</td>
      <td>@nytimes</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>77</td>
    </tr>
    <tr>
      <th>477</th>
      <td>0.0000</td>
      <td>Sat Mar 03 09:25:00 +0000 2018</td>
      <td>@nytimes</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>78</td>
    </tr>
    <tr>
      <th>478</th>
      <td>0.6486</td>
      <td>Sat Mar 03 09:08:42 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.773</td>
      <td>0.000</td>
      <td>0.227</td>
      <td>79</td>
    </tr>
    <tr>
      <th>479</th>
      <td>0.0000</td>
      <td>Sat Mar 03 08:52:19 +0000 2018</td>
      <td>@nytimes</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>80</td>
    </tr>
    <tr>
      <th>480</th>
      <td>-0.3182</td>
      <td>Sat Mar 03 08:36:01 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.887</td>
      <td>0.113</td>
      <td>0.000</td>
      <td>81</td>
    </tr>
    <tr>
      <th>481</th>
      <td>0.0258</td>
      <td>Sat Mar 03 08:07:00 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.909</td>
      <td>0.000</td>
      <td>0.091</td>
      <td>82</td>
    </tr>
    <tr>
      <th>482</th>
      <td>0.0000</td>
      <td>Sat Mar 03 07:49:12 +0000 2018</td>
      <td>@nytimes</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>83</td>
    </tr>
    <tr>
      <th>483</th>
      <td>-0.3818</td>
      <td>Sat Mar 03 07:47:02 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.874</td>
      <td>0.126</td>
      <td>0.000</td>
      <td>84</td>
    </tr>
    <tr>
      <th>484</th>
      <td>-0.2960</td>
      <td>Sat Mar 03 07:15:29 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.879</td>
      <td>0.121</td>
      <td>0.000</td>
      <td>85</td>
    </tr>
    <tr>
      <th>485</th>
      <td>0.5106</td>
      <td>Sat Mar 03 06:59:02 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.845</td>
      <td>0.000</td>
      <td>0.155</td>
      <td>86</td>
    </tr>
    <tr>
      <th>486</th>
      <td>0.0000</td>
      <td>Sat Mar 03 06:42:03 +0000 2018</td>
      <td>@nytimes</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>87</td>
    </tr>
    <tr>
      <th>487</th>
      <td>0.2500</td>
      <td>Sat Mar 03 06:23:39 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.895</td>
      <td>0.000</td>
      <td>0.105</td>
      <td>88</td>
    </tr>
    <tr>
      <th>488</th>
      <td>0.7096</td>
      <td>Sat Mar 03 06:07:01 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.688</td>
      <td>0.000</td>
      <td>0.312</td>
      <td>89</td>
    </tr>
    <tr>
      <th>489</th>
      <td>0.5994</td>
      <td>Sat Mar 03 05:50:16 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.719</td>
      <td>0.000</td>
      <td>0.281</td>
      <td>90</td>
    </tr>
    <tr>
      <th>490</th>
      <td>-0.2960</td>
      <td>Sat Mar 03 05:32:02 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.905</td>
      <td>0.095</td>
      <td>0.000</td>
      <td>91</td>
    </tr>
    <tr>
      <th>491</th>
      <td>-0.4215</td>
      <td>Sat Mar 03 05:17:03 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.707</td>
      <td>0.223</td>
      <td>0.071</td>
      <td>92</td>
    </tr>
    <tr>
      <th>492</th>
      <td>-0.5106</td>
      <td>Sat Mar 03 05:02:02 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.858</td>
      <td>0.142</td>
      <td>0.000</td>
      <td>93</td>
    </tr>
    <tr>
      <th>493</th>
      <td>-0.4215</td>
      <td>Sat Mar 03 04:47:03 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.865</td>
      <td>0.135</td>
      <td>0.000</td>
      <td>94</td>
    </tr>
    <tr>
      <th>494</th>
      <td>0.2732</td>
      <td>Sat Mar 03 04:37:01 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.884</td>
      <td>0.000</td>
      <td>0.116</td>
      <td>95</td>
    </tr>
    <tr>
      <th>495</th>
      <td>0.4215</td>
      <td>Sat Mar 03 04:26:03 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.851</td>
      <td>0.000</td>
      <td>0.149</td>
      <td>96</td>
    </tr>
    <tr>
      <th>496</th>
      <td>0.0000</td>
      <td>Sat Mar 03 04:17:03 +0000 2018</td>
      <td>@nytimes</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>97</td>
    </tr>
    <tr>
      <th>497</th>
      <td>0.2960</td>
      <td>Sat Mar 03 04:02:04 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.556</td>
      <td>0.167</td>
      <td>0.278</td>
      <td>98</td>
    </tr>
    <tr>
      <th>498</th>
      <td>0.0000</td>
      <td>Sat Mar 03 03:47:02 +0000 2018</td>
      <td>@nytimes</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>99</td>
    </tr>
    <tr>
      <th>499</th>
      <td>-0.3612</td>
      <td>Sat Mar 03 03:32:03 +0000 2018</td>
      <td>@nytimes</td>
      <td>0.848</td>
      <td>0.152</td>
      <td>0.000</td>
      <td>100</td>
    </tr>
  </tbody>
</table>
<p>500 rows × 7 columns</p>
</div>




```python
import seaborn as sns
sns.set_style("darkgrid")
sns.lmplot(x="Tweets Ago", y="Compound", data=sentiments_pd, fit_reg=False, hue='Media Source', palette="Set1")
plt.title("Sentiment Analysis of last 100 Tweets " + (time.strftime("%x")))
plt.ylabel("Tweet Polarity")
plt.xlabel("Tweets Ago")

plt.show()
```


![png](output_5_0.png)



```python
# Group by Media Source
media_group = pd.DataFrame(sentiments_pd.groupby('Media Source').mean())

#avg_sentiment = pd.DataFrame(media_group["Compound"].mean())

#avg_sentiment
media_group = media_group.reset_index()
media_group
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Media Source</th>
      <th>Compound</th>
      <th>Negative</th>
      <th>Neutral</th>
      <th>Positive</th>
      <th>Tweets Ago</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>@BBCNews</td>
      <td>-0.024599</td>
      <td>0.80426</td>
      <td>0.10936</td>
      <td>0.08633</td>
      <td>50.5</td>
    </tr>
    <tr>
      <th>1</th>
      <td>@CBS</td>
      <td>0.327892</td>
      <td>0.81746</td>
      <td>0.02827</td>
      <td>0.15426</td>
      <td>50.5</td>
    </tr>
    <tr>
      <th>2</th>
      <td>@CNN</td>
      <td>-0.031819</td>
      <td>0.84224</td>
      <td>0.08406</td>
      <td>0.07376</td>
      <td>50.5</td>
    </tr>
    <tr>
      <th>3</th>
      <td>@FoxNews</td>
      <td>-0.158389</td>
      <td>0.82378</td>
      <td>0.12116</td>
      <td>0.05508</td>
      <td>50.5</td>
    </tr>
    <tr>
      <th>4</th>
      <td>@nytimes</td>
      <td>0.056433</td>
      <td>0.84028</td>
      <td>0.06611</td>
      <td>0.09361</td>
      <td>50.5</td>
    </tr>
  </tbody>
</table>
</div>




```python
sns.set_style("darkgrid")
plt.bar(media_group["Media Source"], media_group["Compound"], color=['red', 'blue', 'green', 'purple', 'orange'])
plt.title("Overall Media Sentiment of last 100 Tweets " + (time.strftime("%x")))
plt.ylabel("Tweet Polarity")
plt.show()
```


![png](output_7_0.png)



```python
sentiments_pd.to_csv("NewsMood.csv")
```
