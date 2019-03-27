package com.CodeBuilder.core.utils;

import com.CodeBuilder.core.pojo.DataColumn;

import com.CodeBuilder.core.pojo.Setting;
import freemarker.template.Template;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;


import java.io.*;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.*;

/**
 * 代码生成工具类
 */

public class CodeBuildUtils {

    //数据库相关
    private static String URL;
    private static String USER;
    private static String PASSWORD;
    private static String DRIVER;
    private static String ishxmodel;

    private String tableName;
    private String changeTableName;
    private String CURRENT_DATE;
    private String AUTHOR;
    private String packageName;
    private String tableAnnotation;
    private String moduleName;
    private String submoduleName;
    private String diskPath;


    //hy:因为某些原因无法自动注入参数，所以用这种方法
    static {
        try {
            dbconfig();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() throws Exception{
        Class.forName(DRIVER);
        Connection connection= DriverManager.getConnection(URL, USER, PASSWORD);
        return connection;
    }


    private static void dbconfig() throws Exception{

        Properties pro=new Properties();
        Resource resource = new ClassPathResource("application.properties");
        File sourceFile =  resource.getFile();
        InputStream in =new FileInputStream(sourceFile);
        pro.load(in);
        URL=pro.getProperty("spring.datasource.url");
        USER=pro.getProperty("spring.datasource.username");
        PASSWORD=pro.getProperty("spring.datasource.password");
        DRIVER=pro.getProperty("spring.datasource.driver-class-name");
        ishxmodel=pro.getProperty("ishxmodel");
    }


    

    public CodeBuildUtils(Setting setting){

        this.tableName=setting.getTableName();
        this.changeTableName = replaceUnderLineAndUpperCase(tableName);
        this.CURRENT_DATE = setting.getCreateDate();
        this.AUTHOR=setting.getAuthor();
        this.packageName=setting.getPackageName();
        this.tableAnnotation=setting.getTableAnnotation();
        this.moduleName=setting.getModuleName();
        this.submoduleName=setting.getSubmoduleName();
        this.diskPath=setting.getFilePath();
    }


    public void generate() throws Exception{
        try {
            Connection connection = getConnection();
            DatabaseMetaData databaseMetaData = connection.getMetaData();
            ResultSet resultSet = databaseMetaData.getColumns(null,"%", tableName,"%");

            //hy：注意 jdbc中的resultSet不可多次使用
            List<DataColumn> columnClassList = new ArrayList<>();
            DataColumn columnClass = null;
            while(resultSet.next()){
                columnClass = new DataColumn();
                //获取字段名称
                columnClass.setColumnName(resultSet.getString("COLUMN_NAME"));
                //获取字段类型
                columnClass.setColumnType(resultSet.getString("TYPE_NAME"));
                //转换字段名称，如 sys_name 变成 SysName
                columnClass.setChangeColumnName(replaceUnderLineAndUpperCase(resultSet.getString("COLUMN_NAME")));
                //字段在数据库的注释
                columnClass.setColumnComment(resultSet.getString("REMARKS"));
                columnClassList.add(columnClass);
            }


            //以匿名类的方式使用多线程生成文件

            Thread t1= new Thread(){
                public void run(){
                    //生成Model（实体类）文件
                    try {
                        generateModelFile(columnClassList);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            };
            t1.start();

            Thread t2= new Thread(){
                public void run(){
                    try {
                        //生成Mapper文件
                        generateMapperFile(columnClassList);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            };
            t2.start();

            Thread t3= new Thread(){
                public void run(){
                    try {
                        //生成MapperXml文件
                        generateMapperXmlFile(columnClassList);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            };
            t3.start();

            Thread t4= new Thread(){
                public void run(){
                    try {
                        //生成Controller层文件
                        generateControllerFile(columnClassList);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            };
            t4.start();

            Thread t5= new Thread(){
                public void run(){
                    try {
                        //生成服务层文件
                        generateServiceFile(columnClassList);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            };
            t5.start();


        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{

        }
    }

    private void generateModelFile(List<DataColumn> columnClassList) throws Exception{

        final String suffix = ".java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Model.ftl";
        File mapperFile = new File(path);
        List<DataColumn> list = new ArrayList<>();
        list.addAll(columnClassList);
        //需要过滤掉id
        for(DataColumn dc :list){
            if ("id".equals(dc.getColumnName())){
                list.remove(dc);
                break;
            }
        }

        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("model_column",list);
        generateFileByTemplate(templateName,mapperFile,dataMap);

    }


    private void generateControllerFile(List<DataColumn> columnClassList) throws Exception{
        final String suffix = "Controller.java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Controller.ftl";
        File mapperFile = new File(path);
        Map<String,Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    private void generateServiceFile(List<DataColumn> columnClassList) throws Exception{
        final String suffix = "Service.java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Service.ftl";
        File mapperFile = new File(path);
        Map<String,Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }




    private void generateMapperFile(List<DataColumn> columnClassList) throws Exception{
        final String suffix = "Mapper.java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Mapper.ftl";
        File mapperFile = new File(path);
        Map<String,Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName,mapperFile,dataMap);

    }
    
    private void generateMapperXmlFile(List<DataColumn> columnClassList) throws Exception{
        final String suffix = "Mapper.xml";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "MapperXml.ftl";
        File mapperFile = new File(path);
        Map<String,Object> dataMap = new HashMap<>();
        List<DataColumn> list = new ArrayList<>();
        list.addAll(columnClassList);
        dataMap.put("model_column",list);
        generateFileByTemplate(templateName,mapperFile,dataMap);

    }
    

    private void generateFileByTemplate(final String templateName,File file,Map<String,Object> dataMap) throws Exception{
        Template template = FreeMarkerTemplateUtils.getTemplate(templateName);
        FileOutputStream fos = new FileOutputStream(file);
        dataMap.put("table_name_small",tableName);
        dataMap.put("table_name",changeTableName);
        dataMap.put("author",AUTHOR);
        dataMap.put("date",CURRENT_DATE);
        dataMap.put("package_name",packageName);
        dataMap.put("table_annotation",tableAnnotation);
        dataMap.put("module_name",moduleName);
        dataMap.put("submodule_name",submoduleName);
        dataMap.put("ishxmodel",ishxmodel);
        Writer out = new BufferedWriter(new OutputStreamWriter(fos, "utf-8"),10240);
        template.process(dataMap,out);
    }

    public String replaceUnderLineAndUpperCase(String str){
    	if(str.endsWith("_")){
    		str = str.substring(0,str.length() - 1);
    	}
        StringBuffer sb = new StringBuffer();
        sb.append(str);
        int count = sb.indexOf("_");
        while(count!=0){
            int num = sb.indexOf("_",count);
            count = num + 1;
            if(num != -1){
                char ss = sb.charAt(count);
                char ia = (char) (ss - 32);
                sb.replace(count , count + 1,ia + "");
            }
        }
        String result = sb.toString().replaceAll("_","");
        return StringUtils.capitalize(result);
    }

}
