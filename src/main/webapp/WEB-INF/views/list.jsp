<%--
  Created by IntelliJ IDEA.
  User: zhiqiang.liu02
  Date: 2018/8/17
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%
//request.setAttribute("pagePath",request.getContextPath());
%>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta http-equiv="X-UA-Compatible" content="ie=edge">
                <title>测试 - Employee List</title>
                <link rel="stylesheet" href="/libs/bootstrap/3.3.7/css/bootstrap.min.css">
                <script src="/libs/jquery/1.12.4/jquery.min.js"></script>
                <script src="/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            </head>

            <body>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12  text-right">
                            <button class="btn btn-primary" type="button">添加</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <table id="employeeTable" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>员工ID</th>
                                        <th>员工名称</th>
                                        <th>员工性别</th>
                                        <th>员工邮箱</th>
                                        <th>所属部门</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="row">
                                <div class="col-md-6" id="page-info">

                                </div>

                                <div class="col-md-6">
                                    <nav>
                                        <ul id="pagination" class="pagination">
                                            <li class="first">
                                                <a href="#">&laquo;</a>
                                            </li>
                                            <li>
                                                <a href="#">1</a>
                                            </li>
                                            <li>
                                                <a href="#">2</a>
                                            </li>
                                            <li>
                                                <a href="#">3</a>
                                            </li>
                                            <li>
                                                <a href="#">4</a>
                                            </li>
                                            <li>
                                                <a href="#">5</a>
                                            </li>
                                            <li class="last">
                                                <a href="#">&raquo;</a>
                                            </li>
                                        </ul>

                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    var $pagination;

                    var pageIndex = 1;

                    // 总页码
                    var pages;

                    $(function () {
                        // 默认获取第一页
                        pageLoad(pageIndex);

                        $pagination = $('#pagination');

                        /**
                         * 页码绑定事件
                         */
                        $pagination.on('click', '.page-num', function () {
                            pageIndex = $(this).attr('pageIndex');
                            pageLoad(pageIndex);
                        });

                        /**
                         * 首页事件绑定
                         */
                        $pagination.on('click', '.first', function () {
                            pageLoad(1);
                        });

                        /**
                         * 上一页
                         */
                        $pagination.on('click', '.previous', function () {
                            if (pageIndex > 1) {
                                pageLoad(pageIndex - 1);
                            }
                        });

                        /**
                         * 上一页
                         */
                        $pagination.on('click', '.next', function () {
                            if (pageIndex < pages) {
                                pageLoad(pageIndex + 1);
                            }
                        });

                        $pagination.on('click', '.last', function () {
                            pageLoad(pages);
                        });
                    });

                    // 加载数据
                    function pageLoad(pageIndex) {
                        $.ajax({
                            url: '/employee/list',
                            data: {
                                pageIndex: pageIndex,
                                time: new Date().getDate()
                            },
                            type: 'POST',
                            success: function (result) {
                                console.log(result);
                                if (200 == result.code) {
                                    loadTable(result.maps.pageInfo.list);
                                    pageInfoShow(result.maps.pageInfo);
                                    paginationFn(result.maps.pageInfo);
                                }
                            }
                        });
                    }

                    /**
                     * 加载数据表
                     */
                    function loadTable(emplist) {
                        var $empTable = $('#employeeTable>tbody').empty();

                        $.each(emplist, function (index, item) {
                            var $tr = $('<tr></tr>');
                            $('<td></td>').append(item.empId).appendTo($tr);
                            $('<td></td>').append(item.empName).appendTo($tr);
                            $('<td></td>').append(item.gender).appendTo($tr);
                            $('<td></td>').append(item.email).appendTo($tr);
                            $('<td></td>').append(item.deptName).appendTo($tr);

                            var $btn_edit = $(
                                '<button type="button" class="btn btn-primary edit_emp">修改</button>');
                            var $btn_del = $('<button type="button" class="btn btn-danger del_emp">删除</button>');
                            $('<td></td>').append($btn_edit).append($btn_del).append($tr);
                            $empTable.append($tr);
                        });
                    }

                    /**
                     * 显示分页详细信息
                     */
                    function pageInfoShow(pageInfo) {
                        var $pageInfo = $('#page-info').empty();
                        $pageInfo.append('当前第' + pageInfo.pageNum + '页，共' + pageInfo.pages +
                            '页，总共' + pageInfo.total + '条记录');
                        pages = pageInfo.pages;
                        pageIndex = pageInfo.pageNum;
                    }

                    function paginationFn(pageInfo) {
                        $pagination.empty();
                        firstPageFn();
                        previousPageFn();
                        pageNum(pageInfo);
                        nextPageFn();
                        lastPageFn();
                    }

                    function firstPageFn() {
                        var $first = $('<li class="first"><a href="#">首页</a></li>');
                        if (1 === pageIndex) {
                            $first.addClass('disabled');
                            return false;
                        }
                        $first.appendTo($pagination);
                    }

                    function previousPageFn() {
                        var $previous = $('<li class="previous"><a href="#">&laquo;</a></li>');
                        if (1 === pageIndex) {
                            $previous.addClass('disabled');
                            return false;
                        }
                        $previous.appendTo($pagination);
                    }

                    function pageNum(pageInfo) {
                        $.each(pageInfo.navigatepageNums, function (index, item) {
                            var $li = $('<li class="page-num" pageIndex="' + item + '"><a href="#">' +
                                item + '</a></li>');
                            if (item === pageIndex) {
                                $li.addClass('active');
                            }
                            $li.appendTo($pagination);
                        });
                    }

                    function nextPageFn() {
                        var $next = $('<li class="next"><a href="#">&raquo;</a></li>');
                        if (pages === pageIndex) {
                            $next.addClass('disabled');
                            return false;
                        }
                        $next.appendTo(pagination);
                    }

                    function lastPageFn() {
                        var $last = $('<li class="last"><a href="#">尾页</a></li>');
                        if (pages === pageIndex) {
                            $last.addClass('disabled');
                            return false;
                        }
                        $last.appendTo($pagination);
                    }
                </script>
            </body>

            </html>