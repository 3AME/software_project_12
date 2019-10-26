<%--
  Created by IntelliJ IDEA.
  User: 33826
  Date: 2019/5/12
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="page-sidebar-wrapper">
    <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
    <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
    <div class="page-sidebar navbar-collapse collapse" id="sidebar_menu_div">
        <!-- BEGIN SIDEBAR MENU -->
        <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
        <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
        <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
        <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
        <!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
        <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
        <ul id="page_sidebar_menu" class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
            <li class="start active ">
                <a href="index.html">
                    <i class="icon-home"></i>
                    <span class="title">Dashboard</span>
                </a>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="icon-basket"></i>
                    <span class="title">eCommerce</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="ecommerce_index.html">
                            <i class="icon-home"></i>
                            Dashboard</a>
                    </li>
                    <li>
                        <a href="ecommerce_orders.html">
                            <i class="icon-basket"></i>
                            Orders</a>
                    </li>
                    <li>
                        <a href="ecommerce_orders_view.html">
                            <i class="icon-tag"></i>
                            Order View</a>
                    </li>
                    <li>
                        <a href="ecommerce_products.html">
                            <i class="icon-handbag"></i>
                            Products</a>
                    </li>
                    <li>
                        <a href="ecommerce_products_edit.html">
                            <i class="icon-pencil"></i>
                            Product Edit</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="icon-rocket"></i>
                    <span class="title">Page Layouts</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="layout_sidebar_reversed.html">
                            <span class="badge badge-warning">new</span>Right Sidebar Page</a>
                    </li>
                    <li>
                        <a href="layout_sidebar_fixed.html">
                            Sidebar Fixed Page</a>
                    </li>
                    <li>
                        <a href="layout_sidebar_closed.html">
                            Sidebar Closed Page</a>
                    </li>
                    <li>
                        <a href="layout_blank_page.html">
                            Blank Page</a>
                    </li>
                    <li>
                        <a href="layout_boxed_page.html">
                            Boxed Page</a>
                    </li>
                    <li>
                        <a href="layout_language_bar.html">
                            Language Switch Bar</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="icon-diamond"></i>
                    <span class="title">UI Features</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="ui_general.html">
                            General Components</a>
                    </li>
                    <li>
                        <a href="ui_buttons.html">
                            Buttons</a>
                    </li>
                    <li>
                        <a href="ui_icons.html">
                            <span class="badge badge-danger">new</span>Font Icons</a>
                    </li>
                    <li>
                        <a href="ui_colors.html">
                            Flat UI Colors</a>
                    </li>
                    <li>
                        <a href="ui_typography.html">
                            Typography</a>
                    </li>
                    <li>
                        <a href="ui_tabs_accordions_navs.html">
                            Tabs, Accordions & Navs</a>
                    </li>
                    <li>
                        <a href="ui_tree.html">
                            <span class="badge badge-danger">new</span>Tree View</a>
                    </li>
                    <li>
                        <a href="ui_page_progress_style_1.html">
                            <span class="badge badge-warning">new</span>Page Progress Bar - Style 1</a>
                    </li>
                    <li>
                        <a href="ui_blockui.html">
                            Block UI</a>
                    </li>
                    <li>
                        <a href="ui_bootstrap_growl.html">
                            <span class="badge badge-roundless badge-warning">new</span>Bootstrap Growl Notifications</a>
                    </li>
                    <li>
                        <a href="ui_notific8.html">
                            Notific8 Notifications</a>
                    </li>
                    <li>
                        <a href="ui_toastr.html">
                            Toastr Notifications</a>
                    </li>
                    <li>
                        <a href="ui_alert_dialog_api.html">
                            <span class="badge badge-danger">new</span>Alerts & Dialogs API</a>
                    </li>
                    <li>
                        <a href="ui_session_timeout.html">
                            Session Timeout</a>
                    </li>
                    <li>
                        <a href="ui_idle_timeout.html">
                            User Idle Timeout</a>
                    </li>
                    <li>
                        <a href="ui_modals.html">
                            Modals</a>
                    </li>
                    <li>
                        <a href="ui_extended_modals.html">
                            Extended Modals</a>
                    </li>
                    <li>
                        <a href="ui_tiles.html">
                            Tiles</a>
                    </li>
                    <li>
                        <a href="ui_datepaginator.html">
                            <span class="badge badge-success">new</span>Date Paginator</a>
                    </li>
                    <li>
                        <a href="ui_nestable.html">
                            Nestable List</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="icon-puzzle"></i>
                    <span class="title">UI Components</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="components_pickers.html">
                            Date & Time Pickers</a>
                    </li>
                    <li>
                        <a href="components_context_menu.html">
                            Context Menu</a>
                    </li>
                    <li>
                        <a href="components_dropdowns.html">
                            Custom Dropdowns</a>
                    </li>
                    <li>
                        <a href="components_form_tools.html">
                            Form Widgets & Tools</a>
                    </li>
                    <li>
                        <a href="components_form_tools2.html">
                            Form Widgets & Tools 2</a>
                    </li>
                    <li>
                        <a href="components_editors.html">
                            Markdown & WYSIWYG Editors</a>
                    </li>
                    <li>
                        <a href="components_ion_sliders.html">
                            Ion Range Sliders</a>
                    </li>
                    <li>
                        <a href="components_noui_sliders.html">
                            NoUI Range Sliders</a>
                    </li>
                    <li>
                        <a href="components_jqueryui_sliders.html">
                            jQuery UI Sliders</a>
                    </li>
                    <li>
                        <a href="components_knob_dials.html">
                            Knob Circle Dials</a>
                    </li>
                </ul>
            </li>
            <!-- BEGIN ANGULARJS LINK -->
            <li class="tooltips" data-container="body" data-placement="right" data-html="true" data-original-title="AngularJS version demo">
                <a href="angularjs" target="_blank">
                    <i class="icon-paper-plane"></i>
					<span class="title">
					AngularJS Version </span>
                </a>
            </li>
            <!-- END ANGULARJS LINK -->
            <li>
                <a href="javascript:;">
                    <i class="icon-settings"></i>
                    <span class="title">Form Stuff</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="form_controls_md.html">
                            <span class="badge badge-roundless badge-danger">new</span>Material Design<br>
                            Form Controls</a>
                    </li>
                    <li>
                        <a href="form_controls.html">
                            Bootstrap<br>
                            Form Controls</a>
                    </li>
                    <li>
                        <a href="form_layouts.html">
                            Form Layouts</a>
                    </li>
                    <li>
                        <a href="form_editable.html">
                            <span class="badge badge-warning">new</span>Form X-editable</a>
                    </li>
                    <li>
                        <a href="form_wizard.html">
                            Form Wizard</a>
                    </li>
                    <li>
                        <a href="form_validation.html">
                            Form Validation</a>
                    </li>
                    <li>
                        <a href="form_image_crop.html">
                            <span class="badge badge-danger">new</span>Image Cropping</a>
                    </li>
                    <li>
                        <a href="form_fileupload.html">
                            Multiple File Upload</a>
                    </li>
                    <li>
                        <a href="form_dropzone.html">
                            Dropzone File Upload</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="icon-briefcase"></i>
                    <span class="title">Data Tables</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="table_basic.html">
                            Basic Datatables</a>
                    </li>
                    <li>
                        <a href="table_tree.html">
                            Tree Datatables</a>
                    </li>
                    <li>
                        <a href="table_responsive.html">
                            Responsive Datatables</a>
                    </li>
                    <li>
                        <a href="table_managed.html">
                            Managed Datatables</a>
                    </li>
                    <li>
                        <a href="table_editable.html">
                            Editable Datatables</a>
                    </li>
                    <li>
                        <a href="table_advanced.html">
                            Advanced Datatables</a>
                    </li>
                    <li>
                        <a href="table_ajax.html">
                            Ajax Datatables</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="icon-user"></i>
                    <span class="title">Login Options</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="login.html">
                            Login Form 1</a>
                    </li>
                    <li>
                        <a href="login_2.html">
                            Login Form 2</a>
                    </li>
                    <li>
                        <a href="login_3.html">
                            Login Form 3</a>
                    </li>
                    <li>
                        <a href="login_soft.html">
                            Login Form 4</a>
                    </li>
                    <li>
                        <a href="extra_lock.html">
                            Lock Screen 1</a>
                    </li>
                    <li>
                        <a href="extra_lock2.html">
                            Lock Screen 2</a>
                    </li>
                </ul>
            </li>

            <li class="last ">
                <a href="javascript:;">
                    <i class="icon-pointer"></i>
                    <span class="title">Maps</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="maps_google.html">
                            Google Maps</a>
                    </li>
                    <li>
                        <a href="maps_vector.html">
                            Vector Maps</a>
                    </li>
                </ul>
            </li>
        </ul>
        <!-- END SIDEBAR MENU -->
    </div>
</div>
