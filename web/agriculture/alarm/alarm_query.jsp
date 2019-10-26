<%--
  Created by IntelliJ IDEA.
  User: 33826
  Date: 2019/5/29
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.text.*"%>
<%
    //做调试用，这里要在正式发布的时候去掉
    System.out.println("["+(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new java.util.Date())+"]=======================调试："+request.getServletPath()+"开始==============================");
%>
<%
    String id=request.getParameter("id");
    String existResultset=request.getParameter("exist_resultset");
%>
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
    <title>Metronic | Admin Dashboard Template</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <!--空白页-->
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <%--<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>--%>
    <link href="../../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN THEME STYLES -->
    <!-- DOC: To use 'rounded corners' style just load 'components-rounded.css' stylesheet instead of 'components.css' in the below style tag -->
    <link href="../../assets/global/css/components-rounded.css" id="style_components" rel="stylesheet" type="text/css"/>
    <link href="../../assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/admin/layout4/css/layout.css" rel="stylesheet" type="text/css"/>
    <link id="style_color" href="../../assets/admin/layout4/css/themes/light.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/admin/layout4/css/custom.css" rel="stylesheet" type="text/css"/>
    <!-- END THEME STYLES -->
    <link rel="shortcut icon" href="favicon.ico"/>
    <!--空白页-->

    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/clockface/css/clockface.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-colorpicker/css/colorpicker.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css"/>
    <!-- END PAGE LEVEL STYLES -->

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
<!-- BEGIN HEADER 顶条-->
<div class="page-header navbar navbar-fixed-top">
    <!-- BEGIN HEADER INNER -->
    <%@include file="../../home/frame/frame_top.jsp"%>
    <!-- END HEADER INNER -->
