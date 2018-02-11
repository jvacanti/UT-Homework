

# Heroes Of Pymoli Data Analysis - J Vacanti

### Insights
#### 1. The vast majority of players are males (81%) and male playes also have the highest average purchase price.
#### 2. Players in the 20-24 age group have the highest number of players and highest total purchase value. 
#### 3. The Retribution Axe is one of the most popular and profitable items


```python
# Dependencies
import pandas as pd
import os
```


```python
file_one = os.path.join("Resources", "purchase_data.json")
#file_tow = os.path.join("Resources", "purchase_data2.json")
```


```python
file_one_df = pd.read_json(file_one, encoding = "ISO-8859-1")
#file_two_df = pd.read_json(file_tow, encoding = "ISO-8859-1")
```


```python
#file_one_df.head()
```


```python
#file_two_df.head()
```


```python
# Append the files
merged_df = file_one_df
#merged_df.head()
```


```python
# Total Unique Players
UniquePlayerCount = merged_df["SN"].value_counts()
```

## Player Count


```python
# Count of Unique Players
TotalPlayers = UniquePlayerCount.count()
TotalPlayers_df = pd.DataFrame({"Total Players":[TotalPlayers]})
TotalPlayers_df
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
      <th>Total Players</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>573</td>
    </tr>
  </tbody>
</table>
</div>



## Purchasing Analysis


```python
# Unique item count
UniqueItemCount = merged_df["Item ID"].value_counts()
```


```python
# Total unique items
TotalUnique = UniqueItemCount.count()

TotalUnique_df = pd.DataFrame({"Total Unique Items":[TotalUnique]})
```


```python
# Avg purchase price
avg_price = merged_df["Price"].mean()

```


```python
#No. of Purchases
NoOfPurchases = merged_df["Gender"].count()
```


```python
#Total Revenue
TotalRev = merged_df["Price"].sum()
```


```python
purchase_analysis_df = pd.DataFrame({"Number of Unique Items":[TotalUnique],
                                 "Avg Puchase Price":[avg_price],
                                    "Total Revenue":[TotalRev],
                                    "No. of Purchases":[NoOfPurchases]})
purchase_analysis_df.round(2)
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
      <th>Avg Puchase Price</th>
      <th>No. of Purchases</th>
      <th>Number of Unique Items</th>
      <th>Total Revenue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2.93</td>
      <td>780</td>
      <td>183</td>
      <td>2286.33</td>
    </tr>
  </tbody>
</table>
</div>



## Gender Demographics


```python
# Create DF removing duplicate screen names to accurate counts
deduped_df = merged_df.drop_duplicates("SN")
```


```python
#Total Count Male and Female
count = deduped_df["Gender"].value_counts()
```


```python
# Filter DF by Gender
male_df = deduped_df.loc[deduped_df["Gender"] == "Male",:]
female_df = deduped_df.loc[deduped_df["Gender"] == "Female",:]
NA_df = deduped_df.loc[deduped_df["Gender"] == "Other / Non-Disclosed",:]
```


```python
# Counts of each gender
count_male = male_df["Gender"].count()
count_female = female_df["Gender"].count()
count_NA = NA_df["Gender"].count()
```


```python
# Percentages of each gender
male_percent = count_male/TotalPlayers
female_percent = count_female/TotalPlayers
NA_percent = count_NA/TotalPlayers
```


```python
# Gender Demographics dataframe
gender_df = pd.DataFrame({
    "Gender":["Male", "Female", "Other/Non-Disclosed"],
    "Percentage of Players":[male_percent, female_percent, NA_percent],
    "Total Count":[count_male, count_female, count_NA]
})
#gender_df
```


