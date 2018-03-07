
## WeatherPy

#### Analysis
##### * Max tempurature peaked at 0 degrees latitude (equator)
##### * Wind speed , humidity and cloudiness had even distribution across latitudes
##### * Currently the northern hemisphere (0-100 lat) is in winter resulting in lower max temperatures than those in the sourthern hemisphere.


```python
# Import dependencies
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import requests as req
import json
import random
import seaborn as sns
import os
from citipy import citipy
import time as time
```


```python
lat_array = []
lon_array = []

for x in range(0,1500):
    lat_array.append(random.uniform(-90,91))
    lon_array.append(random.uniform(-180,181))
```


```python
latlon_df = pd.DataFrame(columns=["lat","long","city"])
latlon_df["lat"] = lat_array
latlon_df["long"] = lon_array
latlon_df.head()
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
      <th>lat</th>
      <th>long</th>
      <th>city</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10.766887</td>
      <td>101.121913</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>30.921339</td>
      <td>177.704861</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>-25.235329</td>
      <td>117.937642</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>17.086292</td>
      <td>-2.787988</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>-55.894156</td>
      <td>-166.561953</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
cities = []
for index,row in latlon_df.iterrows():
    city = citipy.nearest_city(row["lat"],row["long"])
    cities.append(city.city_name)

latlon_df["city"] = cities
latlon_df
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
      <th>lat</th>
      <th>long</th>
      <th>city</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10.766887</td>
      <td>101.121913</td>
      <td>bang saphan</td>
    </tr>
    <tr>
      <th>1</th>
      <td>30.921339</td>
      <td>177.704861</td>
      <td>nikolskoye</td>
    </tr>
    <tr>
      <th>2</th>
      <td>-25.235329</td>
      <td>117.937642</td>
      <td>carnarvon</td>
    </tr>
    <tr>
      <th>3</th>
      <td>17.086292</td>
      <td>-2.787988</td>
      <td>tombouctou</td>
    </tr>
    <tr>
      <th>4</th>
      <td>-55.894156</td>
      <td>-166.561953</td>
      <td>avarua</td>
    </tr>
    <tr>
      <th>5</th>
      <td>55.505680</td>
      <td>167.563128</td>
      <td>nikolskoye</td>
    </tr>
    <tr>
      <th>6</th>
      <td>8.633359</td>
      <td>-50.999653</td>
      <td>sinnamary</td>
    </tr>
    <tr>
      <th>7</th>
      <td>-82.661097</td>
      <td>67.553374</td>
      <td>taolanaro</td>
    </tr>
    <tr>
      <th>8</th>
      <td>-56.891847</td>
      <td>37.957650</td>
      <td>port alfred</td>
    </tr>
    <tr>
      <th>9</th>
      <td>-50.468950</td>
      <td>67.303764</td>
      <td>saint-philippe</td>
    </tr>
    <tr>
      <th>10</th>
      <td>82.282065</td>
      <td>79.409682</td>
      <td>dikson</td>
    </tr>
    <tr>
      <th>11</th>
      <td>73.829081</td>
      <td>-4.205085</td>
      <td>klaksvik</td>
    </tr>
    <tr>
      <th>12</th>
      <td>-22.611036</td>
      <td>-10.751557</td>
      <td>jamestown</td>
    </tr>
    <tr>
      <th>13</th>
      <td>-69.565635</td>
      <td>21.410509</td>
      <td>bredasdorp</td>
    </tr>
    <tr>
      <th>14</th>
      <td>-40.871216</td>
      <td>98.934020</td>
      <td>busselton</td>
    </tr>
    <tr>
      <th>15</th>
      <td>84.014955</td>
      <td>3.765357</td>
      <td>barentsburg</td>
    </tr>
    <tr>
      <th>16</th>
      <td>-3.226527</td>
      <td>-178.579071</td>
      <td>vaitupu</td>
    </tr>
    <tr>
      <th>17</th>
      <td>-21.905083</td>
      <td>4.925047</td>
      <td>henties bay</td>
    </tr>
    <tr>
      <th>18</th>
      <td>5.764131</td>
      <td>100.956981</td>
      <td>betong</td>
    </tr>
    <tr>
      <th>19</th>
      <td>-45.047525</td>
      <td>6.214287</td>
      <td>cape town</td>
    </tr>
    <tr>
      <th>20</th>
      <td>-23.442118</td>
      <td>-86.063657</td>
      <td>marcona</td>
    </tr>
    <tr>
      <th>21</th>
      <td>-50.492440</td>
      <td>-112.667893</td>
      <td>rikitea</td>
    </tr>
    <tr>
      <th>22</th>
      <td>22.839007</td>
      <td>90.854841</td>
      <td>lakshmipur</td>
    </tr>
    <tr>
      <th>23</th>
      <td>-21.356882</td>
      <td>80.442371</td>
      <td>hithadhoo</td>
    </tr>
    <tr>
      <th>24</th>
      <td>-56.944895</td>
      <td>-65.803244</td>
      <td>ushuaia</td>
    </tr>
    <tr>
      <th>25</th>
      <td>-7.233609</td>
      <td>-78.341370</td>
      <td>cajamarca</td>
    </tr>
    <tr>
      <th>26</th>
      <td>75.638994</td>
      <td>32.467393</td>
      <td>vardo</td>
    </tr>
    <tr>
      <th>27</th>
      <td>48.291490</td>
      <td>165.225224</td>
      <td>nikolskoye</td>
    </tr>
    <tr>
      <th>28</th>
      <td>15.244743</td>
      <td>-14.075522</td>
      <td>ourossogui</td>
    </tr>
    <tr>
      <th>29</th>
      <td>-87.627406</td>
      <td>-23.701314</td>
      <td>ushuaia</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1470</th>
      <td>-64.653802</td>
      <td>-41.857818</td>
      <td>ushuaia</td>
    </tr>
    <tr>
      <th>1471</th>
      <td>18.261891</td>
      <td>-155.856932</td>
      <td>hilo</td>
    </tr>
    <tr>
      <th>1472</th>
      <td>27.798939</td>
      <td>-132.745085</td>
      <td>pacific grove</td>
    </tr>
    <tr>
      <th>1473</th>
      <td>-54.537716</td>
      <td>-60.092226</td>
      <td>ushuaia</td>
    </tr>
    <tr>
      <th>1474</th>
      <td>-69.388305</td>
      <td>99.913792</td>
      <td>albany</td>
    </tr>
    <tr>
      <th>1475</th>
      <td>61.071827</td>
      <td>-116.964672</td>
      <td>hay river</td>
    </tr>
    <tr>
      <th>1476</th>
      <td>66.121524</td>
      <td>-31.132967</td>
      <td>tasiilaq</td>
    </tr>
    <tr>
      <th>1477</th>
      <td>-81.752739</td>
      <td>84.129519</td>
      <td>busselton</td>
    </tr>
    <tr>
      <th>1478</th>
      <td>-21.599267</td>
      <td>58.476008</td>
      <td>mahebourg</td>
    </tr>
    <tr>
      <th>1479</th>
      <td>43.168260</td>
      <td>-107.391178</td>
      <td>riverton</td>
    </tr>
    <tr>
      <th>1480</th>
      <td>-64.852793</td>
      <td>-111.699877</td>
      <td>punta arenas</td>
    </tr>
    <tr>
      <th>1481</th>
      <td>-44.534372</td>
      <td>-91.385303</td>
      <td>castro</td>
    </tr>
    <tr>
      <th>1482</th>
      <td>-59.727453</td>
      <td>176.908179</td>
      <td>kaitangata</td>
    </tr>
    <tr>
      <th>1483</th>
      <td>-26.689857</td>
      <td>-48.463940</td>
      <td>penha</td>
    </tr>
    <tr>
      <th>1484</th>
      <td>61.138682</td>
      <td>135.009239</td>
      <td>eldikan</td>
    </tr>
    <tr>
      <th>1485</th>
      <td>23.347991</td>
      <td>113.051410</td>
      <td>guangzhou</td>
    </tr>
    <tr>
      <th>1486</th>
      <td>33.930481</td>
      <td>108.353063</td>
      <td>yuxia</td>
    </tr>
    <tr>
      <th>1487</th>
      <td>6.227625</td>
      <td>-55.667220</td>
      <td>groningen</td>
    </tr>
    <tr>
      <th>1488</th>
      <td>60.928324</td>
      <td>179.677605</td>
      <td>beringovskiy</td>
    </tr>
    <tr>
      <th>1489</th>
      <td>-18.876750</td>
      <td>-167.678872</td>
      <td>alofi</td>
    </tr>
    <tr>
      <th>1490</th>
      <td>-26.998926</td>
      <td>170.099509</td>
      <td>vao</td>
    </tr>
    <tr>
      <th>1491</th>
      <td>-18.046483</td>
      <td>-153.022923</td>
      <td>tevaitoa</td>
    </tr>
    <tr>
      <th>1492</th>
      <td>-84.603367</td>
      <td>-133.332007</td>
      <td>rikitea</td>
    </tr>
    <tr>
      <th>1493</th>
      <td>-88.428696</td>
      <td>130.005606</td>
      <td>new norfolk</td>
    </tr>
    <tr>
      <th>1494</th>
      <td>21.358583</td>
      <td>131.959383</td>
      <td>nishihara</td>
    </tr>
    <tr>
      <th>1495</th>
      <td>-63.555752</td>
      <td>-51.214503</td>
      <td>ushuaia</td>
    </tr>
    <tr>
      <th>1496</th>
      <td>-3.827463</td>
      <td>101.434611</td>
      <td>bengkulu</td>
    </tr>
    <tr>
      <th>1497</th>
      <td>44.150919</td>
      <td>179.079319</td>
      <td>nikolskoye</td>
    </tr>
    <tr>
      <th>1498</th>
      <td>-1.151313</td>
      <td>-90.143973</td>
      <td>puerto ayora</td>
    </tr>
    <tr>
      <th>1499</th>
      <td>-28.415683</td>
      <td>-54.722699</td>
      <td>sao luiz gonzaga</td>
    </tr>
  </tbody>
</table>
<p>1500 rows × 3 columns</p>
</div>




```python
api_key = ""
url = "http://api.openweathermap.org/data/2.5/weather?q="
units = "metric"

