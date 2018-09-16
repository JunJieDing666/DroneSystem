<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
	.BMap_cpyCtrl {  
    display: none;  
    }  
  
    .anchorBL {  
    display: none;  
    }  
     body, html{width: 100%;height: 100%;margin:0;font-family:"΢���ź�";font-size:14px;}
     #allmap{height:90%;width:80%;}
     #r-result{width:80%;} 
    </style>
	<link href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4&ak=jwTcIoGGL3WahiyCb2Hg7juZi1TGym0Y"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js"></script>
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon2.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/video-js.css" >
	
    <script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<script type="text/javascript" src="../JScript/upload.js"></script>
	<script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
    <script type="text/javascript" src="../JScript/json2.js"></script>
    <script type="text/javascript" src="http://vjs.zencdn.net/5.18.4/video.min.js"></script>
    <title>������Ϣ</title>
</head>
<body>
	<div style="width:1500px; height:600px;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td>
	 <div id="allmap"  style="width: 650px; height: 840px"></div>
	</td>
	<td>
	 <div id="video" style="width:650px;height:840px;visibility:hidden">
	  <video id="my-video" class="video-js vjs-default-skin" controls="controls" preload="auto" title="���˻���Ƶ"  width="650px" height="840px"
		  poster="http://video-js.zencoder.com/oceans-clip.png" data-setup="{}">
			<source src="70b4b3719a47aad5bafd0a0f8b433b88.mp4" type="video/mp4">
			<p class="vjs-no-js">
			  To view this video please enable JavaScript, and consider upgrading to a web browser that
			  <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
			</p>
		  </video>
		  <script type="text/javascript">
			videojs("my-video").ready(function(){
				var myPlayer = this;
				myPlayer.play();
			});
		</script>
	 </div>
	</td>
	<td>
		<div id="eCharts" style="width:340px;height:840px">
		    <table>  
		       <tr><td><div id="echarts1" style="width:340px;height:270px"></div></td></tr>  
		       <tr><td><div id="echarts2" style="width:340px;height:270px"></div></td></tr>   
		       <tr><td><div id="echarts3" style="width:340px;height:270px"></div></td></tr>   
		   </table> 
		</div>
	</td>
   </tr>
  </table>
 </div>
	
   
<!--    	<div>
	<input name="button1" type="button" value="���ظ���" onclick="goposition(107.405397,40.855578,111.340683,40.745054)"/>
	<input name="button2" type="button" value="���¸���" onclick="goposition(112.147918,40.91459,110.939024,40.672474)"/>
	<input name="button3" type="button" value="�˰͸���" onclick="goposition(111.374612,40.095626,112.191327,40.311541)"/>
	<input name="button4" type="button" value="���ڸ���" onclick="goposition(111.403213,39.816964,111.968356,39.813154)"/>
	<input name="button5" type="button" value="���˻�1��" onclick="init()"/>
    </div>
 -->
</body>
</html>

