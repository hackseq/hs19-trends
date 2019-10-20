#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Oct 18 14:51:31 2019

@author: Emma
"""
import googlemaps
import pandas as pd


aff_data=pd.read_csv("AllWebscrape.csv")
aff_list=aff_data['affiliation'].tolist()
#%%%%
gmaps=googlemaps.Client(key="AIzaSyC3jCkodWM4lwGaA1zOWFBGjUZRBgVppkc")

#test_list=["Simon Fraser University","University of British Columbia"]
latlong_list= []


for aff in aff_list:
    try:
        result=gmaps.geocode(aff)
        lat_long=result[0]['geometry']['location']
        latlong_list.append(lat_long)
    except: 
        latlong_list.append("NA")
        



        
aff_data['latlong']=latlong_list
aff_data.to_csv("affiliations_lat_long.csv")

#%%%%%%%
