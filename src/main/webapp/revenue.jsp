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
    <link rel="stylesheet" href="style.css">
    <LINK REL="SHORTCUT ICON" HREF="iconweb.ico">
    <title>Quản lý tài chính</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<body>

<header class="row">
    <table style="border: none; width: 100%">
        <tr style="margin-bottom: 2px">
            <td style="text-align: left;border: none;">
                <h1 style="font-size: 50px;color: white">Tài Chính Team</h1>
            </td>
            <td style="text-align: right;border: none;">
                <div style="text-align: right; padding-bottom: 2%">
                    <p style="color: white;font-size: 15px">${user.fullName}</p>
                    <a href="/expenditure?action=logout" style="color: white;font-size: 15px">
                        Đăng xuất
                    </a>
                </div>
            </td>
        </tr>
    </table>
</header>

<section class="row">
    <div class="col-12">
        <div>
            <a href="/expenditure?action=">
                <button type="button" class="col-6 col-m-6">Chi</button>
            </a>
            <a href="/revenue?action=">
                <button type="button" class="col-6 col-m-6" style="background-color: white">Thu</button>
            </a>
        </div>
        <div id="menu" style="width: 70%;height: 30px;background: none;border: none;">
            <ul>
                <li><a>Chi Tiết</a>
                    <ul>
                        <li><a id="day">Theo ngày</a></li>
                        <li><a id="week">Theo tuần</a></li>
                        <li><a id="month">Theo tháng</a></li>
                        <li><a id="money">Theo tiền</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <div style="width: 70%;height: 0;background: none;border: none;float: left;clear: both">
        </div>
        <div>
            <form class="row" id="formmoney" action="/revenue?action=money" method="post" style="display: none">
                <table>
                    <tr>
                        <td>
                            <label class="col-2">Từ:</label>
                        </td>
                        <td>
                            <input class="col-2" name="min" type="number" value="0" style="width: 120px"><br>
                        </td>
                        <td>
                            <label class="col-2">Đến:</label>
                        </td>
                        <td>
                            <input class="col-2" name="max" type="number" value="0" style="width: 120px"><br>
                        </td>
                        <td>
                            <div class="col-2">
                                <button class="close" type="submit">Ok</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
            <form class="row" id="formday" action="/revenue?action=day" method="post" style="display: none">
                <table>
                    <tr>
                        <td>
                            <label class="col-2">Ngày tháng:</label>
                        </td>
                        <td>
                            <input class="col-2" name="date" type="date" style="width: 150px"><br>
                        </td>
                        <td>
                            <div class="col-2">
                                <button class="close" type="submit">Ok</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
            <form class="row" id="formweek" action="/revenue?action=week" method="post" style="display: none;">
                <table>
                    <tr>
                        <td>
                            <label class="col-2">Ngày tháng:</label>
                        </td>
                        <td>
                            <input class="col-2" name="date" type="date" style="width: 150px"><br>
                        </td>
                        <td>
                            <div class="col-2">
                                <button class="close" type="submit">Ok</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
            <form class="row" id="formmonth" action="/revenue?action=month" method="post" style="display: none;">
                <table>
                    <tr>
                        <td>
                            <label class="col-2">Ngày tháng:</label>
                        </td>
                        <td>
                            <input class="col-2" name="date" type="date" style="width: 150px"><br>
                        </td>
                        <td>
                            <div class="col-2">
                                <button class="close" type="submit">Ok</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div>
            <div style="background-color: aquamarine" class="col-12">
                <table style="width: 100%">
                    <tr>
                        <th>Ngày tháng</th>
                        <th>Danh mục</th>
                        <th>Tên danh mục</th>
                        <th>Số tiền</th>
                        <th>Ghi chú</th>
                        <th>Sửa</th>
                    </tr>

                    <c:forEach items="${listRe}" var="re">
                        <tr>
                            <td>${re.date}</td>
                            <td><img width="35px" height="35px" src="${re.category.linkIcon}"></td>
                            <td>${re.category.name}</td>
                            <td>${re.money}</td>
                            <td>${re.note}</td>
                            <td>
                                <c:if test="${re.date.equals(dateNow)}">
                                    <a href="/revenue?action=editre&idre=${re.id}">
                                        <button>Sửa</button>
                                    </a>
                                </c:if>
                            </td>

                        </tr>
                    </c:forEach>
                    <tr>
                        <th colspan="3">
                            Tổng số tiền:
                        </th>
                        <th colspan="3">
                            ${totalMoney}
                        </th>
                    </tr>
                </table>

            </div>

        </div>
        <div style="background-color: chocolate" class="col-12">
            <div class="col-6" style="background-color: aquamarine">
                <table style="width: 100%">
                    <tr>
                        <th>Danh mục</th>
                        <th>Tên danh mục</th>
                    </tr>
                    <c:forEach items="${listCategoryRe}" var="cate">
                        <tr>
                            <td><img width="50px" height="50px" src="${cate.linkIcon}"/></td>
                            <td>${cate.name}</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="2"><a href="/revenue?action=addCate">
                            <button>Thêm danh mục</button>
                        </a></td>
                    </tr>

                </table>

            </div>
            <div style="background-color: chocolate" class="col-6">
                <canvas id="myChart" style="width:50%;max-width:500px"></canvas>
                <button type="button" onclick="ve();">Xem biểu đồ</button>

                <script>
                    function ve() {
                        var xValues = [];
                        var yValues = [];
                        var size = document.getElementById("size").value;
                        for (let i = 0; i < size; i++) {
                            xValues.push(document.getElementById(i + "k").value);
                            yValues.push(document.getElementById(i + "v").value);
                        }
                        var barColors = [
                            "#b91d47",
                            "#00aba9",
                            "#2b5797",
                            "#a49e9e",
                            "#458463",
                            "#a93b75",
                            "#ff020d",
                            "#00ff77",
                            "#ffd400",
                            "#c528f6",
                            "#000000",
                            "#22ff00",
                            "#ffffff"
                        ];


                        new Chart("myChart", {
                            type: "pie",
                            data: {
                                labels: xValues,
                                datasets: [{
                                    backgroundColor: barColors,
                                    data: yValues,
                                }]
                            },
                            options: {
                                title: {
                                    display: true,
                                    text: "Biểu đồ thu chi cá nhân"
                                }
                            }
                        });
                    }
                </script>
            </div>
            <div class="col-12">
                <div class="col-6">
                    <a href="/revenue?action=addre">
                        <button type="button" class="col-6">Thêm khoản thu</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<div style="display: none">
    <c:forEach items="${map}" var="map" varStatus="count">
        <input id="${count.index}v" value="${map.value}" type="number">
        <input id="${count.index}k" value="${map.key}" type="text">
    </c:forEach>
    <input id="size" value="${size}">
</div>

<div class="row">
    <footer>
        <p>Liên hệ: 18008198.</p>
    </footer>
</div>
<script type="text/javascript" src="/formInputDate.js"></script>
</body>
</html>
