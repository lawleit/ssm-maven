package com.adu.crud.dao;

import com.adu.crud.entity.Department;
import com.adu.crud.entity.Employee;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.exception.InvalidConfigurationException;
import org.mybatis.generator.exception.XMLParserException;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:spring/applicationContext*.xml"})
public class EmployeeMapperTest {

    private String uuid = uuid= UUID.randomUUID().toString();

    @Resource
    private EmployeeMapper employeeMapper;

    @Before
    public void setUp() throws Exception {
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void testFindAll() {
        System.out.println(employeeMapper);
        List<Employee> employeeList=employeeMapper.findAll(null);
        System.out.println(employeeList.size());
    }

    /**
     * 向数据库中插入1000条记录
     * @throws Exception
     */
    @Test
    public void testRandomInsert() throws Exception{
        System.out.println(employeeMapper);
        for (int i=0;i<1000;i++){
            employeeMapper.insert(new Employee(null,"李四"+uuid,"男",uuid+"@gmail.com",new Department(1)));
        }
    }

    /**
     * TODO: Mybatis Generator 逆向工程，生成基础代码
     * @throws IOException
     * @throws XMLParserException
     * @throws InvalidConfigurationException
     * @throws SQLException
     * @throws InterruptedException
     */
    @Test
    public void testMbg() throws IOException, XMLParserException, InvalidConfigurationException, SQLException, InterruptedException {
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        File configFile = new File("mbg.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }
}