```python
gender_final = gender_df
gender_final["Percentage of Players"] = pd.Series(["{0:.2f}%".format(val * 100) for val in gender_df["Percentage of Players"]], index = gender_df.index)
gender_final
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
      <th>Gender</th>
      <th>Percentage of Players</th>
      <th>Total Count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Male</td>
      <td>81.15%</td>
      <td>465</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Female</td>
      <td>17.45%</td>
      <td>100</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Other/Non-Disclosed</td>
      <td>1.40%</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>



## Purchasing Analysis (Gender)


```python
# This analysis uses the entire data set rather than the one deduped by SN used for Gender Demographics Analysis. 
male2_df = merged_df.loc[merged_df["Gender"] == "Male",:]
female2_df = merged_df.loc[merged_df["Gender"] == "Female",:]
NA2_df = merged_df.loc[merged_df["Gender"] == "Other / Non-Disclosed",:]
```


```python
# Purchase count by gender
F_PurchaseCount = female2_df["Gender"].count()
M_PurchaseCount = male2_df["Gender"].count()
NA_PurchaseCount = NA2_df["Gender"].count()
```


```python
# Avg purchase price
F_AvgPurchasePrice = female2_df["Price"].mean()
M_AvgPurchasePrice = male2_df["Price"].mean()
NA_AvgPurchasePrice = NA2_df["Price"].mean()
```


```python
#Total purchase value
F_PurchaseValue = female2_df["Price"].sum()
M_PurchaseValue = male2_df["Price"].sum()
NA_PurchaseValue = NA2_df["Price"].sum()
```


```python
# Normalized is purchase value divided by count of gender
F_normalized = F_PurchaseValue/count_female
M_normalized = M_PurchaseValue/count_male
NA_normalized = NA_PurchaseValue/count_NA
```


```python
PurchasingAnalysis_df = pd.DataFrame({
    "Gender":["Male", "Female", "Other/Non-Disclosed"],
    "Purchase Count":[M_PurchaseCount, F_PurchaseCount, NA_PurchaseCount],
    "Purchase Price (Avg)":[M_AvgPurchasePrice, F_AvgPurchasePrice, NA_AvgPurchasePrice],
    "Total Purchase Value":[M_PurchaseValue, F_PurchaseValue, NA_PurchaseValue],
    "Normalized Totals":[M_normalized, F_normalized, NA_normalized]
})
PurchasingAnalysis_df.round(2)
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
      <th>Gender</th>
      <th>Normalized Totals</th>
      <th>Purchase Count</th>
      <th>Purchase Price (Avg)</th>
      <th>Total Purchase Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Male</td>
      <td>4.02</td>
      <td>633</td>
      <td>2.95</td>
      <td>1867.68</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Female</td>
      <td>3.83</td>
      <td>136</td>
      <td>2.82</td>
      <td>382.91</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Other/Non-Disclosed</td>
      <td>4.47</td>
      <td>11</td>
      <td>3.25</td>
      <td>35.74</td>
    </tr>
  </tbody>
</table>
</div>



## Age Demographics


```python
# Break age into bins
# Find min and max for age range 7-45
# merged_df.max()
# merged_df.min()
bins = [0,10,15,20,25,30,35,40,45,50,100]
group_names = ["<10","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49",">50"]
pd.cut(merged_df["Age"],bins,labels=group_names).head()
```




    0    35-39
    1    20-24
    2    30-34
    3    20-24
    4    20-24
    Name: Age, dtype: category
    Categories (10, object): [<10 < 10-14 < 15-19 < 20-24 ... 35-39 < 40-44 < 45-49 < >50]




```python
merged_df["Age Groups"] = pd.cut(merged_df["Age"],bins,labels=group_names)
#merged_df.head()
```


```python
age_summary = merged_df.groupby(["Age Groups"])
#age_summary.count().head(10)
```


```python
# Purchase count
age_final = pd.DataFrame(merged_df["Age Groups"].value_counts())
#age_final
```


```python
# Ave purchase price
age_final["Avg Purchase Price"] = age_summary["Price"].mean()
#age_final
```


```python
# Total purchased value
age_final["Total Purchase Value"] = age_summary["Price"].sum()
#age_final
```


