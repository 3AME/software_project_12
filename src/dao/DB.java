package dao;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

public class DB {

    private Connection a;
    private Statement statement;
    private String drivername;
    private String database;
    private Integer debugLevel=1;

    public DB(String s) {

        database = s;
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException classnotfoundexception) {
            classnotfoundexception.printStackTrace();
        }
        try {
            System.out.println("DB.java里面准备statement!!!");
            //a= DriverManager.getConnection("jdbc:mysql://192.168.1.114:3306/test?user=dbUser&password=123456w&useUnicode=true&characterEncoding=utf-8");
            //a= DriverManager.getConnection("jdbc:mysql://192.168.43.77:3306/"+s+"?user=dbUser&password=123456w&useUnicode=true&characterEncoding=utf-8");
            //a= DriverManager.getConnection("jdbc:mysql://10.132.50.57:3306/test?user=dbUser&password=123456w&useUnicode=true&characterEncoding=utf-8");
            //System.out.println(s1);
            a= DriverManager.getConnection("jdbc:mysql://localhost:3306/"+s+"?user=newXM18&password=123456w&useUnicode=true&characterEncoding=utf-8");

            statement = a.createStatement();
        } catch (SQLException sqlexception) {
            sqlexception.printStackTrace();
        }
    }

    public void close() {
        try {
            statement.close();
            a.close();
        } catch (SQLException sqlexception) {
            sqlexception.printStackTrace();
        }
    }

    public ResultSet executeQuery(String s) {
        ResultSet resultset = null;
        try {
            if(debugLevel>0){
                System.out.println("aa["+(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())+"]"+"DB executeQuery 数据库名"+database+":" + s);
            }
            resultset = statement.executeQuery(s);
        } catch (SQLException sqlexception) {
            sqlexception.printStackTrace();
        }
        return resultset;
    }

    public void executeUpdate(String s) {
        try {
            if(debugLevel>0){
                System.out.println("["+(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())+"]"+"DB executeUpdate:" + s);
            }
            statement.executeUpdate(s);
        } catch (SQLException sqlexception) {
            sqlexception.printStackTrace();
        }
    }

    public String getTable() {
        return database;
    }

    public void setTable(String s) {
        database = s;
    }
}
