package com.CodeBuilder.core.web;
import com.CodeBuilder.core.pojo.Table;
import com.CodeBuilder.core.service.TableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class TableController {

    @Autowired
    TableService tableService;

    @RequestMapping("/tableList")
    public String tableList(Model m) {
        List<Table> tableList=tableService.findList();
        m.addAttribute("tableList",tableList);
        return "tableList";
    }

}
