$(function(){
    showDate();
    $("#drop_down,#drop_list").mouseover(function(){//����ƶ���select���еĲ���
        $(".js_list001").show();//ʹ������optionѡ��show����                
    });
    $("#drop_down,#drop_list").mouseout(function(){//����ƿ���select����Ϊ
         $(".js_list001").hide();        
    });
    
    $("#p1").click(function(){
    	
    	 if($(".userlist").css("display")=="none"){
    	        $("#userlist").slideToggle("slow");
    	      
    	    }
    	 $(".overlay").height(document.body.scrollHeight);
    	 $(".overlay").width(document.body.scrollWidth);
    	 console.log(document.body.scrollWidth);
    	  // fadeTo��һ������Ϊ�ٶȣ��ڶ���Ϊ͸����
    	  // ���ط�ʽ����͸���ȣ���֤�����ԣ���Ҳ�����޸��鷳������
    	  $(".overlay").fadeTo(200, 0.5);
    	  // ���������Сʱ�Ŵ��ȫ�����ֵ�����
    	  // ����˵�����Ǵ������õ�����
    	  $(window).resize(function(){
    	    $(".overlay").height(document.body.scrollHeight);
    	    $(".overlay").width(document.body.scrollWidth);
    	  });
    	 closewindow();
    });  
    
    $("#p2").click(function(){
   	 if($(".userlist").css("display")=="none"){
   	        $("#rolelist").slideToggle("slow");
   	        
   	    } 
   	showBg();
   	closewindow();
    });   
    
    $("#p3").click(function(){
      	 if($(".userlist").css("display")=="none"){
      	        $("#privilegelist").slideToggle("slow");
      	     
      	    }
      	$(".overlay").height(document.body.scrollHeight);
   	 $(".overlay").width(document.body.scrollWidth);
   	 console.log(document.body.scrollWidth);
   	  // fadeTo��һ������Ϊ�ٶȣ��ڶ���Ϊ͸����
   	  // ���ط�ʽ����͸���ȣ���֤�����ԣ���Ҳ�����޸��鷳������
   	  $(".overlay").fadeTo(200, 0.5);
   	  // ���������Сʱ�Ŵ��ȫ�����ֵ�����
   	  // ����˵�����Ǵ������õ�����
   	  $(window).resize(function(){
   	    $(".overlay").height(document.body.scrollHeight);
   	    $(".overlay").width(document.body.scrollWidth);
   	  });
   	 closewindow();
      	 
    }); 
   
 })
 
 function closewindow()
{	
	 $(".title_sample a img").click(function (){
	        
         $(this).parent().parent().parent().hide("slow");
         $(".overlay").fadeOut(200);
 });
}

function showBg(){
	var bh=$("body").height();
	var bw=$("body").width();
	$(".overlay").css({
		height:bh,
		width:bw,
		display:"block",
	});
}
function ale(){
	alert("��ҳ����ʱδ���ţ�");
 }

 function showDate()
{
	var dt=new Date();
	var day;
	switch(dt.getDay())
	{
	case 0:
	day="��";
	break;
	case 1:
	day="һ";
	break;
	case 2:
	day="��";
	break;
	case 3:
	day="��";
	break;
	case 4:
	day="��";
	break;
	case 5:
	day="��";
	break;
	case 6:
	day="��";
	break;
	}
	$("#myDate").text("����"+day+" "+dt.getFullYear()+"-"+(dt.getMonth() + 1)+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes()+":"+dt.getSeconds());
}

function doLogout(){
	var result = confirm("������ʾ��Ϣ:�Ƿ�ȷ���˳���ϵͳ��");
	if(result == false){
		return false;
	}
	$.ajax({
		type: "post",
		url: "/droneSystem/UserServlet.do?method=5&time=" + new Date().getTime(),
		dataType: "json",	//�������������ݵ�Ԥ������
		beforeSend: function(XMLHttpRequest){
			//ShowLoading();
		},
		success: function(data, textStatus){
			window.location.href="/droneSystem/";
		},
		complete: function(XMLHttpRequest, textStatus){
			//HideLoading();
		},
		error: function(){
			//���������
		}
	});
}