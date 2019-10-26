<%--
  Created by IntelliJ IDEA.
  User: 33826
  Date: 2019/6/8
  Time: 12:19
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.*,org.json.JSONObject,org.json.JSONArray,java.util.ArrayList"%>
<%
    //做调试用，这里要在正式发布的时候去掉
    System.out.println("[" + (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new java.util.Date()) + "]=======================调试：" + request.getServletPath() + "开始==============================");
%>
<%
    String existResultset = request.getParameter("exist_resultset");
%>
<%
    //接下来从session里取json出来，循环对于json里的aaData，显示每一条记录（略）
    JSONObject jsonObj=new JSONObject();
    if(existResultset!=null && existResultset.equals("1")){
        jsonObj=(JSONObject)session.getAttribute("agriculture_modu_get_record_result");
    }
    System.out.println("获得的数据集是："+jsonObj.toString());
    JSONArray jsonArr=(JSONArray)jsonObj.get("aaData");
    System.out.println(jsonArr.toString());
    ArrayList jsonRec=(ArrayList)jsonArr.get(0);

%>

<style media=print>
    .no_print{display:none;}
    .page_next{page-break-after: always;}
</style>
<OBJECT id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0 width=0></OBJECT>
<div>
    <input type="button" class="no_print" value="打印" onclick="javascript:window.print()">
    <input type="button" class="no_print" value="返回" onclick=javascript:window.history.back()>
    <input type="button" style="display:none;" value="页面设置" onclick="javascript:WebBrowser.ExecWB(8,1)">
    <input type="button" style="display:none;" value="打印预览" onclick="javascript:WebBrowser.ExecWB(7,1)">
</div>



<html>
<head>
    <meta charset="utf-8"/>
    <title>Title</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <%--<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css">--%>
    <link href="../../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="../../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css">
    <link href="../../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="../../assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css">
    <link href="../../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
    <!-- END PAGE LEVEL STYLES -->
    <!-- BEGIN THEME STYLES -->
    <link href="../../assets/global/css/components-rounded.css" id="style_components" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/admin/layout4/css/layout.css" rel="stylesheet" type="text/css"/>
    <link id="style_color" href="../../assets/admin/layout4/css/themes/light.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/admin/layout4/css/custom.css" rel="stylesheet" type="text/css"/>
    <!-- END THEME STYLES -->
    <link rel="shortcut icon" href="favicon.ico"/>
</head>
<body>
<table class="table table-striped table-bordered table-hover sample_1" id="sample_1" style="width:80%;margin-left:10%" >
    <thead>
    <tr>
        <th>
            id
        </th>
        <th>模块名称</th>
        <th>权限</th>
        <th>id号</th>
        <th>父id号</th>
        <th>目录名</th>
        <th>文件名</th>
        <th>文件id</th>
    </tr>
    </thead>
    <tbody id="record_list_div">
    <%--tbody--%>
    </tbody>
    <tfoot>
    <tr style="font-size: 14px;">
        <th>
            id
        </th>
        <th>模块名称</th>
        <th>权限</th>
        <th>id号</th>
        <th>父id号</th>
        <th>目录名</th>
        <th>文件名</th>
        <th>文件id</th>
    </tr>
    </tfoot>
</table>


<div>
    <span style="margin-left:60%" id="day"></span>

</div>
</body>
</html>


<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="../../assets/global/plugins/respond.min.js"></script>
<script src="../../assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<script src="../../assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="../../assets/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<script src="../../assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="../../assets/admin/layout4/scripts/layout.js" type="text/javascript"></script>
<script src="../../assets/admin/layout4/scripts/demo.js" type="text/javascript"></script>
<script src="../../assets/admin/pages/scripts/table-managed.js"></script>




<script type="text/javascript" src="../../assets/scripts/public/frame.js"></script>
<!-- END JAVASCRIPTS -->




<script>
    var module="agriculture";
    var sub="modu";
    jQuery(document).ready(function() {
        initRecordList();
        init();
    });


    var initRecordList=function(){
        existResultset=1;//打印时数据是已经获取的


        var table = $('#sample_1');
        // begin first table
        table.dataTable({
            bFilter: false,    //去掉搜索框方法三：这种方法可以


            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "在表中没有找到数据",
                "info": "共 _TOTAL_ 条数据",
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

            "columns": [{"orderable": false
            }, {
                "orderable": true
            }, {
                "orderable": false
            }, {
                "orderable": false
            }, {
                "orderable": true
            }, {
                "orderable": false
            }, {
                "orderable": false
            }, {
                "orderable": false
            }],
            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": "All",
            'paging':false,
            //"serverSide": true,//强制显示全部
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

                            var list=json.aaData;
                            console.log(list);
                            if(list.length>0){
                                //Record.recordCount=list.length;
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

    var init = function() {
        var today=new Date();
        var mouth=today.getMonth()+1;
        $("#day").html("<span>"+today.getFullYear()+"</span><span>年</span><span>"+mouth+"</span><span>月</span><span>"+today.getDate()+"</span><span>日</span>");

    }


</script>