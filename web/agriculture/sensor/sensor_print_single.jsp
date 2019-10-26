<%--
  Created by IntelliJ IDEA.
  User: 33826
  Date: 2019/6/7
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //做调试用，这里要在正式发布的时候去掉
    System.out.println("[" + (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new java.util.Date()) + "]=======================调试：" + request.getServletPath() + "开始==============================");
%>
<%
    String id = request.getParameter("id");
    String existResultset = request.getParameter("exist_resultset");
%>
<style media=print>
    .no_print{display:none;}
    .page_next{page-break-after: always;}
</style>
<OBJECT id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0 width=0></OBJECT>
<div>
    <input type="button" class="no_print" value="打印" onclick="javascript:window.print()">
    <input type="button" class="no_print" value="返回" onclick=javascript:window.location.href="sensor_view.jsp?id=<%=id%>">
    <input type="button" style="display:none;" value="页面设置" onclick="javascript:WebBrowser.ExecWB(8,1)">
    <input type="button" style="display:none;" value="打印预览" onclick="javascript:WebBrowser.ExecWB(7,1)">
</div>


<!DOCTYPE html>
<!--
Template Name: Metronic - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.3.5
Version: 4.1.0
Author: KeenThemes
Website: http://www.keenthemes.com/
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Like: www.facebook.com/keenthemes
Purchase: http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
-->
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title>智慧农业</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <%--<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>--%>
    <link href="../../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
    <link href="../../assets/global/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/jqvmap/jqvmap/jqvmap.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/morris/morris.css" rel="stylesheet" type="text/css">
    <!-- END PAGE LEVEL PLUGIN STYLES -->
    <!-- BEGIN PAGE STYLES -->
    <link href="../../assets/admin/pages/css/tasks.css" rel="stylesheet" type="text/css"/>
    <!-- END PAGE STYLES -->
    <!-- BEGIN THEME STYLES -->
    <!-- DOC: To use 'rounded corners' style just load 'components-rounded.css' stylesheet instead of 'components.css' in the below style tag -->
    <link href="../../assets/global/css/components-rounded.css" id="style_components" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/admin/layout4/css/layout.css" rel="stylesheet" type="text/css"/>
    <link id="style_color" href="../../assets/admin/layout4/css/themes/light.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/admin/layout4/css/custom.css" rel="stylesheet" type="text/css"/>
    <!-- END THEME STYLES -->
    <link rel="shortcut icon" href="favicon.ico"/>

    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/clockface/css/clockface.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-colorpicker/css/colorpicker.css"/>

    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css"/>
    <!-- END PAGE LEVEL SCRIPTS -->

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<!-- DOC: Apply "page-header-fixed-mobile" and "page-footer-fixed-mobile" class to body element to force fixed header or footer in mobile devices -->
<!-- DOC: Apply "page-sidebar-closed" class to the body and "page-sidebar-menu-closed" class to the sidebar menu element to hide the sidebar by default -->
<!-- DOC: Apply "page-sidebar-hide" class to the body to make the sidebar completely hidden on toggle -->
<!-- DOC: Apply "page-sidebar-closed-hide-logo" class to the body element to make the logo hidden on sidebar toggle -->
<!-- DOC: Apply "page-sidebar-hide" class to body element to completely hide the sidebar on sidebar toggle -->
<!-- DOC: Apply "page-sidebar-fixed" class to have fixed sidebar -->
<!-- DOC: Apply "page-footer-fixed" class to the body element to have fixed footer -->
<!-- DOC: Apply "page-sidebar-reversed" class to put the sidebar on the right side -->
<!-- DOC: Apply "page-full-width" class to the body element to have full width page without the sidebar menu -->
<body class="page-header-fixed page-sidebar-closed-hide-logo page-sidebar-closed-hide-logo">




<div class="page-content">


    <!-- BEGIN PAGE CONTENT INNER -->


    <div class="col-md-12">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->


        <div class="portlet-body">




            <div class="portlet light bordered form-fit">

                <div class="portlet-body form">
                    <!-- BEGIN FORM-->
                    <form action="#" class="form-horizontal form-row-seperated" id="page_form" name="page_form">
                        <div class="form-body">
                            <input type="hidden" id="action" name="action" value="modify_record"/>
                            <input type="hidden" id="id" name="id" value="<%=id%>" />

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    设备ID
                                </label>
                                <div class="col-md-9">
                                    <input type="text" id="device_id" name="device_id" class="form-control"
                                           placeholder="请输入设备ID" value=""/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    数据类型
                                </label>
                                <div class="col-md-9">
                                    <input type="text" id="value_type" name="value_type" class="form-control"
                                           placeholder="请输入数据类型" value=""/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">
                                    数值
                                </label>
                                <div class="col-md-9">
                                    <input type="text" id="sensor_value_string" name="sensor_value_string"
                                           class="form-control" placeholder="请输入数值" value=""/>
                                </div>
                            </div>

                            <div class="form-group last">
                                <label class="control-label col-md-3">检测时间</label>
                                <div class="col-md-9">
                                    <div class="input-group date form_datetime">
                                        <input type="text" id="detect_time" name="detect_time" class="form-control" size="16"  value=""/>
														<span class="input-group-btn">
															<button class="btn default date-set" type="button">
                                                                <i class="fa fa-calendar"></i>
                                                            </button>
														</span>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                    <!-- END FORM-->
                </div>

            </div>



        </div>

        <!-- END EXAMPLE TABLE PORTLET-->
    </div>



    <!-- END PAGE CONTENT INNER -->


</div>



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
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="../../assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="../../assets/admin/layout4/scripts/layout.js" type="text/javascript"></script>
<script src="../../assets/admin/layout4/scripts/demo.js" type="text/javascript"></script>
<script src="../../assets/admin/pages/scripts/form-samples.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script type="text/javascript" src="../../assets/scripts/home/mainmenu.js?v"></script>


<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript" src="../../assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="../../assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="../../assets/global/plugins/clockface/js/clockface.js"></script>
<script type="text/javascript" src="../../assets/global/plugins/bootstrap-daterangepicker/moment.min.js"></script>
<script type="text/javascript" src="../../assets/global/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>

<script type="text/javascript" src="../../assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="../../assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->

<script src="../../assets/admin/pages/scripts/components-pickers.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->

<script type="text/javascript" src="../../assets/scripts/public/frame.js"></script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>


<script>
    var module="agriculture";
    var sub="sensor";
    jQuery(document).ready(function() {
        init();

    });

    var init = function() {
        var id=$("#id").val();
        var url="../../"+module+"_"+sub+"_servlet_action?action=get_record_view&id="+id+"&exist_resultset=1";
        $.post(url,function(json) {
            if (json.result_code == 0) {

                var list = json.aaData;
                var json = list[0];

                var id=json[0];
                var image="../../assets/module/img/public/logo.jpg";
                var deviceId=json[1];
                var valueType=json[2];
                var sensorValueString=json[3];
                var detectTime=json[4];

                console.log(deviceId);
                console.log(valueType);
                console.log(sensorValueString);
                console.log("detect time is "+detectTime);

                $("#device_id").val(deviceId);
                $("#value_type").val(valueType);
                $("#sensor_value_string").val(sensorValueString);
                $("#detect_time").val(detectTime);
            }
        })
    }


</script>