</div>
<!-- END HEADER 顶条-->
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER 中间-->
<div class="page-container">
    <!-- BEGIN SIDEBAR 侧栏-->
    <%@include file="../../home/frame/frame_left.jsp"%>
    <!-- END SIDEBAR 侧栏-->
    <!-- BEGIN CONTENT 右侧-->
    <div class="page-content-wrapper">
        <div class="page-content">
            <!-- BEGIN PAGE HEAD -->
            <div class="page-head">
                <!-- BEGIN PAGE TITLE -->
                <div class="page-title">
                    <h1>用户管理 <small>用户列表</small></h1>
                </div>
                <!-- END PAGE TITLE -->
                <!-- BEGIN PAGE TOOLBAR -->
                <div class="page-toolbar">
                    <!-- BEGIN THEME PANEL -->
                    <div class="btn-group btn-theme-panel">
                        <a href="javascript:;" class="btn dropdown-toggle" data-toggle="dropdown">
                            <i class="icon-settings"></i>
                        </a>
                        <div class="dropdown-menu theme-panel pull-right dropdown-custom hold-on-click">
                            <div class="row">
                                <div class="col-md-4 col-sm-4 col-xs-12">
                                    <h3>主题</h3>
                                    <ul class="theme-colors">
                                        <li class="theme-color theme-color-default" data-theme="default">
                                            <span class="theme-color-view"></span>
                                            <span class="theme-color-name">暗色</span>
                                        </li>
                                        <li class="theme-color theme-color-light active" data-theme="light">
                                            <span class="theme-color-view"></span>
                                            <span class="theme-color-name">亮色</span>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-12 seperator">
                                    <h3>布局</h3>
                                    <ul class="theme-settings">
                                        <li>
                                            Theme Style
                                            <select class="layout-style-option form-control input-small input-sm">
                                                <option value="square">Square corners</option>
                                                <option value="rounded" selected="selected">Rounded corners</option>
                                            </select>
                                        </li>
                                        <li>
                                            Layout
                                            <select class="layout-option form-control input-small input-sm">
                                                <option value="fluid" selected="selected">Fluid</option>
                                                <option value="boxed">Boxed</option>
                                            </select>
                                        </li>
                                        <li>
                                            Header
                                            <select class="page-header-option form-control input-small input-sm">
                                                <option value="fixed" selected="selected">Fixed</option>
                                                <option value="default">Default</option>
                                            </select>
                                        </li>
                                        <li>
                                            Top Dropdowns
                                            <select class="page-header-top-dropdown-style-option form-control input-small input-sm">
                                                <option value="light">Light</option>
                                                <option value="dark" selected="selected">Dark</option>
                                            </select>
                                        </li>
                                        <li>
                                            Sidebar Mode
                                            <select class="sidebar-option form-control input-small input-sm">
                                                <option value="fixed">Fixed</option>
                                                <option value="default" selected="selected">Default</option>
                                            </select>
                                        </li>
                                        <li>
                                            Sidebar Menu
                                            <select class="sidebar-menu-option form-control input-small input-sm">
                                                <option value="accordion" selected="selected">Accordion</option>
                                                <option value="hover">Hover</option>
                                            </select>
                                        </li>
                                        <li>
                                            Sidebar Position
                                            <select class="sidebar-pos-option form-control input-small input-sm">
                                                <option value="left" selected="selected">Left</option>
                                                <option value="right">Right</option>
                                            </select>
                                        </li>
                                        <li>
                                            Footer
                                            <select class="page-footer-option form-control input-small input-sm">
                                                <option value="fixed">Fixed</option>
                                                <option value="default" selected="selected">Default</option>
                                            </select>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END THEME PANEL -->
                </div>
                <!-- END PAGE TOOLBAR -->
            </div>
            <!-- END PAGE HEAD -->
            <!-- BEGIN PAGE BREADCRUMB -->
            <ul class="page-breadcrumb breadcrumb hide">
                <li>
                    <a href="javascript:;">Home</a><i class="fa fa-circle"></i>
                </li>
                <li class="active">
                    Dashboard
                </li>
            </ul>
            <!-- END PAGE BREADCRUMB -->
            <!-- BEGIN PAGE CONTENT INNER -->

            <div class="row">
                <div class="col-md-12">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-globe"></i>查询页
                            </div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse">
                                </a>
                                <a href="javascript:Page.reload();" class="reload" id="tools_menu_reload"><!--js不好用？-->
                                </a>
                                <a href="javascript:;" class="remove">
                                </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <!--按钮条开始-->


                            <div class="portlet light bordered form-fit">

                                <div class="portlet-body form">
                                    <!-- BEGIN FORM-->
                                    <form action="#" class="form-horizontal form-row-seperated" id="page_form" name="page_form">
                                        <div class="form-body">
                                            <input type="hidden" id="action" name="action" value="get_record"/>
                                            <input type="hidden" id="id" name="id" value="<%=id %>"/>
                                            <input type="hidden" id="exist_resultset" name="exist_resultset" value="<%=existResultset %>"/>

                                            <div class="form-group">
                                                <label class="col-md-3 control-label">数值类型</label>
                                                <div class="col-md-9">
                                                    <select class="bs-select form-control" id="value_type" name="value_type">
                                                        <option value="TEMPERATURE">土壤温度</option>
                                                        <option value="HUMIDITY">土壤湿度</option>
                                                        <option value="AIR-TEMPERATURE">空气温度</option>
                                                        <option value="AIR-HUMIDITY">空气湿度</option>
                                                        <option value="LUMEN">光照强度</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group last">
                                                <label class="control-label col-md-3">限制时间</label>
                                                <div class="col-md-6">
                                                    <span>从</span>
                                                    <div class="input-group date form_datetime">

                                                        <input type="text" id="time_from" name="time_from" class="form-control" size="16" placeholder="请输入限制时间" value=""/>
														<span class="input-group-btn">
															<button class="btn default date-set" type="button">
                                                                <i class="fa fa-calendar"></i>
                                                            </button>
														</span>

                                                    </div>
                                                    <span>到</span>
                                                    <div class="input-group date form_datetime">
                                                        <input type="text" id="time_to" name="time_to" class="form-control" size="16" placeholder="请输入限制时间" value=""/>
														<span class="input-group-btn">
															<button class="btn default date-set" type="button">
                                                                <i class="fa fa-calendar"></i>
                                                            </button>
														</span>

                                                    </div>
                                                    <button type="button" class="btn green-haze btn-circle btn-sm" id="today_button">今天</button>
                                                    <button type="button" class="btn green-haze btn-circle btn-sm" id="yestoday_button">昨天</button>
                                                    <button type="button" class="btn green-haze btn-circle btn-sm" id="before_yestoday_button">前天</button>
                                                    <button type="button" class="btn green-haze btn-circle btn-sm" id="month_button">本月</button>
                                                    <%--<button type="button" class="btn green-haze btn-circle btn-sm" id="before_month_button">30天内</button>--%>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="form-actions">

                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">

                                                    <button type="button" id="search_button" class="btn green-meadow">
                                                        开始查询
                                                    </button>

                                                    <button type="button" id="return_button" class="btn green-meadow">
                                                        返回
                                                    </button>

                                                    <%--<button type="button" id="cancel_button" class="btn default">Cancel</button>--%>
                                                    <button type="reset" class="btn default">清空</button>

                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <!-- END FORM-->
                                </div>

                            </div>



                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->
                </div>
            </div>


            <!-- END PAGE CONTENT INNER -->


        </div>
    </div>
    <!-- END CONTENT 右侧-->
</div>
<!-- END CONTAINER 中间-->
<!-- BEGIN FOOTER -->
<div class="page-footer">
    <div class="page-footer-inner">
        2014 &copy; Metronic by keenthemes. <a href="http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes" title="Purchase Metronic just for 27$ and get lifetime updates for free" target="_blank">Purchase Metronic!</a>
    </div>
    <div class="scroll-to-top">
        <i class="icon-arrow-up"></i>
    </div>
</div>
<!-- END FOOTER -->
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



<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>

<script type="text/javascript" src="../../assets/scripts/agriculture/alarm/alarm_query.js"></script>

