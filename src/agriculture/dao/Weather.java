package agriculture.dao;

public class Weather {
	//数据库字段
	private String id;

	private String userId;
	private String userRole;

	private String creator;
	private String createTime;
	//传递条件查询用
	private String action;
	private String dbName;
	private String tableName="";
	private String type="";
	private String timeFrom="";
	private String timeTo="";
	private String timeSelect="";
	private String groupId="";
	private String groupSelect="";
	private String timeInterval="";
	private String statisticType="";
    private String orderBy="";

	private String location="";
	private String updateTime="";
	private String tempString="";
	private String detailString="";
	private String windDirection="";
	private String windForce="";
	private String pressureString="";
	private String humidityString="";

	public String getPrecipitationString() {
		return precipitationString;
	}

	public void setPrecipitationString(String precipitationString) {
		this.precipitationString = precipitationString;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getTempString() {
		return tempString;
	}

	public void setTempString(String tempString) {
		this.tempString = tempString;
	}

	public String getDetailString() {
		return detailString;
	}

	public void setDetailString(String detailString) {
		this.detailString = detailString;
	}

	public String getWindDirection() {
		return windDirection;
	}

	public void setWindDirection(String windDirection) {
		this.windDirection = windDirection;
	}

	public String getWindForce() {
		return windForce;
	}

	public void setWindForce(String windForce) {
		this.windForce = windForce;
	}

	public String getPressureString() {
		return pressureString;
	}

	public void setPressureString(String pressureString) {
		this.pressureString = pressureString;
	}

	public String getHumidityString() {
		return humidityString;
	}

	public void setHumidityString(String humidityString) {
		this.humidityString = humidityString;
	}

	private String precipitationString="";

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getOrderBy() {
        return orderBy;
    }


	public Weather() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTimeFrom() {
		return timeFrom;
	}

	public void setTimeFrom(String timeFrom) {
		this.timeFrom = timeFrom;
	}

	public String getTimeTo() {
		return timeTo;
	}

	public void setTimeTo(String timeTo) {
		this.timeTo = timeTo;
	}

	public String getTimeSelect() {
		return timeSelect;
	}

	public void setTimeSelect(String timeSelect) {
		this.timeSelect = timeSelect;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getGroupSelect() {
		return groupSelect;
	}

	public void setGroupSelect(String groupSelect) {
		this.groupSelect = groupSelect;
	}

	public String getTimeInterval() {
		return timeInterval;
	}

	public void setTimeInterval(String timeInterval) {
		this.timeInterval = timeInterval;
	}

	public String getStatisticType() {
		return statisticType;
	}

	public void setStatisticType(String statisticType) {
		this.statisticType = statisticType;
	}

}
