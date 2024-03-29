<%--
  Created by IntelliJ IDEA.
  User: 33826
  Date: 2019/5/12
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.text.*"%>
<%
    //做调试用，这里要在正式发布的时候去掉
    System.out.println("[" + (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new java.util.Date()) + "]=======================调试：" + request.getServletPath() + "开始==============================");
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
    <link href="../../assets/admin/layout4/css/themes/light.css" rel="stylesheet" type="text/css" id="style_color"/>
    <link href="../../assets/admin/layout4/css/custom.css" rel="stylesheet" type="text/css"/>
    <!-- END THEME STYLES -->
    <link rel="shortcut icon" href="favicon.ico"/>

    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css"/>
    <link href="../../assets/admin/pages/css/search.css" rel="stylesheet" type="text/css"/>
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
                                    <h3>THEME</h3>
                                    <ul class="theme-colors">
                                        <li class="theme-color theme-color-default" data-theme="default">
                                            <span class="theme-color-view"></span>
                                            <span class="theme-color-name">Dark Header</span>
                                        </li>
                                        <li class="theme-color theme-color-light active" data-theme="light">
                                            <span class="theme-color-view"></span>
                                            <span class="theme-color-name">Light Header</span>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-12 seperator">
                                    <h3>LAYOUT</h3>
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
                                <i class="fa fa-globe"></i>记录表
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
                            <div class="table-toolbar">
                                <div class="btn-group" style="margin: 5px 0px 5px 0px;">
                                    <button id="add_button" class="btn green-meadow">
                                        增加记录
                                    </button>
                                </div>
                                <div class="btn-group" style="margin: 5px 0px 5px 0px;">
                                    <button id="search_button" class="btn green-meadow">
                                        查询记录
                                    </button>
                                </div>
                                <div class="btn-group" style="margin: 5px 0px 5px 0px;">
                                    <button id="export_button" class="btn green-meadow">
                                        导出
                                    </button>
                                </div>
                                <div class="btn-group" style="margin: 5px 0px 5px 0px;">
                                    <button id="print_button" class="btn green-meadow">
                                        打印
                                    </button>
                                </div>
                                <div class="btn-group" style="margin: 5px 0px 5px 0px;">
                                    <button id="statistic_button" class="btn green-meadow">
                                        统计
                                    </button>
                                </div>
                                <div class="btn-group" style="margin: 5px 0px 5px 0px;">
                                    <button id="layout_button" class="btn green-meadow">
                                        以列表形式展示
                                    </button>
                                </div>

                            </div>
                            <!--按钮条结束-->
                            <!--排序开始-->
                            <div class="row">
                                <label class="control-label col-md-2" style="margin: 6px 0 6px 30px;">排序</label>
                                <div class="col-md-2">
                                    <select class="form-group form-control"  id="sort_01">
                                        <option value="null">请选择</option>
                                        <option value="value_float">按数值大小</option>
                                        <option value="handle_time">按处理时间</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <select class="form-group form-control"  id="sort_02">
                                        <option value="null">请选择</option>
                                        <option value="value_float">按数值大小</option>
                                        <option value="handle_time">按处理时间</option>
                                    </select>
                                </div>

                                <!--
                                <div class="col-md-2">
                                    <select class="form-group form-control"  id="sort_03">
                                        <option value="null">请选择</option>
                                        <option value="value_float">按数值大小</option>
                                        <option value="handle_time">按处理时间</option>
                                    </select>
                                </div>
                                -->

                                <div class="btn-group" style="margin: 0px 0px 0px 15px;">
                                    <button id="sort_button" class="btn default green-stripe">
                                        点击排序
                                    </button>
                                </div>
                            </div>
                            <!--排序结束-->

                            <div class="row booking-results">
                                <label id="record_list_tip" class="col-md-12" style="margin-top: 10px;">
                                    记录列表
                                </label>
                                <div id="record_list_div">
                                    <div class="col-md-12">
                                        <div class="booking-result" >
                                            <div class="booking-img">
                                                <img src="../../assets/admin/pages/media/gallery/image4.jpg" alt="">
                                            </div>
                                            <div class="booking-info" style="overflow:hidden;">
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>

                                            </div>
                                            <div style="margin:15px 0 25px 0;">
                                                <button  type="button" class="btn default red-stripe" onclick="Page.deleteRecord(1);">删除</button>
                                                <button  type="button" class="btn default yellow-stripe" onclick="Page.modifyRecord(1);">修改</button>
                                                <button  type="button" class="btn default purple-stripe" onclick="Page.modifyRecord(1);">修改</button>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="booking-result" style="margin-bottom: 25px;">
                                            <div class="booking-img">
                                                <img src="../../assets/admin/pages/media/gallery/image4.jpg" alt="">
                                            </div>
                                            <div class="booking-info" style="overflow:hidden;">
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>

                                            </div>
                                            <button  type="button" class="btn default red-stripe" onclick="Page.deleteRecord(1);">删除</button>
                                            <button  type="button" class="btn default yellow-stripe" onclick="Page.modifyRecord(1);">修改</button>
                                            <button  type="button" class="btn default purple-stripe" onclick="Page.modifyRecord(1);">修改</button>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="booking-result" style="margin-bottom: 25px;">
                                            <div class="booking-img">
                                                <img src="../../assets/admin/pages/media/gallery/image4.jpg" alt="">
                                            </div>
                                            <div class="booking-info" style="overflow:hidden;">
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>

                                            </div>
                                            <button  type="button" class="btn default red-stripe" onclick="Page.deleteRecord(1);">删除</button>
                                            <button  type="button" class="btn default yellow-stripe" onclick="Page.modifyRecord(1);">修改</button>
                                            <button  type="button" class="btn default purple-stripe" onclick="Page.modifyRecord(1);">修改</button>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="booking-result" style="margin-bottom: 25px;">
                                            <div class="booking-img">
                                                <img src="../../assets/admin/pages/media/gallery/image4.jpg" alt="">
                                            </div>
                                            <div class="booking-info" style="overflow:hidden;">
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>
                                                <p>a deserunt laborum. <a href="javascript:;">read more... </a></p>

                                            </div>
                                            <button  type="button" class="btn default red-stripe" onclick="Page.deleteRecord(1);">删除</button>
                                            <button  type="button" class="btn default yellow-stripe" onclick="Page.modifyRecord(1);">修改</button>
                                            <button  type="button" class="btn default purple-stripe" onclick="Page.modifyRecord(1);">修改</button>
                                        </div>
                                    </div>


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
<script src="../../assets/global/plugins/jqvmap/jqvmap/jquery.vmap.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.russia.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.world.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.europe.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.germany.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.usa.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jqvmap/jqvmap/data/jquery.vmap.sampledata.js" type="text/javascript"></script>
<!-- IMPORTANT! fullcalendar depends on jquery-ui.min.js for drag & drop support -->
<script src="../../assets/global/plugins/morris/morris.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/morris/raphael-min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery.sparkline.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="../../assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="../../assets/admin/layout4/scripts/layout.js" type="text/javascript"></script>
<script src="../../assets/admin/layout2/scripts/quick-sidebar.js" type="text/javascript"></script>
<script src="../../assets/admin/layout4/scripts/demo.js" type="text/javascript"></script>
<script src="../../assets/admin/pages/scripts/index3.js" type="text/javascript"></script>
<script src="../../assets/admin/pages/scripts/tasks.js" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script type="text/javascript" src="../../assets/scripts/home/mainmenu.js?v"></script>
<script type="text/javascript" src="../../assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script src="../../assets/global/plugins/fancybox/source/jquery.fancybox.pack.js"></script>
<script src="../../assets/admin/pages/scripts/search.js"></script>



<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>

<script type="text/javascript" src="../../assets/scripts/agriculture/alarm/alarm_list.js"></script>