package com.adu.crud.service;

import com.adu.crud.entity.Employee;

import java.util.List;

public interface EmployeeService {

    /**
     * 查询所有记录
     * @param employee Employee
     * @return List
     */
    List<Employee> findAll(Employee employee);
}
