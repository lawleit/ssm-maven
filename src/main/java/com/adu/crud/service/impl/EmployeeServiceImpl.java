package com.adu.crud.service.impl;

import com.adu.crud.dao.EmployeeMapper;
import com.adu.crud.entity.Employee;
import com.adu.crud.service.EmployeeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Resource
    private EmployeeMapper employeeMapper;

    /**
     * @param test
     * @return
     */
    @Override
    public List<Employee> findAll(String test) {
        return employeeMapper.findAll(null);
    }
}
