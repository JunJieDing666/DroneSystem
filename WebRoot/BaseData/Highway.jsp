<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>�������ƹ���</title>
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon2.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
	<script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
	<script type="text/javascript"  src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<script>
		$(function(){			
			$('#table2').datagrid({
				title:'���ٹ�·����',
				width:900,
				height:500,
				singleSelect:false, 
                nowrap: false,
                striped: true,
				url:'',
				//sortName: 'Id',
				remoteSort: false,
				singleSelect:true, 
				idField:'Id',
				frozenColumns:[[
	                {field:'ck',checkbox:true}
				]],
				columns:[[
					{field:'Name',title:'����',width:80,align:'center'},
					{field:'Brief',title:'ƴ������',width:60,align:'center'},
					{field:'Code',title:'���',width:100,align:'center'},
					{field:'StartPoint',title:'���',width:80,align:'center'},
					{field:'EndPoint',title:'�յ�',width:80,align:'center'},
					{field:'Length',title:'����',width:80,align:'center'},
					{field:'Width',title:'���',width:80,align:'center'},
					{field:'LaneNum',title:'������',width:80,align:'center'},
					{field:'DesignSpeed',title:'����ٶ�',width:80,align:'center'},
					{field:'MaxLonGrade',title:'�������',width:80,align:'center'},
					{field:'Rank',title:'�ȼ�',width:80,align:'center'},
					{field:'Status',title:'״̬',width:80,align:'center'}
				]],
				pagination:false,
				rownumbers:true,
				toolbar:[{
						text:'����',
						iconCls:'icon-add',
						handler:function(){
							$('#edit').window('open');
							$('#form1').show();
							$('#form1').form('clear');
							var clickname="����";
							$('#edit').panel({title:clickname});
						}
					},'-',{
						text:'�޸�',
						iconCls:'icon-edit',
						handler:function(){
							var select = $('#table2').datagrid('getSelected');
							if(select){
								$('#edit').window('open');
								$('#form1').show();
								var clickname="�޸�";
								$('#edit').panel({title:clickname});
								$('#form1').form('load',select);
								$('#form1').form('validate');
						}else{
							$.messager.alert('��ʾ','��ѡ��һ������','warning');
							}
						}
				},'-',{
						text:'ע��',
						iconCls:'icon-remove',
						handler:function(){
							var select = $('#table2').datagrid('getSelected');
							if(select){
								$.messager.confirm('��ʾ','ȷ��ע����',function(r){
								if(r){
									$.ajax({
									type:'POST',
									url:'/jlyw/AddressServlet.do?method=5',
									data:"id="+select.Id,
									dataType:"html",
									success:function(data){
										$('#table2').datagrid('reload');
									}
								});
								}
							});	
							}
							else
							{
								$.messager.alert('��ʾ','��ѡ��һ������','warning');
							}
						}
				}]
			});
			
		});
		
		function Submit(){
			$('#form1').form('submit',{
				url: '/jlyw/AddressServlet.do?method=4',
				onSubmit:function(){ return $('#form1').form('validate');},
		   		success:function(data){
		   			var result = eval("("+data+")");
		   			$.messager.alert('��ʾ',result.msg,'info');
		   			if(result.IsOK)
		   				closed();
					$('#table2').datagrid('reload');
		   		 }
			});
		}
		
		function closed(){
			$('#edit').dialog('close');
		}
			
		</script>

</head>

<body>
<DIV class="JlywMainLayoutDiv">
	<DIV class="JlywCenterLayoutDIV">
	<div style="width:900px"  region="center">
		
		<table id="table2" style="height:500px; width:900px"></table>
		
		<div id="edit" class="easyui-window" title="�޸�" style="padding: 10px;width: 540px;height: 300px;"
		iconCls="icon-edit" closed="true" maximizable="false" minimizable="false" collapsible="false" modal="true">
			<form id="form1" method="post">
				<div>
					<table id="table3" iconCls="icon-edit" >
					<input id="Id" name="Id" type="hidden"/>
						<tr>
							<td align="right">��·���ƣ�</td>
							<td align="left"><input id="Name" name="Name" class="easyui-validatebox" required="true"/></td>
							<td align="right">ƴ�����룺</td>
							<td align="left"><input id="Brief" name="Brief" class="easyui-validatebox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
							<td align="left"><input id="Code" name="Code" class="easyui-validatebox" required="true"/></td>
                            <td align="right">��������</td>
							<td align="left"><input id="LaneNum" name="LaneNum" class="easyui-validatebox"/></td>
						</tr>
						<tr>
							<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�㣺</td>
							<td align="left"><input id="StartPoint" name="StartPoint" class="easyui-combobox" required="true"/></td>
							<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�㣺</td>
							<td align="left"><input id="EndPoint" name="EndPoint" class="easyui-combobox"/></td>
                            </tr>
                        <tr>
                            <td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�ȣ�</td>
							<td align="left"><input id="Length" name="Length" class="easyui-validate"/></td>
                            <td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�ȣ�</td>
							<td align="left"><input id="Width" name="Width" class="easyui-validate"/></td>
						</tr>
                        <tr>
                            <td align="right">����ٶȣ�</td>
							<td align="left"><input id="DesignSpeed" name="DesignSpeed" class="easyui-validate"/></td>
                            <td align="right">������£�</td>
							<td align="left"><input id="MaxLonGrade" name="MaxLonGrade" class="easyui-validate"/></td>
						</tr>
                        <tr>
                        	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
							<td align="left"><input id="WebSite" name="WebSite" class="easyui-validate"/></td>
                            <td align="right">״&nbsp;&nbsp;&nbsp;&nbsp;̬��</td>
                            <td>
								<select id="Status" name="Status" class="easyui-combobox" style="width:152px" required="true" panelHeight="auto"  editable="false">
									<option value="0">����</option>
									<option value="1">��ʱ</option>
								</select>
							</td>
                        </tr>
                       
						<tr height="50px">	
							<td></td>
							<td><a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="Submit()">�ύ</a></td>
							<td></td>
							<td><a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closed()">ȡ��</a></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</DIV>
</DIV>
</body>
</html>
