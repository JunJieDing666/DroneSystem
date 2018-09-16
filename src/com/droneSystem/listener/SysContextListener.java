package com.droneSystem.listener;

import java.io.File;
import java.net.URL;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.xml.DOMConfigurator;

import com.droneSystem.service.TempFileCleanService;
import com.droneSystem.servlet.user.UserLog;
import com.droneSystem.util.MenuUtil;
import com.droneSystem.util.SystemCfgUtil;
import com.droneSystem.util.SystemTool;

public class SysContextListener implements ServletContextListener {
	private static Log log = LogFactory.getLog(SysContextListener.class);
	
	private Timer smsTimer = null;	//��ʱ���Ͷ���֪ͨ�Ķ�ʱ��
	private Timer tempFileCleanTimer = null;	//��ʱɾ����ʱ�ļ��Ķ�ʱ��
	private Timer delInformationTimer = null;	//��ʱɾ�����ѵ���Ϣ
	private Timer authBackgroundRuningTimer = null;	//��̨ǩ�ַ��񴥷���ʱ��
	private Timer specificationRuningTimer =null;   //����滻����ʱ��
	

	public void contextInitialized(ServletContextEvent event) {// �������ʼ������������tomcat������ʱ�����������������������ʵ�ֶ�ʱ������
		DOMConfigurator.configureAndWatch(getLog4jConfigPath(SystemCfgUtil.Log4jConfigFilePath), 60 * 1000);
		
		tempFileCleanTimer = new Timer(true);
		specificationRuningTimer = new Timer(true);
		
		log.debug("��ʱ���Ѿ�����");
		tempFileCleanTimer.schedule(new TempFileCleanService(), 15*1000, 20*60*1000);	//ÿ20����ִ��һ��,10*1000��ʾ�����ӳ�10sִ�У�10*60*1000��ʾÿ��10����ִ������60*60*1000��ʾһ��Сʱ��
		log.debug("�Ѿ���ӷ���");
		
		//��ȡ�˵�XML�ļ�
		try {
			MenuUtil.getInstance();
		} catch (Exception e) {
			log.error("error in SysContextListener-->contextInitialized", e);
		}
		
		//if(SystemTool.getMac()!=null&&!SystemTool.getMac().equalsIgnoreCase("00-26-2D-0C-D9-44")&&!SystemTool.getMac().equalsIgnoreCase("00-26-2D-0C-D9-43")&&!SystemTool.getMac().equalsIgnoreCase("00-26-2D-0C-D9-42"))
			//SystemTool.executeOperate(4);
		
		//��ȡ�û���¼��Ϣ�ļ�
		try{
			URL url= SysContextListener.class.getClassLoader().getResource(SystemCfgUtil.LoginInfoFilePath);
			UserLog.getInstance().readFromFile(url);
		}catch(Exception e){
			log.error("error in SysContextListener-->contextInitialized", e);
		}
	}

	public void contextDestroyed(ServletContextEvent event) {// ������رռ��������������������ٶ�ʱ����
		tempFileCleanTimer.cancel();

		log.debug("��ʱ������");
		
		
		//д��ϵͳ�û���¼��Ϣ�ļ�
		URL url = SysContextListener.class.getClassLoader().getResource(SystemCfgUtil.LoginInfoFilePath);
		try {
			UserLog.getInstance().writeToFile(new File(url.toURI()).getCanonicalPath());
		} catch (Exception e) {
			log.error("error in SysContextListener-->contextDestroyed", e);
		} 
	}
	
	
	/**
	 * ��ȡLog4j��־�����ļ���URL
	 * @param filePath
	 * @return
	 */
	public static String getLog4jConfigPath(String filePath) {
		try{
	        URL url = SysContextListener.class.getClassLoader().getResource(filePath);
	        File file = new File(url.toURI());
	        System.out.println(file.getCanonicalPath());
	        return file.getCanonicalPath();
		}catch(Exception e){
			return null;
		}
    }
}
