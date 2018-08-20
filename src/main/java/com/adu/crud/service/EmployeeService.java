package com.adu.crud.service;

import com.adu.crud.entity.Employee;

import java.util.List;

public interface EmployeeService {

    /**
     *
     * @param employee
     * @return
     */
    List<Employee> findAll(Employee employee);
}
