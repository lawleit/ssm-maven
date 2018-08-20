<%--
  Created by IntelliJ IDEA.
  User: zhiqiang.liu02
  Date: 2018/8/17
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>测试 - Employee List</title>
    <link rel="stylesheet" href="libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        .edit_emp{
            margin-right: 10px;
        }
    </style>
    <script src="libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="libs/bootstrap/3.3.7/js/bootstrap.min.js" defer></script>
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

    // 当前页码，default 1
    var pageIndex = 1;

    // 总页码
    var pages;

    $(function () {
        // 首屏加载第一页
        pageLoad(pageIndex);

        $pagination = $('#pagination');

        // 页码
        $pagination.on('click', '.page-num', function () {
            pageIndex = $(this).attr('pageIndex');
            pageLoad(pageIndex);
        });

        // 首页
        $pagination.on('click', '.first', function () {
            pageLoad(1);
        });

        // 上一页
        $pagination.on('click', '.previous', function () {
            if (pageIndex > 1) {
                pageLoad(pageIndex - 1);
            } else {
                // TODO: do nothing
            }
        });

        // 下一页
        $pagination.on('click', '.next', function () {
            if (pageIndex < pages) {
                pageLoad(pageIndex + 1);
            } else {
                // TODO: do nothing
            }
        });

        // 尾页
        $pagination.on('click', '.last', function () {
            pageLoad(pages);
        });

    });

    /**
     * 页面加载数据
     * @param pageIndex
     */
    function pageLoad(pageIndex) {
        $.ajax({
            url: 'employee/list',
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
     * 构建数据表
     * @param emplist
     */
    function loadTable(emplist) {
        var $empTable = $('#employeeTable>tbody').empty();

        $.each(emplist, function (index, item) {
            var $tr = $('<tr></tr>');
            var $btn_edit = $('<button type="button" class="btn btn-primary edit_emp">修改</button>');
            var $btn_del = $('<button type="button" class="btn btn-danger del_emp">删除</button>');
            $('<td></td>').append(item.empId).appendTo($tr);
            $('<td></td>').append(item.empName).appendTo($tr);
            $('<td></td>').append(item.gender).appendTo($tr);
            $('<td></td>').append(item.email).appendTo($tr);
            $('<td></td>').append(item.department.deptName).appendTo($tr);
            $('<td></td>').append($btn_edit).append($btn_del).appendTo($tr);
            $empTable.append($tr);
        });
    }

    /**
     * 显示分页相关信息
     * @param pageInfo
     */
    function pageInfoShow(pageInfo) {
        var $pageInfo = $('#page-info').empty();
        $pageInfo.append('当前第' + pageInfo.pageNum + '页，共' + pageInfo.pages +
            '页，总共' + pageInfo.total + '条记录');
        pages = pageInfo.pages;
        pageIndex = pageInfo.pageNum;
    }

    /**
     * 构建分页组件
     * @param pageInfo
     */
    function paginationFn(pageInfo) {
        $pagination.empty();
        firstPageFn();
        previousPageFn();
        pageNumFn(pageInfo);
        nextPageFn();
        lastPageFn();
    }

    /**
     * 首页
     * @returns {boolean}
     */
    function firstPageFn() {
        var $first = $('<li class="first"><a href="javascript:void(0)">首页</a></li>');
        if (1 === pageIndex) {
            $first.addClass('disabled');
            return false;
        }
        $first.appendTo($pagination);
    }

    /**
     * 上一页
     * @returns {boolean}
     */
    function previousPageFn() {
        var $previous = $('<li class="previous"><a href="javascript:void(0)">&laquo;</a></li>');
        if (1 === pageIndex) {
            $previous.addClass('disabled');
            return false;
        }
        $previous.appendTo($pagination);
    }

    /**
     * 页码
     * @param pageInfo
     */
    function pageNumFn(pageInfo) {
        $.each(pageInfo.navigatepageNums, function (index, item) {
            var $li = $('<li class="page-num" pageIndex="' + item + '"><a href="javascript:void(0)">' +
                item + '</a></li>');
            if (item === pageIndex) {
                $li.addClass('active');
            }
            $li.appendTo($pagination);
        });
    }

    /**
     * 下一页
     * @returns {boolean}
     */
    function nextPageFn() {
        var $next = $('<li class="next"><a href="javascript:void(0)">&raquo;</a></li>');
        if (pages === pageIndex) {
            $next.addClass('disabled');
            return false;
        }
        $next.appendTo(pagination);
    }

    /**
     * 尾页
     * @returns {boolean}
     */
    function lastPageFn() {
        var $last = $('<li class="last"><a href="javascript:void(0)">尾页</a></li>');
        if (pages === pageIndex) {
            $last.addClass('disabled');
            return false;
        }
        $last.appendTo($pagination);
    }
</script>
</body>

</html>