<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

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
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jwTcIoGGL3WahiyCb2Hg7juZi1TGym0Y" charset="utf-8"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon2.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/video-js.css" >
	
    <script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<script type="text/javascript" src="../JScript/upload.js"></script>
	<script src="http://echarts.baidu.com/build/dist/echarts-all.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../JScript/json2.js"></script>
    <script type="text/javascript" src="http://vjs.zencdn.net/5.18.4/video.min.js"></script>
    <title>������Ϣ</title>
</head>
<body>
	<div style="width:2150px; height:650px;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td>
	 <div id="allmap"  style="width: 650px; height: 650px"></div>
	</td>
	<td>
	 <div id="video" style="width:650px;height:650px">
	  <video id="my-video" class="video-js vjs-default-skin" controls="controls" preload="auto" title="���˻���Ƶ"  width="650px" height="650px"
		  poster="http://video-js.zencoder.com/oceans-clip.png" data-setup="{}">
		 <source src="../Inc/test.mp4" type="video/mp4">
				<!-- <source src="rtmp://live.hkstv.hk.lxdns.com/live/hks" type="rtmp/flv">-->
			<p class="vjs-no-js">
			  To view this video please enable JavaScript, and consider upgrading to a web browser that
			  <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
			</p>
		  </video>
		 

<!-- 	<object type='application/x-vlc-plugin' id='vlc' events='True' width="650" height="650" pluginspage="http://www.videolan.org" codebase="http://downloads.videolan.org/pub/videolan/vlc-webplugins/2.0.6/npapi-vlc-2.0.6.tar.xz">
        <param name='mrl' value='rtsp://localhost:8554/123' />
        <param name='volume' value='50' />
        <param name='autoplay' value='true' />
        <param name='loop' value='false' />
        <param name='fullscreen' value='false' />
    </object>
 -->
	 </div>
	</td>
	<td>
		<div id="eCharts" style="width:850px;height:650px;" >
		    <table>  
		       <tr><td><div id="echarts1" style="width:850px;height:650px"></div></td></tr>   
		   </table> 
		</div>
	</td>
   </tr>
  </table>
 </div>
</body>
</html>

<script type="text/javascript">
    // �ٶȵ�ͼAPI����
    function G(id) {
        return document.getElementById(id);
    }
    var timer=1;
	var videoId = 0;
	init();
    var map = new BMap.Map("allmap");
   map.setMapStyle({
    styleJson:[
          {
                    "featureType": "land",
                    "elementType": "geometry",
                    "stylers": {
                              "color": "#e7f7fc"
                    }
          },
          {
                    "featureType": "water",
                    "elementType": "all",
                    "stylers": {
                              "color": "#96b5d6"
                    }
          },
          {
                    "featureType": "green",
                    "elementType": "all",
                    "stylers": {
                              "color": "#b0d3dd"
                    }
          },
          {
                    "featureType": "highway",
                    "elementType": "geometry.fill",
                    "stylers": {
                              "color": "#a6cfcf"
                    }
          },
          {
                    "featureType": "highway",
                    "elementType": "geometry.stroke",
                    "stylers": {
                              "color": "#7dabb3"
                    }
          },
          {
                    "featureType": "arterial",
                    "elementType": "geometry.fill",
                    "stylers": {
                              "color": "#e7f7fc"
                    }
          },
          {
                    "featureType": "arterial",
                    "elementType": "geometry.stroke",
                    "stylers": {
                              "color": "#b0d5d4"
                    }
          },
          {
                    "featureType": "local",
                    "elementType": "labels.text.fill",
                    "stylers": {
                              "color": "#7a959a"
                    }
          },
          {
                    "featureType": "local",
                    "elementType": "labels.text.stroke",
                    "stylers": {
                              "color": "#d6e4e5"
                    }
          },
          {
                    "featureType": "arterial",
                    "elementType": "labels.text.fill",
                    "stylers": {
                              "color": "#374a46"
                    }
          },
          {
                    "featureType": "highway",
                    "elementType": "labels.text.fill",
                    "stylers": {
                              "color": "#374a46"
                    }
          },
          {
                    "featureType": "highway",
                    "elementType": "labels.text.stroke",
                    "stylers": {
                              "color": "#e9eeed"
                    }
          }
     ]
    });
    map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(111.755933, 40.848919), 11);                   // ��ʼ����ͼ,���ó��к͵�ͼ����

	var ctrl = new BMapLib.TrafficControl({
		showPanel: true //�Ƿ���ʾ·����ʾ���
	});      
	
	map.addControl(ctrl);
	ctrl.setAnchor(BMAP_ANCHOR_BOTTOM_RIGHT);  
	ctrl.showTraffic({ predictDate: { hour: 15, weekday: 5 } });
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
    
var myChart = echarts.init(document.getElementById('echarts1'));
var now = new Date();
var len = 10;
var res = [];
while (len--) {
res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
    now = new Date(now - 2000);
}
var res1 = [];
var res2 = [];
var len = 10;
while (len--) {
  res1.push(0);
  
}
var xAxisData = res; //x������
var yAxisData = res1; //y������

