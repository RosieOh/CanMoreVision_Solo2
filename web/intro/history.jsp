<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String path5 = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CanMoreVision 소개 </title>
    <%@ include file="/setting/head.jsp" %>
    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 필요한 폰트를 로딩 : 구글 웹 폰트에서 폰트를 선택하여 해당 내용을 붙여 넣기 -->
    <link rel="stylesheet" href="<%=path5%>/css/google.css">
    <link rel="stylesheet" href="<%=path5%>/css/fonts.css">

    <!-- 필요한 플러그인 연결 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <link rel="stylesheet" href="<%=path5%>/css/common.css">
    <link rel="stylesheet" href="<%=path5%>/css/header.css">
    <link rel="stylesheet" href="<%=path5%>/css/history.css">
    <link rel="stylesheet" href="<%=path5%>/css/footer.css">
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@ include file="/layout/header.jsp" %>
    </header>
    <div class="sub_wrap">
        <section class="sub_sec" id="sub01">
            <div class="sub_con">
                <div class="sub_title_wrap">
                    <h2>걸어온 길</h2>
                </div>
                <div class="sub01_txt">
                    <p>차별화된 맞춤형 교육 서비스를 제공하겠다는 CanMoreVision의 아름다운 약속! CanMoreVision이 앞으로의 20년을 함께하고 싶습니다.</p>
                </div>
                <div class="sub01_his">
                    <div class="sub01_his_pt pt_lt">
<%--                        <div class="sub01_pt_img imgnew"></div>--%>
    <div class="sub01_his_pt pt_rt">
        <h3>SINCE 2023</h3>
        <div class="pt_in">
            <div class="his_con">
                <div class="his">
                    <div class="year">2023</div>
                    <div class="cont">
                        <p>
                            <span class="txt">7월 천재교육 풀스택 JAVA 2기 과정 시작</span>
                        </p>
                        <p>
                            <span class="txt">7월 천재교육 1차 프로젝트 CornEDU 시작</span>
                        </p>
                        <p>
                            <span class="txt">7월 천재교육 1차 개인 프로젝트 CanMoreVision 시작</span>
                        </p>
                        <p>
                            <span class="txt">8월 천재교육 2차 팀 프로젝트 시작</span>
                        </p>
                        <p>
                            <span class="txt">8월 천재교육 2차 개인 프로젝트 시작</span>
                        </p>
                        <p>
                            <span class="txt">9월 천재교육 3차 팀 프로젝트 시작</span>
                        </p>
                        <p>
                            <span class="txt">9월 천재교육 3차 개인 프로젝트 시작</span>
                        </p>
                        <p>
                            <span class="txt">10월 천재교육 4차 팀 프로젝트 시작</span>
                        </p>
                        <p>
                            <span class="txt">10월 천재교육 4차 개인 프로젝트 시작</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
                    </div>
                </div>
            </div>
    </section>
    </div>
</div>

<footer class="ft" id="ft">
    <%@ include file="/layout/footer.jsp" %>
</footer>
</body>
</html>