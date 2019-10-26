/**
 * Created by 33826 on 2019/6/7.
 */
var Frame = function() {
    //一些公共变量，框架用到的，例如状态等
    var html="";
    var userId=null;
    var userName=null;
    var currentPageUrl=null;
    var initFrameStyle = function() {
        $(".page-content-single").css("background-color","#fff");
        $(".page-content-single").css("margin-left","0px");
        $(".page-content-single").css("margin-top","0px");
        $(".page-content-single").css("min-height","600px");
        $(".page-content-single").css("padding","25px 20px 10px 20px");
    };
    var getParameter=function(param){
        var paramValue="";
        var url=window.location.search;
        if(url.indexOf("?")!=-1)
        {
            var str = url.substr(1)
            strs = str.split("&");
            var key=new Array(strs.length);
            var value=new Array(strs.length);
            for(i=0;i<strs.length;i++)
            {
                key[i]=strs[i].split("=")[0]
                value[i]=unescape(strs[i].split("=")[1]);  //key[i]和value[i]分别是上个页面或者URL传过来的参数名和参数
                if(key[i]==param){
                    paramValue=value[i];
                }
            }
        }
        return paramValue;
    };
    var getSystemStatus=function(){
        var url="../../common_data_action?action=get_system_status";
        $.post(url,function(data){
            var json=eval("("+data+")");
            var list=json.aaData;
            if(list!=null){}
        });
    };
    var getUserStatus=function(){
        var url="../../user_center_data_action?action=get_user_status";
        $.post(url,function(data){
            var json=eval("("+data+")");
            var list=json.aaData;
            userName=json.user_name;
            userId=json.user_id;
            showUser(userName);
            showUserAvatar(json.user_avatar);
            showUserNoticeList(json.aaNoticeData);
            showUserModuleStatus(json.aaModuleData);
            showUserBlogStatus("0");
            if(list!=null){}
        });
    };
    var getUserResource=function(){
        var url="../../user_center_data_action?action=get_user_resource";
        $.post(url,function(data){
            //console.log(JSON.stringify(data));
            if(data.result_code==0){
                var list=data.aaData;
                if(list){showUserResourceList(list);}
            }else{
                alert(data.result_msg);
            }
        });
    };
    var showUser=function(userName){
        var obj=$("#current_user");
        if(obj){
            obj.html(userName);
        }else{}
    };
    var showUserAvatar=function(userAvatar){
        var obj=$("#current_user_avatar");
        if(obj){
            obj.attr("src",userAvatar);
        }else{}
    };
    var showUserBlogStatus=function(unreadCount){	//博客未读评论数量
        var obj=$("#unread_blog_notice");
        if(obj){
            if(parseInt(unreadCount)>0){
                obj.html(unreadCount);
                obj.show();
            }
            else{
                obj.hide();
            }
        }else{}
    };
    var showUserModuleStatus=function(list){
        var count=0;
        if(list.length>0){
            for(var i=0;i<list.length;i++){
                count=count+showUserModule(list[i]);
            }
        }
        if(count>0){
            $("#unread_notice").html(count);
        }else{
            $("#unread_notice").hide();
        }
    }
    var showUserModule=function(json){
        return json[2];
    }
    var showUserNoticeList=function(list){
        html=$("#user_notice_div").html();
        var count=0;
        if(list.length>0){
            //notice_id,notice_title,count,action_type,action
            for(var i=0;i<list.length;i++){
                count=showUserNotice(list[i]);
            }
        }
        $("#user_notice_div").html(html);
        if(count>0){
            $("#user_notice_div_count").html(count);
            $("#user_notice_div_count_tip").html(count);
        }else{
            $("#user_notice_div_count").hide();
            $("#user_notice_div_count_tip").html("0");
        }
    }
    var showUserNotice=function(json){
        html=html+"						<li>";
        html=html+"							<ul class=\"dropdown-menu-list scroller\" style=\"height: 250px;\" data-handle-color=\"#637283\">";
        html=html+"								<li onclick=\"window.location.href='"+json[5]+"?action="+json[0]+"&content="+json[3]+"'\">";
        html=html+"									<a href=\"javascript:;\">";
        html=html+"									<span class=\"time\" style=\"width:20px;height:20px;background:red;color:#FFF;border-radius:50%!important;\">"+json[2]+"</span>";
        html=html+"									<span class=\"details\">";
        html=html+"									<span class=\"label label-sm label-icon label-success\">";
        html=html+"									<i class=\"fa fa-plus\"></i>";
        html=html+"									</span>";
        html=html+"									"+json[1]+"</span>";
        html=html+"									</a>";
        html=html+"								</li>";
        html=html+"							</ul>";
        html=html+"						</li>";
        return json[2];
    }
    var showUserResourceList=function(list){
        var currentPage=window.location.href;
        for(var i=0;i<list.length;i++){
            var pageUrl=list[i][3];
            if(currentPage.indexOf(pageUrl)>0){
                showResource(list[i]);
            }else{}
        }
    };
    var showResource=function(json){
        var obj=$("#"+json[1]);
        if(obj)
            obj.show();
    };
    var returnWeiXin=function(){
        WeixinJSBridge.call('closeWindow');
    };
    var showMsg= function(msg){
        $("#portlet-config #content_div").html(msg);
        $("#portlet-config").modal("show");
    }
    var showModal= function(msg){
        $("#portlet_modal_msg #content_div").html(msg);
        $("#portlet_modal_msg").modal("show");
    }
    var showConfirm= function(msg){
        $("#portlet_modal_confirm #content_div").html(msg);
        $("#portlet_modal_confirm").modal("show");
    }
    var isWeiXin=function(){
        var ua = window.navigator.userAgent.toLowerCase();
        if(ua.match(/MicroMessenger/i) == 'micromessenger'){
            return true;
        }else{
            return false;
        }
    }
    var initWeiXin=function(){
        if(isWeiXin()){
            if($("#return_weixin_button")!=null)
                $("#return_weixin_button").show();
        }else{
            if($("#return_weixin_button")!=null)
                $("#return_weixin_button").hide();
        }
    }
    var processError=function(json){
        //这里Frame仅处理result_code<10的情况，其他都给具体的js去接管
        if(json.result_code==1){}
        if(json.result_code==2){}
        if(json.result_code==3){
            //session超时了
            alert("长时间没有操作导致系统需要重新登陆，请您前往登陆界面登陆。");
            //showMsg("长时间没有操作导致系统需要重新登陆，请您前往登陆界面登陆。");
            window.location.href="../../home/login.jsp";
        }
    };
    var logVisit=function(){
        var url="../../security_log_servlet_action?action=log_visit&page_url="+window.location.pathname;
        $.post(url,function(data){
            var json=eval("("+data+")");
            if(json.result_code==0){
            }else{
                processError(json);
            }
        });
    };
    return {
        init: function(module,sub) {
            initFrameStyle();
            initLeftMenu(module);
            getSystemStatus();
            //getUserStatus();
            //getUserResource();
            //initWeiXin();
            //logVisit();
            DraggableDialog.init();
        },
        processError:function(json){
            processError(json);
        },
        returnWeiXin:function(){returnWeiXin();},
        hideWaitTip:function(){},
        getUserId:function(){return userId},
        getUserName:function(){return userName},
        showWaitTip:function(){},getParameter:function(param){return getParameter(param);},
        showMsg:function(msg){showMsg(msg);},
        isWeiXin:function(){return isWeiXin();}
    };
}();


