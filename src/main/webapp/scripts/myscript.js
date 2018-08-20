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