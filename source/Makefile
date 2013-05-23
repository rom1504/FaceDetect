all:facedetect
	
facedetect:facedetect.cpp
	mkdir -p ../bin
	g++ `pkg-config --cflags opencv` -o ../bin/facedetect facedetect.cpp `pkg-config --libs opencv`
