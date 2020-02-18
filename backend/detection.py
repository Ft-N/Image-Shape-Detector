import cv2
import numpy as np
import math
import sys
from math import sqrt, acos, degrees

def cross_sign(x1, y1, x2, y2):
	# True if cross is positive
	# False if negative or zero
	if x1 * y2 > x2 * y1: #dalam
		return 1
	return 0 #luar

def angle(vector1, vector2):
	x1 = vector1[0]
	y1 = vector1[1]
	x2 = vector2[0]
	y2 = vector2[1]

	numer = (x1 * x2 + y1 * y2) #dot product
	denom = sqrt((x1 ** 2 + y1 ** 2) * (x2 ** 2 + y2 ** 2)) #multiple of length of both vector
	cross = cross_sign(x1, y1, x2, y2)
	
	if cross: #dalam
		sudut = int(round(degrees(acos(numer / denom)), 0)) + 180
	else: #luar
		sudut = 180 - int(round(degrees(acos(numer / denom)), 0))
	return sudut

def getVector(approxed):
	newApproxed = np.append(approxed, [approxed[0]], axis=0)
	vectors = []
	
	for i in range(len(newApproxed)-1):
		vectors.append(np.subtract(newApproxed[i], newApproxed[i+1]))
	return np.array(vectors,dtype=np.int64)

def detectImage(filename):
	img = cv2.imread(filename, cv2.IMREAD_GRAYSCALE)
	t, tresh = cv2.threshold(img, 210, 250, cv2.THRESH_BINARY_INV)

	konturs, _ = cv2.findContours(tresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

	approxed = None

	for kontur in konturs:
		approx = cv2.approxPolyDP(kontur, 0.01*cv2.arcLength(kontur, True), True)
		approxed = approx.reshape((len(approx), 2))
		# cv2.drawContours(tresh, [approx], 0, (255, 255, 255), 5)

	vectors = getVector(approxed)
	newVectors = np.append(vectors, [vectors[0]], axis=0)
	result = []
	for i in range(len(newVectors)-1):
		result.append(angle(newVectors[i], newVectors[i+1]))
	return result

# cv2.imshow('ori', tresh)
# cv2.waitKey(0)
# cv2.destroyAllWindows()