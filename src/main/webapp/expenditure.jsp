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
    <LINK REL="SHORTCUT ICON" HREF="/iconweb.ico">
    <title>Quản lý tài chính</title>
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
                    <li><a id="bymoney">Theo tiền</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <div class="row" style="width: 70%;height: 0;background: none;border: none;float: left;clear: both">
    </div>
    <div>
        <form class="row" id="formmoney" action="/expenditure?action=money" method="post" style="display: none">
            <label class="col-2">Từ:</label>
            <input class="col-2" name="min" type="number"><br>
            <label class="col-2">Đến:</label>
            <input class="col-2" name="max" type="number"><br>
            <div class="col-2">
                <button class="close" type="submit">Ok</button>
            </div>
        </form>
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
        <div style=" background-color: silver" class="col-6">
            <table>
                <tr>
                    <th>Danh mục</th>
                    <th>Tên danh mục</th>
                </tr>
                <c:forEach items="${listCategory}" var="cate">
                    <tr>
                        <td><img width="50px" height="50px" src="${cate.linkIcon}"/></td>
                        <td>${cate.name}</td>

                    </tr>
                </c:forEach>
                <tr>
                    <td><a href="/expenditure?action=addCate">
                        <button>Thêm danh mục</button>
                    </a></td>
                </tr>

            </table>

        </div>
        <div style=" background-color:darkkhaki" class="col-6">
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
            <c:if test="${message!=''}">
                <p style="color: #cc3333">${message}</p>
            </c:if>
            <form id="editmonth" action="/expenditure?action=editmonth&id=${limited.id}" method="post"
                  style="display: none">
                <table>
                    <tr>
                        <td><input name="limitmonth" type="number" value="${limited.limitMonth}"></td>
                        <td>
                            <button class="close" type="submit">Ok</button>
                        </td>
                    </tr>
                </table>

            </form>
            <form id="editday" action="/expenditure?action=editday&id=${limited.id}" method="post"
                  style="display: none">
                <table>
                    <tr>
                        <td><input name="limitday" type="number" value="${limited.limitDay}"></td>
                        <td>
                            <button class="close" type="submit">Ok</button>
                        </td>
                    </tr>
                </table>
            </form>
            <script>
                let openeditmonth = document.getElementById('openeditmonth');
                let openeditday = document.getElementById('openeditday');
                let editmonth = document.getElementById('editmonth');
                let editday = document.getElementById('editday');

                openeditday.onclick = function () {
                    editday.style.display = "block";
                    editmonth.style.display = "none";
                }
                openeditmonth.onclick = function () {
                    editday.style.display = "none";
                    editmonth.style.display = "block";
                }
                close.onclick = function () {
                    editday.style.display = "none";
                    editmonth.style.display = "none";
                }
            </script>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="col-6">
                <a href="/expenditure?action=addexp">
                    <button type="button" class="col-6">Thêm khoản chi</button>
                </a>
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
