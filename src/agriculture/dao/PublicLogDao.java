package agriculture.dao;

/**
 * Created by anfan on 2019-12-06.
 */
import dao.DB;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PublicLogDao {
    /*
     * 功能：返回结果集
     */
    public JSONObject getRecord(PublicLog query) throws SQLException, IOException, JSONException {
        String tableName="public_log";
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
                list.add(rs.getString("colContent"));
                list.add(rs.getString("colUserId"));
                list.add(rs.getString("colModule"));
                list.add(rs.getString("ip"));
                list.add(rs.getString("create_time"));
                list.add("1");
				/*
				if(query.getUserId()!=null && query.getUserId().equals(rs.getString("user_id"))){//session里的uesr_id =表里的user_id
					list.add("1");
				}else{
					list.add("0");
				}
				*/

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

    public JSONObject getRecordById(String action,String dbName,String id) throws JSONException{
        String resultMsg="ok";
        int resultCode=0;
        List jsonList = new ArrayList();
        try {
            DB query_db = new DB(dbName);
            //构造sql语句，根据传递过来的查询条件参数
            String tableName="agriculture_publicLog";
            String sql="select * from "+tableName+" where id="+id+" order by create_time desc";
            ResultSet rs = query_db.executeQuery(sql);
            while (rs.next()) {
                List list = new ArrayList();
                list.add(rs.getString("id"));

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

    /*
     * 功能：构造历史记录查询的sql语句,type=all查询所有，type=id查询某个记录，余下按照条件设置查询
     */
    private String createGetRecordSql(PublicLog query){
        String sql="";
        String where="";
        System.out.println("id:"+query.getId());
        //构造查询条件where开始
        if(query.getId()!=null && !query.getId().equals("null")&&  !query.getId().equals("undefined")){/////
            where="where id="+query.getId();
        }
/*
		if(query.getValueType()!=null && !query.getValueType().equals("null") && !query.getValueType().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and value_type like '%"+query.getValueType()+"%'";//title改成value_type
            }else{
                where="where value_type like '%"+query.getValueType()+"%'";
            }
        }
		*/
        if(query.getValueType()!=null && !query.getValueType().equals("null") && !query.getValueType().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and value_type= '"+query.getValueType()+"'";//title改成value_type
            }else{
                where="where value_type= '"+query.getValueType()+"'";
            }
        }
/*
        if(query.getExceptionDetail()!=null && !query.getExceptionDetail().equals("null") && !query.getExceptionDetail().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and exception_detail like '%"+query.getExceptionDetail()+"%'";//title改成user_name
            }else{
                where="where exception_detail like '%"+query.getExceptionDetail()+"%'";
            }
        }
		*/
        //System.out.println(query.getRoleId());
        if(query.getHandleStatus()!=null && !query.getHandleStatus().equals("null") && !query.getHandleStatus().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and handle_status= '"+query.getHandleStatus()+"'";//title改成user_name
            }else{
                where="where handle_status= '"+query.getHandleStatus()+"'";
            }
        }

        if(query.getTimeFrom()!=null && query.getTimeTo()!=null && !query.getTimeFrom().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and handle_time between '"+query.getTimeFrom()+"' and '"+query.getTimeTo()+"'";
            }else{
                where="where handle_time between '"+query.getTimeFrom()+"' and '"+query.getTimeTo()+"'";
            }
        }
        //构造查询条件where结束
        //构造排序条件orderby开始
        String orderBy="";
        System.out.println("orderBy in publicLogDao is "+query.getOrderBy());
        if(query.getOrderBy()!=null && !query.getOrderBy().equals("null") && !query.getOrderBy().isEmpty())
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