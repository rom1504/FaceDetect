all:facedetect
	
facedetect:facedetect.cpp
	g++ `pkg-config --cflags opencv` -o ../bin/facedetect facedetect.cpp `pkg-config --libs opencv`