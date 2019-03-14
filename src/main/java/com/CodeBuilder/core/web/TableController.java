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
public class TableController {

    @Autowired
    TableService tableService;

    /*restful 部分*/
    @GetMapping("/tables")
    public PageInfo<Table> list(@RequestParam(value = "start", defaultValue = "1") int start, @RequestParam(value = "size", defaultValue = "10") int size) throws Exception {
        //PageHelper.startPage(start,size,"id desc");
        PageHelper.startPage(start,size);
        List<Table> hs=tableService.findList();
        System.out.println(hs.size());

        PageInfo<Table> page = new PageInfo<>(hs,5); //5表示导航分页最多有5个，像 [1,2,3,4,5] 这样
        return page;
    }

    @GetMapping("/build")
    public Object build(String tableName) throws Exception {

        Map<String,String> result = new HashMap<>();
        if(StringUtils.isNotBlank(tableName)){
            tableService.codeBuild(tableName);
            result.put("status","success");
        }else{
            result.put("status","fail");
        }

        return result;
    }


    /*页面显示部分*/
    @RequestMapping(value="/tableList", method=RequestMethod.GET)
    public ModelAndView tableList() {
        ModelAndView mv = new ModelAndView("tableList");
        mv.addObject("url", "tableList");
        return mv;
    }

}
