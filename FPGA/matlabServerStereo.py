# Dr. Kaputa
# Matlab Server
from numpysocket import NumpySocket
import cv2
import numpy as np
import time
import mmap
import struct
import sys, random
import ctypes
import copy
from frameGrabber import ImageProcessing
from frameGrabber import ImageFeedthrough
from frameGrabber import ImageWriter

camProcessed = ImageProcessing()
camFeedthrough = ImageFeedthrough()
camWriter = ImageWriter()

npSocket = NumpySocket()
npSocket.startServer(9999)

def processImage()
    tempHLeft, tempHRight = camFeedthrough.getStereoHorzontial()
    tempVLeft, tempVRight = camFeedthrough.getStereoVertical()  # Assuming this is the correct method
    vLeft = np.ascontiguousarray(tempVLeft, dtype=np.uint8).view(np.uint16)  # Corrected dtype and view method
    vRight = np.ascontiguousarray(tempVRight, dtype=np.uint8).view(np.uint16)
    hLeft = np.ascontiguousarray(tempHLeft, dtype=np.uint8).view(np.uint16) 
    hRight = np.ascontiguousarray(tempHRight, dtype=np.uint8).view(np.uint16)
    return vLeft, vRight, hLeft, hRight


# only set this flag to true if you have generated your bit file with a 
# Vivado reference design for Simulink
simulink = True    
if simulink == True:
    f1 = open("/dev/mem", "r+b")
    simulinkMem = mmap.mmap(f1.fileno(), 1000, offset=0x43c60000)
    simulinkMem.seek(0) 
    simulinkMem.write(struct.pack('l', 1))       # reset IP core
    simulinkMem.seek(8)                         
    simulinkMem.write(struct.pack('l', 752))     # image width
    simulinkMem.seek(12)                        
    simulinkMem.write(struct.pack('l', 480))     # image height
    simulinkMem.seek(16)                        
    simulinkMem.write(struct.pack('l', 94))       #  horizontal porch
    simulinkMem.seek(20)                        
    simulinkMem.write(struct.pack('l', 1000))     #  vertical porch when reading from debug
    simulinkMem.seek(4) 
    simulinkMem.write(struct.pack('l', 1))       # enable IP core

print "entering main loop"


# feel free to modify this command structue as you wish.  It might match the 
# command structure that is setup in the Matlab side of things on the host PC.
while (1)
    # Receive command
    cmd = npSocket.receiveCmd()
    
    # Check the received command and perform actions accordingly
    if cmd == '0':
        # If command is '0', receive data and set frame
        data = npSocket.receive()
        camWriter.setFrame(data)
        # Send a response (e.g., acknowledgment)
        npSocket.send(np.array(2))
    elif cmd == '1':
        # If command is '1', process image and obtain calibration values
        calibrationValue = processImage()
        maxValue = [np.argmax(arr) for arr in calibrationValue]
        npSocket.send(maxValue)
    elif cmd == '2':
        # If command is '2', process image and calculate differences
        normalizedValue = processImage()
        differentialValue = np.subtract(normalizedValue,calibrationValue,dtype=np.uint16)
        maxValue = [np.argmax(arr) for arr in differentialValues]
        npSocket.send(maxValue)
    else:
        # If command is not recognized, break out of the loop
        break
npSocket.close()