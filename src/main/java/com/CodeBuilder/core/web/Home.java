package com.CodeBuilder.core.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Home {

    @RequestMapping("/home")
    public String home(Model m) {
        //m.addAttribute("name", "thymeleaf");
        return "home";
    }

}
