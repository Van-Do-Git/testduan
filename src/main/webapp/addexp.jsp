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
    <form action="/expenditure?action=addexp" method="post">
        <label>Số tiền</label>
        <input name="money" type="number"/>
        <select name="id">
            <option>Chọn danh mục</option>
            <c:forEach items="${listCategory}" var="cate">
                <option value="${cate.id}">
                    <img width="50px" height="50px" src="${cate.linkIcon}"/>
                        ${cate.name}
                </option>
            </c:forEach>
        </select>
        <input name="note" type="text"/>
        <button type="submit">Thêm mới</button>
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
