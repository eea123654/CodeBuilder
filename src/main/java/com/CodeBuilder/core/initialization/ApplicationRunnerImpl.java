package com.CodeBuilder.core.initialization;

import com.CodeBuilder.core.utils.SettingUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Component
public class ApplicationRunnerImpl implements ApplicationRunner {

    @Value("${spring.datasource.url}")
    private String URL;
    @Value("${spring.datasource.username}")
    private String USER;
    @Value("${spring.datasource.password}")
    private String PASSWORD;
    @Value("${spring.datasource.driver-class-name}")
    private String DRIVER;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        //注入参数


        SettingUtils settingUtils = new SettingUtils();
        boolean check=settingUtils.checkTables();
        if(!check){
            settingUtils.createTable();
        }
    }

}
