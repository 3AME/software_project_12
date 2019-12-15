package agriculture.publicLog;

/**
 * Created by anfan on 2019-12-06.
 */
import agriculture.dao.PublicLog;
import agriculture.dao.PublicLogDao;
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
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class ServletAction extends HttpServlet {
    //这里是需要改的,module和sub
    public String module = "agriculture";
    public String sub = "publicLog";

    public String preFix = module + "_" + sub;
    public String resultPath = module + "/" + sub;
    public String resultPage = "result.jsp";
    public String resultUrl = resultPath + "/" + resultPage;
    public String redirectPath = module + "/" + sub;
    public String redirectPage = "record_list.jsp";
    public String redirectUrl = redirectPath + "/" + redirectPage;
    public String databaseName = "ylxdb";
    public SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public LogEvent ylxLog = new LogEvent();

    /*
     * 处理顺序：先是service，后根据情况doGet或者doPost
     */
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processAction(request, response);
    }

    public void processAction(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        System.out.println("session:" + session);
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
        showDebug("processAction收到的action是：" + action);
        if (session.getAttribute("user_role") == null) {
            try {
                processError(request, response, 3, "session超时，请重新登录系统！");
            } catch (JSONException e) {
                e.printStackTrace();
            }
        } else {
            if (action == null) {
                try {
                    processError(request, response, 1, "传递过来的action是null！");
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            } else {
                //这几个常规增删改查功能
                if (action.equals("get_record")) {
                    actionOk = true;
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

                if (!actionOk) {
                    try {
                        processError(request, response, 2, "[" + module + "/" + sub + "/ServletAction]没有对应的action处理过程，请检查action是否正确！action=" + action);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    public void processError(HttpServletRequest request, HttpServletResponse response, int errorNo, String errorMsg) throws JSONException, IOException {
        String action = request.getParameter("action");
        //errorNo=0->没有错误
        //errorNo=1->action是空值
        //errorNo=2->没有对应的处理该action的函数
        //errorNo=3->session超时
        showDebug("错误信息：" + errorMsg + "，代码：" + errorNo);
        JSONObject jsonObj = new JSONObject();
        boolean isAjax = true;
        if (request.getHeader("x-requested-with") == null) {
            isAjax = false;
        }    //判断是异步请求还是同步请求
        if (isAjax) {
            jsonObj.put("result_code", errorNo);
            jsonObj.put("result_msg", errorMsg);
            jsonObj.put("action", action);
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
        } else {
            errorMsg = java.net.URLEncoder.encode(errorMsg, "UTF-8");
            String url = resultPath + "/" + resultPage + "?action=" + action + "&result_code=" + errorNo + "&redirect_path=" + redirectPath + "&redirect_page=" + redirectPage + "&result_msg=" + errorMsg;
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

    public void showDebug(String msg) {
        System.out.println("[" + (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date()) + "][" + module + "/" + sub + "/ServletAction]" + msg);
    }

    /*
     * 功能：查询记录
     */
    public void getRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.print("getReocrd in publicLog entered!");
        HttpSession session = request.getSession();
        String dbName = (String) session.getAttribute("unit_db_name");
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        String colModule = request.getParameter("col_module");//查询功能使用
        String colUserId = request.getParameter("col_user_id");


        String existResultset = request.getParameter("exist_resultset");

        if ((existResultset == null) || (existResultset.equals("null") || existResultset.isEmpty()))
            existResultset = "0";
        String userId = session.getAttribute("user_id") == null ? null : (String) session.getAttribute("user_id");
        String userName = session.getAttribute("user_name") == null ? null : (String) session.getAttribute("user_name");
        String userRole = session.getAttribute("user_role") == null ? null : (String) session.getAttribute("user_role");
        String userAvatar = session.getAttribute("user_avatar") == null ? null : (String) session.getAttribute("user_avatar");
        //这里可以修改成统一一个函数读取变量，下面的session里的attr可以用一个变量代替
        //检查输入参数是否正确先
        showDebug("[getRecord]收到页面传过来的参数是：" + existResultset + "," + action + "," + colUserId + "," + id + "," + colModule);
        /*----------------------------------------数据获取完毕，开始和数据库交互*/
        String creator = (String) session.getAttribute("user_name");
        String createTime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
        PublicLog query = new PublicLog();
        query.setId(id);
        query.setAction(action);
        query.setDbName(dbName);
        query.setColUserId(colUserId);
        query.setColModule(colModule);

        JSONObject jsonObj = null;
        if (existResultset.equals("1")) {
            //要求提取之前查询结果，如果有就取出来，如果没有就重新查询一次，并且保存进session里
            if (session.getAttribute(module + "_" + sub + "_get_record_result") != null) {
                jsonObj = (JSONObject) session.getAttribute(module + "_" + sub + "_get_record_result");
            } else {
                //如果没有就报错
                jsonObj = new JSONObject();
                jsonObj.put("result_code", 10);
                jsonObj.put("result_msg", "exist_resultset参数不当，服务器当前没有结果数据！请重新设置！");
            }
        } else {
            //如果是新查询
            PublicLogDao publicLogDao = new PublicLogDao();
            jsonObj = publicLogDao.getRecord(query);
            session.setAttribute(module + "_" + sub + "_get_record_result", jsonObj);
        }
        System.out.println("the json in getRecord in publicLog servletAction is " + jsonObj);
        jsonObj.put("user_id", userId);
        jsonObj.put("user_name", userName);
        jsonObj.put("user_role", userRole);
        jsonObj.put("user_avatar", userAvatar);
        jsonObj.put("action", action);
        /*--------------------数据查询完毕，根据交互方式返回数据--------------------*/
        boolean isAjax = true;
        System.out.println("request.getHeader(\"x-requested-with\"):" + request.getHeader("x-requested-with"));
        if (request.getHeader("x-requested-with") == null) {
            isAjax = false;
        }    //判断是异步请求还是同步请求
        System.out.println("isAjax:" + isAjax);
        if (isAjax) {
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
        } else {
            String resultMsg = "操作已经执行，请按返回按钮返回列表页面！";
            int resultCode = 0;
            redirectUrl = "record_list.jsp?exist_resultset=1";///getrecord的同步返回置为1，查询功能就是跳转
            resultMsg = java.net.URLEncoder.encode(resultMsg, "UTF-8");
            String url = redirectPath + "/" + redirectUrl;
            showDebug("[getRecord]结果URL：" + url);
            response.sendRedirect(url);
        }
    }

    public void getRecordView(HttpServletRequest request, HttpServletResponse response) throws Throwable {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String dbName = (String) session.getAttribute("unit_db_name");
        String id = request.getParameter("id");
        String index = request.getParameter("index");
        String existResultset = request.getParameter("exist_resultset");
        if ((existResultset == null) || (existResultset.equals("null") || existResultset.isEmpty()))
            existResultset = "0";
        String userId = session.getAttribute("user_id") == null ? null : (String) session.getAttribute("user_id");
        String userName = session.getAttribute("user_name") == null ? null : (String) session.getAttribute("user_name");
        //检查输入参数是否正确先
        showDebug("收到页面传过来的参数是：exist_resultset=" + existResultset + ",action=" + action + ",id=" + id + ",index=" + index);
		/*----------------------------------------数据获取完毕，开始和数据库交互*/
        JSONObject jsonObj = null;
        PublicLog query = new PublicLog();
        query.setAction(action);
        query.setDbName(dbName);

        if (existResultset.equals("1")) {            //如果是新查询
            //如果有就取出来，如果没有就重新查询一次，并且保存进session里
            if (session.getAttribute(module + "_" + sub + "_get_record_result") != null) {
                JSONObject json = (JSONObject) session.getAttribute(module + "_" + sub + "_get_record_result");
                showDebug(json.toString());
                jsonObj = getResultSetNavigateId(id, index, json);
                jsonObj.put("user_id", userId);
                jsonObj.put("user_name", userName);
                jsonObj.put("action", action);
                jsonObj.put("result_code", 0);
                jsonObj.put("result_msg", "ok");
                //然后还有导航信息
                json = (JSONObject) session.getAttribute(module + "_" + sub + "_get_record_result");
                //showDebug("[getRecordView]重新取出来的数据是："+json.toString());
            } else {
                //如果没有就重新查询一次
                showDebug("[getRecordView]没有就重新查询一次。");
                if (dbName != null) {
                    String creator = (String) session.getAttribute("user_name");
                    String createTime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
                    PublicLogDao publicLogDao = new PublicLogDao();
                    jsonObj = publicLogDao.getRecord(query);
                    jsonObj.put("user_id", userId);
                    jsonObj.put("user_name", userName);
                    jsonObj.put("action", action);
                    jsonObj.put("result_code", 0);
                    jsonObj.put("result_msg", "ok");
                    session.setAttribute(module + "_" + sub + "_get_record_result", jsonObj);
                }
            }
        } else {
            showDebug("[getRecordView]existsResult=0，重新查询");
            if (dbName != null) {
                String creator = (String) session.getAttribute("user_name");
                String createTime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
                PublicLogDao publicLogDao = new PublicLogDao();
                jsonObj = publicLogDao.getRecord(query);
                jsonObj.put("user_id", userId);
                jsonObj.put("user_name", userName);
                jsonObj.put("action", action);
                session.setAttribute(module + "_" + sub + "_get_record_result", jsonObj);
            }
        }
        boolean isAjax = true;
        if (request.getHeader("x-requested-with") == null) {
            isAjax = false;
        }    //判断是异步请求还是同步请求
        if (isAjax) {
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
        } else {
            String resultMsg = "操作已经执行，请按返回按钮返回列表页面！";
            int resultCode = 0;
            redirectUrl = "record_list.jsp";
            resultMsg = java.net.URLEncoder.encode(resultMsg, "UTF-8");
            String url = resultUrl + "?result_msg=" + resultMsg + "&result_code=" + resultCode + "&redirect_url=" + redirectUrl;
            showDebug("getRecordById结果URL：" + url);
            response.sendRedirect(url);
        }
    }

    private JSONObject getResultSetNavigateId(String id, String index, JSONObject json) throws NumberFormatException, JSONException {
        //然后找到对应id的记录
        JSONArray jsonList = new JSONArray();
        //根据id获得index
        if (id != null && !id.isEmpty()) {
            index = getRecordIndexFromId(id, json);//获取顺序序号

        }
        ArrayList list = (ArrayList) json.getJSONArray("aaData").get(Integer.parseInt(index));
        jsonList.put(list);
        int count = json.getJSONArray("aaData").length();
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("count", count);
        jsonObj.put("first", 0);
        if (Integer.parseInt(index) > 0)
            jsonObj.put("prev", Integer.parseInt(index) - 1);
        else
            jsonObj.put("prev", 0);
        if (Integer.parseInt(index) < (count - 1))
            jsonObj.put("next", Integer.parseInt(index) + 1);
        else
            jsonObj.put("next", count - 1);
        jsonObj.put("last", count - 1);
        jsonObj.put("total", count);
        jsonObj.put("current_index", index);
        jsonObj.put("aaData", jsonList);
        return jsonObj;
    }

    private String getRecordIndexFromId(String id, JSONObject json) throws JSONException {
        String index = "-1";
        JSONArray jsonArr = (JSONArray) json.getJSONArray("aaData");
        for (int i = 0; i < jsonArr.length(); i++) {
            ArrayList list = (ArrayList) jsonArr.get(i);
            //System.out.println(list.get(0)+"");
            if (id.equals(list.get(0) + "")) {
                index = list.get(9) + "";//序号位
                break;
            }
        }
        return index;
    }
}