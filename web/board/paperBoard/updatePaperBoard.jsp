<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%-- 1. 필요한 라이브러리 가져오기 --%>
<%@ page import="java.sql.*" %>
<%@ page import="com.chunjae_pro01.dto.*" %>
<%@ page import="com.chunjae_pro01.util.DBC" %>
<%@ page import="com.chunjae_pro01.util.MariaDBCon" %>
<%
    String path5 = request.getContextPath();
%>
<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int bno = Integer.parseInt(request.getParameter("bno"));

    // 2. DB 연결하기
    DBC conn = new MariaDBCon();
    con = conn.connect();

    //3. SQL을 실행하여 Result(공지사항 한 레코드)을 가져오기
    String sql = "select * from applimentboard where bno=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, bno);
    rs = pstmt.executeQuery();

    //4. 가져온 한 레코드를 하나의 Board 객체에 담기
    ApplimentBoard applimentBoard  = new ApplimentBoard();
    if(rs.next()){
        applimentBoard.setBno(rs.getInt("bno"));
        applimentBoard.setTitle(rs.getString("title"));
        applimentBoard.setContent(rs.getString("content"));
        applimentBoard.setAuthor(rs.getString("author"));
        applimentBoard.setResdate(rs.getString("resdate"));
        applimentBoard.setCnt(rs.getInt("cnt"));
    }
    conn.close(rs, pstmt, con);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 수정하기</title>

    <%@ include file="/setting/head.jsp" %>
    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 필요한 폰트를 로딩 : 구글 웹 폰트에서 폰트를 선택하여 해당 내용을 붙여 넣기 -->
    <link rel="stylesheet" href="<%=path5%>/css/google.css">
    <link rel="stylesheet" href="<%=path5%>/css/fonts.css">
    <link rel="stylesheet" href="<%=path5%>/css/content_header.css">
    <!-- 필요한 플러그인 연결 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <link rel="stylesheet" href="<%=path5%>/css/common.css">
    <link rel="stylesheet" href="<%=path5%>/css/header.css">
    <style>
        /* 본문 영역 스타일 */
        .contents { clear:both; min-height:110vh;
            /* background-image: url("../../images/bg_visual_overview.jpg"); */
            background-repeat: no-repeat; background-position:center -250px; }
        .contents::after { content:""; clear:both; display:block; width:100%; }

        .page { clear:both; width: 100vw; height: 130vh; position:relative; }
        .page::after { content:""; display:block; width: 100%; clear:both; }

        .page_wrap { clear:both; width: 1200px; height: auto; margin:0 auto; }
        .page_tit { font-size:48px; text-align: center; padding-top:1em; color:#fff;
            padding-bottom: 1rem; }

        .content_tit {
            font-weight: bold;
            font-size: 25px;
            margin: 80px 30px 30px 10px;
        }

        .breadcrumb { clear:both;
            width:1200px; margin: 0 auto; text-align: right; color:#fff;
            padding-top: 28px; padding-bottom: 28px; }
        .breadcrumb a { color:#fff; }
        .frm { clear:both; width:1200px; margin:0 auto; padding-top: 80px; }

        .tb1 { width:800px; margin:50px auto; }
        .tb1 th { width:150px; line-height:32px; padding-top:8px; padding-bottom:8px;
            border-top:1px solid #333; border-bottom:1px solid #333;
            background-color:#A9D0F5; color:#fff; vertical-align:top;}
        .tb1 td { width:650px; line-height:32px; padding-top:8px; padding-bottom:8px;
            border-bottom:1px solid #333;
            padding-left: 14px; border-top:1px solid #333; }

        .indata { display:inline-block; width:600px; height: 48px; line-height: 48px;
            padding:14px; font-size:18px; }
        .indata2 { width: 600px; padding: 14px; font-size:18px; }
        .inbtn { display:block;  border-radius:100px;
            min-width:140px; padding-left: 24px; padding-right: 24px; text-align: center;
            line-height: 48px; background-color: #A9D0F5; color:#fff; font-size: 18px; }
        .inbtn:first-child { float:left; }
        .inbtn:last-child { float:right; }
    </style>

    <link rel="stylesheet" href="<%=path5%>/css/ft.css">
    <style>

    </style>
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@ include file="/layout/header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="content_header">
            <div class="breadcrumb">
                <p><a href="<%=path5 %>">Home</a> &gt; <span> 학부모 커뮤니티 </span> </p>
                <h2 class="page_tit"> 학부모 커뮤니티 </h2>
            </div>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">공지사항 수정하기</h2>
                <hr>
                <!-- 5. Board 객체의 내용을 폼의 각 컨트롤(input/textarea)에 바인딩하여 출력 -->
                <form action="updateApplimentBoardPro.jsp" method="post">
                    <table class="tb1">
                        <tbody>
                        <tr>
                            <th>글 번호</th>
                            <td><input type="text" name="bno" id="bno" class="indata" value="<%=applimentBoard.getBno() %>" readonly></td>
                        </tr>
                        <tr>
                            <th>글 제목</th>
                            <td><input type="text" name="title" id="title" class="indata" value="<%=applimentBoard.getTitle() %>" required></td>
                        </tr>
                        <tr>
                            <th>글 내용</th>
                            <td><textarea rows="10" cols="80" name="content" id="content" class="indata2"><%=applimentBoard.getContent() %></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <%-- 6. 수정하기(submit)을 누르면, 수정처리로 넘기기 --%>
                                <a href="javascript:history.go(-1)" class="inbtn"> 이전 페이지 </a>
                                <% if(sid.equals("admin") || sid.equals(applimentBoard.getAuthor())) { %>
                                    <input type="submit" value="글수정" class="inbtn">
                                <a href="/board/applimentBoard/delApplimentBoard.jsp?bno=<%=applimentBoard.getBno() %>" class="inbtn">글 삭제</a>
                                <% } %>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="/layout/footer.jsp" %>
    </footer>
</div>
</body>
</html>