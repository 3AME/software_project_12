package agriculture.news;

import agriculture.dao.News;
import agriculture.dao.NewsDao;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import utility.LogEvent;
import utility.excel.ExcelWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class ServletAction extends HttpServlet {
    //这里是需要改的,module和sub
    public String module = "agriculture";
    public String sub = "news";

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

    /*
     * 处理顺序：先是service，后根据情况doGet或者doPost
     */
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processAction(request,response);
    }
    public void processAction(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        System.out.println("session:"+session);
        request.setCharacterEncoding("UTF-8");
        try {
            ylxLog.setSession(session);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String action = request.getParameter("action");
        //todo_add.jsp，这里name="action" value="add_record"，form用post的方式提交，后端就会提取：
        //request.getParameter("action");得到value，就是add_record。

        boolean actionOk = false;
        showDebug("processAction收到的action是："+action);
        if(session.getAttribute("user_role")==null){
            try {
                processError(request, response,3,"session超时，请重新登录系统！");
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }else{
            if (action == null){
                try {
                    processError(request, response,1,"传递过来的action是null！");
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }else{
                //这几个常规增删改查功能
                if (action.equals("get_record")) {
                    actionOk=true;
                    try {
                        getRecord(request, response);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if (action.equals("get_record_view")) {
                    actionOk=true;
                    try {
                        getRecordView(request, response);
                    } catch (Throwable e) {
                        e.printStackTrace();
                    }
                }
                if (action.equals("add_record")) {
                    actionOk=true;
                    try {
                        addRecord(request, response);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if (action.equals("modify_record")) {
                    actionOk=true;
                    try {
                        modifyRecord(request, response);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if (action.equals("delete_record")) {
                    actionOk=true;
                    try {
                        deleteRecord(request, response);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if (action.equals("set_record_top")) {
                    actionOk=true;
                    try {
                        setRecordTop(request, response);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if (action.equals("export_record")) {
                    actionOk=true;
                    try {
                        exportRecord(request, response);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if (!actionOk) {
                    try {
                        processError(request, response,2,"["+module+"/"+sub+"/ServletAction]没有对应的action处理过程，请检查action是否正确！action="+action);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
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
    /*
     * 功能：查询记录
     */
    public void getRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String dbName=(String)session.getAttribute("unit_db_name");
        String action = request.getParameter("action");
        String id=request.getParameter("id");
        String title=request.getParameter("title");//查询功能使用
        String summary=request.getParameter("summary");
        String newsurl=request.getParameter("newsurl");
        String roleId=request.getParameter("role_id");//查询功能使用
        String type= request.getParameter("type");
        String timeFrom= request.getParameter("time_from");
        String timeTo= request.getParameter("time_to");
        String existResultset= request.getParameter("exist_resultset");
        String orderBy=request.getParameter("order_by");
        System.out.println("orderby:"+orderBy);
        if((existResultset==null) ||(existResultset.equals("null") || existResultset.isEmpty())) existResultset="0";
        String userId=session.getAttribute("user_id")==null?null:(String)session.getAttribute("user_id");
        String userName=session.getAttribute("user_name")==null?null:(String)session.getAttribute("user_name");
        String userRole=session.getAttribute("user_role")==null?null:(String)session.getAttribute("user_role");
        String userAvatar=session.getAttribute("user_avatar")==null?null:(String)session.getAttribute("user_avatar");
        //这里可以修改成统一一个函数读取变量，下面的session里的attr可以用一个变量代替
        //检查输入参数是否正确先
        showDebug("[getRecord]收到页面传过来的参数是："+existResultset+","+action+","+type+","+id+","+timeFrom+","+timeTo);
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        String creator=(String)session.getAttribute("user_name");
        String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
        News query=new News();
        query.setId(id);
        query.setAction(action);
        query.setDbName(dbName);
        query.setType(type);
        query.setTitle(title);
        query.setSummary(summary);
        query.setTimeFrom(timeFrom);
        query.setTimeTo(timeTo);
        query.setUserId(userId);
        query.setUserRole(userRole);
        query.setOrderBy(orderBy);
        query.setRoleId(roleId);
        query.setNewsurl(newsurl);
        JSONObject jsonObj=null;
        if(existResultset.equals("1")){
            //要求提取之前查询结果，如果有就取出来，如果没有就重新查询一次，并且保存进session里
            if(session.getAttribute(module+"_"+sub+"_get_record_result")!=null){
                jsonObj=(JSONObject)session.getAttribute(module+"_"+sub+"_get_record_result");
            }else{
                //如果没有就报错
                jsonObj=new JSONObject();
                jsonObj.put("result_code",10);
                jsonObj.put("result_msg","exist_resultset参数不当，服务器当前没有结果数据！请重新设置！");
            }
        }else{
            //如果是新查询
            NewsDao NewsDao=new NewsDao();
            jsonObj=NewsDao.getRecord(query);
            session.setAttribute(module+"_"+sub+"_get_record_result",jsonObj);
        }
        jsonObj.put("user_id",userId);
        jsonObj.put("user_name",userName);
        jsonObj.put("user_role",userRole);
        jsonObj.put("user_avatar",userAvatar);
        jsonObj.put("action",action);
		/*--------------------数据查询完毕，根据交互方式返回数据--------------------*/
        boolean isAjax=true;
        System.out.println("request.getHeader(\"x-requested-with\"):"+request.getHeader("x-requested-with"));
        if(request.getHeader("x-requested-with")==null){isAjax=false;}	//判断是异步请求还是同步请求
        System.out.println("isAjax:"+isAjax);
        if(isAjax){
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
            String resultMsg="操作已经执行，请按返回按钮返回列表页面！";
            int resultCode=0;
            redirectUrl="record_list.jsp?exist_resultset=1";///getrecord的同步返回置为1，查询功能就是跳转
            resultMsg=java.net.URLEncoder.encode(resultMsg, "UTF-8");
            String url = redirectPath+"/"+redirectUrl;
            showDebug("[getRecord]结果URL："+url);
            response.sendRedirect(url);
        }
    }
    public void getRecordView(HttpServletRequest request, HttpServletResponse response) throws Throwable {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String dbName=(String)session.getAttribute("unit_db_name");
        String id=request.getParameter("id");
        String index=request.getParameter("index");
        String existResultset= request.getParameter("exist_resultset");
        if((existResultset==null) ||(existResultset.equals("null") || existResultset.isEmpty())) existResultset="0";
        String userId=session.getAttribute("user_id")==null?null:(String)session.getAttribute("user_id");
        String userName=session.getAttribute("user_name")==null?null:(String)session.getAttribute("user_name");
        //检查输入参数是否正确先
        showDebug("收到页面传过来的参数是：exist_resultset="+existResultset+",action="+action+",id="+id+",index="+index);
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        JSONObject jsonObj=null;
        News query=new News();
        query.setAction(action);
        query.setDbName(dbName);
        query.setUserId(userId);
        if(existResultset.equals("1")){			//如果是新查询
            //如果有就取出来，如果没有就重新查询一次，并且保存进session里
            if(session.getAttribute(module+"_"+sub+"_get_record_result")!=null){
                JSONObject json=(JSONObject)session.getAttribute(module+"_"+sub+"_get_record_result");
                showDebug(json.toString());
                jsonObj=getResultSetNavigateId(id,index,json);
                jsonObj.put("user_id",userId);
                jsonObj.put("user_name",userName);
                jsonObj.put("action",action);
                jsonObj.put("result_code",0);
                jsonObj.put("result_msg","ok");
                //然后还有导航信息
                json=(JSONObject)session.getAttribute(module+"_"+sub+"_get_record_result");
                //showDebug("[getRecordView]重新取出来的数据是："+json.toString());
            }else{
                //如果没有就重新查询一次
                showDebug("[getRecordView]没有就重新查询一次。");
                if(dbName!=null){
                    String creator=(String)session.getAttribute("user_name");
                    String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
                    NewsDao NewsDao=new NewsDao();
                    jsonObj=NewsDao.getRecord(query);
                    jsonObj.put("user_id",userId);
                    jsonObj.put("user_name",userName);
                    jsonObj.put("action",action);
                    jsonObj.put("result_code",0);
                    jsonObj.put("result_msg","ok");
                    session.setAttribute(module+"_"+sub+"_get_record_result",jsonObj);
                }
            }
        }else{
            showDebug("[getRecordView]existsResult=0，重新查询");
            if(dbName!=null){
                String creator=(String)session.getAttribute("user_name");
                String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
                NewsDao NewsDao=new NewsDao();
                jsonObj=NewsDao.getRecord(query);
                jsonObj.put("user_id",userId);
                jsonObj.put("user_name",userName);
                jsonObj.put("action",action);
                session.setAttribute(module+"_"+sub+"_get_record_result",jsonObj);
            }
        }
        boolean isAjax=true;
        if(request.getHeader("x-requested-with")==null){isAjax=false;}	//判断是异步请求还是同步请求
        if(isAjax){
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
            String resultMsg="操作已经执行，请按返回按钮返回列表页面！";
            int resultCode=0;
            redirectUrl="record_list.jsp";
            resultMsg=java.net.URLEncoder.encode(resultMsg, "UTF-8");
            String url = resultUrl+"?result_msg="+resultMsg+"&result_code="+resultCode+"&redirect_url="+redirectUrl;
            showDebug("getRecordById结果URL："+url);
            response.sendRedirect(url);
        }
    }
    private JSONObject getResultSetNavigateId(String id,String index,JSONObject json) throws NumberFormatException, JSONException{
        //然后找到对应id的记录
        JSONArray jsonList=new JSONArray();
        //根据id获得index
        if(id!=null && !id.isEmpty()){
            index=getRecordIndexFromId(id,json);//获取顺序序号

        }
        ArrayList list=(ArrayList)json.getJSONArray("aaData").get(Integer.parseInt(index));
        jsonList.put(list);
        int count=json.getJSONArray("aaData").length();
        JSONObject jsonObj=new JSONObject();
        jsonObj.put("count",count);
        jsonObj.put("first",0);
        if(Integer.parseInt(index)>0)
            jsonObj.put("prev",Integer.parseInt(index)-1);
        else
            jsonObj.put("prev",0);
        if(Integer.parseInt(index)<(count-1))
            jsonObj.put("next",Integer.parseInt(index)+1);
        else
            jsonObj.put("next",count-1);
        jsonObj.put("last",count-1);
        jsonObj.put("total",count);
        jsonObj.put("current_index",index);
        jsonObj.put("aaData",jsonList);
        return jsonObj;
    }
    private String getRecordIndexFromId(String id,JSONObject json) throws JSONException{
        String index="-1";
        JSONArray jsonArr=(JSONArray)json.getJSONArray("aaData");
        for(int i=0;i<jsonArr.length();i++){
            ArrayList list=(ArrayList)jsonArr.get(i);
            //System.out.println(list.get(0)+"");
            if(id.equals(list.get(0)+"")){
                index=list.get(13)+"";//序号位
                break;
            }
        }
        return index;
    };
    public void addRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String dbName=(String)session.getAttribute("unit_db_name");
        String agricultureId=request.getParameter("agriculture_id");
        String title=request.getParameter("title");
        String summary=request.getParameter("summary");
        String newsurl=request.getParameter("newsurl");
        String status=request.getParameter("status");
        String roleId=request.getParameter("role_id");
        System.out.println("roleid:"+roleId);
        String limitTime=request.getParameter("limit_time");
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        JSONObject jsonObj=null;
        //检查输入参数是否正确先
        if(dbName!=null){
            String userId=session.getAttribute("user_id")==null?null:(String)session.getAttribute("user_id");
            String creator=(String)session.getAttribute("user_name");///////
            String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
			/*----------------------------------------数据获取完毕，开始和数据库交互*/
            NewsDao NewsDao=new NewsDao();
            News news=new News();
            news.setAction(action);
            news.setDbName(dbName);
            news.setParentId(agricultureId);
            news.setTitle(title);
            news.setSummary(summary);
            news.setLimitTime(limitTime);
            news.setUserId(userId);
            news.setCreator(creator);
            news.setCreateTime(createTime);
            news.setRoleId(roleId);
            news.setNewsurl(newsurl);
            jsonObj=NewsDao.addRecord(news);
            ylxLog.log("用户 "+creator+" 于 "+createTime+" 添加了 ["+module+"]["+sub+"] 记录，用户名为["+title+"]","添加记录",module,sub);
        }
        boolean isAjax=true;
        if(request.getHeader("x-requested-with")==null){isAjax=false;}	//判断是异步请求还是同步请求
        System.out.println(isAjax);
        if(isAjax){
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
            String message="添加成功";
            //mm=java.net.URLEncoder.encode(mm, "UTF-8");
            session.setAttribute(module+"_"+sub+"_message",message);
            String url=module + "/" + sub+ "/" +"record_list.jsp";
            showDebug("[addRecord]结果URL："+url);
            response.sendRedirect(url);


            //JOptionPane.showMessageDialog(null, "标题【错误】", "格式输入错误", JOptionPane.ERROR_MESSAGE);
            //response.sendRedirect(module + "/" + sub+ "/" +"record_list.jsp");
            //System.out.println("jieshu");

            /*
            String resultMsg="ok";
            int resultCode=0;
            resultMsg="操作已经执行，请按返回按钮返回列表页面！";
            redirectUrl="news_list.jsp";////////////
            resultMsg=java.net.URLEncoder.encode(resultMsg, "UTF-8");
            String url = resultUrl+"?result_msg="+resultMsg+"&result_code="+resultCode+"&redirect_url="+redirectUrl;
            showDebug("[addRecord]结果URL："+url);
            response.sendRedirect(url);
            //跳转到resultUrl，即result.jsp，并且传递参数，提示信息resultMsg和resultCode和一个返回连接redirectUrl
            //具体如何跳转视resultCode而定
            */
        }
    }
    /*
     * 功能：修改记录
     */
    public void modifyRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String dbName=(String)session.getAttribute("unit_db_name");
        String id=request.getParameter("id");
        String title=request.getParameter("title");
        String summary=request.getParameter("summary");
        String roleId=request.getParameter("role_id");
        String limitTime=request.getParameter("limit_time");
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        JSONObject jsonObj=null;
        //检查输入参数是否正确先
        System.out.println(id);
        if(id!=null && dbName!=null){
            String creator=(String)session.getAttribute("user_name");
            String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
            NewsDao NewsDao=new NewsDao();
            News news=new News();
            news.setId(id);
            news.setDbName(dbName);
            news.setTitle(title);
            news.setSummary(summary);
            news.setRoleId(roleId);
            news.setLimitTime(limitTime);
            news.setCreator(creator);
            news.setCreateTime(createTime);
            jsonObj=NewsDao.modifyRecord(news);
            System.out.println("下面是日志修改");
            ylxLog.log("用户 "+creator+" 于 "+createTime+" 修改了 ["+module+"]["+sub+"] 记录，id为["+id+"]","修改记录",module,sub);
        }
        boolean isAjax=true;
        if(request.getHeader("x-requested-with")==null){isAjax=false;}	//判断是异步请求还是同步请求
        if(isAjax){
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
            String message="修改成功";
            //mm=java.net.URLEncoder.encode(mm, "UTF-8");
            session.setAttribute(module+"_"+sub+"_message",message);
            String url=module + "/" + sub+ "/" +"record_list.jsp";
            showDebug("[modifyRecord]结果URL："+url);
            response.sendRedirect(url);



//            String resultMsg="操作已经执行，请按返回按钮返回列表页面！";
//            int resultCode=0;
//            redirectUrl="news_list.jsp";
//            resultMsg=java.net.URLEncoder.encode(resultMsg, "UTF-8");
//            String url = resultUrl+"?result_msg="+resultMsg+"&result_code="+resultCode+"&redirect_url="+redirectUrl;
//
//            response.sendRedirect(url);


        }
    }
    public void deleteRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String dbName=(String)session.getAttribute("unit_db_name");
        String[] ids = request.getParameterValues("id");

		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        JSONObject jsonObj=null;
        //检查输入参数是否正确先
        if(ids!=null && dbName!=null){
            String creator=(String)session.getAttribute("user_name");
            String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
			/*----------------------------------------数据获取完毕，开始和数据库交互*/
            NewsDao NewsDao=new NewsDao();
            jsonObj=NewsDao.deleteRecord(action,dbName,ids,creator,createTime);
            for(int i=0;i<ids.length;i++){
                ylxLog.log("用户 "+creator+" 于 "+createTime+" 删除了 ["+module+"]["+sub+"] 记录，id为["+ids[i]+"]","删除记录",module,sub);
            }

        }
        boolean isAjax=true;
        if(request.getHeader("x-requested-with")==null){isAjax=false;}	//判断是异步请求还是同步请求
        if(isAjax){
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
            String resultMsg="操作已经执行，请按返回按钮返回列表页面！";
            int resultCode=0;
            redirectUrl="record_list.jsp";
            resultMsg=java.net.URLEncoder.encode(resultMsg, "UTF-8");
            String url = resultUrl+"?result_msg="+resultMsg+"&result_code="+resultCode+"&redirect_url="+redirectUrl;
            showDebug("[deleteRecord]结果URL："+url);
            response.sendRedirect(url);
        }
    }
    public void setRecordTop(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String dbName=(String)session.getAttribute("unit_db_name");
        String id=request.getParameter("id");
        String summary=request.getParameter("summary");
        String type= request.getParameter("type");
        String userId=session.getAttribute("user_id")==null?null:(String)session.getAttribute("user_id");
        String userName=session.getAttribute("user_name")==null?null:(String)session.getAttribute("user_name");

		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        JSONObject jsonObj=null;
        //检查输入参数是否正确先
        if(dbName!=null){
            String creator=(String)session.getAttribute("user_name");
            String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
            NewsDao NewsDao=new NewsDao();
            jsonObj=NewsDao.setRecordTop(action,dbName,type,userId,id);
            jsonObj.put("user_id",userId);
            jsonObj.put("user_name",userName);
        }
        boolean isAjax=true;
        if(request.getHeader("x-requested-with")==null){isAjax=false;}	//判断是异步请求还是同步请求
        if(isAjax){
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
            session.setAttribute(module+"_"+sub+"_get_record_result",jsonObj);
            String resultMsg="操作已经执行，请按返回按钮返回列表页面！";
            int resultCode=0;
            redirectUrl="record_list.jsp";
            resultMsg=java.net.URLEncoder.encode(resultMsg, "UTF-8");
            String url = resultUrl+"?result_msg="+resultMsg+"&result_code="+resultCode+"&redirect_url="+redirectUrl;
            showDebug("[setRecordTop]结果URL："+url);
            response.sendRedirect(url);
        }
    }
    public void exportRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        String dbName=(String)session.getAttribute("unit_db_name");
        String action = request.getParameter("action");
        String existResultset= request.getParameter("exist_resultset");
        if((existResultset==null) ||(existResultset.equals("null") || existResultset.isEmpty())) existResultset="0";
        String userId=session.getAttribute("user_id")==null?null:(String)session.getAttribute("user_id");
        String userName=session.getAttribute("user_name")==null?null:(String)session.getAttribute("user_name");
        String userRole=session.getAttribute("user_role")==null?null:(String)session.getAttribute("user_role");
        String userAvatar=session.getAttribute("user_avatar")==null?null:(String)session.getAttribute("user_avatar");
        //这里可以修改成统一一个函数读取变量，下面的session里的attr可以用一个变量代替
        //检查输入参数是否正确先
        showDebug("[exportRecord]收到页面传过来的参数是："+existResultset+","+action);
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        String creator=(String)session.getAttribute("user_name");
        String createTime=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
        //String exportFilePathName="C:\\upload\\agriculture\\export\\news_export_"+(new SimpleDateFormat("yyyyMMddHHmmss")).format(new Date())+".xls";
        String exportFilePathName="C:\\download\\XM18\\";
        String filename="news_export_"+(new SimpleDateFormat("yyyyMMddHHmmss")).format(new Date())+".xls";
        exportFilePathName+=filename;
        System.out.println(exportFilePathName);
        JSONObject jsonObj=null;
        if(existResultset.equals("1")){
            //要求从session提取之前查询结果，如果有就取出来，如果没有就报错
            if(session.getAttribute(module+"_"+sub+"_get_record_result")!=null){
                jsonObj=(JSONObject)session.getAttribute(module+"_"+sub+"_get_record_result");
                //取出来以后，导出
                exportData(jsonObj,exportFilePathName);

                session.setAttribute("url","/pa/"+filename);
                //System.out.println("pa/"+filename);
                File f= new File(exportFilePathName);
                long fileLength=f.length();
                session.setAttribute("fileLength",fileLength);
                System.out.println("长度"+f.length());
            }else{
                //如果没有就报错
                jsonObj=new JSONObject();
                jsonObj.put("result_code",10);
                jsonObj.put("result_msg","exist_resultset参数不当，服务器当前没有结果数据！请重新设置！");
            }
        }else{
            //如果没有就报错
            jsonObj=new JSONObject();
            jsonObj.put("result_code",10);
            jsonObj.put("result_msg","exist_resultset参数不当，服务器当前没有结果数据！请重新设置！");
        }
        jsonObj.put("user_id",userId);
        jsonObj.put("user_name",userName);
        jsonObj.put("user_role",userRole);
        jsonObj.put("user_avatar",userAvatar);
        jsonObj.put("action",action);
		/*--------------------数据查询完毕，根据交互方式返回数据--------------------*/
        boolean isAjax=true;
        if(request.getHeader("x-requested-with")==null){isAjax=false;}	//判断是异步请求还是同步请求
        if(isAjax){
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
            String resultMsg="操作已经执行，文件已导出到：“"+exportFilePathName+"”，请按返回按钮返回列表页面！";
            int resultCode=0;
            redirectUrl="record_list.jsp?exist_resultset=1";
            resultMsg=java.net.URLEncoder.encode(resultMsg, "UTF-8");
            String url = resultUrl+"?result_msg="+resultMsg+"&result_code="+resultCode+"&redirect_url="+redirectUrl+"&redirect_param_name=exist_resultset&redirect_param=1";
            showDebug("[exportRecord]结果URL："+url);
            //response.sendRedirect(url);


            String mm="导出成功,点击下载链接下载";
            mm=java.net.URLEncoder.encode(mm, "UTF-8");
            response.sendRedirect(module+"/"+sub+"/record_list.jsp?exist_resultset=1&result_msg="+mm);

        }
    }
    public void exportData(JSONObject jsonObj,String filePathName) throws Exception {
        if(jsonObj!=null){
            //开始导出到excel
            ExcelWriter ew=new ExcelWriter();
            //需要观察json里的格式
            String[] cols={"role_id⊙text⊙id","time_interval⊙text⊙news_name","count⊙text⊙summary","color⊙text⊙newsurl","color_name⊙text⊙register_time",
                    "color_name⊙text⊙status","color_name⊙text⊙end_tag","color_name⊙text⊙user_id","color_name⊙text⊙creator","color_name⊙text⊙role_id",
                    "color_name⊙text⊙create_time"};	//name⊙type⊙nick
            ew.CreExcel(jsonObj, "用户数据", cols, filePathName);//路径+表名，把jsonObj里的数据存到cols里,存到文件里
            jsonObj.put("result_code",0);
            jsonObj.put("result_msg","读取了上一次的查询配置");
        }
    }
    public static final String DEF_CHATSET = "UTF-8";
    public static final int DEF_CONN_TIMEOUT = 30000;
    public static final int DEF_READ_TIMEOUT = 30000;
    public static String userAgent =  "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36";

    //配置您申请的KEY
    public static final String APPKEY ="7f2a21548ca5f12ae441512124b8a581";

    //1.新闻检索
    public static void getRequest1(){
        String result =null;
        String url ="http://v.juhe.cn/toutiao/index?key=7f2a21548ca5f12ae441512124b8a581";//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("q","");//需要检索的关键字,请UTF8 URLENCODE
        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
        params.put("dtype","");//返回数据的格式,xml或json，默认json

        try {
            result =net(url, params, "GET");
            JSONObject object = new JSONObject(result);
            System.out.println(object.get("result"));
            if(object.getInt("error_code")==0){
                System.out.println(object.get("result"));
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //2.实时热点
    public static void getRequest2(){
        String result =null;
        String url ="http://v.juhe.cn/toutiao/index?key=7f2a21548ca5f12ae441512124b8a581";//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
        params.put("dtype","");//返回数据的格式,xml或json，默认json

        try {
            result =net(url, params, "GET");
            JSONObject object = new JSONObject(result);
            if(object.getInt("error_code")==0){
                System.out.println(object.get("result"));
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     *
     * @param strUrl 请求地址
     * @param params 请求参数
     * @param method 请求方法
     * @return  网络请求字符串
     * @throws Exception
     */
    public static String net(String strUrl, Map params,String method) throws Exception {
        HttpURLConnection conn = null;
        BufferedReader reader = null;
        String rs = null;
        try {
            StringBuffer sb = new StringBuffer();
            if(method==null || method.equals("GET")){
                strUrl = strUrl+"?"+urlencode(params);
            }
            URL url = new URL(strUrl);
            conn = (HttpURLConnection) url.openConnection();
            if(method==null || method.equals("GET")){
                conn.setRequestMethod("GET");
            }else{
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
            }
            conn.setRequestProperty("User-agent", userAgent);
            conn.setUseCaches(false);
            conn.setConnectTimeout(DEF_CONN_TIMEOUT);
            conn.setReadTimeout(DEF_READ_TIMEOUT);
            conn.setInstanceFollowRedirects(false);
            conn.connect();
            if (params!= null && method.equals("POST")) {
                try {
                    DataOutputStream out = new DataOutputStream(conn.getOutputStream());
                    out.writeBytes(urlencode(params));
                } catch (Exception e) {
                    // TODO: handle exception
                }
            }
            InputStream is = conn.getInputStream();
            reader = new BufferedReader(new InputStreamReader(is, DEF_CHATSET));
            String strRead = null;
            while ((strRead = reader.readLine()) != null) {
                sb.append(strRead);
            }
            rs = sb.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                reader.close();
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
        return rs;
    }

    //将map型转为请求参数型
    public static String urlencode(Map<String,Object>data) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry i : data.entrySet()) {
            try {
                sb.append(i.getKey()).append("=").append(URLEncoder.encode(i.getValue()+"","UTF-8")).append("&");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }
//    public void insertRecord() throws SQLException{
//        getRequest1();
//        JSONObject object=new JSONObject();
//        String register_time[]=new String[object.size()];
//        Statement stmt=null;
//        String strSQL="";
//        String timePoint="";
//        for(int i=0;i<object.size();i++){
//            register_time=object.getJSONObject(i).getString("date");
//            strSQL="insert into agriculture_news (refister_time) values('"
//                    +register_time[i]+"');";
//        }
//    }
}