temp = []
humidity = []
clouds = []
wind = []

counter = 0
try:
    for index,row in latlon_df.iterrows():
        counter += 1
        print(counter)
        query_url = url + row["city"] + "&appid=" + api_key + "&units=" + units
        info = req.get(query_url).json()
        temp.append(info["main"]["temp"])
        humidity.append(info["main"]["humidity"])
        clouds.append(info["clouds"]["all"])
        wind.append(info["wind"]["speed"])
        time.sleep(1)
except:
    pass
        
latlon_df["temp"] = temp
latlon_df["humidity"] = humidity
latlon_df["cloudiness"] = clouds
latlon_df["wind speed"] = wind
```

    1
    2
    3
    4
    5
    6
    7
    8



    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    <ipython-input-28-f1cb399b4f6d> in <module>()
         23     pass
         24 
    ---> 25 latlon_df["temp"] = temp
         26 latlon_df["humidity"] = humidity
         27 latlon_df["cloudiness"] = clouds


    ~/anaconda3/envs/PythonData/lib/python3.6/site-packages/pandas/core/frame.py in __setitem__(self, key, value)
       2517         else:
       2518             # set column
    -> 2519             self._set_item(key, value)
       2520 
       2521     def _setitem_slice(self, key, value):


    ~/anaconda3/envs/PythonData/lib/python3.6/site-packages/pandas/core/frame.py in _set_item(self, key, value)
       2583 
       2584         self._ensure_valid_index(value)
    -> 2585         value = self._sanitize_column(key, value)
       2586         NDFrame._set_item(self, key, value)
       2587 


    ~/anaconda3/envs/PythonData/lib/python3.6/site-packages/pandas/core/frame.py in _sanitize_column(self, key, value, broadcast)
       2758 
       2759             # turn me into an ndarray
    -> 2760             value = _sanitize_index(value, self.index, copy=False)
       2761             if not isinstance(value, (np.ndarray, Index)):
       2762                 if isinstance(value, list) and len(value) > 0:


    ~/anaconda3/envs/PythonData/lib/python3.6/site-packages/pandas/core/series.py in _sanitize_index(data, index, copy)
       3119 
       3120     if len(data) != len(index):
    -> 3121         raise ValueError('Length of values does not match length of ' 'index')
       3122 
       3123     if isinstance(data, PeriodIndex):


    ValueError: Length of values does not match length of index



```python
#Kept running into a city not found error. Even with tutor we couldn't get through it.
```


```python
# get random sample from openweathermap city list
sample_size = 500
city_list = os.path.join("city.list.json")
sample_list = pd.read_json(city_list)
sample_list = pd.DataFrame(sample_list)

