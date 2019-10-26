/**
 * Created by 33826 on 2019/5/23.
 */
var ipp;
function findIP(callback) {
    var myPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection; //compatibility for firefox and chrome
    var pc = new myPeerConnection({iceServers: []}),
        noop = function() {},
        localIPs = {},
        ipRegex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/g,
        key;

    function ipIterate(ip) {
        if (!localIPs[ip]) callback(ip);
        localIPs[ip] = true;
    }
    pc.createDataChannel("");
    pc.createOffer().then(function(sdp) {
        sdp.sdp.split('\n').forEach(function(line) {
            if (line.indexOf('candidate') < 0) return;
            line.match(ipRegex).forEach(ipIterate);
        });
        pc.setLocalDescription(sdp, noop, noop);
    });
    pc.onicecandidate = function(ice) {
        if (!ice || !ice.candidate || !ice.candidate.candidate || !ice.candidate.candidate.match(ipRegex)) return;
        ice.candidate.candidate.match(ipRegex).forEach(ipIterate);
    };
}

findIP(function(ip){
    console.log('got ip: ', ip);
    ipp=ip;
    //session.setAttribute("ip",ip);
});

jQuery(document).ready(function() {
    Metronic.init(); // init metronic core components
    Layout.init(); // init current layout
    Login.init();
    Demo.init();
    // init background slide images
    $.backstretch([
            "../../assets/admin/pages/media/bg/1.jpg",
            "../../assets/admin/pages/media/bg/2.jpg",
            "../../assets/admin/pages/media/bg/3.jpg",
            "../../assets/admin/pages/media/bg/4.jpg"
        ], {
            fade: 1000,
            duration: 8000
        }
    );
    Page.init();
});


var Page = function() {
    var html="";
    var handleButtonEvent=function(){
        $('#login').click(function() {Page.login();});
        $('#register-submit-btn').click(function() {Page.register();});
        $('#find').click(function() {Page.find();});

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
    };

    var checkInput=function(){
        var bOk=true;
        var action=$("#action").val();
        if(action==null || action==""){Frame.showMsg("名称不能为空！");bOk=false;};
        return bOk;
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

    var login=function(){
        var userName=$("#username1").val();
        var password=$("#password1").val();
        console.log(userName+" "+password+" "+ipp);
        var url="../login_servlet_action?action=login&user_name="+userName+"&password="+password+"&ip="+ipp;
        $.post(url,function(json){
            if(json.result=="yes"){
                console.log("good");
                window.location.href="../agriculture/index.html";

            }else{
                alert("用户名或密码错误");
            }

        });
        console.log("login");
    };
    var register=function(){
        var userName=$("#username2").val();
        var password=$("#register_password").val();
        var email=$("#email").val();
        console.log(userName+" "+password+" "+email);
        var url="../login_servlet_action?action=register&user_name="+userName+"&password="+password+"&email="+email;
        $.post(url,function(json){
            if(json.result=="yes"){
                console.log("good");
                window.location.href="../agriculture/index.html";

            }else{
                alert("???邮箱使用过");
            }

        });
        console.log("login");
    };
    var find=function(){

        var email=$("#findemail").val();
        console.log(email);
        var url="../login_servlet_action?action=find&email="+email;
        $.post(url,function(json){
            if(json.result=="yes"){
                console.log("good");
                window.location.href="../agriculture/index.html";
             //   window.location.href="../agriculture/news/record_list.jsp";

            }else{
                alert("hhh邮箱使用过hhh");
              //  function
            }

        });
        console.log("login");
    };
    return {
        init: function() {

            handleButtonEvent();
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

        login:function(){
            login();
        },
        register:function(){
            register();
        },
        find:function(){
            find();
        },
        processError:function(json){
            processError(json);
        }
    }
}();//Page
