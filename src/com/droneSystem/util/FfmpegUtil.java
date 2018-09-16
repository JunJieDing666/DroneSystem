package com.droneSystem.util;

import java.io.File;  
import java.io.IOException;  
import java.util.ArrayList;  
import java.util.Calendar;  
import java.util.List;  

public class FfmpegUtil {  
      
    private static String inputPath = "";  
      
    private static String outputPath = "";  
      
    private static String ffmpegPath = "";  
      
    public static void main(String args[]) throws IOException {  
        long startTime = System.currentTimeMillis();
        getPath();  
        System.out.println(startTime);
//        processImg(inputPath,ffmpegPath,"d",0);
//        if (!checkfile(inputPath)) {  
//            System.out.println(inputPath + " is not file");  
//            return;  
//        }  
//        if (process()) {  
//            System.out.println("ok");  
//        }  
        processEachImg(inputPath,ffmpegPath);
        long endTime = System.currentTimeMillis();
        System.out.println(endTime);
        System.out.println(endTime - startTime);
    }  
      
    private static void getPath() { // �Ȼ�ȡ��ǰ��Ŀ·�����ڻ��Դ�ļ���Ŀ���ļ���ת������·��  
        File diretory = new File("");  
        try {  
            String currPath = diretory.getAbsolutePath();  
            inputPath = currPath + "\\input\\test.mp4";  
            outputPath = currPath + "\\output\\";  
            ffmpegPath = currPath + "\\ffmpeg\\";  
            System.out.println(currPath);  
        }  
        catch (Exception e) {  
            System.out.println("getPath����");  
        }  
    }  
      
    private static boolean process() {  
        int type = checkContentType();  
        boolean status = false;  
        if (type == 0) {  
            System.out.println("ֱ��ת��flv��ʽ");  
            status = processFLV(inputPath);// ֱ��ת��flv��ʽ  
        }
        return status;  
    }  
  
    private static int checkContentType() {  
        String type = inputPath.substring(inputPath.lastIndexOf(".") + 1, inputPath.length())  
                .toLowerCase();  
        // ffmpeg�ܽ����ĸ�ʽ����asx��asf��mpg��wmv��3gp��mp4��mov��avi��flv�ȣ�  
        if (type.equals("avi")) {  
            return 0;  
        } else if (type.equals("mpg")) {  
            return 0;  
        } else if (type.equals("wmv")) {  
            return 0;  
        } else if (type.equals("3gp")) {  
            return 0;  
        } else if (type.equals("mov")) {  
            return 0;  
        } else if (type.equals("mp4")) {  
            return 0;  
        } else if (type.equals("asf")) {  
            return 0;  
        } else if (type.equals("asx")) {  
            return 0;  
        } else if (type.equals("flv")) {  
            return 0;  
        }  
       
        return 9;  
    }  
  
    private static boolean checkfile(String path) {  
        File file = new File(path);  
        if (!file.isFile()) {  
            return false;  
        }  
        return true;  
    }  
  
    /** 
     * ��Ƶ��ͼ 
     * @param veido_path    ��Ƶ·�� 
     * @param ffmpeg_path   ffmpeg·�� 
     * @param image_name    ͼƬ����·�� 
     * @param time          ��ͼʱ��� 
     * @return 
     */  
    public static boolean processImg(String veido_path, String ffmpeg_path, String image_name, float time) {  
        File file = new File(veido_path);  
        if (!file.exists()) {  
            return false;  
        }  
        List<String> commands = new java.util.ArrayList<String>();  
        commands.add(ffmpeg_path + "ffmpeg");  
        commands.add("-ss");//SS���������ʼ��ͼ�ٶ����  
        commands.add("\""+time+"\"");//������������ý�ȡ��Ƶ������ʱ�Ļ���  
        commands.add("-i");  
        commands.add(veido_path);  
        commands.add("-vframes");  
        commands.add("1");  
        commands.add("-y");  
        commands.add("-f");  
        commands.add("image2");   
        commands.add(outputPath + image_name+".jpg");  
        try {  
            ProcessBuilder builder = new ProcessBuilder();  
            builder.command(commands);  
            builder.start();  
            return true;  
        } catch (Exception e) {  
            e.printStackTrace();  
            return false;  
        }  
    }  
    
    //����Ƶ��֡
    public static boolean processEachImg(String veido_path, String ffmpeg_path) {  
        File file = new File(veido_path);  
        if (!file.exists()) {  
            return false;  
        }  
        List<String> commands = new java.util.ArrayList<String>();  
        commands.add(ffmpeg_path + "ffmpeg");  
        commands.add("-i");  
        commands.add(veido_path);    
        commands.add(outputPath + "frames_%05d.jpg");  
        try {  
            ProcessBuilder builder = new ProcessBuilder();  
            builder.command(commands);  
            builder.start();  
            return true;  
        } catch (Exception e) {  
            e.printStackTrace();  
            return false;  
        }  
    }  
    // ffmpeg�ܽ����ĸ�ʽ����asx��asf��mpg��wmv��3gp��mp4��mov��avi��flv�ȣ�  
    private static boolean processFLV(String oldfilepath) {  
  
        if (!checkfile(inputPath)) {  
            System.out.println(oldfilepath + " is not file");  
            return false;  
        }  
          
        List<String> command = new ArrayList<String>();  
        command.add(ffmpegPath + "ffmpeg");  
        command.add("-i");  
        command.add(oldfilepath);  
        command.add("-ab");  
        command.add("56");  
        command.add("-ar");  
        command.add("22050");  
        command.add("-qscale");  
        command.add("8");  
        command.add("-r");  
        command.add("15");  
        command.add("-s");  
        command.add("600x500");  
        command.add(outputPath + "a.flv");  
  
        try {   
            Process videoProcess = new ProcessBuilder(command).redirectErrorStream(true).start();  
              
            new PrintStream(videoProcess.getErrorStream()).start();  
              
            new PrintStream(videoProcess.getInputStream()).start();  
              
            videoProcess.waitFor();  
              
            return true;  
        } catch (Exception e) {  
            e.printStackTrace();  
            return false;  
        }  
    }  
}  
  
class PrintStream extends Thread   
{  
    java.io.InputStream __is = null;  
    public PrintStream(java.io.InputStream is)   
    {  
        __is = is;  
    }   
  
    public void run()   
    {  
        try   
        {  
            while(this != null)   
            {  
                int _ch = __is.read();  
                if(_ch != -1)   
                    System.out.print((char)_ch);   
                else break;  
            }  
        }   
        catch (Exception e)   
        {  
            e.printStackTrace();  
        }   
    }  
}  