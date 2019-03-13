package com.CodeBuilder.core.web;

import com.CodeBuilder.core.pojo.Table;
import com.CodeBuilder.core.service.TableService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class SettingController {

    /*页面显示部分*/
    @RequestMapping(value="/defaultSetting", method=RequestMethod.GET)
    public ModelAndView defaultSetting() {
        ModelAndView mv = new ModelAndView("defaultSetting");
        return mv;
    }

}
