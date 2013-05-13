#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include <iostream>
#include <stdio.h>

using namespace std;
using namespace cv;

void detectAndDraw( Mat& img,CascadeClassifier& cascade,double scale,string fimg);


int main( int argc, const char** argv )
{
	if(argc!=4)
	{
		cout<<"Usage: "<<argv[0]<<" <image> <imageSortie> <modele>\n";
	}
    Mat frame, frameCopy, image;


    CascadeClassifier cascade;
    double scale = 1;

    cascade.load( argv[3] );
     image = imread( argv[1], 1 );
   
	if( !image.empty() )
	{
		detectAndDraw( image, cascade, scale ,argv[2]);
		waitKey(0);
	}
    return 0;
}

void detectAndDraw( Mat& img,CascadeClassifier& cascade,double scale,string fimg)
{
    int i = 0;
    double t = 0;
    vector<Rect> faces;
    const static Scalar colors[] =  { CV_RGB(0,0,255),
        CV_RGB(0,128,255),
        CV_RGB(0,255,255),
        CV_RGB(0,255,0),
        CV_RGB(255,128,0),
        CV_RGB(255,255,0),
        CV_RGB(255,0,0),
        CV_RGB(255,0,255)} ;
		int w=cvRound (img.rows/scale),h=cvRound(img.cols/scale);
    Mat gray, smallImg( w, h, CV_8UC1 );

    cvtColor( img, gray, CV_BGR2GRAY );
    resize( gray, smallImg, smallImg.size(), 0, 0, INTER_LINEAR );
    equalizeHist( smallImg, smallImg );

    t = (double)cvGetTickCount();
    cascade.detectMultiScale( smallImg, faces,
        1.1, 2, 0
       // |CV_HAAR_FIND_BIGGEST_OBJECT
        //|CV_HAAR_DO_ROUGH_SEARCH
        |CV_HAAR_SCALE_IMAGE
        ,
        Size(cvRound(w*0.05), cvRound(h*0.05)) );
    for( vector<Rect>::const_iterator r = faces.begin(); r != faces.end(); r++, i++ )
    {
        Scalar color = colors[i%8];
		cout<<r->x<<"\t"<<r->y<<"\t"<<r->width<<"\t"<<r->height<<"\n";
		rectangle(img,Point(r->x,r->y),Point(r->x+r->width,r->y+r->height),color);
      
    }
    imwrite(fimg,img);
}
