package com.CodeBuilder.core.utils;
import com.CodeBuilder.core.pojo.Setting;
import org.apache.commons.lang3.StringUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class SettingUtils {


    public static void main(String[] args){
        SettingUtils test = new SettingUtils();
        test.checkTables();
    }

    //检测是否有默认配置
    public boolean checkTables() {
        boolean check = false;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            conn = DbUtils.getConnection();
            String sql = "select count(*) as num from setting where is_default = '1' ";
            st= conn.prepareStatement(sql);
            rs = st.executeQuery();

            while (rs.next()) {
                int num = rs.getInt("num");
                if(num>0){
                    check = true;
                }
            }
        } catch (SQLException e) {
            //e.printStackTrace();
            check = false;
        }finally {
            DbUtils.colseResource(conn, st, rs);
        }
        return check;
    }

    public boolean createTable() {

        boolean check = true;

        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            conn = DbUtils.getConnection();
            String sql = "CREATE TABLE setting (" +
                    "  id INTEGER  GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL ," +
                    "  dbname varchar(255) DEFAULT NULL," +
                    "  table_name varchar(255) DEFAULT NULL," +
                    "  package_name varchar(255) DEFAULT NULL," +
                    "  create_date varchar(255) DEFAULT NULL," +
                    "  author varchar(255) DEFAULT NULL," +
                    "  table_annotation varchar(255) DEFAULT NULL," +  //表简介
                    "  file_path varchar(255) DEFAULT NULL," +  //文件生成路径
                    "  is_open varchar(5) DEFAULT NULL," +  //是否开启，0未开启，1已开启
                    "  is_default varchar(5) DEFAULT NULL," +  //是否默认设置，1为默认
                    "  PRIMARY KEY (id)" +
                    ")";
            st= conn.prepareStatement(sql);
            st.executeUpdate();

            //插入默认数据
            String insertsql = "insert into setting values(null,null,null,?,?,?,?,?,?,?)";
            st= conn.prepareStatement(insertsql);
            st.setString(1, "com.CodeBuilder"); //package_name
            SimpleDateFormat sdf =new SimpleDateFormat("yyyy/MM/dd" );
            Date d= new Date();
            String create_date = sdf.format(d);
            st.setString(2, create_date);
            st.setString(3, "CodeBuilder");
            st.setString(4, "");
            st.setString(5, "D://");
            st.setString(6, "1");
            st.setString(7, "1");
            int result = st.executeUpdate();

            if(result!=1){
                check = false;
            }
        } catch (SQLException e) {
            check = false;
            e.printStackTrace();
        }finally {
            DbUtils.colseResource(conn, st, rs);
        }

        return check;
    }



    public Setting getDefaultSetting(){

        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Setting setting = new Setting();

        try {
            conn = DbUtils.getConnection();
            String sql = "select * from setting where is_default = '1' ";
            st= conn.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                setting.setId(rs.getInt("id"));
                setting.setDbname(rs.getString("dbname"));
                setting.setPackageName(rs.getString("package_name"));
                setting.setCreateDate(rs.getString("create_date"));
                setting.setAuthor(rs.getString("author"));
                setting.setTableAnnotation(rs.getString("table_annotation"));
                setting.setFilePath(rs.getString("file_path"));
                setting.setIsDefault(rs.getString("is_default"));
                setting.setIsOpen(rs.getString("is_open"));
                setting.setIsDefault(rs.getString("is_default"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            DbUtils.colseResource(conn, st, rs);
        }
        return setting;
    }

    public Setting getTableSetting(String tableName){

        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Setting setting = new Setting();

        try {
            conn = DbUtils.getConnection();
            String sql = "select * from setting where table_name = ? ";
            st= conn.prepareStatement(sql);
            st.setString(1, tableName);
            rs = st.executeQuery();
            while (rs.next()) {
                if(StringUtils.isNotBlank(rs.getString("id"))){
                    setting.setId(rs.getInt("id"));
                    setting.setDbname(rs.getString("dbname"));
                    setting.setTableName(rs.getString("table_name"));
                    setting.setPackageName(rs.getString("package_name"));
                    setting.setCreateDate(rs.getString("create_date"));
                    setting.setAuthor(rs.getString("author"));
                    setting.setTableAnnotation(rs.getString("table_annotation"));
                    setting.setFilePath(rs.getString("file_path"));
                    setting.setIsOpen(rs.getString("is_open"));
                    setting.setIsDefault(rs.getString("is_default"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            DbUtils.colseResource(conn, st, rs);
        }
        return setting;
    }


    public void updateDefaultSetting(Setting setting){

            Connection conn = null;
            PreparedStatement st = null;
            ResultSet rs = null;

            try {
                conn = DbUtils.getConnection();
                String sql = "update setting set package_name=?,create_date=?,author=?,file_path=? where  is_default = '1' ";
                st= conn.prepareStatement(sql);
                st.setString(1, setting.getPackageName());
                st.setString(2, setting.getCreateDate());
                st.setString(3, setting.getAuthor());
                st.setString(4, setting.getFilePath());
                int result = st.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }finally {
                DbUtils.colseResource(conn, st, rs);
            }
    }

    public void updateTableSetting(Setting setting){

        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            String sql = "update setting set package_name=?,create_date=?,author=?,table_annotation=?,file_path=?,is_open=? where  id = ? ";
            st= conn.prepareStatement(sql);
            st.setString(1, setting.getPackageName());
            st.setString(2, setting.getCreateDate());
            st.setString(3, setting.getAuthor());
            st.setString(4, setting.getTableAnnotation());
            st.setString(5, setting.getFilePath());
            st.setString(6, setting.getIsOpen());
            st.setInt(7, setting.getId());
            int result = st.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            DbUtils.colseResource(conn, st, rs);
        }
    }

    public void insertTableSetting(Setting setting){

        System.out.println(setting.getTableName());

        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            String sql = "insert into setting values(null,?,?,?,?,?,?,?,?,?)";

            st= conn.prepareStatement(sql);
            st.setString(1, "");
            st.setString(2, setting.getTableName());
            st.setString(3, setting.getPackageName());
            st.setString(4, setting.getCreateDate());
            st.setString(5, setting.getAuthor());
            st.setString(6, setting.getTableAnnotation());
            st.setString(7, setting.getFilePath());
            st.setString(8, setting.getIsOpen());
            st.setString(9, "0");
            int result = st.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            DbUtils.colseResource(conn, st, rs);
        }
    }

    public void add() {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            // 获取连接
            conn = DbUtils.getConnection();

            // 编写sql
            String sql = "insert into category values (?,?)";

            // 创建语句执行者
            st= conn.prepareStatement(sql);

            //设置参数
            st.setString(1, "10");
            st.setString(2, "测试目录");

            // 执行sql
            int i = st.executeUpdate();

            if(i==1) {
                System.out.println("数据添加成功！");
            }else {
                System.out.println("数据添加失败！");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            DbUtils.colseResource(conn, st, rs);
        }

    }

}
