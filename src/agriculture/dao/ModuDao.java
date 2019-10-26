package agriculture.dao;

/**
 * Created by 33826 on 2019/6/7.
 */

import java.sql.Connection;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthEditorPaneUI;

import org.json.JSONException;
import org.json.JSONObject;

import dao.DB;
import utility.LogEvent;

public class ModuDao{
    /*
     * 功能：返回结果集
     */
    public JSONObject getRecord(Modu query) throws SQLException, IOException, JSONException {
        String tableName="agriculture_tree";
        //开始查询数据库
        String resultMsg="ok";
        int resultCode=0;
        List jsonList = new ArrayList();
        try {
            DB query_db = new DB(query.getDbName());
            //构造sql语句，根据传递过来的查询条件参数
            String sql="";
            int count=0;
            query.setTableName(tableName);
            sql=createGetRecordSql(query);
            ResultSet rs = query_db.executeQuery(sql);
            while (rs.next()) {
                List list = new ArrayList();
                list.add(rs.getString("id"));
                list.add(rs.getString("MODULE_NAME"));
                list.add(rs.getString("role_id"));
                list.add(rs.getString("CATEGORY_ID"));
                list.add(rs.getString("PARENT_CATEGORY_ID"));
                list.add(rs.getString("FILE_PATH"));
                list.add(rs.getString("HREFLINK"));
                list.add(rs.getString("FILE_ID"));
                list.add(rs.getString("FILE_NAME"));
                list.add(rs.getString("CHAIN_NAME"));
                list.add(rs.getString("create_time"));

                list.add("1");
//				if(query.getUserId()!=null && query.getUserId().equals(rs.getString("user_id"))){//session里的uesr_id =表里的user_id
//					list.add("1");
//				}else{
//					list.add("0");
//				}
                list.add(count);
                count=count+1;	//做上下记录导航用
                jsonList.add(list);
            }
            rs.close();
            query_db.close();
        } catch (SQLException sqlexception) {
            sqlexception.printStackTrace();
            resultCode=10;
            resultMsg="查询数据库出现错误！"+sqlexception.getMessage();
        }
        //////////数据库查询完毕，得到了json数组jsonList//////////
        //jsonList.clear();
        //下面开始构建返回的json
        JSONObject jsonObj=new JSONObject();
        jsonObj.put("aaData",jsonList);
        jsonObj.put("result_msg",resultMsg);//如果发生错误就设置成"error"等
        jsonObj.put("result_code",resultCode);//返回0表示正常，不等于0就表示有错误产生，错误代码
        return jsonObj;
    }
    public JSONObject modifyRecord(Modu modu) throws JSONException{
        //String action,String dbName,String id,String FileName(user_name),String password,String creator,String createTime
        String resultMsg="ok";
        int resultCode=0;
        List jsonList = new ArrayList();
        try {
            DB query_db = new DB(modu.getDbName());
            //构造sql语句，根据传递过来的查询条件参数
            String tableName="agriculture_tree";
            String sql="update "+tableName+" set MODULE_NAME='"+modu.getModuleName()+"',CATEGORY_ID='"+modu.getCategoryId()+"',PARENT_CATEGORY_ID='"+modu.getParentCategoryId()+"',HREFLINK='"+modu.getHreflink()+"',FILE_ID='"+modu.getFileId()+"',FILE_NAME='"+modu.getFileName()+"',FILE_PATH='"+modu.getFilePath()+"' where id="+modu.getId();
            System.out.println(sql);
            query_db.executeUpdate(sql);
            sql="select * from "+tableName+" order by create_time desc";
            ResultSet rs = query_db.executeQuery(sql);
            while (rs.next()) {
                List list = new ArrayList();
                list.add(rs.getString("id"));
                list.add(rs.getString("password"));
                jsonList.add(list);
            }
            rs.close();
            query_db.close();
        } catch (SQLException sqlexception) {
            sqlexception.printStackTrace();
            resultCode=10;
            resultMsg="查询数据库出现错误！"+sqlexception.getMessage();
        }
        //下面开始构建返回的json
        JSONObject jsonObj=new JSONObject();
        jsonObj.put("aaData",jsonList);
        jsonObj.put("action",modu.getAction());
        jsonObj.put("result_msg",resultMsg);//如果发生错误就设置成"error"等
        jsonObj.put("result_code",resultCode);//返回0表示正常，不等于0就表示有错误产生，错误代码
        return jsonObj;
    }
    public JSONObject getRecordById(String action,String dbName,String id) throws JSONException{
        String resultMsg="ok";
        int resultCode=0;
        List jsonList = new ArrayList();
        try {
            DB query_db = new DB(dbName);
            //构造sql语句，根据传递过来的查询条件参数
            String tableName="agriculture_tree";
            String sql="select * from "+tableName+" where id="+id+" order by create_time desc";
            ResultSet rs = query_db.executeQuery(sql);
            while (rs.next()) {
                List list = new ArrayList();
                list.add(rs.getString("id"));
                list.add(rs.getString("password"));
                jsonList.add(list);
            }
            rs.close();
            query_db.close();
        } catch (SQLException sqlexception) {
            sqlexception.printStackTrace();
            resultCode=10;
            resultMsg="查询数据库出现错误！"+sqlexception.getMessage();
        }
        //下面开始构建返回的json
        JSONObject jsonObj=new JSONObject();
        jsonObj.put("aaData",jsonList);
        jsonObj.put("action",action);
        jsonObj.put("result_msg",resultMsg);//如果发生错误就设置成"error"等
        jsonObj.put("result_code",resultCode);//返回0表示正常，不等于0就表示有错误产生，错误代码
        return jsonObj;
    }
    public JSONObject addRecord(Modu modu) throws JSONException, SQLException{
        String resultMsg="ok";
        int resultCode=0;
        List jsonList = new ArrayList();
        DB query_db = new DB(modu.getDbName());
        //构造sql语句，根据传递过来的查询条件参数
        String tableName="agriculture_tree";
        String sql="insert into "+tableName+"(MODULE_NAME,CATEGORY_ID,PARENT_CATEGORY_ID,HREFLINK,FILE_ID,FILE_NAME,FILE_PATH,role_id,creator,create_time) values('"+modu.getModuleName()+"','"+modu.getCategoryId()+"','"+modu.getParentCategoryId()+
                "','"+modu.getHreflink()+"','"+modu.getFileId()+"','"+modu.getFileName()+"','"+modu.getFilePath()+"','"+modu.getRoleId()+"','"+modu.getCreator()+"','"+modu.getCreateTime()+"')";
        query_db.executeUpdate(sql);
        query_db.close();
        //下面开始构建返回的json
        JSONObject jsonObj=new JSONObject();
        jsonObj.put("aaData",jsonList);
        jsonObj.put("action",modu.getAction());
        jsonObj.put("result_msg",resultMsg);//如果发生错误就设置成"error"等
        jsonObj.put("result_code",resultCode);//返回0表示正常，不等于0就表示有错误产生，错误代码
        return jsonObj;
    }
    public JSONObject deleteRecord(String action,String dbName,String[] ids,String creator,String createTime) throws JSONException, SQLException{
        String tableName="agriculture_tree";
        String resultMsg="ok";
        int resultCode=0;
        List jsonList = new ArrayList();
        DB query_db = new DB(dbName);

        //构造sql语句，根据传递过来的查询条件参数
        for(int i=0;i<ids.length;i++){
            String sql="delete from "+tableName+" where id="+ids[i];
            query_db.executeUpdate(sql);

        }
        query_db.close();
        //下面开始构建返回的json
        JSONObject jsonObj=new JSONObject();
        jsonObj.put("aaData",jsonList);
        jsonObj.put("action",action);
        jsonObj.put("result_msg",resultMsg);//如果发生错误就设置成"error"等
        jsonObj.put("result_code",resultCode);//返回0表示正常，不等于0就表示有错误产生，错误代码
        return jsonObj;
    }
    public JSONObject setRecordTop(String action,String dbName,String type,String userId,String id) throws JSONException, SQLException{
        String tableName="agriculture_tree";
        String resultMsg="ok";
        int resultCode=0;
        List jsonList = new ArrayList();
        DB query_db = new DB(dbName);
        DB update_db = new DB(dbName);
        //构造sql语句，根据传递过来的查询条件参数
        //String sql="select max(priority) as priority from agriculture_users where user_id='"+userId+"'";
        String sql="select max(priority) as priority from agriculture_tree";
        int priority=0;
        ResultSet rs=query_db.executeQuery(sql);
        if(rs.next()){
            priority=rs.getInt("priority");
        }
        query_db.close();
        update_db.executeUpdate("update agriculture_tree set priority="+(priority+1)+" where id="+id);
        update_db.close();
        //下面开始构建返回的json
        JSONObject jsonObj=new JSONObject();
        jsonObj.put("aaData",jsonList);
        jsonObj.put("action",action);
        jsonObj.put("result_msg",resultMsg);//如果发生错误就设置成"error"等
        jsonObj.put("result_code",resultCode);//返回0表示正常，不等于0就表示有错误产生，错误代码
        return jsonObj;
    }
    /*
     * 功能：构造历史记录查询的sql语句,type=all查询所有，type=id查询某个记录，余下按照条件设置查询
     */
    private String createGetRecordSql(Modu query){
        String sql="";
        String where="";
        System.out.println("id:"+query.getId());
        //构造查询条件where开始
        if(query.getId()!=null && !query.getId().equals("null")&&  !query.getId().equals("undefined")){/////
            where="where id="+query.getId();
        }
        if(query.getModuleName()!=null && !query.getModuleName().equals("null") && !query.getModuleName().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and MODULE_NAME like '%"+query.getModuleName()+"%'";//FileName改成user_name
            }else{
                where="where MODULE_NAME like '%"+query.getModuleName()+"%'";
            }
        }
        if(query.getFileId()!=null && !query.getFileId().equals("null") && !query.getFileId().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and FILE_ID like '%"+query.getFileId()+"%'";//FileName改成user_name
            }else{
                where="where FILE_ID like '%"+query.getFileId()+"%'";
            }
        }
        //System.out.println(query.getRoleId());
        if(query.getRoleId()!=null && !query.getRoleId().equals("null") && !query.getRoleId().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and role_id= '"+query.getRoleId()+"'";//FileName改成user_name
            }else{
                where="where role_id= '"+query.getRoleId()+"'";
            }
        }
        if(query.getTimeFrom()!=null && query.getTimeTo()!=null && !query.getTimeFrom().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and create_time between '"+query.getTimeFrom()+"' and '"+query.getTimeTo()+"'";
            }else{
                where="where create_time between '"+query.getTimeFrom()+"' and '"+query.getTimeTo()+"'";
            }
        }
        //构造查询条件where结束
        //构造排序条件orderby开始
        String orderBy="";
        if(query.getOrderBy()!=null)
            orderBy=" order by "+query.getOrderBy();
        //构造排序条件orderby结束
        //构造sql开始
        if(query.getType()!=null && query.getType().equals("all") && query.getUserRole().equals("manager")){
            sql="select * from "+query.getTableName()+" order by create_time desc";
        }else{
            if(query.getId()!=null && !query.getId().equals("null") &&  !query.getId().equals("undefined")){/////////////
                sql="select * from "+query.getTableName()+" where id="+query.getId();
            }else{
                if(where.isEmpty()){
                    //sql="select * from "+query.getTableName()+" where user_id='"+query.getUserId()+"'"+orderBy;
                    sql="select * from "+query.getTableName()+orderBy;
                }else{
                    //sql="select * from "+query.getTableName()+" "+where+" and user_id='"+query.getUserId()+"'"+orderBy;
                    sql="select * from "+query.getTableName()+" "+where+orderBy;
                    //System.out.println("???");
                }
            }
        }
        return sql;
    }
}

