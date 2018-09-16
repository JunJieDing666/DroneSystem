package com.droneSystem.javacv;

import javax.swing.JFrame;

import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.avcodec;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.opencv_objdetect;
import org.bytedeco.javacv.CanvasFrame;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.FrameGrabber;
import org.bytedeco.javacv.FrameRecorder;
import org.bytedeco.javacv.OpenCVFrameConverter;
//����Ϊ����ʹ�ã�����������ͷ��ȡ����Ƶ���͵�rtmp��������
public class RecordCamera {
	public static void recordCamera(String outputFile, double frameRate)  
            throws Exception, InterruptedException, org.bytedeco.javacv.FrameRecorder.Exception {  
        Loader.load(opencv_objdetect.class);  
        FrameGrabber grabber = FrameGrabber.createDefault(0);//��������ͷĬ��0������ʹ��javacv��ץȡ��������ʹ�õ���ffmpeg����opencv�������в鿴Դ��  
        grabber.start();//����ץȡ��  
  
        OpenCVFrameConverter.ToIplImage converter = new OpenCVFrameConverter.ToIplImage();//ת����  
        IplImage grabbedImage = converter.convert(grabber.grab());//ץȡһ֡��Ƶ������ת��Ϊͼ�����������ͼ��������ʲô����ˮӡ������ʶ��ȵ��������  
        int width = grabbedImage.width();  
        int height = grabbedImage.height();  
      
        FrameRecorder recorder = FrameRecorder.createDefault(outputFile, width, height);  
        recorder.setVideoCodec(avcodec.AV_CODEC_ID_H264); // avcodec.AV_CODEC_ID_H264������  
        recorder.setFormat("flv");//��װ��ʽ����������͵�rtmp�ͱ�����flv��װ��ʽ  
        recorder.setFrameRate(frameRate);  
          
        recorder.start();//����¼����  
        long startTime=0;  
        long videoTS=0;  
        CanvasFrame frame = new CanvasFrame("camera", CanvasFrame.getDefaultGamma() / grabber.getGamma());  
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
        frame.setAlwaysOnTop(true);  
        Frame rotatedFrame=converter.convert(grabbedImage);//��֪��Ϊʲô���ﲻ��ת���Ͳ����Ƶ�rtmp  
        while (frame.isVisible() && (grabbedImage = converter.convert(grabber.grab())) != null) {  
            rotatedFrame = converter.convert(grabbedImage);  
            frame.showImage(rotatedFrame);  
            if (startTime == 0) {  
                startTime = System.currentTimeMillis();  
            }  
            videoTS = 1000 * (System.currentTimeMillis() - startTime);  
            recorder.setTimestamp(videoTS);  
            recorder.record(rotatedFrame);  
            Thread.sleep(40);  
        }  
        frame.dispose();  
        recorder.stop();  
        recorder.release();  
        grabber.stop();  
      
    } 
	
	public static void main(String[] args) throws Exception, InterruptedException, org.bytedeco.javacv.FrameRecorder.Exception {  
        recordCamera("rtmp://192.168.1.5/live/record1",25);  
    }  

}
