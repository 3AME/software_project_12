/**
 * Created by 33826 on 2019/5/14.
 */
var module="agriculture";
var sub="alarm";
var existResultset="0";//record_list默认是新查询，查询功能就是url置1了，函数里面要再获取一遍最新值
jQuery(document).ready(function() {
    Metronic.init(); // init metronic core componets
    Layout.init(); // init layout
    Demo.init(); // init demo features

    Page.init();
    Record.init();
});

/* ================================================================================ */
var Record = function() {
    var userId;
    var userName;
    var recordCount=0;
    var html="";
    /*
    var initRecordListHeader = function() {
        var html="";
        html=html+"						<tr>";
        html=html+"							<th class=\"table-checkbox\"><input type=\"checkbox\" class=\"group-checkable\" data-set=\"#record_list .checkboxes\" /></th>";
        html=html+"							<th>事项标题</th>";
        html=html+"							<th>内容</th>";
        html=html+"							<th>类型</th>";
        html=html+"							<th>完成时间</th>";
        html=html+"							<th>限制时间</th>";
        html=html+"							<th>完成标志</th>";
        html=html+"						</tr>";
        $("#record_list_head").html(html);
    };
    */

    //显示记录相关函数开始，有用
    var initRecordList=function(){
        existResultset=$("#exist_resultset").val();//获取页面上的
        $('#example').DataTable( {
            "language": {
                "lengthMenu": "Display _MENU_ records per page",
                "zeroRecords": "Nothing found - sorry",
                "info": "Showing page _PAGE_ of _PAGES_",
                "infoEmpty": "No records available",
                "infoFiltered": "(filtered from _MAX_ total records)"
            }
        } );

        var table = $('#sample_1');
        // begin first table
        table.dataTable({
            bFilter: false,
            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "在表中没有找到数据",
                "info": "显示从 _START_ 条到 _END_ 在总共 _TOTAL_ 条中",
                "infoEmpty": "没有数据",
                "infoFiltered": "（从总共的 _MAX_ 条记录中筛选出）",
                "lengthMenu": "一页显示 _MENU_ 条数据",
                "search": "查询：",
                "zeroRecords": "没有找到匹配记录",
                "paginate": {
                    "previous":"Prev",
                    "next": "Next",
                    "last": "Last",
                    "first": "First"
                }
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
            // So when dropdowns used the scrollable div should be removed.
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

            "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.

            "columns": [{"mRender": function(data, type, full) {
                sReturn =
                    '<div style="width:100px;">' +
                        '<input type="checkbox" class="checkboxes" value="'+data+'"/>' +
                        '<a href="javascript:Record.modifyRecord('+data+')"><i class=\"icon-list\"></i></a>' +
                        '<a href="javascript:Record.modifyRecord('+data+')"><span class=\"\" title="修改"><i class=\"icon-pencil\"></i></span></a>' +
                        '<a href="javascript:Record.deleteRecord('+data+')"><span class=\"\" title="删除"><i class=\"icon-trash\"></i></span></a>' +
                    '</div>';
                return sReturn;
            },"orderable": false
            }, {
                "orderable": true
            }, {
                "orderable": false
            }, {
                "orderable": false
            }, {
                "orderable": false
            }, {
                "orderable": true
            }],
            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": 5,
            "pagingType": "bootstrap_full_number",
            "columnDefs": [{  // set default column settings
                'orderable': false,
                'targets': [0]
            }, {
                "searchable": false,
                "targets": [0]
            }],
            "order": [
                [1, "asc"]
            ], // set first column as a default sort by asc
            "fnDrawCallback": function(){$(".checkboxes").uniform();$(".group-checkable").uniform();},
            "fnServerData":function (sSource, aoData, fnCallback, oSettings) {
                $.ajax({
                    "dataType": 'json',
                    "type": "POST",
                    "url": sSource,
                    "data": aoData,
                    "success": function(json){
                        if(json.result_code==0){
                            Record.userId=json.user_id;
                            Record.userName=json.user_name;
                            var list=json.aaData;
                            console.log(list);
                            if(list.length>0){
                                Record.recordCount=list.length;
                                //这里进行数据处理显示
                                fnCallback(json);
                            }else{}
                        }else{
                            Frame.processError(json);
                        }
                    }
                });
            },
            "sAjaxSource": "../../"+module+"_"+sub+"_servlet_action?action=get_record&exist_resultset="+existResultset
        });

        var tableWrapper = jQuery('#sample_1_wrapper');

        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).attr("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).attr("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
            jQuery.uniform.update(set);
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });

        tableWrapper.find('.dataTables_length select').addClass("form-control input-xsmall input-inline"); // modify table per page dropdown

    }

    //显示记录相关函数结束
    //添加记录相关函数开始
    var addNew=function(){
        var projectId=encodeURI(document.getElementById("project_id").value);
        var title=encodeURI(document.getElementById("title").value);
        var content=encodeURI(document.getElementById("content").value);
        var executor=encodeURI(document.getElementById("executor").value);
        var beginTime=encodeURI(document.getElementById("begin_time").value);
        var endTime=encodeURI(document.getElementById("end_time").value);
        var expectEndTime=encodeURI(document.getElementById("expect_end_time").value);
        var endTag=document.getElementById("end_tag").value;
        var status=encodeURI(document.getElementById("status").value);
        var url="../../"+module+"_"+sub+"_servlet_action?action=add_record"+
            "&project_id="+projectId+"&title="+title+"&content="+content+"&executor="+
            executor+"&begin_time="+beginTime+"&end_time="+endTime+"&expect_end_time="+expectEndTime+"&end_tag="+endTag+"&status="+status;
        $.post(url,function(e){processAddRecordResult(e);}).error(function(XMLHttpRequest, textStatus, errorThrown){
            alert("addNew()发生错误："+XMLHttpRequest.status+","+XMLHttpRequest.readyState+","+textStatus);
        })
    }
    var processAddRecordResult=function(data){
        window.location.reload();
    }
    //添加记录相关函数结束
    //删除记录相关函数开始，有用
    var deleteRecord=function(id){
        var selectedCount=0;
        if(id!=null){
            selectedCount=1;
            var url="../../"+module+"_"+sub+"_servlet_action?action=delete_record&id="+id;
        }else{
            var set = $('.sample_1').find('.group-checkable').attr("data-set");
            console.log("set:"+set);
            var url="../../"+module+"_"+sub+"_servlet_action?action=delete_record";
            jQuery(set).each(function () {
                var checked = $(this).attr("checked");
                if (checked) {
                    var id=this.value;
                    url=url+"&id="+id;
                    selectedCount++;
                } else {
                }
            });
        }
        if(selectedCount>0){
            var tip="";
            if(selectedCount==1){
                tip="您确定要删除这个记录吗？";
            }else{
                tip="您确定要删除这 "+selectedCount+" 条记录吗？";
            }
            if(confirm(tip)){
                $.post(url,function(e){processDeleteRecordResult(e);}).error(function(XMLHttpRequest, textStatus, errorThrown){
                    alert("deleteRecord()发生错误："+XMLHttpRequest.status+","+XMLHttpRequest.readyState+","+textStatus);
                })
            }
        }
    }
    var processDeleteRecordResult=function(json){
        if(json.result_code==0){
            window.location.href="record_list.jsp";
        }
    }
    //删除记录相关函数结束
    //show相关函数开始
    var showRecord=function(){
        var set = $('.datatable').find('.group-checkable').attr("data-set");
        var id=null;
        jQuery(set).each(function () {
            var checked = $(this).attr("checked");
            if (checked) {
                id=this.value;
            } else {
            }
        });
        if(id!=null){
            showRecordById(id);
        }
    }
    var showRecordById=function(id){
        var url="../../"+module+"_"+sub+"_servlet_action?action=get_record_by_id&id="+id;
        $.post(url,function(e){processShowRecordById(e);}).error(function(XMLHttpRequest, textStatus, errorThrown){
            alert("processShowRecordById()发生错误："+XMLHttpRequest.status+","+XMLHttpRequest.readyState+","+textStatus);
        })
    }
    var processShowRecordById=function(data){
        data=eval("("+data+")");
        var list=data.aaData;
        document.getElementById("id").value=list[0][0];
        document.getElementById("project_id").value=list[0][1];
        document.getElementById("title").value=list[0][2];
        document.getElementById("content").value=list[0][3];
        document.getElementById("begin_time").value=list[0][4];
        document.getElementById("end_time").value=list[0][5];
        document.getElementById("expect_end_time").value=list[0][6];
        document.getElementById("executor").value=list[0][7];
        document.getElementById("end_tag").value=list[0][8];
        document.getElementById("status").value=list[0][9];
    }
    //show相关函数结束
    //修改相关函数开始
    var modifyRecord=function(id){
        window.location.href=sub+"_view.jsp?id="+id;
    }
    var processModifyRecordResult=function(data){
        var json=eval("("+data+")");
        if(checkSession(json)){
            window.location="../../home/main/login.jsp";
        }
        if(json.result_code==0){
            window.location.reload();
        }
    }
    var checkSession=function(json){
        var ok=true;
        if(json.result_code==3){
            ok=false;
        }
        return ok;
    }
    //修改相关函数结束

    var sortRecord=function(sortName){
        var id=$("#id").val();
        console.log(id);
        var url="../../"+module+"_"+sub+"_servlet_action?action=get_record&id="+id+"&order_by="+sortName;
        console.log(url);
        $.post(url,function(json){
            console.log("返回的json"+JSON.stringify(json));
            Record.showResult(json);
        });
    };
    var exportRecord=function(){

            window.location.href="../../"+module+"_"+sub+"_servlet_action?action=export_record&exist_resultset=1";

    }
    return {
        init: function() {
            //initRecordListHeader();
            initRecordList();
        },
        deleteRecord:function(id){
            deleteRecord(id);
        },
        addNew:function(){
            addNew();
        },
        modifyRecord:function(id){
            modifyRecord(id);
        },
        showRecord:function(){
            showRecord();
        },
        showResult:function(json){
            showResult(json);
        },
        sortRecord:function(sortName){
            sortRecord(sortName);
        },
        exportRecord:function(){
            exportRecord();
        }
    };
}();
/*================================================================================*/
var Page = function() {
    var layout=2;
    var initPageStyle = function() {
        //hideFrameNav();
    };
    var hideFrameNav=function(){
        //根据需要隐藏掉一些不需要的面板
        //隐藏顶部菜单栏
        $("#page_top_div").hide();
        //隐藏旁边的菜单栏
        $("#page_sidebar_wrapper_div").hide();
        //隐藏page header
        $("#page_header_div").hide();
        //隐藏按钮工具
        $("#tool_button_div").hide();
        //隐藏掉风格板块
        $("#style_customizer_div").hide();
    };
    var handleButtonEvent=function(){
        $('#return_button').click(function() {Page.confirmBack();});
        $('#search_button').click(function() {Page.searchRecord();});
        $('#delete_button').click(function() {Record.deleteRecord();});
        $('#add_button').click(function() {Page.addRecord();});
        $('#submit_button').click(function() {Page.submitRecord();});
        $('#tools_menu_reload').click(function() {Page.reload();});
        $('#help_button').click(function() {Page.help();});
        $('#export_button').click(function() {Page.exportRecord();});
        $('#statistic_button').click(function() {Page.statisticRecord();});
        $('#layout_button').click(function() {Page.layoutRecord();});
        $('#print_button').click(function() {Page.printRecord();});
        $('#sort_button').click(function() {Page.sortRecord();});
        $('#clean_search').click(function() {Page.cleanSearch();});
    };
    var layoutRecord=function(){
        if(layout==1)
            window.location.href="record_list.jsp";
        if(layout==2)
            window.location.href=sub+"_list.jsp";
    }

    var searchRecord=function(){
        window.location.href=sub+"_query.jsp";
    };

    var sortRecord=function(){//Page里的函数处理排序规则，传给Record里的函数
        var sortName=undefined;
        sortName=$("#sort_01").val();//register_time,user_name,role_id
        if($("#sort_02").val()!=null) sortName=sortName+","+$("#sort_02").val();
        if($("#sort_02").val()!=null) sortName=sortName+","+$("#sort_03").val();
        console.log(sortName);
        Record.sortRecord(sortName);
    };

    var addRecord=function(){
        window.location.href=sub+"_add.jsp";
    };

    var printRecord=function(){

        var url="../../"+module+"_"+sub+"_servlet_action?action=get_record&exist_resultset=1";
        $.post(url,function(json){
            if(json.result_code==0){
                var list=json.aaData;
                var length=list.length;
                if(length==0) alert("记录为空不能打印");
                else window.location.href=sub+"_print_table.jsp?exist_resultset=1";
            }else{
                if(Page!=null){
                    Page.processError(json);
                }
            }
        })
//post里面的内容总是在最后运行
    };
    var handleMessage=function(){
        var message=$("#result_msg").val();
        console.log(message);
        if(message=="导出成功")
        {
            alert("导出成功");
        }
        if(message=="添加成功")
        {
            alert("添加成功");
        }
        if(message=="修改成功")
        {
            alert("修改成功");
        }
    };
    var statisticRecord=function(){
        window.location.href="../statistic/"+sub+"_statistic_query.jsp";
    }
    return {
        init: function() {
            handleMessage();
            initPageStyle();
            handleButtonEvent();
        },
        searchRecord:function(){
            searchRecord();
        },
        layoutRecord:function(){
            layoutRecord();
        },
        reload:function(){
            console.log("reload");
            window.location.reload();
        },
        sortRecord:function (){
            sortRecord();
        },
        addRecord:function(){
            addRecord();
        },
        exportRecord:function(){
            Record.exportRecord();
        },
        printRecord:function(){
            printRecord();
        },
        cleanSearch:function(){
            window.location.href="record_list.jsp";
        },
        statisticRecord:function(){
            statisticRecord();
        }
    }
}();
/*================================================================================*/