```python
bins = [0,10,15,20,25,30,35,40,45,50,100]
deduped_df = merged_df.drop_duplicates("SN")
group_names = ["<10","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49",">50"]
pd.cut(deduped_df["Age"],bins,labels=group_names).head()
age_count = deduped_df.groupby(["Age Groups"])
age_count = age_count.count()
age_count = age_count
```


```python
# Normalized totals
# count of users in each age group

age_final["Normalized Totals"] = age_final["Total Purchase Value"]/age_count["Age"]
age_final = age_final.round(2)
age_final = age_final.rename(columns={"Age Groups":"Purchase Count"})
age_final
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
      <th>Purchase Count</th>
      <th>Avg Purchase Price</th>
      <th>Total Purchase Value</th>
      <th>Normalized Totals</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>20-24</th>
      <td>305</td>
      <td>2.96</td>
      <td>902.61</td>
      <td>3.86</td>
    </tr>
    <tr>
      <th>15-19</th>
      <td>184</td>
      <td>2.87</td>
      <td>528.74</td>
      <td>3.80</td>
    </tr>
    <tr>
      <th>10-14</th>
      <td>78</td>
      <td>2.87</td>
      <td>224.15</td>
      <td>4.15</td>
    </tr>
    <tr>
      <th>25-29</th>
      <td>76</td>
      <td>2.89</td>
      <td>219.82</td>
      <td>4.23</td>
    </tr>
    <tr>
      <th>30-34</th>
      <td>58</td>
      <td>3.07</td>
      <td>178.26</td>
      <td>4.05</td>
    </tr>
    <tr>
      <th>35-39</th>
      <td>44</td>
      <td>2.90</td>
      <td>127.49</td>
      <td>5.10</td>
    </tr>
    <tr>
      <th>&lt;10</th>
      <td>32</td>
      <td>3.02</td>
      <td>96.62</td>
      <td>4.39</td>
    </tr>
    <tr>
      <th>40-44</th>
      <td>3</td>
      <td>2.88</td>
      <td>8.64</td>
      <td>2.88</td>
    </tr>
    <tr>
      <th>&gt;50</th>
      <td>0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>45-49</th>
      <td>0</td>
      <td>NaN</td>
      <td>0.00</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



## Top Spenders


```python
#Purchase Counter
merged_df["Purchase Counter"] = 1

#merged_df.head()
```


```python
# Top Spenders
SN_group = merged_df.groupby("SN")
top_spenders = pd.DataFrame(SN_group["Price","Purchase Counter"].sum())
top_spenders = top_spenders.sort_values("Price", ascending=False)
top_spenders = top_spenders.head(5)
top_spenders.head(10)

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
      <th>Price</th>
      <th>Purchase Counter</th>
    </tr>
    <tr>
      <th>SN</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Undirrala66</th>
      <td>17.06</td>
      <td>5</td>
    </tr>
    <tr>
      <th>Saedue76</th>
      <td>13.56</td>
      <td>4</td>
    </tr>
    <tr>
      <th>Mindimnya67</th>
      <td>12.74</td>
      <td>4</td>
    </tr>
    <tr>
      <th>Haellysu29</th>
      <td>12.73</td>
      <td>3</td>
    </tr>
    <tr>
      <th>Eoda93</th>
      <td>11.58</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Avg Purchase Price
