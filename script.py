import requests
import random
import board
import neopixel
import threading
import time

# Possible titles to choose from
titles = ['Paris Agreement', 'Climate Change', 'Global Warming', 'Oil', 'Solar',
          'Hurricane', 'Sea Levels', 'Pollution', 'Ozone', 'Fracking', 'Energy',
          'Sea Level', 'Plastic', 'Landfill', 'Iceberg', 'Polar Bears', 'Wildfire']

# Base URL of the API
URL = 'https://chroniclingamerica.loc.gov/search/titles/results'
R = 0
G = 255
B = 0
pixels = neopixel.NeoPixel(board.D21, 8)
params = {'format':'json'}

# This function is continuously called in a thread every 5 seconds.
# It chooses a word from above and uses the API to get a value that
# will be used to update the colors in the LED. 
def change_colors():
    global R
    global B
    choice = random.choice(titles)
    params['terms'] = choice
    r = requests.get(URL, params=params)
    response = r.json()
    val = response['totalItems']
    R = (val % 255)
    B = (val % 255)
    threading.Timer(5.0, change_colors).start()
    
change_colors()
while True:
    pixels.fill((R,G,B))

