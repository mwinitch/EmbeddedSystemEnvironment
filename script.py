import requests
import random
import board
import neopixel
import threading
import time

titles = ['Paris Agreement', 'Climate Change', 'Global Warming', 'Oil', 'Solar',
          'Hurricane', 'Sea Levels', 'Pollution', 'Ozone']

URL = 'https://chroniclingamerica.loc.gov/search/titles/results'
R = 0
G = 255
B = 0
pixels = neopixel.NeoPixel(board.D21, 8)
params = {'format':'json'}
#params['terms'] = 'Ozone'

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