<script type="text/javascript">
    // �ٶȵ�ͼAPI����
    function G(id) {
        return document.getElementById(id);
    }

    var map = new BMap.Map("allmap");
    map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(111.755933, 40.848919), 11);                   // ��ʼ����ͼ,���ó��к͵�ͼ����

	var ctrl = new BMapLib.TrafficControl({
		showPanel: true //�Ƿ���ʾ·����ʾ���
	});      
	map.addControl(ctrl);
	ctrl.setAnchor(BMAP_ANCHOR_BOTTOM_RIGHT);  
	
	var mapType1 = new BMap.MapTypeControl({mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]});
	map.addControl(mapType1);          //2Dͼ������ͼ
	
    // ����һ���ؼ���,��function
    function ZoomControl() {
        this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
        this.defaultOffset = new BMap.Size(10, 10);
    }

    // ͨ��JavaScript��prototype���Լ̳���BMap.Control
    ZoomControl.prototype = new BMap.Control();

    // �Զ���ؼ�����ʵ���Լ���initialize����,���ҽ��ؼ���DOMԪ�ط���
    // �ڱ������д�����divԪ����Ϊ�ؼ�������,��������ӵ���ͼ������
    ZoomControl.prototype.initialize = function(map){
      // ����һ��DOMԪ��
      var div = document.createElement("div");
      div.innerHTML = '<div id="r-result">������ַ:<input type="text" id="suggestId" size="20" value="�ٶ�" style="width:150px;" /></div><div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>';

      // ���DOMԪ�ص���ͼ��
      map.getContainer().appendChild(div);
      // ��DOMԪ�ط���
      return div;
    }

    // �����ؼ�
    var myZoomCtrl = new ZoomControl();
    // ��ӵ���ͼ����
    map.addControl(myZoomCtrl);
	
    var ac = new BMap.Autocomplete(    //����һ���Զ���ɵĶ���
        {"input" : "suggestId"
        ,"location" : map
    });

    ac.addEventListener("onhighlight", function(e) {  //�����������б��ϵ��¼�
    var str = "";
        var _value = e.fromitem.value;
        var value = "";
        if (e.fromitem.index > -1) {
            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        }
        str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

        value = "";
        if (e.toitem.index > -1) {
            _value = e.toitem.value;
            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        }
        str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
        G("searchResultPanel").innerHTML = str;
    });

    var myValue;
    ac.addEventListener("onconfirm", function(e) {    //����������б����¼�
    var _value = e.item.value;
        myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;

        setPlace();
    });

    function setPlace(){
        map.clearOverlays();    //�����ͼ�����и�����
        function myFun(){
            var pp = local.getResults().getPoi(0).point;    //��ȡ��һ�����������Ľ��
            map.centerAndZoom(pp, 14);
            map.addOverlay(new BMap.Marker(pp));    //��ӱ�ע
        }
        var local = new BMap.LocalSearch(map, { //��������
          onSearchComplete: myFun
        });
        local.search(myValue);
    }
	
	function goposition(id,x1,y1,x2,y2){
	    map.clearOverlays();//���ͼ�㸲����
	    var p1 = new BMap.Point(x1,y1);
	    var p2 = new BMap.Point(x2,y2);
		getUnmans(id);
		var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, panel : "results", autoViewport: true},
	        onPolylinesSet:function(routes) { 
	            searchRoute = routes[0].getPolyline();//����·��
	            map.addOverlay(searchRoute); 
	        }, 
	        onMarkersSet:function(routes) {
	            map.removeOverlay(routes[0].marker); //ɾ�����
	            map.removeOverlay(routes[1].marker);//ɾ���յ�
	        }
	        
    });
 
    driving.search(p1, p2);
	}
		
	function deletePoint()
    {      //ɾ������ͼ������
        var allOverlay = map.getOverlays();
		for (var i = 0; i < allOverlay.length -1; i++){
				map.clearOverlays();  //���ͼ������
				return false;
		}		  
    }
    
    var time = ['', '', '', '', '', '', ''];
    var data1 = [0, 0, 0, 0, 0, 0, 0];
    var data2 = [0, 0, 0, 0, 0, 0, 0];
    var data3 = [0, 0, 0, 0, 0, 0, 0];
    time = ['11.10','11.11','11.12','11.13','11.14','11.15','11.16'];
	data1 = [211, 300, 190, 210, 220, 130, 333];
	data2 = [11, 11, 15, 13, 12, 13, 10];
   	data3 = [100, 101, 105, 99, 80, 102, 111]; 
	var option1 = {
	    title : {
	        text: '�����仯���'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['', '', '', '', '', '', '']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value} V/h'
	            }
	        }
	    ],
	    series : [
	        {
	            name:'����',
	            type:'line',
	            data:[211, 300, 190, 210, 220, 130, 333],
	            markPoint : {
	                data : [
	                    {type : 'max', name: '���ֵ'},
	                    {type : 'min', name: '��Сֵ'}
	                ]
	            },
	            markLine : {
	                data : [
	                    {type : 'average', name: 'ƽ��ֵ'}
	                ]
	            }
	        }
	    ]
	};
       
	var option2 = {
	    title : {
	        text: 'ѩ��仯���'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['', '', '', '', '', '', '']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value} M'
	            }
	        }
	    ],
	    series : [
	        {
	            name:'ѩ��',
	            type:'line',
	            data:[211, 300, 190, 210, 220, 130, 333],
	            markPoint : {
	                data : [
	                    {type : 'max', name: '���ֵ'},
	                    {type : 'min', name: '��Сֵ'}
	                ]
	            },
	            markLine : {
	                data : [
	                    {type : 'average', name: 'ƽ��ֵ'}
	                ]
	            }
	        }
	    ]
	};
       
	var option3 = {
	    title : {
	        text: 'ɳ��仯���'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['', '', '', '', '', '', '']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value} M^2'
	            }
	        }
	    ],
	    series : [
	        {
	            name:'ɳ��',
	            type:'line',
	            data:[211, 300, 190, 210, 220, 130, 333],
	            markPoint : {
	                data : [
	                    {type : 'max', name: '���ֵ'},
	                    {type : 'min', name: '��Сֵ'}
	                ]
	            },
	            markLine : {
	                data : [
	                    {type : 'average', name: 'ƽ��ֵ'}
	                ]
	            }
	        }
	    ]
	};
                   
	var myChart1 = echarts.init(document.getElementById('echarts1')); 
    myChart1.setOption(option1); 
    var myChart2 = echarts.init(document.getElementById('echarts2'));  
    myChart2.setOption(option2); 
    var myChart3 = echarts.init(document.getElementById('echarts3'));  
    myChart3.setOption(option3); 
    setECharts(echarts1);
	setECharts(echarts2);
	setECharts(echarts3);
    function getUnmans(id){
	  $.ajax({
           	 	type: "post", 
               	cache: false, 
             	dataType: 'json',
             	url: '/droneSystem/DroneServlet.do?method=1',
               	data:{Id:id},
            success: function(data){
            
               //map.panTo(new BMap.Point(data.drones[0].longitude, data.drones[0].latitude));
               
			    deletePoint();
				var marker = new Array();
				for(var i=0;i<data.drones.length;i++) { 
				    //var myIcon = new BMap.Icon("../images/drone.png", new BMap.Size(10,10));
			        marker[i]= new BMap.Marker(new BMap.Point(data.drones[i].longitude,data.drones[i].latitude));  // ������ע��
				 	map.addOverlay(marker[i]); //��ӱ�ע
					//var label = new window.BMap.Label(data.drones[i].code, {offset: new window.BMap.Size(20, -10)}); //������ǩ   
                    var label = new window.BMap.Label("���˻����:"+data.drones[i].code,{offset: new window.BMap.Size(20, -10)});  // �����ı���ע����
		                label.setStyle({
			                  color : "blue",
			                  fontSize : "12px",
			                  //height : "20px",
			                  lineHeight : "20px",
			                  fontFamily:"΢���ź�"
		                 });
		            marker[i].setLabel(label);  //��ӱ�ǩ
                    //var Content = '<div><p style="margin:0;line-height:1.5;font-size:13px;text-indent:2em"><br/>���˻���ţ�'+data.drones[0].code+'<br/>���ȣ�'+data.drones[0].longitude+'<br/>γ�ȣ�'+data.drones[0].latitude+'<br/>�ٶ�<br/>���ͼ�겥����Ƶ��</p></div>' 
					//addMouseoverHandler(marker[i], Content);
					marker[i].addEventListener("click", function (){
						if(eCharts.style.visibility="hidden"){
	                   		eCharts.style.visibility="visible";
	                   	}
					  	myvideo = document.getElementById("video");  
	                   	if(myvideo.style.visibility="hidden"){
	                   		myvideo.style.visibility="visible";
	                   	}
	                   	else if(myvideo.style.visibility="visible")
	                   		myvideo.style.visibility="hidden";
	          			});					 					
						
					}	
		}	
		}); 	
    
	}
	
   function init() {	
  		getUnmans();
		setInterval("getUnmans()",60000) ;//�趨ÿһ����ˢ��һ��
	} 

  
			
	

	

	
</script>


