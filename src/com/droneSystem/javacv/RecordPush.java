package com.droneSystem.javacv;

import javax.swing.JFrame;

import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.avcodec;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.opencv_objdetect;
import org.bytedeco.javacv.CanvasFrame;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.FrameGrabber;
import org.bytedeco.javacv.FrameRecorder;
import org.bytedeco.javacv.OpenCVFrameConverter;
//���ϳɵ���Ƶ���͵�rtmp��������,rtmp��������Ҫʵ�ִ��
public class RecordPush {
    public static void recordPush(String inputFile,String outputFile,int v_rs) throws Exception, org.bytedeco.javacv.FrameRecorder.Exception, InterruptedException{  
        Loader.load(opencv_objdetect.class);  
        long startTime=0;  
        FrameGrabber grabber =FFmpegFrameGrabber.createDefault(inputFile);  
        try {  
            grabber.start();  
        } catch (Exception e) {  
            try {  
                grabber.restart();  
            } catch (Exception e1) {  
                throw e;  
            }  
        }  
          
        OpenCVFrameConverter.ToIplImage converter = new OpenCVFrameConverter.ToIplImage();  
        Frame grabframe =grabber.grab();  
        IplImage grabbedImage =null;  
        if(grabframe!=null){  
            System.out.println("ȡ����һ֡");  
            grabbedImage = converter.convert(grabframe);  
        }else{  
            System.out.println("û��ȡ����һ֡");  
        }  
        
        FrameRecorder recorder;  
        try {  
            recorder = FrameRecorder.createDefault(outputFile, 1280, 720);  
        } catch (org.bytedeco.javacv.FrameRecorder.Exception e) {  
            throw e;  
        }  
        recorder.setVideoCodec(avcodec.AV_CODEC_ID_H264); // avcodec.AV_CODEC_ID_H264  
        recorder.setFormat("flv");  
        recorder.setFrameRate(v_rs);  
        recorder.setGopSize(v_rs);  
        System.out.println("׼����ʼ����...");  
        try {  
            recorder.start();  
        } catch (org.bytedeco.javacv.FrameRecorder.Exception e) {  
            try {  
                System.out.println("¼��������ʧ�ܣ�������������...");  
                if(recorder!=null)  
                {  
                    System.out.println("���Թر�¼����");  
                    recorder.stop();  
                    System.out.println("�������¿���¼����");  
                    recorder.start();  
                }  
                  
            } catch (org.bytedeco.javacv.FrameRecorder.Exception e1) {  
                throw e;  
            }  
        }  
        System.out.println("��ʼ����");  
        CanvasFrame frame = new CanvasFrame("camera", CanvasFrame.getDefaultGamma() / grabber.getGamma());  
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
        frame.setAlwaysOnTop(true);  
        while (frame.isVisible() && (grabframe=grabber.grab()) != null) {  
            System.out.println("����...");  
            frame.showImage(grabframe);  
            grabbedImage = converter.convert(grabframe);  
            Frame rotatedFrame = converter.convert(grabbedImage);  
              
            if (startTime == 0) {  
                startTime = System.currentTimeMillis();  
            }  
            recorder.setTimestamp(1000 * (System.currentTimeMillis() - startTime));//ʱ���  
            if(rotatedFrame!=null){  
            recorder.record(rotatedFrame);  
            }  
              
            Thread.sleep(40);  
        }  
        frame.dispose();  
        recorder.stop();  
        recorder.release();  
        grabber.stop();  
        System.exit(2);  
    }  
    
    public static void main(String[] args)  
            throws Exception {  
  
        String inputFile = "D:/test/test.mp4";  //��ȡ�ϳɵ���Ƶ
  
        String outputFile="rtmp://219.230.75.103:5080/live/Stream14128589";  //rtmp��ĵ�ַ��Ϊ����ip��ַ�����͵�rtmp��������
  
        recordPush(inputFile, outputFile,25);  


    }
}
