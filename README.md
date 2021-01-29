# Generative Art on the Environment
This is the first project for the Creative Embedded Systems course where we were tasked with creating some kind of generative art using a monitor and LED lights on a Raspberry Pi. I decided to create an art statement relating to the environment. [Click here to see a video of the work in action.](https://youtu.be/TZ8BeDq3w_I) This README will be concerned with the technical details of the setup. The first part of the setup would be to clone this repository. 

## The Monitor
An HDMI cord connects the monitor to the Raspberry Pi. The actual code that creates the visualization is the Processing script `collisions.pde`. To download Processing for a Raspberry Pi, [click here](https://pi.processing.org/download/) for various ways to install it on your Pi. The script relies on the `Ball` class to create each circle and update its position and color. The function `millis()` is used to keep track of time so that every 5 seconds a new ball can be added to the screen. The function `map()` is used to convert a range of one values into a range of another. This function is used for converting time changes to color changes (mapping time to valid RGB values). 

## THE LEDs
[Click here](https://learn.adafruit.com/neopixels-on-raspberry-pi/raspberry-pi-wiring) for a helpful article that goes into the detail into the setup for connecting LEDs to a Raspberry Pi. What we have to do is connect the following with a wire:
1. Connect Neopixels 5V (denoted V) to Pi 5V
2. Connect Neopixels Ground(denoted G) to Pi GND
3. Connect Neopixels input control (denoted S) to GPIO 21

[Click here](https://pinout.xyz/) for a nice webpage showing the various Pi pins and where the needed ones are. Once those are connected you should be all set. The following commands should be run in the terminal:
```
sudo pip3 install rpi_ws281x adafruit-circuitpython-neopixel
sudo python3 -m pip install --force-reinstall adafruit-blinka
```

`scripy.py` is responsible for controlling the LEDs. The script sets the LEDs to various shades of green. The shade is determined by a number coming from an API. The API provides historical information on US newspaper and it is used to pull the count of terms appearing in headlines. [Click here](https://chroniclingamerica.loc.gov/about/api/) to read more about the API. The function `change_colors()` is responsible for calling the API and updating the colors the LEDs will show, and this is done with the help of the threading module. The script otherwise is just a while loop that keeps setting the LEDs to the desired color. 

## Running the Processing and Python Script

With the hardware and code setup we just need to run the scripts. In order to run both scripts, the file `run.sh` is included which simply runs both of the other files. Make sure that since this is a Bash file, it is executable. This can be done using `sudo chmod +x run.sh`. In order to run both scripts when the Raspberry Pi starts up, we can edit the `~/.bashrc` file and add the following line to the bottom of it:
```
/home/pi/Desktop/project1/collisions/run.sh
```

**Important note: The paths in the `.bashrc` file and the paths in the `run.sh` file are ABSOLUTE paths. Therefore, when you clone this on your machine you will likely need to change the paths to fit where the project is on your Raspberry Pi.**
