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
        <a href="/revenue?action=logout">
            <button style="position: relative; left: 80%">Đăng xuất</button>
        </a>
    </div>

</header>

<section class="row">
    <form action="/revenue?action=addre" method="post">
        <table>
            <tr>
                <td>
                    <label>Số tiền</label>
                    <input id="money" name="money" type="number"/>
                </td>
                <td>
                    <select name="id">
                        <option>Chọn danh mục</option>
                        <c:forEach items="${listCategoryRe}" var="cate">
                            <option value="${cate.id}">
                                <img width="50px" height="50px" src="${cate.linkIcon}"/>
                                    ${cate.name}
                            </option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <input name="note" type="text"/>
                </td>
                <td>
                    <button type="submit">Thêm mới</button>
                </td>
            </tr>
        </table>
    </form>
</section>
<div class="row">
    <footer>
        <p>Liên hệ: 18008198.</p>
    </footer>
</div>
<script type="text/javascript" src="/formInputDate.js"></script>
</body>
</html>