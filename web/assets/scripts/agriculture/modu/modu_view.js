/**
 * Created by 33826 on 2019/6/8.
 */

var module="agriculture";
var sub="modu";
jQuery(document).ready(function() {
    Metronic.init(); // init metronic core components
    Layout.init(); // init current layout

    Demo.init(); // init demo features

    ComponentsPickers.init();	//这个本页面要编写对应的对象

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
        var a = UrlParam.paramValues("id");
        console.log(a);
        var id=$("#id").val();
        console.log(id);
        getRecordViewById(id);
    }
    var getRecordViewById = function(id){
        var url="../../"+module+"_"+sub+"_servlet_action?action=get_record_view&id="+id+"&exist_resultset=1";
        getRecordView(url);
    }
    var getRecordViewByIndex = function(index){
        var url="../../"+module+"_"+sub+"_servlet_action?action=get_record_view&index="+index+"&exist_resultset=1";
        getRecordView(url);
    }
    var getRecordView = function(url){
        Metronic.startPageLoading({message: '正在查询中，请稍候...'});	//开始等待动画
        $.post(url,function(json){
            if(json.result_code==0){
                Record.userId=json.user_id;
                Record.userName=json.user_name;
                Record.firstId=json.first;
                Record.prevId=json.prev;
                Record.nextId=json.next;
                Record.lastId=json.last;
                Record.totalCount=json.total;
                Record.currentId=json.current_index;
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
        window.location.href=sub+"_view.jsp?id="+id;
    };
    var deleteRecord = function(id){
        if(confirm("您确定要删除这条记录吗？")){
            if(id>-1){
                $.post("../../"+module+"_"+sub+"_servlet_action?action=delete_record&id="+id,function(json){
                    if(json.result_code==0){
                        window.location.href=sub+"_list.jsp";
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
    var first=function(){
        getRecordViewByIndex(Record.firstId);
    }
    var prev=function(){
        getRecordViewByIndex(Record.prevId);
    }
    var next=function(){
        getRecordViewByIndex(Record.nextId);
    }
    var last=function(){
        getRecordViewByIndex(Record.lastId);
    }
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
        first:function(){first();},
        prev:function(){prev();},
        next:function(){next();},
        last:function(){last();},
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
    var nowid;
    var html="";
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

        $('#first_button').click(function() {Page.first();});
        $('#prev_button').click(function() {Page.prev();});
        $('#next_button').click(function() {Page.next();});
        $('#last_button').click(function() {Page.last();});

        $('#print_button').click(function() {Page.printRecord();});
    };
    var addRecord=function(){
        window.location.href=sub+"_add.jsp";
    }
    var showResult=function(json){
        var title="记录显示";
        if($("#title_div")) $("#title_div").html(title);
        if(json!=null){
            var list=json.aaData;
            //console.log(list);
            var tip="当前查询到了 "+json.count+" 条记录";
            tip=tip+"，现在是第 "+(parseInt(Record.currentId)+1)+" 条记录。";//当前记录的序号，不是id
            //console.log(tip);
            if($("#tip_div")) $("#tip_div").html(tip);
            if($("#record_list_tip")) $("#record_list_tip").html(tip);
            showRecordList(list);
        }
    };
    var showRecordList=function(list){

        for(var i=0;i<list.length;i++){
            showRecord(list[i]);
        }

    };
    var showRecord = function(json){
        var id=json[0];
        nowid=id;
        console.log(nowid);
        var image="../../assets/module/img/public/logo.jpg";
        var moduleName=json[1];
        var roleId=json[2];
        var categoryId=json[3];
        var parentCategoryId=json[4];
        var filePath=json[5];
        var hreflink=json[6];
        var fileId=json[7];//全id
        var fileName=json[8];//模块名


        //var me=json[11];
        $("#MODULE_NAME").val(moduleName);
        $("#role_id").val(roleId);
        $("#CATEGORY_ID").val(categoryId);
        $("#PARENT_CATEGORY_ID").val(parentCategoryId);
        $("#FILE_PATH").val(filePath);
        $("#HREFLINK").val(hreflink);
        $("#FILE_ID").val(fileId);
        $("#FILE_NAME").val(fileName);
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
        id=$("#id").val();
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
    var printRecord=function(){

        window.location.href=sub+"_print_single.jsp?id="+nowid;
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
        first:function(){Record.first();},
        prev:function(){Record.prev();},
        next:function(){Record.next();},
        last:function(){Record.last();},
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
        printRecord:function(){
            printRecord();
        }
    }
}();//Page
/*================================================================================*/
UrlParam = function() { // url参数
    var data, index;
    (function init() {
        data = []; //值，如[["1","2"],["zhangsan"],["lisi"]]
        index = {}; //键:索引，如{a:0,b:1,c:2}
        var u = window.location.search.substr(1);
        if (u != '') {
            var params = decodeURIComponent(u).split('&');
            for (var i = 0, len = params.length; i < len; i++) {
                if (params[i] != '') {
                    var p = params[i].split("=");
                    if (p.length == 1 || (p.length == 2 && p[1] == '')) {// p | p= | =
                        data.push(['']);
                        index[p[0]] = data.length - 1;
                    } else if (typeof(p[0]) == 'undefined' || p[0] == '') { // =c 舍弃
                        continue;
                    } else if (typeof(index[p[0]]) == 'undefined') { // c=aaa
                        data.push([p[1]]);
                        index[p[0]] = data.length - 1;
                    } else {// c=aaa
                        data[index[p[0]]].push(p[1]);
                    }
                }
            }
        }
    })();
    return {
        // 获得参数,类似request.getParameter()
        param : function(o) { // o: 参数名或者参数次序
            try {
                return (typeof(o) == 'number' ? data[o][0] : data[index[o]][0]);
            } catch (e) {
            }
        },
        //获得参数组, 类似request.getParameterValues()
        paramValues : function(o) { // o: 参数名或者参数次序
            try {
                return (typeof(o) == 'number' ? data[o] : data[index[o]]);
            } catch (e) {}
        },
        //是否含有paramName参数
        hasParam : function(paramName) {
            return typeof(paramName) == 'string' ? typeof(index[paramName]) != 'undefined' : false;
        },
        // 获得参数Map ,类似request.getParameterMap()
        paramMap : function() {
            var map = {};
            try {
                for (var p in index) { map[p] = data[index[p]]; }
            } catch (e) {}
            return map;
        }
    }
}();