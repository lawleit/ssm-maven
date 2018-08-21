package com.adu.crud.controller;

import com.adu.crud.entity.Employee;
import com.adu.crud.service.EmployeeService;
import com.adu.crud.utils.Message;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    // 每页显示的记录数
    @Value("${global.pageSize}")
    private int pageSize;

    @Resource
    private EmployeeService employeeService;

    /**
     * 动态跳转页面
     *
     * @param viewName 页面名
     * @return view file name
     */
    @RequestMapping(value = "/{viewName}", method = RequestMethod.GET)
    public String dynamicForward(@PathVariable String viewName) {
        return viewName;
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public Message list(@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex) {
        PageHelper.startPage(pageIndex, pageSize);
        List<Employee> employees = employeeService.findAll(null);
        PageInfo<Employee> pageInfo = new PageInfo<>(employees, 5);
        return Message.getSuccess().addAttribute("pageInfo", pageInfo);
    }

    // @RequestMapping(value = "/find",method = RequestMethod.GET)
    // public String findAll(@RequestParam(value = "pageIndex",defaultValue = "1" ) Integer pageIndex, Model model)
    //         throws Exception {
    //     PageHelper.startPage(pageIndex, pageSize);
    //     List<Employee> employees = employeeService.findAll(null);
    //     PageInfo<Employee> pageInfo = new PageInfo<>(employees,5);
    //     model.addAttribute("pageInfo",pageInfo);
    //     // return Message.getSuccess().addAttribute("pageInfo",pageInfo);
    //     return "emplist";
    // }

}
