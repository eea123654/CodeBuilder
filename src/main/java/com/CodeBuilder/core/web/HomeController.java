package com.CodeBuilder.core.web;

import com.CodeBuilder.core.mapper.ClientMapper;
import com.CodeBuilder.core.mapper.TableMapper;
import com.CodeBuilder.core.pojo.Client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    ClientMapper clientMapper;

    @RequestMapping("/home")
    public String home(Model m) {
        m.addAttribute("url", "home");
        return "home";
    }

}