sample_cities = sample_list.sample(sample_size)

sample_cities.head()
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
      <th>coord</th>
      <th>country</th>
      <th>id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>109248</th>
      <td>{'lon': -82.565376, 'lat': 27.40143}</td>
      <td>US</td>
      <td>4146587</td>
      <td>Ballentine Manor</td>
    </tr>
    <tr>
      <th>168751</th>
      <td>{'lon': 107.962196, 'lat': -7.1499}</td>
      <td>ID</td>
      <td>7920665</td>
      <td>Balakasap</td>
    </tr>
    <tr>
      <th>103132</th>
      <td>{'lon': 69.055, 'lat': 41.113331}</td>
      <td>UZ</td>
      <td>1538262</td>
      <td>Yangiyŭl Shahri</td>
    </tr>
    <tr>
      <th>151713</th>
      <td>{'lon': 4.5467, 'lat': 44.716499}</td>
      <td>FR</td>
      <td>6615784</td>
      <td>Saint-Priest</td>
    </tr>
    <tr>
      <th>165188</th>
      <td>{'lon': 107.898598, 'lat': -7.1099}</td>
      <td>ID</td>
      <td>1638107</td>
      <td>Leles</td>
    </tr>
  </tbody>
</table>
</div>




```python
api_key = "09b5e513d610e151dcad61efd3016f9f"
url = "http://api.openweathermap.org/data/2.5/weather?q="
units = "metric"


weather_data = []
cityIDs = sample_cities["id"].tolist()
query_url = url + "appid=" + api_key + "&units=" + units + "&id="


for ID in cityIDs:
    weather_data.append(req.get(query_url + str(ID)).json())

weather_data[0]

# http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
```




    {'base': 'stations',
     'clouds': {'all': 1},
     'cod': 200,
     'coord': {'lat': 27.4, 'lon': -82.57},
     'dt': 1519695300,
     'id': 4146587,
     'main': {'humidity': 94,
      'pressure': 1022,
      'temp': 23,
      'temp_max': 23,
      'temp_min': 23},
     'name': 'Ballentine Manor',
     'sys': {'country': 'US',
      'id': 731,
      'message': 0.0045,
      'sunrise': 1519732581,
      'sunset': 1519774193,
      'type': 1},
     'visibility': 16093,
     'weather': [{'description': 'clear sky',
       'icon': '01n',
       'id': 800,
       'main': 'Clear'}],
     'wind': {'deg': 310, 'speed': 2.1}}




