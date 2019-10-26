package agriculture.dao;

import dao.DB;
import org.json.JSONException;
import org.json.JSONObject;
import agriculture.dao.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;

public class SensorDao {
	/*
	 * 功能：返回结果集
	 */
	public int[] minNum ={0, 20, 0, 30, 10};
	//minimal number of 5 kinds of data
	public int[]  maxNum = {25, 100, 30, 100, 7000};
	//maximal number of 5 kinds of data.

	public void handleAbnormalData(int id,String valueString,String valueType){
		System.out.println("handleAbnormalData in sensorDao enetered!!!!");
		List jsonList = new ArrayList();
		DB query_db = new DB("agriculture");
		//构造sql语句，根据传递过来的查询条件参数
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式

		String tableName="agriculture_alarm";
		String sql="insert into "+tableName+"(value_string,value_float,handle_status,send_status,creator,create_time,value_type) values('"
				+valueString+"','"
				+Float.parseFloat(valueString)+"','"
				+0+"','"
				+0+"','"
				+"PROGRAM"+"','"
				+df.format(new Date())+"','"
				+valueType+"')";
		query_db.executeUpdate(sql);
		System.out.println("sql in handleAbnormalData is "+sql);

		//构造sql语句，根据传递过来的查询条件参数
		tableName="agriculture_sensor";

		sql="update "+tableName
				+" set handle_status='"
				+1
				+"' where id="+id;

		System.out.println(sql);
		query_db.executeUpdate(sql);
		query_db.close();
	}

	public boolean dataIsAbnormal(String valueType,float valueFloat){
		//System.out.println("dataIsAbnormal in sensorDao entered.");
		boolean flag=false;
		int index=-1;
		switch (valueType){
			case "TEMPERATURE":
				index=0;break;

			case "HUMIDITY":
				index=1;break;

			case "AIR-TEMPERATURE":
				index=2;break;

			case "AIR-HUMIDITY":
				index=3;break;

			case "LUMEN":
				index=4;break;

			default:
				System.out.println("Error in valueType in dataIsAbnormal().");
				break;
		}

		if(valueFloat<minNum[index] || valueFloat>maxNum[index]){
			flag=true;
		}
		return flag;
	}


