$(function(){
	   var myChart1 = echarts.init(document.getElementById('echarts1'),'blue');   
		var now = new Date();
		var len = 10;
		var res = [];
		
		while (len--) {
		res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
		    now = new Date(now - 2000);
		}
		var res1 = [];
		//var res2 = [];
		var len = 10;
		while (len--) {
		    res1.push(0);
		  
		}
		var xAxisData = res; //x������
		var yAxisData = res1; //y������

	
	// ָ��ͼ��������������
	var option1 = {
			title : {
			    text: '',
			    textstyle:{
			    	"fontSize":"20",
		            "fontWeight": "bolder"
		    },
			},
			tooltip : {
			    trigger: 'axis'
			    },
			    legend: {
			        data:['ʵʱ���г������仯', 'ʵʱ���г������仯'],
			        textStyle: {  
			            color: '#fff',          //legend������ɫ 
			            fontSize:'22'

			        }
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            dataView : {show: true, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        },
			        
		            itemSize:'22',
		            emphasis:{//����ʱ
		                iconStyle:{
		                    borderColor:"white"//ͼ�ε������ɫ
		                }
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
			            axisLabel: {        
			                show: true,
			                textStyle: {
			                    color: '#fff',
			                    fontSize:'20'
			                }
			            },
			        // �����������Ƿ���ʾ
				        splitLine: {
				                show: false, 
				                //  �ı�������ɫ
				                lineStyle: {
				                    // ʹ����ǳ�ļ��ɫ
				                    color: ['white']
				                }                            
				        },
			            axisLine:{
			                lineStyle:{
			                    //color:'ellow',
			                    //width:2
			                }
			            },

			            boundaryGap : true,
			            data:xAxisData
			        }
			   ],
			   yAxis : [
			      {
			           type : 'value',
			           scale: true,
			           name : '������V/h',
			           axisLabel: {        
			                show: true,
			                textStyle: {
			                    color: '#fff',
			                    fontSize:'20'
			                }
			            },
			        // �����������Ƿ���ʾ
				        splitLine: {
				                show: false, 
				                //  �ı�������ɫ
				                lineStyle: {
				                    // ʹ����ǳ�ļ��ɫ
				                    color: ['white']
				                }                            
				        },
			           boundaryGap: [0.2, 0.2]
			      },
			      {
			           type : 'value',
			           scale: true,
			           name : '������V/h',
			           axisLabel: {        
			                show: true,
			                textStyle: {
			                    color: '#fff',
			                    fontSize:'20'
			                }
			            },
			        // �����������Ƿ���ʾ
				        splitLine: {
				                show: false, 
				                //  �ı�������ɫ
				                lineStyle: {
				                    // ʹ����ǳ�ļ��ɫ
				                    color: ['white']
				                }                            
				        },
			           boundaryGap: [0.2, 0.2]
			      }
			  ],
			  series : [
			       {
			            name:"ʵʱ���г������仯",
			            type:'line',
			            
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
			            
			       },
			       {
			            name:"ʵʱ���г������仯",
			            type:'line',
			            
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
			            
			       },
			       
			  ]
			};

    myChart1.setOption(option1);
    $(window).resize(function(){
       myChart1.resize();
    });
    window.onresize = myChart1.resize();
	
	
});

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
	          //newcharts();
	          axisData = (new Date()).toLocaleTimeString().replace(/^\D*/, '');
	          lastData = data.ts;
	          //lastData = Math.round(Math.random() * 1000);
	        
	          }
	      }
	  }); 
	  // ��̬���ݽӿ� addData
      myChart1.addData([
        [
            0,        // ϵ������
            lastData, // ��������
            false,     // ���������Ƿ�Ӷ���ͷ������
            false,    // �Ƿ����Ӷ��г��ȣ�false���Զ�ɾ��ԭ�����ݣ���ͷ����ɾ��β����β����ɾ��ͷ
            axisData //��������
        ]		       
	  ]);

	}, 3000);
	}