top_spenders["Avg Purchase Price"] = (top_spenders["Price"]/top_spenders["Purchase Counter"])
top_spenders = top_spenders.round(2)
```


```python
top_spenders = top_spenders.rename(columns = {"Price":"Total Purchase Value", "Purchase Counter":"Puchase Count"})
top_spenders
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
      <th>Total Purchase Value</th>
      <th>Puchase Count</th>
      <th>Avg Purchase Price</th>
    </tr>
    <tr>
      <th>SN</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Undirrala66</th>
      <td>17.06</td>
      <td>5</td>
      <td>3.41</td>
    </tr>
    <tr>
      <th>Saedue76</th>
      <td>13.56</td>
      <td>4</td>
      <td>3.39</td>
    </tr>
    <tr>
      <th>Mindimnya67</th>
      <td>12.74</td>
      <td>4</td>
      <td>3.18</td>
    </tr>
    <tr>
      <th>Haellysu29</th>
      <td>12.73</td>
      <td>3</td>
      <td>4.24</td>
    </tr>
    <tr>
      <th>Eoda93</th>
      <td>11.58</td>
      <td>3</td>
      <td>3.86</td>
    </tr>
  </tbody>
</table>
</div>



## Most Popular Items


```python
# Top five items
item_group = merged_df.groupby("Item ID")
top_items = pd.DataFrame(item_group["Purchase Counter"].sum())
top_items = top_items.sort_values("Purchase Counter", ascending=False)
top_items = top_items.head(5)

#top_items.head(10)
```


```python
top_items["Item Price"] = merged_df["Price"]
top_items["Item Name"] = merged_df["Item Name"]
top_items["Total Purchase Value"] = top_items["Purchase Counter"] * top_items["Item Price"]
top_items = top_items.rename(columns={"Purchase Counter":"Purchase Count"})
top_items
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
      <th>Purchase Count</th>
      <th>Item Price</th>
      <th>Item Name</th>
      <th>Total Purchase Value</th>
    </tr>
    <tr>
      <th>Item ID</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>39</th>
      <td>11</td>
      <td>1.27</td>
      <td>Stormfury Mace</td>
      <td>13.97</td>
    </tr>
    <tr>
      <th>84</th>
      <td>11</td>
      <td>4.51</td>
      <td>Thorn, Satchel of Dark Souls</td>
      <td>49.61</td>
    </tr>
    <tr>
      <th>31</th>
      <td>9</td>
      <td>1.93</td>
      <td>Shadow Strike, Glory of Ending Hope</td>
      <td>17.37</td>
    </tr>
    <tr>
      <th>175</th>
      <td>9</td>
      <td>4.14</td>
      <td>Retribution Axe</td>
      <td>37.26</td>
    </tr>
    <tr>
      <th>13</th>
      <td>9</td>
      <td>3.68</td>
      <td>Piety, Guardian of Riddles</td>
      <td>33.12</td>
    </tr>
  </tbody>
</table>
</div>



## Most Profitable Items


```python
Price_group = merged_df.groupby(["Item ID", "Item Name"])
top_profit = pd.DataFrame(Price_group["Price"].sum())
top_profit["Item Price"] = Price_group["Price"].mean()
top_profit["Purchase Count"] = Price_group["Purchase Counter"].sum()
top_profit = top_profit.sort_values("Price", ascending=False)
top_profit = top_profit.rename(columns={"Price":"Total Purchase Value"})
top_profit = top_profit.head(5)

top_profit

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
      <th></th>
      <th>Total Purchase Value</th>
      <th>Item Price</th>
      <th>Purchase Count</th>
    </tr>
    <tr>
      <th>Item ID</th>
      <th>Item Name</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>34</th>
      <th>Retribution Axe</th>
      <td>37.26</td>
      <td>4.14</td>
      <td>9</td>
    </tr>
    <tr>
      <th>115</th>
      <th>Spectral Diamond Doomblade</th>
      <td>29.75</td>
      <td>4.25</td>
      <td>7</td>
    </tr>
    <tr>
      <th>32</th>
      <th>Orenmir</th>
      <td>29.70</td>
      <td>4.95</td>
      <td>6</td>
    </tr>
    <tr>
      <th>103</th>
      <th>Singed Scalpel</th>
      <td>29.22</td>
      <td>4.87</td>
      <td>6</td>
    </tr>
    <tr>
      <th>107</th>
      <th>Splitter, Foe Of Subtlety</th>
      <td>28.88</td>
      <td>3.61</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>


