import cv2
import cvzone
from cvzone.ColorModule import ColorFinder
import numpy as np



#color finder Object
myColorFinder = ColorFinder(True)#running debug mod to find color
hsvVals = 'red'
#hsvVals = {'hmin': 30, 'smin': 169, 'vmin': 0, 'hmax': 35, 'smax': 255, 'vmax': 255}


while True:
    #success, frame = cap.read()
    frame = cv2.imread("CamAngel.png") #Testing Img Values to get hsVals

    #Find Ball Color
    imgColor, mask = myColorFinder.update(frame, hsvVals)


    #Display
    cv2.imshow("Image", imgColor)

    cv2.waitKey(50)

cv2.destroyAllWindows()