	public JSONObject getRecord(Sensor query) throws SQLException, IOException, JSONException {
		System.out.println("================================getRecord in sensorDao entered!!!!================================");

		String tableName="agriculture_sensor";
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
			System.out.println("sql in getRecord in sensorDao is "+sql);

			ResultSet rs = query_db.executeQuery(sql);
			while (rs.next()) {
				List list = new ArrayList();
				list.add(rs.getString("id"));
				list.add(rs.getString("device_id"));
				list.add(rs.getString("value_type"));
				list.add(rs.getString("sensor_value_string"));
				list.add(rs.getString("detect_time"));
				list.add(rs.getString("creator"));
				list.add(rs.getString("create_time"));

			//	System.out.println("query.getRoleId in getRecord in sensorDao is "+query.getRoleId());
				list.add("1");
			/*	if(query.getUserId()!=null && query.getUserId().equals(rs.getString("user_id"))){//session里的uesr_id =表里的user_id
					list.add("1");
				}else{
					list.add("0");
				}
				*/
				list.add(count);
				count=count+1;	//做上下记录导航用
				list.add(rs.getString("handle_status"));

				if(
						dataIsAbnormal(rs.getString("value_type"),
						Float.parseFloat(rs.getString("sensor_value_float")))
						&& Integer.parseInt(rs.getString("handle_status"))==0
						)
				{
					handleAbnormalData(Integer.parseInt(rs.getString("id")),
							rs.getString("sensor_value_string"),
							rs.getString("value_type"));
				}


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
	public JSONObject modifyRecord(Sensor sensor) throws JSONException{
		//String action,String dbName,String id,String title(user_name),String password,String creator,String createTime
		String resultMsg="ok";
		int resultCode=0;
		List jsonList = new ArrayList();
		try {
			DB query_db = new DB(sensor.getDbName());
			//构造sql语句，根据传递过来的查询条件参数
			String tableName="agriculture_sensor";
			System.out.println("value string in modify record is "+sensor.getSensorValueString());
			System.out.println("value float in modify record is "+Float.parseFloat(sensor.getSensorValueString()));

			String sql="update "+tableName
					+" set device_id='"
					+sensor.getDeviceId()
					+"',value_type='"
					+sensor.getValueType()
					+"',sensor_value_string='"
					+sensor.getSensorValueString()
					+"',sensor_value_float='"
					+Float.parseFloat(sensor.getSensorValueString())
					+"' where id="+sensor.getId();
			
			System.out.println(sql);
            query_db.executeUpdate(sql);
			sql="select * from "+tableName+" order by create_time desc";
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
		jsonObj.put("action",sensor.getAction());
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
			String tableName="agriculture_sensor";
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
	public JSONObject addRecord(Sensor sensor) throws JSONException, SQLException{
		String resultMsg="ok";
		int resultCode=0;
		List jsonList = new ArrayList();
		DB query_db = new DB(sensor.getDbName());
		//构造sql语句，根据传递过来的查询条件参数
		String tableName="agriculture_sensor";
		String sql="insert into "
				+tableName
				+"(device_id,value_type,sensor_value_string,sensor_value_float,detect_time,creator,create_time) values('"
				+sensor.getDeviceId()+"','"
				+sensor.getValueType()+"','"
				+sensor.getSensorValueString()+"','"
				+Float.parseFloat(sensor.getSensorValueString())+"','"
				+sensor.getDetectTime()+"','"
				+sensor.getCreator()+"','"
				+sensor.getCreateTime()+"')";

		query_db.executeUpdate(sql);
		query_db.close();
		//下面开始构建返回的json
		JSONObject jsonObj=new JSONObject();
		jsonObj.put("aaData",jsonList);
		jsonObj.put("action",sensor.getAction());
		jsonObj.put("result_msg",resultMsg);//如果发生错误就设置成"error"等
		jsonObj.put("result_code",resultCode);//返回0表示正常，不等于0就表示有错误产生，错误代码
		return jsonObj;
	}
	public JSONObject deleteRecord(String action,String dbName,String[] ids,String creator,String createTime) throws JSONException, SQLException{
		String tableName="agriculture_sensor";
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
		String tableName="agriculture_sensor";
		String resultMsg="ok";
		int resultCode=0;
		List jsonList = new ArrayList();
		DB query_db = new DB(dbName);
		DB update_db = new DB(dbName);
		//构造sql语句，根据传递过来的查询条件参数
		//String sql="select max(priority) as priority from agriculture_sensor where user_id='"+userId+"'";
		String sql="select max(priority) as priority from agriculture_sensor";
		int priority=0;
		ResultSet rs=query_db.executeQuery(sql);
		if(rs.next()){
			priority=rs.getInt("priority");
		}
		query_db.close();
		update_db.executeUpdate("update agriculture_sensor set priority="+(priority+1)+" where id="+id);
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
	private String createGetRecordSql(Sensor query){
		String sql="";
		String where="";
        System.out.println("id:"+query.getId());
        //构造查询条件where开始
		if(query.getId()!=null && !query.getId().equals("null")&&  !query.getId().equals("undefined")){/////
			where="where id="+query.getId();
		}
		if(query.getDeviceId()!=null && !query.getDeviceId().equals("null") && !query.getDeviceId().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and device_id like '%"+query.getDeviceId()+"%'";//title改成user_name
            }else{
                where="where device_id like '%"+query.getDeviceId()+"%'";
            }
        }
        if(query.getValueType()!=null && !query.getValueType().equals("null") && !query.getValueType().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and value_type like '%"+query.getValueType()+"%'";//title改成user_name
            }else{
                where="where value_type like '%"+query.getValueType()+"%'";
            }
        }
        //System.out.println(query.getRoleId());
        if(query.getSensorValueString()!=null && !query.getSensorValueString().equals("null") && !query.getSensorValueString().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and sensor_value_string= '"+query.getSensorValueString()+"'";//title改成user_name
            }else{
                where="where sensor_value_string= '"+query.getSensorValueString()+"'";
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
		System.out.println("orderby in createSql in sensorDao is "+query.getOrderBy());
        if(query.getOrderBy()!=null && !query.getOrderBy().equals("null")  && !query.getOrderBy().isEmpty())
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
