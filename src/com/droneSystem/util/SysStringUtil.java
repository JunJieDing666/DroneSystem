package com.droneSystem.util;

/**
 * ϵͳ��һЩ�����ַ�����������
 * @author zhan
 *
 */
public class SysStringUtil {
	/**
	 * ��̨����ǰ̨������Ϣ���ص�ContentType������
	 * @author zhan
	 *
	 */
	public static class ResponseContentType{
		public static final String Type_FormSubmit = "text/html;charset=utf-8";	//Form�ύʱ������Ϣ��ContentType����response.setContentType("text/html;charset=utf-8");
		public static final String Type_AjaxSubmit = "text/json;charset=utf-8";	//Ajax�ύ����ǰ̨Ajax��Ҫ���÷��صĸ�ʽΪjson
		public static final String Type_EasyUIDatagrid = "text/json;charset=utf-8";	//ʹ��easyui datagrid��������
		public static final String Type_EasyUICombobox = "text/json;charset=gbk";	//ʹ��easyui combobox��������
	}
	
}
