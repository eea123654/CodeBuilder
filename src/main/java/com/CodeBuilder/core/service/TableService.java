package com.CodeBuilder.core.service;

import com.CodeBuilder.core.mapper.TableMapper;
import com.CodeBuilder.core.pojo.Setting;
import com.CodeBuilder.core.pojo.Table;
import com.CodeBuilder.core.utils.CodeBuildUtils;
import com.CodeBuilder.core.utils.SettingUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TableService {
    @Autowired
    TableMapper tableMapper;

    public List<Table> findList() {
        return tableMapper.findList();
    }

    public void codeBuild(String tableName)  throws Exception {

        SettingUtils settingUtils = new SettingUtils();
        //查询数据表配置信息
        Setting setting = settingUtils.getTableSetting(tableName);
        if (0==setting.getId()){
            setting = settingUtils.getDefaultSetting();
        }
        setting.setTableName(tableName);
        //生成代码
        CodeBuildUtils build = new CodeBuildUtils(setting);
        build.generate();
    }


}