```python
#Get temperature and latitude date
temp_data = [data.get("main").get("temp_max") for data in weather_data]
lat_data = [data.get("coord").get("lat") for data in weather_data]
humid_data = [data.get("main").get("humidity") for data in weather_data]
cloudy_data = [data.get("clouds").get("all") for data in weather_data]
wind_data = [data.get("wind").get("speed") for data in weather_data]

plot_data = {"Temperature": temp_data, "Latitude": lat_data, "Humidity": humid_data, "Cloudiness": cloudy_data, "Wind Speed": wind_data}
plot_data_df = pd.DataFrame(plot_data)
plot_data_df.head()
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
      <th>Cloudiness</th>
      <th>Humidity</th>
      <th>Latitude</th>
      <th>Temperature</th>
      <th>Wind Speed</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>94</td>
      <td>27.40</td>
      <td>23.00</td>
      <td>2.10</td>
    </tr>
    <tr>
      <th>1</th>
      <td>36</td>
      <td>83</td>
      <td>-7.15</td>
      <td>24.28</td>
      <td>1.41</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0</td>
      <td>87</td>
      <td>41.11</td>
      <td>9.00</td>
      <td>3.10</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0</td>
      <td>52</td>
      <td>44.72</td>
      <td>-10.70</td>
      <td>4.56</td>
    </tr>
    <tr>
      <th>4</th>
      <td>36</td>
      <td>83</td>
      <td>-7.11</td>
      <td>24.28</td>
      <td>1.41</td>
    </tr>
  </tbody>
</table>
</div>



### Tempurature (C) vs. Latitude


```python
# Build scatter plot
sns.regplot(x=plot_data_df["Latitude"], y=plot_data_df["Temperature"], fit_reg=False, marker="o")

