import cv2
import cvzone
from cvzone.ColorModule import ColorFinder
import numpy as np

cap = cv2.VideoCapture("BallVideo.mp4")


#color finder Object
myColorFinder = ColorFinder(False)#running debug mod to find color
#hsvVals = 'red'
#hsvVals = {'hmin': 30, 'smin': 169, 'vmin': 0, 'hmax': 35, 'smax': 255, 'vmax': 255} Don't remove for BallVideo.mp4
hsvVals = {'hmin': 30, 'smin': 169, 'vmin': 0, 'hmax': 35, 'smax': 255, 'vmax': 255}

#Variables
positionListX = []
positionListY = []
xList = [item for item in range(0,1300)]

while True:
    success, frame = cap.read()
    #frame = cv2.imread("firstBall.png") #Testing Img Values to get hsVals

    #Find Ball Color
    imgColor, mask = myColorFinder.update(frame, hsvVals)

    #Ball Location
    imgContours, contours = cvzone.findContours(frame, mask, minArea=500)

    if contours:
        positionListX.append(contours[0]['center'][0])
        positionListY.append(contours[0]['center'][1])
        #print(cx,cy)

    if positionListX:
        # Polynomial Regression y = Ax^2 + Bx + C
        #Find Coefficients

        A,B,C = np.polyfit(positionListX,positionListY,2)



        for i, (posX, posY) in enumerate(zip(positionListX,positionListY)):
            pos = (posX,posY)
            cv2.circle(imgContours,pos,5,(0,255,0),cv2.FILLED) #Showing center point of ball

            if i == 0:
                cv2.line(imgContours, pos, pos, (0, 255, 0), 2)
            else:
                cv2.line(imgContours,pos,(positionListX[i-1],positionListY[i-1]), (0,255,0), 2)

        for x in xList:
            y = int(A * x**2 + B*x + C)
            cv2.circle(imgContours, (x, y), 3, (255, 0, 255), cv2.FILLED)


    #Display
    cv2.imshow("Image", imgContours)

    cv2.waitKey(50)
cv2.destroyAllWindows()