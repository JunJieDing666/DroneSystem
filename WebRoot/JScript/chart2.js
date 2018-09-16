$(function(){	
	var myChart2 = echarts.init(document.getElementById('echarts2'),'blue');
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
	
	var option2 = {
	title: {
        text: '',   
        textstyle:{
            fontWeight: 'normal',              //������ɫ
            color: 'FFFFFF',
            fontSize:'25'
    },

    },
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'cross',
            label: {
            //    backgroundColor: 'F2F2F2'
            }
        }
    },
    legend: {
        data:['ÿ�������г������仯', 'ÿ�������г������仯'],
        textStyle: {  
            color: '#fff',          //legend������ɫ 
            fontSize:'22'

        }

      
    },
    toolbox: {
        show: true,
        feature: {
            dataView: {readOnly: false},
            restore: {},
            saveAsImage: {}
        },
        itemSize:'22',
        emphasis:{//����ʱ
            iconStyle:{
                borderColor:"white"//ͼ�ε������ɫ
            }
        }
    },
    dataZoom: {
        show: false,
        start: 0,
        end: 100
    },
    xAxis: [
        {
            type: 'category',
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
                    color:'#FFFFFF',
                    width:2
                }
            },


            boundaryGap: true,
            data: (function (){
                var now = new Date();
                var res = [];
                var len = 10;
                while (len--) {
                    res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
                    now = new Date(now - 2000);
                }
                return res;
            })()
        },
        {
            type: 'category',
            boundaryGap: true,
            data: (function (){
                var res = [];
                var len = 10;
                while (len--) {
                    res.push(10 - len - 1);
                }
                return res;
            })()
        }
    ],
    yAxis: [
        {
            type: 'value',
            scale: true,
            name: '������V/h',
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
            max: 30,
            min: 0,
            boundaryGap: [0.2, 0.2]
        },
        {
            type: 'value',
            scale: true,
            name: '������V/h',
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
            max: 1200,
            min: 0,
            boundaryGap: [0.2, 0.2]
        }
       
    ],
    series: [
        {
            name:'ÿ�������г������仯',
            type:'bar',
            xAxisIndex: 1,
            yAxisIndex: 1,   
            data:(function (){
                var res = [];
                var len = 10;
                while (len--) {
                    res.push(Math.round(Math.random() * 1000));
                }
                return res;
            })(),
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
            name:'ÿ�������г������仯',
            type:'bar',
            data:(function (){
                var res = [];
                var len = 0;
                while (len < 10) {
                    res.push((Math.random()*10 + 5).toFixed(1) - 0);
                    len++;
                }
                return res;
            })(),
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

app.count = 11;
setInterval(function (){
    axisData = (new Date()).toLocaleTimeString().replace(/^\D*/,'');

    var data0 = option2.series[0].data;
    var data1 = option2.series[1].data;
    data0.shift();
    data0.push(Math.round(Math.random() * 1000));
    data1.shift();
    data1.push((Math.random() * 10 + 5).toFixed(1) - 0);

    option2.xAxis[0].data.shift();
    option2.xAxis[0].data.push(axisData);
    option2.xAxis[1].data.shift();
    option2.xAxis[1].data.push(app.count++);

    myChart2.setOption(option2);
    
    $(window).resize(function(){
        myChart2.resize();
    });
    window.onresize = myChart2.resize();
}, 2100);

	
	
	

	
	   
})