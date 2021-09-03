<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Dai
  Date: 31/08/2021
  Time: 4:32 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
    <link rel="stylesheet" href="/style.css">
</head>
<body>

<header class="row">
    <h1 style="float: left" class="col-8">LogoPage</h1>
    <div class="col-4" style="text-align: right; padding-bottom: 2%">
        <p>${user.fullName}</p>
        <a href="/expenditure?action=logout">
            <button style="position: relative; left: 80%">Đăng xuất</button>
        </a>
    </div>

</header>

<section class="row">
    <div class="row">
        <button type="button" class="col-6 col-m-6">Thu</button>
        <button type="button" class="col-6 col-m-6">Chi</button>
    </div>
    <div class="row" id="menu" style="width: 70%;height: 30px;background: none;border: none;">
        <ul>
            <li><a>Chi Tiết</a>
                <ul>
                    <li><a id="day">Theo ngày</a></li>
                    <li><a id="week">Theo tuần</a></li>
                    <li><a id="month">Theo tháng</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <div class="row" style="width: 70%;height: 0;background: none;border: none;float: left;clear: both">
    </div>
    <div>
        <form class="row" id="formday" action="/expenditure?action=day" method="post" style="display: none">
            <label class="col-2">Ngày tháng:</label>
            <input class="col-2" name="date" type="date"><br>
            <div class="col-2">
                <button class="close" type="submit">Ok</button>
            </div>
        </form>
        <form class="row" id="formweek" action="/expenditure?action=week" method="post" style="display: none;">
            <label class="col-2">Ngày tháng:</label>
            <input class="col-2" name="date" type="date" style="background-color: #CDCDCD"><br>
            <div class="col-2">
                <button class="close" type="submit">Ok</button>
            </div>
        </form>
        <form class="row" id="formmonth" action="/expenditure?action=month" method="post" style="display: none;">
            <label class="col-2">Ngày tháng:</label>
            <input class="col-2" name="date" type="date" style="background-color:royalblue"><br>
            <div class="col-2">
                <button class="close" type="submit">Ok</button>
            </div>
        </form>
    </div>
    <div class="row">
        <div style="background-color: aquamarine" class="col-12">
            <table>
                <tr>
                    <th>Ngày tháng</th>
                    <th>Danh mục</th>
                    <th>Tên danh mục</th>
                    <th>Số tiền</th>
                    <th>Ghi chú</th>
                    <th>Sửa</th>
                </tr>

                <c:forEach items="${listEx}" var="exp">
                    <tr>
                        <td>${exp.date}</td>
                        <td><img width="35px" height="35px" src="${exp.category.linkIcon}"></td>
                        <td>${exp.category.name}</td>
                        <td>${exp.money}</td>
                        <td>${exp.note}</td>
                        <td>
                            <c:if test="${exp.date.equals(dateNow)}">
                                <a href="/expenditure?action=editexp&idexp=${exp.id}">
                                    <button>Sửa</button>
                                </a>
                            </c:if>
                        </td>

                    </tr>
                </c:forEach>
            </table>

        </div>

    </div>
    <div class="row">
        <div style="height: 65%; background-color: silver" class="col-8">
            <table>
                <tr>
                    <th>Danh mục</th>
                    <th>Tên danh mục</th>
                    <th>Sửa danh mục</th>
                    <th>Thêm danh mục</th>
                </tr>
                <c:forEach items="${listCategory}" var="cate">
                    <tr>
                        <td><img width="50px" height="50px" src="${cate.linkIcon}"/></td>
                        <td>${cate.name}</td>
                        <td><a href="/expenditure?action=edit&id=cate.id">
                            <button>Sửa danh mục</button>
                        </a></td>
                        <td><a href="/expenditure?action=addCate">
                            <button>Thêm danh mục</button>
                        </a></td>
                    </tr>
                </c:forEach>

            </table>

        </div>
        <div style="height: 65%; background-color:darkkhaki" class="col-4">
            <table>
                <tr>
                    <th>Hạn mức</th>
                    <th>Số tiền</th>
                    <th>Sửa</th>
                </tr>

                <tr>
                    <td>Hạn mức ngày</td>
                    <th>${limited.limitDay}</th>
                    <td>
                        <button id="openeditday">Edit</button>
                    </td>
                </tr>
                <tr>
                    <td>Hạn mức tháng</td>
                    <th>${limited.limitMonth}</th>
                    <td>
                        <button id="openeditmonth">Edit</button>
                    </td>
                </tr>
            </table>
            <form id="editmonth" action="/expenditure?action=editmonth&id=${limited.id}" method="post"
                  style="display: none">
                <input name="limitmonth" type="number" value="${limited.limitMonth}"><br>
                <button class="close" type="submit">Ok</button>
            </form>
            <form id="editday" action="/expenditure?action=editday&id=${limited.id}" method="post"
                  style="display: none">
                <input name="limitday" type="number" value="${limited.limitDay}"><br>
                <button class="close" type="submit">Ok</button>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="col-6">
                <a href="/expenditure?action=addexp">
                    <button type="button" class="col-6">Thêm khoản chi</button>
                </a>
            </div>
            <div class="col-6">
                <button type="button" class="col-6">Tìm kiếm</button>
            </div>
        </div>
    </div>
</section>
<div class="row">
    <footer>
        <p>Liên hệ: 18008198.</p>
    </footer>
</div>
<script type="text/javascript" src="/formInputDate.js"></script>
</body>
</html>
