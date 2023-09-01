<%@ page import="javax.xml.xpath.XPathEvaluationResult" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.chunjae_pro01.util.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.chunjae_pro01.dto.Member" %>
<%
    String path10 = request.getContextPath();
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>온라인 상담</title>
    <%@ include file="/setting/head.jsp" %>

    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 필요한 폰트를 로딩 : 구글 웹 폰트에서 폰트를 선택하여 해당 내용을 붙여 넣기 -->
    <link rel="stylesheet" href="<%=path10%>/css/google.css">
    <link rel="stylesheet" href="<%=path10%>/css/fonts.css">
    <link rel="stylesheet" href="<%=path10%>/css/online.css">

    <!-- 필요한 플러그인 연결 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <link rel="stylesheet" href="<%=path10%>/css/common.css">
    <link rel="stylesheet" href="<%=path10%>/css/header.css">
    <link rel="stylesheet" href="<%=path10%>/css/content_header.css">
    <link rel="stylesheet" href="<%=path10%>/css/footer.css">

</head>
<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="/layout/header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="content_header">
            <div class="breadcrumb">
                <p><a href="<%=path10 %>/">Home</a> &gt; 고객지원 &gt; <span> 온라인 상담 </span> </p>
                <h2 class="page_tit"> 온라인 상담 </h2>
            </div>
        </div>
        <section class="page" id="page1">
            <form action="onlinePro.jsp" method="post">
                <table class="tb1">
                    <tbody>
                    <tr>
                        <th><label for="author">이름</label></th>
                        <td><input type="text" name="name" id="name" class="indata" required>
                            <input type="hidden" name="author" id="author" value="<%=sid %>">
                        </td>
                    </tr>
                    <tr>
                        <th><label for="from">이메일</label></th>
                        <td><input type="email" name="from" id="from" class="indata" required></td>
                    </tr>
                    <tr>
                        <th><label for="tel">연락처</label></th>
                        <td><input type="tel" name="tel" id="tel" class="indata" required></td>
                    </tr>
                    <tr>
                        <th><label for="title">상담 제목</label></th>
                        <td><input type="text" name="title" id="title" class="indata" required></td>
                    </tr>
                    <tr>
                        <th><label for="content">상담 내용</label></th>
                        <td>
                            <textarea cols="100" rows="6" name="content" id="content" maxlength="600" class="indata2"></textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="btn_group">
                    <button type="submit" class="inbtn">상담 신청</button>
                </div>
            </form>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="/layout/footer.jsp" %>
    </footer>
</div>
</body>
</html>