// ָ��ͼ��������������
var option = {
title : {
    text: '�����仯���'
},
tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:['������']
    },
    toolbox: {
        show : true,
        feature : {
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    dataZoom : {
        show : false,
        start : 0,
        end : 100
    },
    xAxis : [
        {
            type : 'category',
            boundaryGap : true,
            data:xAxisData
        }
   ],
   yAxis : [
      {
           type : 'value',
           scale: true,
           name : '������V/h',
           boundaryGap: [0.2, 0.2]
      }
  ],
  series : [
       {
            name:'������',
            type:'line',
            lineStyle: {
            normal: {
              //color: '#4F2F4F',
              width: 2
              //type: solid
            },
            },
            data:yAxisData,
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

var axisData;
var lastData = 0;
clearInterval(app);
var app = {};

myChart.setOption(option);
var opts = {
				width : 0,     // ��Ϣ���ڿ��
				height: 0,     // ��Ϣ���ڸ߶�
				title : "<span style='font-size:15px;color:#0099cc;background-color:#FFFFFF'>"+"������Ϣ����"+"</span>" , // ��Ϣ���ڱ���
				enableMessage:true//����������Ϣ�����Ͷ�Ϣ
			   };   
   
    function getUnmans(id){
	  $.ajax({
           	 	type: "post", 
               	cache: false, 
             	dataType: 'json',
             	url: '/droneSystem/DroneServlet.do?method=0',
               	data:{Id:id},
            success: function(data){
            
               //map.panTo(new BMap.Point(data.drones[0].longitude, data.drones[0].latitude));
               
			   // deletePoint();
				

				for(var i=0;i<data.drones.length;i++) { 
				    //var myIcon = new BMap.Icon("../images/drone.png", new BMap.Size(10,10));
				    //alert(i);
				    var icon = new BMap.Icon('..//images//camera.png', new BMap.Size(100, 100),{
				   
				    anchor:new BMap.Size(0,0),
                    imageOffset:new BMap.Size(0,0)});
                    icon.setImageSize(new BMap.Size(24, 24));
			        var point = new BMap.Point(data.drones[i].longitude,data.drones[i].latitude);  
			        var marker = new BMap.Marker(point,{ // ������ע��
							icon: icon
							});		
				 	map.addOverlay(marker); //��ӱ�ע
					//var label = new window.BMap.Label(data.drones[i].code, {offset: new window.BMap.Size(20, -10)}); //������ǩ   
                    var label = new window.BMap.Label("���˻����:"+data.drones[i].code,{offset: new window.BMap.Size(20, -10)});  // �����ı���ע����
		                label.setStyle({
			                  color : "#0099cc",
			                  fontSize : "14px",
			                  backgroundColor :"0.05",
			                  border:"0",			                  
			                  lineHeight : "20px",
			                  //fontWeight :"bold" //����Ӵ�
		                 });
		            marker.setLabel(label);  //��ӱ�ǩ
		            (function(){
		            var thepoint = data.drones[i];
		            marker.addEventListener("click", function (){
		            
		            map.panTo(point);
		            
					showInfo(this, thepoint);//������Ϣ����
					test();
					videojs("my-video").ready(function(){
						var myPlayer = this;
						myPlayer.play();
					});
					getEcharts();
		            });
		            })();
		            
		            function showInfo(thisMarker,point){
		             //thisMarker.setAnimation(BMAP_ANIMATION_BOUNCE);
		             var content = 
					"<p style='margin:0;line-height:1.5;font-size:13px;text-indent:0em'>���˻���ţ� "+point.code+"<br/>���ȣ�"+point.longitude+" γ�ȣ�"+point.latitude+"</br>ѩ��Ԥ���ȼ��� 2</br>״̬�� 0</p>";
					 var infoWindow = new BMap.InfoWindow(content, opts);
					 thisMarker.openInfoWindow(infoWindow);
		            }
		            
		            function getEcharts(){
		            app.timeTicket = setInterval(function (){
							  var url = '/droneSystem/DroneServlet.do?method=6';
							  var paramData={type:1};
							  $.ajax({
							      url: url,
							      type: 'post',
							      data: paramData,
							      dataType: 'json',
							      cache: false,
							      error:function(){
							          console.log("get redis error!!!");
							      },
							      success: function(data){
							          if(data != null){
							          //alert(data.ts);
							          axisData = (new Date()).toLocaleTimeString().replace(/^\D*/, '');
							          lastData = data.ts;
							         // lastData = Math.round(Math.random() * 1000);
							        
							          }
							      }
							  }); 
							    // ��̬���ݽӿ� addData
							    myChart.addData([
							        [
							            0,        // ϵ������
							            lastData, // ��������
							            false,     // ���������Ƿ�Ӷ���ͷ������
							            false,    // �Ƿ����Ӷ��г��ȣ�false���Զ�ɾ��ԭ�����ݣ���ͷ����ɾ��β����β����ɾ��ͷ
							            axisData //��������
							        ]
							       
							    ]);
							}, 2000);
		               }		
					}	
		}	
		}); 	
    
	}
	
	
	 function test(){
	  $.ajax({
       	 	type: "post", 
           	cache: false, 
           	dataType: 'json',
           	url: '/droneSystem/DroneServlet.do?method=3',
           	data:{type:3,inputStream:"D:\\test\\LL.mp4"},
            success: function(data){
            //alert(321);
         		videoId = data.videoId;
			}	
		}); 	
    
	}
	
	function test1(){
		  $.ajax({
           	 	type: "post", 
               	cache: false, 
             	dataType: 'json',
             	url: '/droneSystem/DroneServlet.do?method=5',
             	data:{type:3},
            	success: function(data){
            		//alert(data.ts);
					timer ++;
//         			alert(data.Scale);
				}	
			}); 	
	    
		}

		function test2(){
		  $.ajax({
           	 	type: "post", 
               	cache: false, 
             	dataType: 'json',
             	url: '/droneSystem/DroneServlet.do?method=6',
             	data:{type:3,videoId:videoId},
            	success: function(data){
            	//alert(videoId);
 //           		alert(videoId + data.ts);
				}	
			}); 	
	    
	}
   function init() {	
  		getUnmans();
		setInterval("getUnmans()",60000) ;//�趨ÿһ����ˢ��һ��
	} 

  	
			
	

	

	
</script>


