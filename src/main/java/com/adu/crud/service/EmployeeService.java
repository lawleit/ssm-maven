package com.adu.crud.service;

import com.adu.crud.entity.Employee;

import java.util.List;

public interface EmployeeService {

    /**
     *
     * @param test
     * @return
     */
    List<Employee> findAll(String test);
}
