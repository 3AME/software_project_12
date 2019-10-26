/**
 * Created by 33826 on 2019/5/20.
 */
var module="agriculture";
var sub="weather";

jQuery(document).ready(function() {
    Metronic.init(); // init metronic core componets
    Layout.init(); // init layout
    Demo.init(); // init demo features 设置小按钮

    FormSamples.init();

    ComponentsPickers.init();//时间选择器

    Page.init();
    Record.init();
});
/*================================================================================*/
var Record = function() {
    var userId=undefined;
    var userName=undefined;
    var userRole=undefined;
    var userAvatar=undefined;

    var initRecordList = function(){
        getRecord();
    }
    var getRecord = function(){
        Metronic.startPageLoading({message: '正在查询中，请稍候...'});	//开始等待动画
        var id=$("#id").val();
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
        window.location.href="todo_view.jsp?id="+id;
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
    return {
        init: function() {
            //initRecordList();

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
        }
    };
}();//Record;
/* ================================================================================ */
//关于页面的控件生成等操作都放在Page里，和Record独立，Record主要是和记录集交互
var Page = function() {
    var html="";

    var processError=function(json){
        if(Frame!=null)
            Frame.processError(json);
    };
    var handleButtonEvent=function(){
        $('#return_button').click(function() {Page.confirmBack();});
        $('#search_button').click(function() {Page.searchRecord();});
        $('#delete_button').click(function() {Page.deleteRecord();});
        $('#add_button').click(function() {Page.addRecord();});
        $('#submit_button').click(function() {Page.submitRecord();});
        $('#tools_menu_reload').click(function() {Page.reload();});
        $('#help_button').click(function() {Page.help();});
        $('#export_button').click(function() {Page.exportRecord();});
        $('#cancel_button').click(function() {Page.resetData();});
    };
    var showResult=function(json){
        var title="记录显示";
        if($("#title_div")) $("#title_div").html(title);
        if(json!=null){
            var list=json.aaData;
            var tip="当前查询到了 "+list.length+" 条记录";
            if($("#tip_div")) $("#tip_div").html(tip);
            if($("#record_list_tip")) $("#record_list_tip").html(tip);
            showRecordList(list);
        }
    };
    var showRecordList=function(list){
        for(var i=0;i<list.length;i++){
            showRecord(list[i]);
        }
        $("#project_id").html(html);
    };
    var showRecord = function(json){
        var id=json[0];
        var projectId=json[1];
        var projectName=json[2];
        html=html+"<option value=\""+projectId+"\">"+projectName+"</option>";
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

        //var tip="操作成功";
        //confirm(tip);
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
        console.log(sub+"_query.jsp");
        window.location.href=sub+"_query.jsp";
    };
    var confirmBack=function(){
        DraggableDialog.setId("confirm_back");
        DraggableDialog.setCancel(Page.onCancel);
        DraggableDialog.setButtonTitle("确定","取消");
        DraggableDialog.setOk(Page.returnBack);
        DraggableDialog.showMsg("确定要返回上一页吗？","提示");
    };
    var initUpdateTime=function(){
        var today=new Date();
        console.log(today);
        var limitDay=ComponentsPickers.formatDateTime(today,"yyyy-MM-dd");
        $("#update_time").val(limitDay);
    };
    var onCancel=function(){
        DraggableDialog.close();
    };
    var returnBack=function(){
        history.go(-1);
    };
    var resetData=function(){
        var clickresult = false;

        clickresult =window.confirm("点击重填后所有信息都将被清空。\n你确认重填吗？");

        return clickresult;
    };
    return {
        init: function() {
            handleButtonEvent();
            initUpdateTime();
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
        reload:function(){
            window.location.reload();
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
        resetData:function(){
            resetData();
        }
    }
}();//Page
/*================================================================================*/
