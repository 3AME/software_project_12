package agriculture.dao;

/**
 * Created by 33826 on 2019/6/26.
 */
public class Log {

    //数据库字段
    private String id;
    private String colTime;
    private String colContent;
    private String colOperation;
    private String colUserId;
    private String colModule;
    private String colSub;
    private String ip;
    private String createTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getColTime() {
        return colTime;
    }

    public void setColTime(String colTime) {
        this.colTime = colTime;
    }

    public String getColContent() {
        return colContent;
    }

    public void setColContent(String colContent) {
        this.colContent = colContent;
    }

    public String getColOperation() {
        return colOperation;
    }

    public void setColOperation(String colOperation) {
        this.colOperation = colOperation;
    }

    public String getColUserId() {
        return colUserId;
    }

    public void setColUserId(String colUserId) {
        this.colUserId = colUserId;
    }

    public String getColModule() {
        return colModule;
    }

    public void setColModule(String colModule) {
        this.colModule = colModule;
    }

    public String getColSub() {
        return colSub;
    }

    public void setColSub(String colSub) {
        this.colSub = colSub;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
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

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

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

}
