package com.adu.crud.controller;

import com.adu.crud.utils.Message;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class EmployeeControllerTest {

    /**
     * 传入spring mvc的ioc
     */
    @Autowired
    private WebApplicationContext context;

    /**
     * 虚拟mvc请求，获取处理结果
     */
    private MockMvc mockMvc;

    @Before
    public void setUp() throws Exception {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testFindAll() throws Exception {

        // 模拟请求拿到返回值
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/employee/list")
                .param("pageIndex", "1")).andReturn();
//        mvcResult.getResponse().content
        // 得到request中pageInfo
        ObjectMapper objectMapper = new ObjectMapper();
        Message message = objectMapper.readValue(mvcResult.getResponse().getContentAsString(),Message.class);
        // Map<String, PageInfo> maps = objectMapper.readValue(json, Map.class);
        // Map<String,Map<Stirng,PageInfo>> maps = message.getMaps();
        // maps.get("page")

        // System.out.println("当前页码：" + pageInfo.getPageNum());
        // System.out.println("总页码：" + pageInfo.getPages());
        // System.out.println("总记录数：" + pageInfo.getTotal());
        // System.out.println("在页面需要连续显示的页码：" + Arrays.toString(pageInfo.getNavigatepageNums()));
        // System.out.println("数据源：" + pageInfo.getList());
        //
        // List<Employee> employeeList = pageInfo.getList();
        // for (Employee employee:employeeList){
        //     System.out.println("ID：" + employee.getEmpId() + "==>Name:" + employee.getEmpName());
        // }
    }
}