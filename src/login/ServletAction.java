package login;

import agriculture.sendmail.sendMail;
//import common.Email;
import dao.DB;
import org.json.JSONException;
import org.json.JSONObject;
import utility.LogEvent;

import javax.mail.Transport;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by 33826 on 2019/5/23.
 */
@WebServlet(name = "ServletAction")
public class ServletAction extends HttpServlet {
    public String module = "login";
    public String sub = "";
    public String preFix = module + "_" + sub;
    public String resultPath = module + "/" + sub;
    public String resultPage = "result.jsp";
    public String resultUrl=resultPath+"/"+resultPage;
    public String redirectPath = module + "/" + sub;
    public String redirectPage = "record_list.jsp";
    public String redirectUrl=redirectPath+"/"+redirectPage;
    public String databaseName="ylxdb";
    public SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public LogEvent ylxLog = new LogEvent();
    public String IP;


    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processAction(request,response);
    }
    public void processAction(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        System.out.println("神奇的session:"+session);
        request.setCharacterEncoding("UTF-8");
        try {
            ylxLog.setSession(session);
        } catch (Exception e) {
            e.printStackTrace();
        }
        IP=getIpAddr(request);
        System.out.println("ip:"+IP);
        String action = request.getParameter("action");
        //todo_add.jsp，这里name="action" value="add_record"，form用post的方式提交，后端就会提取：
        //request.getParameter("action");得到value，就是add_record。

        boolean actionOk = false;
        showDebug("processAction收到的action是："+action);
        if (action.equals("login")) {
            actionOk=true;
            try {
                login(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (JSONException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (action.equals("register")) {
            actionOk=true;
            try {
                register(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (JSONException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (action.equals("find")) {
            actionOk=true;
            try {
                find(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (JSONException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

//        if(session.getAttribute("user_role")==null){
//            try {
//                processError(request, response,3,"session超时，请重新登录系统！");
//            } catch (JSONException e) {
//                e.printStackTrace();
//            }
//        }else{
//            if (action == null){
//                try {
//                    processError(request, response,1,"传递过来的action是null！");
//                } catch (JSONException e) {
//                    e.printStackTrace();
//                }
//            }else{
//                //这几个常规增删改查功能
//                if (action.equals("login")) {
//                    actionOk=true;
//                    try {
//                        login(request, response);
//                    } catch (SQLException e) {
//                        e.printStackTrace();
//                    } catch (JSONException e) {
//                        e.printStackTrace();
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                    }
//                }
//
//
//
//
//                if (!actionOk) {
//                    try {
//                        processError(request, response,2,"["+module+"/"+sub+"/ServletAction]没有对应的action处理过程，请检查action是否正确！action="+action);
//                    } catch (JSONException e) {
//                        e.printStackTrace();
//                    }
//                }
//
//
//            }
//        }
    }
    public void processError(HttpServletRequest request, HttpServletResponse response,int errorNo,String errorMsg) throws JSONException, IOException{
        String action = request.getParameter("action");
        //errorNo=0->没有错误
        //errorNo=1->action是空值
        //errorNo=2->没有对应的处理该action的函数
        //errorNo=3->session超时
        showDebug("错误信息："+errorMsg+"，代码："+errorNo);
        JSONObject jsonObj=new JSONObject();
        boolean isAjax=true;
        if(request.getHeader("x-requested-with")==null){isAjax=false;}	//判断是异步请求还是同步请求
        if(isAjax){
            jsonObj.put("result_code",errorNo);
            jsonObj.put("result_msg",errorMsg);
            jsonObj.put("action",action);
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out;
            try {
                out = response.getWriter();
                out.print(jsonObj);
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            errorMsg = java.net.URLEncoder.encode(errorMsg, "UTF-8");
            String url = resultPath+"/"+resultPage+"?action="+action+"&result_code="+errorNo+"&redirect_path=" + redirectPath + "&redirect_page=" + redirectPage + "&result_msg=" + errorMsg;
            showDebug(url);
            response.sendRedirect(url);
        }
    }
    /*
     * 功能：进行一个本类测试，不用启动整个项目，测试所写的Java
     */
    public static void main(String[] args) throws Exception {
        System.out.println("");
    }
    public void showDebug(String msg){
        System.out.println("["+(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())+"]["+module+"/"+sub+"/ServletAction]"+msg);
    }


    private String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        System.out.println("x-forwarded-for ip: " + ip);
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
            // 多次反向代理后会有多个ip值，第一个ip才是真实ip
            if( ip.indexOf(",")!=-1 ){
                ip = ip.split(",")[0];
            }
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
            System.out.println("Proxy-Client-IP ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
            System.out.println("WL-Proxy-Client-IP ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
            System.out.println("HTTP_CLIENT_IP ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            System.out.println("HTTP_X_FORWARDED_FOR ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
            System.out.println("X-Real-IP ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
            System.out.println("getRemoteAddr ip: " + ip);
        }
        System.out.println("获取客户端ip: " + ip);
        return ip;
    }
    public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        String dbName=(String)session.getAttribute("unit_db_name");
        String action = request.getParameter("action");
        String id=request.getParameter("id");
        String title=request.getParameter("title");
        String password=request.getParameter("password");
        System.out.println(password);
        String type= request.getParameter("type");
        String timeFrom= request.getParameter("time_from");
        String timeTo= request.getParameter("time_to");
        String existResultset= request.getParameter("exist_resultset");
        String orderBy=request.getParameter("order_by");
        System.out.println("orderby:"+orderBy);
        if((existResultset==null) ||(existResultset.equals("null") || existResultset.isEmpty())) existResultset="0";
        String userId=session.getAttribute("user_id")==null?null:(String)session.getAttribute("user_id");
        //String userName=session.getAttribute("user_name")==null?null:(String)session.getAttribute("user_name");
        String userName=request.getParameter("user_name");

        //String IP = request.getParameter("ip");//前端获取的ip传过来的,不用RTC


        String userRole=session.getAttribute("user_role")==null?null:(String)session.getAttribute("user_role");
        String userAvatar=session.getAttribute("user_avatar")==null?null:(String)session.getAttribute("user_avatar");
        //这里可以修改成统一一个函数读取变量，下面的session里的attr可以用一个变量代替
        //检查输入参数是否正确先
        showDebug("[login]收到页面传过来的参数是："+userName+","+password);
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        String creator=(String)session.getAttribute("user_name");
        String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());

        DB query_db = new DB(dbName);
        String sql="select * from agriculture_users where user_name='"+userName+"' and password='"+password+"'";
        ResultSet rs = query_db.executeQuery(sql);
        if(rs.next()){
            System.out.println("结果集不为空!");
            String role=rs.getString("role_id");
            System.out.println(role);
            session.setAttribute("user_role",role);
            session.setAttribute("user_id",userName);
            session.setAttribute("user_name",userName);
            session.setAttribute("ip",IP);
            ylxLog.getClientInformation();
            ylxLog.log("用户 "+userName+" 于 "+createTime+" 登陆了系统，ip为["+IP+"]","登录系统",module,sub);

            boolean isAjax=true;
            if(request.getHeader("x-requested-with")==null){isAjax=false;}
            //Ajax 异步请求比传统的同步请求多了一个头参数
            System.out.println(isAjax);//为true，有请求头，异步，要返回json

            JSONObject jsonObj=new JSONObject();
            jsonObj.put("result","yes");
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out;
            try {
                System.out.println("ajax");
                out = response.getWriter();
                out.print(jsonObj);
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
//            response.sendRedirect("../agriculture/users/users_list.jsp");
//            return ;
        }
        else{
            System.out.println("结果集为空!");

        }

    }
    public void register(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String dbName=(String)session.getAttribute("unit_db_name");
        String action = request.getParameter("action");
        String id=request.getParameter("id");
        String title=request.getParameter("title");//查询功能使用
        String password=request.getParameter("password");///////
        String email=request.getParameter("email");
        String type= request.getParameter("type");
        String timeFrom= request.getParameter("time_from");
        String timeTo= request.getParameter("time_to");
        String existResultset= request.getParameter("exist_resultset");
        String orderBy=request.getParameter("order_by");
        System.out.println("orderby:"+orderBy);
        if((existResultset==null) ||(existResultset.equals("null") || existResultset.isEmpty())) existResultset="0";
        String userId=session.getAttribute("user_id")==null?null:(String)session.getAttribute("user_id");
        //String userName=session.getAttribute("user_name")==null?null:(String)session.getAttribute("user_name");
        String userName=request.getParameter("user_name");

        String userRole=session.getAttribute("user_role")==null?null:(String)session.getAttribute("user_role");
        String userAvatar=session.getAttribute("user_avatar")==null?null:(String)session.getAttribute("user_avatar");
        //这里可以修改成统一一个函数读取变量，下面的session里的attr可以用一个变量代替
        //检查输入参数是否正确先
        showDebug("[login]收到页面传过来的参数是："+userName+","+password);
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        String creator=(String)session.getAttribute("user_name");
        String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());


        DB query_db = new DB(dbName);


        String sql="select * from agriculture_users where email='"+email+"'";
        ResultSet rs = query_db.executeQuery(sql);
        if(rs.next()){
            System.out.println("结果集不为空!");
            JSONObject jsonObj=new JSONObject();
            jsonObj.put("result","no");
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out;
            try {
                System.out.println("ajax");
                out = response.getWriter();
                out.print(jsonObj);
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
//            response.sendRedirect("../agriculture/users/users_list.jsp");
//            return ;
        }
        else{
            System.out.println("结果集为空!");

            sql="insert into agriculture_users(parent_id,user_name,password,register_time,user_id,role_id,creator,create_time,email) values('','"+userName+"','"+password+
                    "','"+createTime+"','"+userName+"','normal','"+userName+"','"+createTime+"','"+email+"')";
            query_db.executeUpdate(sql);
            session.setAttribute("user_role","normal");
            session.setAttribute("user_id",userName);
            session.setAttribute("user_name",userName);
            session.setAttribute("ip",IP);
            ylxLog.getClientInformation();
            ylxLog.log("用户 "+userName+" 于 "+createTime+" 注册了账号，ip为["+IP+"]","注册账号",module,sub);

            JSONObject jsonObj=new JSONObject();
            jsonObj.put("result","yes");
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out;
            try {
                System.out.println("ajax");
                out = response.getWriter();
                out.print(jsonObj);
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }





    }
    public void find(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String dbName=(String)session.getAttribute("unit_db_name");
        String action = request.getParameter("action");
        String id=request.getParameter("id");
        String title=request.getParameter("title");//查询功能使用
        String password=request.getParameter("password");///////
        String email=request.getParameter("email");
        String type= request.getParameter("type");
        String timeFrom= request.getParameter("time_from");
        String timeTo= request.getParameter("time_to");
        String existResultset= request.getParameter("exist_resultset");
        String orderBy=request.getParameter("order_by");
        System.out.println("orderby:"+orderBy);
        if((existResultset==null) ||(existResultset.equals("null") || existResultset.isEmpty())) existResultset="0";
        String userId=session.getAttribute("user_id")==null?null:(String)session.getAttribute("user_id");
        //String userName=session.getAttribute("user_name")==null?null:(String)session.getAttribute("user_name");
        String userName=request.getParameter("user_name");

        String userRole=session.getAttribute("user_role")==null?null:(String)session.getAttribute("user_role");
        String userAvatar=session.getAttribute("user_avatar")==null?null:(String)session.getAttribute("user_avatar");
        //这里可以修改成统一一个函数读取变量，下面的session里的attr可以用一个变量代替
        //检查输入参数是否正确先
        showDebug("[login]收到页面传过来的参数是："+userName+","+password+","+email);
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        String creator=(String)session.getAttribute("user_name");
        String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());

        String[] emailbox=new String[1];
        emailbox[0]=email;
//
        //Email em=new Email();
        //em.send(emailbox,"lafhhh@outlook.com"," "," ","找回密码","你的密码是");
        sendMail em=new sendMail();
        showDebug("发送邮件成功");










    }
}
