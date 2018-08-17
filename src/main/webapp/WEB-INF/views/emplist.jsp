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
  <link rel="stylesheet" href="/libs/bootstrap/3.3.7/bootstrap.min.css">
  <script src="/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="/libs/bootstrap/3.3.7/bootstrap.min.js" async></script>
</head>

<body>
  <div class="row">
    <div class="row">
      <div class="col-md-4 col-md-offset-8">
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
          <div class="col-md-6" id="page_info_area">

          </div>

          <div class="col-md-6">
            <nav>
              <ul id="pagination" class="pagination"></ul>
            </nav>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script>
    var pagination;

    var pageIndex = 1;

    var page;

    // 加载数据
    function pageload() {
      $.ajax({
        url: "/employee/list",
        data: {
          pageIndex: pageIndex,
          time: new Date().getDate()
        },
        type: "POST",
        success: function (result) {
          console.log(result);
          if (200 === result.code) {
            loadTable(result.maps.pageInfo.list);
            page_info_show(result.maps.pageInfo);
            paginationFn(result.maps.pageInfo);
          }
        }
      });
    }
    
    // 构造table
    function loadTable(emplist){
      var empsTable = $("#employeeTable").empty();

      $.each(emplist,function(index, item){
        var tr=$('<tr></tr>');
        $('<td></td>')
      });
    }

  </script>
</body>

</html>