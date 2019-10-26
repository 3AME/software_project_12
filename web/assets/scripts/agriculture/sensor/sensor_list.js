/**
 * Created by 33826 on 2019/5/16.
 */
var module="agriculture";
var sub="sensor";
jQuery(document).ready(function() {
    Metronic.init(); // init metronic core componets
    Layout.init(); // init layout
    Demo.init(); // init demo features
    Search.init();//未知


    Page.init();
    Record.init();
});

/*================================================================================*/
var Record = function() {
    var userId=undefined;
    var userName=undefined;
    var userRole=undefined;
    var userAvatar=undefined;
    var initRecordStyle = function() {
    };
    var initRecordList = function(){
        getRecord();
    }
    var getRecord = function(){
        Metronic.startPageLoading({message: '正在查询中，请稍候...'});	//开始等待动画
        var id=$("#id").val();
        console.log(id);
        var existResultset=$("#exist_resultset").val();
        var url="../../"+module+"_"+sub+"_servlet_action?action=get_record&id="+id+"&exist_resultset="+existResultset;
        $.post(url,function(json){
            if(json.result_code==0){
                Record.userId=json.user_id;
                Record.userName=json.user_name;
                Record.userRole=json.user_role;
                Record.userAvatar=json.user_avatar;
                Page.showResult(json);
            }else{
                if(Page!=null){
                    Page.processError(json);
                }
            }
            Metronic.stopPageLoading();	//停止等待动画
        }).error(function(xhr,errorText,errorType){
            alert('错误信息：'+errorText+",错误类型："+errorType);
        });
    };
    var viewRecord=function(id){
        window.location.href=sub+"_view.jsp?id="+id+"&exist_resultset=1";
    };
    var deleteRecord = function(id){
        if(confirm("您确定要删除这条记录吗？")){
            if(id>-1){
                $.post("../../"+module+"_"+sub+"_servlet_action?action=delete_record&id="+id,function(json){
                    if(json.result_code==0){
                        var count=json.count;
                        var amount=json.amount;
                        initRecordList();
                        initRecordStyle();
                        alert("已经从数据表删除该记录！");
                    }
                })
            }
        }
    };
    var exportRecord=function(){
        window.location.href="../../"+module+"_"+sub+"_servlet_action?action=export_record&exist_resultset=1";

    }
    var search=function(){
        page_form.submit();
    }
    var sortRecord=function(sortName){
        var id=$("#id").val();
        console.log("id in sensor_list is "+id);
        var url="../../"+module+"_"+sub+"_servlet_action?action=get_record&id="+id+"&order_by="+sortName;
        //console.log(url);
        $.post(url,function(json){
            console.log("返回的json"+JSON.stringify(json));
            Page.showResult(json);
        });
    };
    return {
        init: function() {
            initRecordList();
            initRecordStyle();
        },
        deleteRecord:function(id){
            deleteRecord(id);
        },
        viewRecord:function(id){
            viewRecord(id);
        },
        exportRecord:function(){
            exportRecord();
        },
        search:function(){
            search();
        },
        sortRecord:function(sortName){
            sortRecord(sortName);
        }
    };
}();//Record;
/* ================================================================================ */
//关于页面的控件生成等操作都放在Page里，和Record独立，Record主要是和记录集交互
var Page = function() {
    var html="";
    var layout=1;
    var initPageStyle = function() {
        hideFrameNav();
    };
    var hideFrameNav=function(){
        //根据需要隐藏掉一些不需要的面板
        //隐藏顶部菜单栏
        //$("#page_top_div").hide();
        //隐藏旁边的菜单栏
        //$("#page_sidebar_wrapper_div").hide();
        //隐藏风格设置栏
        $("#style_customizer_div").hide();
        //隐藏page header
        $("#page_header_div").hide();
        //隐藏page 底部
        $("#page_footer_div").hide();
        var displaySidebar=true;
        if(!displaySidebar){
            if($("body").hasClass("page-container-bg-solid")){
                $("body").removeClass("page-sidebar-closed-hide-logo page-container-bg-solid");
                $("body").addClass("page-full-width");
            }else{}
        }
        //隐藏提醒图标
        $("#header_inbox_bar").hide();
        $("#header_calendar_bar").hide();
    };
    var processError=function(json){
        /*if(Frame!=null)
            Frame.processError(json);*/
        alert("Error!");
    };
    var handleButtonEvent=function(){
        $('#return_button').click(function() {Page.confirmBack();});
        $('#search_button').click(function() {Page.searchRecord();});
        $('#delete_button').click(function() {Page.deleteRecord();});
        $('#add_button').click(function() {Page.addRecord();});
        $('#submit_button').click(function() {Page.submitRecord();});//无用
        $('#tools_menu_reload').click(function() {Page.reload();});
        $('#help_button').click(function() {Page.help();});
        $('#export_button').click(function() {Page.exportRecord();});
        $('#statistic_button').click(function() {Page.statisticRecord();});
        $('#layout_button').click(function() {Page.layoutRecord();});
        $('#print_button').click(function() {Page.printRecord();});
        $('#sort_button').click(function() {Page.sortRecord()});
    };
    var addRecord=function(){
        window.location.href=sub+"_add.jsp";
    }
    var showResult=function(json){
        var title="记录显示";
        if($("#title_div")) $("#title_div").html(title);
        if(json!=null){
            var list=json.aaData;////////还是aaData
            var tip="当前查询到了 "+list.length+" 条记录";
            if($("#tip_div")) $("#tip_div").html(tip);
            if($("#record_list_tip")) $("#record_list_tip").html(tip);
            showRecordList(list);
        }
    };
    var showRecordList=function(list){
        html="";
        //html时page的局部变量
        for(var i=0;i<list.length;i++){
            showRecord(list[i]);
        }

        $("#record_list_div").html(html);
    };
    var showRecord = function(json){
        console.log("the json in showRecord is "+JSON.stringify(json));

        var id=json[0];

        //var image="../../assets/module/img/public/wkbj.jpg";
        var deviceId=json[1];
        var valueType=json[2];
        var sensorValueString=json[3];
        var detectTime=json[4];
        var me=json[7];

        html=html+"		                            <div class=\"col-md-12\">";
        html=html+"                                      <div class=\"booking-result\">";
        html=html+"                                            <div class=\"booking-img\">";
        html=html+"                                                <img src=\"/assets/admin/layout4/img/jiongxianer.jpg\" alt=\"\">";
        html=html+"                                            </div>";
        html=html+"                                            <div class=\"booking-info\" style=\"overflow:hidden;\">";
        html=html+"                                                <p>设备ID："+deviceId+"</p>";
        html=html+"                                                <p>数值类型："+valueType+"</p>";
        html=html+"                                                <p>数值大小："+sensorValueString+"</p>";
        html=html+"                                                <p>检测时间："+detectTime+"</p>";
        html=html+"                                            </div>";
        html=html+"                                            <div style=\"margin:15px 0 25px 0;\">";

        if(me=="1"){
        html=html+"                                                <button  type=\"button\" class=\"btn default red-stripe\" onclick=\"Page.deleteRecord("+id+");\">删除</button>";
        html=html+"                                                <button  type=\"button\" class=\"btn default yellow-stripe\" onclick=\"Page.modifyRecord("+id+");\">修改</button>";
        }
        html=html+"                                                <button  type=\"button\" class=\"btn default purple-stripe\" onclick=\"Page.viewRecord("+id+");\">查看</button>";
        html=html+"                                            </div>";
        html=html+"                                        </div>";
        html=html+"                                    </div>";
    };
    var help=function(){
        var strUrl=location.pathname;
        window.open('../../help/online/new_win_help.jsp?page_url='+strUrl, 'big', 'fullscreen=yes');
    }
    var submitRecord=function(){
        if(checkInput()==true){
            page_form.action="../../"+module+"_"+sub+"_servlet_action";
            page_form.submit();
        }
    };
    var checkInput=function(){
        var bOk=true;
        var action=$("#action").val();
        if(action==null || action==""){Frame.showMsg("名称不能为空！");bOk=false;};
        return bOk;
    };
    var deleteRecord=function(id){
        Record.deleteRecord(id);
    };
    var viewRecord=function(id){
        Record.viewRecord(id);
    };
    var modifyRecord=function(id){
        window.location.href=sub+"_view.jsp?id="+id;
    };
    var searchRecord=function(){
        window.location.href=sub+"_query.jsp";
    };
    var statisticRecord=function(){
        window.location.href="../statistic/"+sub+"_statistic_query.jsp";
    }
    var layoutRecord=function(){
        if(layout==1)
            window.location.href="record_list.jsp";
        if(layout==2)
            window.location.href=sub+"_list.jsp";
    }
    var printRecord=function(){
        window.location.href=sub+"_print_table.jsp?exist_resultset=1";
    };
    var confirmBack=function(){
        DraggableDialog.setId("confirm_back");
        DraggableDialog.setCancel(Page.onCancel);
        DraggableDialog.setButtonTitle("确定","取消");
        DraggableDialog.setOk(Page.returnBack);
        DraggableDialog.showMsg("确定要返回上一页吗？","提示");
    };
    var onCancel=function(){
        DraggableDialog.close();
    }
    var returnBack=function(){
        history.go(-1);
    };
    var sortRecord=function(){//Page里的函数处理排序规则，传给Record里的函数
        var sortName=undefined;
        sortName=$("#sort_01").val()+","+$("#sort_02").val()+","+$("#sort_03").val();//register_time,user_name,role_id
        console.log("sortName in sensor_list is "+sortName);
        Record.sortRecord(sortName);
    };
    return {
        init: function() {
            initPageStyle();
            handleButtonEvent();
        },
        processError:function(json){
            processError(json);
        },
        showResult:function(json){
            showResult(json);
        },
        showRecordList:function(list){
            showRecordList(list);
        },
        submitRecord:function(){
            submitRecord();
        },
        addRecord:function(){
            addRecord();
        },
        deleteRecord:function(id){
            deleteRecord(id);
        },
        viewRecord:function(id){
            viewRecord(id);
        },
        searchRecord:function(){
            searchRecord();
        },
        exportRecord:function(){
            Record.exportRecord();
        },
        statisticRecord:function(){
            statisticRecord();
        },
        printRecord:function(){
            printRecord();
        },
        modifyRecord:function(id){
            modifyRecord(id);
        },
        reload:function(){
            window.location.reload();
        },
        layoutRecord:function(){
            layoutRecord();
        },
        confirmBack:function(){
            confirmBack();
        },
        returnBack:function(){
            returnBack();
        },
        onCancel:function(){
            onCancel();
        },
        help:function(){
            help();
        },
        sortRecord:function (){
            sortRecord();
        }
    }
}();//Page
/*================================================================================*/
