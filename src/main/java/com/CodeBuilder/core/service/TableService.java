package com.CodeBuilder.core.service;

import com.CodeBuilder.core.mapper.TableMapper;
import com.CodeBuilder.core.pojo.Setting;
import com.CodeBuilder.core.pojo.Table;
import com.CodeBuilder.core.utils.CodeBuildUtils;
import com.CodeBuilder.core.utils.SettingUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TableService {
    @Autowired
    TableMapper tableMapper;

    @Value("${spring.datasource.url}")  
    private String url;  
    
    public List<Table> findList() {
    	 String dbname="";
    	 int scale1 = url.lastIndexOf("/");
         int scale2 = url.lastIndexOf("?");
         if(-1==scale2){
        	 dbname=url.substring((scale1+1),url.length());
         }else{
        	 dbname=url.substring((scale1+1),scale2);
         }    	
        return tableMapper.findList(dbname);
    }

    public void codeBuild(String tableName)  throws Exception {

        SettingUtils settingUtils = new SettingUtils();
        //查询数据表配置信息
        Setting setting = settingUtils.getTableSetting(tableName);
        if(0==setting.getId()){
            setting=settingUtils.getDefaultSetting();
        }else{
            if("0".equals(setting.getIsOpen())){
                setting=settingUtils.getDefaultSetting();
            }
        }

        setting.setTableName(tableName);
        //生成代码
        CodeBuildUtils build = new CodeBuildUtils(setting);
        build.generate();
    }


}