# Incorporate the other graph properties
sns.set_style("dark")
plt.title("City Latitude vs. Max Temperature (2/26/18)")
plt.ylabel("Tempurature (Celsius)")
plt.xlabel("Latitude")
plt.grid(True)
plt.axvline(0, color='r')


# Save the figure
plt.savefig("Lat_v_Temp.png")

# Show plot
plt.show()
```


![png](output_12_0.png)


### Humidity (%) vs. Latitude


```python
sns.regplot(x=plot_data_df["Latitude"], y=plot_data_df["Humidity"], fit_reg=False, marker="o")

# Incorporate the other graph properties
sns.set_style("dark")
plt.title("City Latitude vs. Humidity(%) (2/26/18)")
plt.ylabel("Humidity (%)")
plt.xlabel("Latitude")
plt.grid(True)
plt.axvline(0, color='r')

# Save the figure
plt.savefig("Lat_v_Humidity.png")

# Show plot
plt.show()
```


![png](output_14_0.png)


### Latitude vs. Cloudiness Plot


```python
sns.regplot(x=plot_data_df["Latitude"], y=plot_data_df["Cloudiness"], fit_reg=False, marker="o")

# Incorporate the other graph properties
sns.set_style("dark")
plt.title("City Latitude vs. Cloudiness (%) (2/26/18)")
plt.ylabel("Cloudiness (%)")
plt.xlabel("Latitude")
plt.grid(True)
plt.axvline(0, color='r')

# Save the figure
plt.savefig("Lat_v_Cloud.png")

# Show plot
plt.show()
```


![png](output_16_0.png)


### Latitude vs. Wind Speed


```python
sns.regplot(x=plot_data_df["Latitude"], y=plot_data_df["Wind Speed"], fit_reg=False, marker="o")

# Incorporate the other graph properties
sns.set_style("dark")
plt.title("City Latitude vs. Wind Speed (2/26/18)")
plt.ylabel("Wind Speed")
plt.xlabel("Latitude")
plt.grid(True)
plt.axvline(0, color='r')

# Save the figure
plt.savefig("Lat_v_Temp.png")

# Show plot
plt.show()
```


![png](output_18_0.png)

