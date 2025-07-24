# my_city_functions.py

import pandas as pd
from datetime import datetime
import requests
from bs4 import BeautifulSoup
from lat_lon_parser import parse

def CityGeoInfo(citylist):

    # create list for all urls:
    city_url_list = []
    for city in citylist:
        url_wiki = "https://en.wikipedia.org/wiki/"
        city_wiki_url = url_wiki + city
        city_url_list.append(city_wiki_url)
    
    # initial df for storing the scraped information:
    Cities_Geo_data = {
        'City': [],
        'Country': [],
        'Latitude': [],
        'Longitude':[],
    }
    
    Cities_Geo_df = pd.DataFrame(Cities_Geo_data)
    
    # loop to webcrap the neede information:
    for url in city_url_list:
        # parse HTML with BeautifulSoup:
        response_loop = requests.get(url)
        soup_city = BeautifulSoup(response_loop.content, 'html.parser')
    
        # Webscrape needed information:
        city_name = soup_city.find_all('h1')[0].get_text()
        country_name = soup_city.find('a', href = '/wiki/Germany', title = 'Germany').get_text()
        latitude = parse(soup_city.find(class_ = 'latitude').get_text())
        longitude = parse(soup_city.find(class_ = 'longitude').get_text())
        
        #write city information into the Cities_df:
        Cities_Geo_df.loc[len(Cities_Geo_df)] = [city_name, country_name, latitude, longitude]
   
    return Cities_Geo_df


def CityPop(citylist):

    # create list for all urls:
    city_url_list = []
    for city in citylist:
        url_wiki = "https://en.wikipedia.org/wiki/"
        city_wiki_url = url_wiki + city
        city_url_list.append(city_wiki_url)
    
    # initial df for storing the scraped information:
    Cities_pop_data = {
        'City': [],
        'Population':[],
        'Date_Data_retrieved':[]
    }
    
    Cities_Pop_df = pd.DataFrame(Cities_pop_data)
    
    # loop to webcrap the neede information:
    for url in city_url_list:
        # parse HTML with BeautifulSoup:
        response_loop = requests.get(url)
        soup_city = BeautifulSoup(response_loop.content, 'html.parser')
    
        # Webscrape needed information:
        city_name = soup_city.find_all('h1')[0].get_text()
        population = soup_city.find(string = 'Population').find_next('td').get_text()
        population = int(population.replace(',',''))
        time = datetime.today()
        
        #write city information into the Cities_df:
        Cities_Pop_df.loc[len(Cities_Pop_df)] = [city_name, population, time]
   
    return Cities_Pop_df