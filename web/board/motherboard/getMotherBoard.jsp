<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/setting/encoding.jsp" %>
<%
    String path5 = request.getContextPath();
%>
<%-- 1. 필요한 라이브러리 가져오기 --%>
<%@ page import="java.sql.*" %>
<%@ page import="com.chunjae_pro01.dto.*" %>
<%@ page import="com.chunjae_pro01.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int bno = Integer.parseInt(request.getParameter("bno"));

    // 2. DB 연결하기
    DBC conn = new MariaDBCon();
    con = conn.connect();

    //3. 조회수 처리
    int count=0;
    String sql = "UPDATE motherboard SET cnt=cnt+1 WHERE bno=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, bno);
    count = pstmt.executeUpdate();
    pstmt.close();


    //4. SQL을 실행하여 Result(공지사항 한 레코드)을 가져오기
    sql = "select * from motherboard where bno=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, bno);
    rs = pstmt.executeQuery();


    //5. 가져온 한 레코드를 하나의 Board 객체에 담기
    Board bd  = new Board();
    if(rs.next()){
        bd.setBno(rs.getInt("bno"));
        bd.setTitle(rs.getString("title"));
        bd.setContent(rs.getString("content"));
        bd.setAuthor(rs.getString("author"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date d = sdf.parse(rs.getString("resdate"));
        bd.setResdate(sdf.format(d));
        bd.setCnt(rs.getInt("cnt"));

    }
    rs.close();
    pstmt.close();

    sql = "SELECT cno, author, resdate, content FROM motherComment WHERE bno=? ORDER BY cno DESC LIMIT 0, 10";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, bno);
    rs = pstmt.executeQuery();

    List<Comment> cList = new ArrayList<>();
    while(rs.next()) {
        Comment cmt = new Comment();
        cmt.setCno(rs.getInt("cno"));
        cmt.setAuthor(rs.getString("author"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date d = sdf.parse(rs.getString("resdate"));
        cmt.setResdate(sdf.format(d));
        cmt.setContent(rs.getString("content"));
        cList.add(cmt);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-cmtale=1.0">
    <title> 학부모 커뮤니티 상세보기 </title>
    <%@ include file="/setting/head.jsp" %>    <link rel="stylesheet" href="<%=path5%>/css/google.css">
    <link rel="stylesheet" href="<%=path5%>/css/fonts.css">
    <link rel="stylesheet" href="<%=path5%>/css/content_header.css">

    <!-- 필요한 플러그인 연결 -->
    <cmtript src="https://code.jquery.com/jquery-latest.js"></cmtript>
    <link rel="stylesheet" href="<%=path5%>/css/common.css">
    <link rel="stylesheet" href="<%=path5%>/css/header.css">
    <style>
        /* 본문 영역 스타일 */
        /* 본문 영역 스타일 */
        .contents {
            clear: both;
        }

        .contents::after {
            content: "";
            clear: both;
            display: block;
            width: 100%;
        }

        .page {
            position: relative;
            clear: both;
            width: 100%;
            min-height: 100vh;
        }

        .page::after {
            content: "";
            display: block;
            width: 100%;
            clear: both;
        }

        .page_wrap {
            clear: both;
            width: 1200px;
            margin: 0 auto;
        }

        .page_tit {
            font-size: 48px;
            text-align: center;
            padding-top: 1em;
            color: #fff;
            padding-bottom: 2.4rem;
        }

        .breadcrumb {
            clear: both;
            width: 1200px;
            margin: 0 auto;
            text-align: right;
            color: #fff;
            padding-top: 28px;
            padding-bottom: 28px;
        }

        .breadcrumb a {
            color: #fff;
        }

        .view_detail {
            width: 800px;
            margin: 50px auto;
        }

        .view_detail tr {
            width: 100%;
        }

        .view_detail tr td {
            width: 100%;
        }

        .view_detail .btn {
            float: right;
            width: 50px;
            height: 50px;
            text-align: right;
            line-height: 50px;
            border: none;
            background-color: #fff;
        }

        .view_detail .title {
            padding: 20px;
            font-size: 18pt;
            font-weight: bold;
            line-height: 30px;
        }

        .view_detail .author {
            width: 50%;
            padding: 0px 20px 10px 20px;
            text-align: right;
        }

        .view_detail .resdate {
            width: 50%;
            padding: 0px 20px 10px 20px;
        }

        .view_detail .content {
            clear: both;
            width: 100%;
            padding: 20px;
            box-sizing: border-box;
            line-height: 20px;
        }

        .comment_detail {
            width: 800px;
            margin: 50px auto;
        }

        .comment_detail .input_comment {
            width: 700px;
            height: 100px;
            line-height: 30px;
            padding: 10px;
            box-sizing: border-box;
            font-size: 13pt;
            resize: none;
            font-family: 'Noto-Sans', sans-serif;
        }
        .comment_detail .sub_comment {
            position: relative;
            width: 90px;
            height: 98px;
            border-radius: 5px;
        }

        .sub_comment .comment_btn {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 5px;
            background-color: #A9D0F5;
        }

        .comment_detail .comment_list {
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 150px;
        }

        .comment_detail .comment_list::after {
            clear: both;
            display: block;
            width: 100%;
            content: "";
        }

        .comment_detail .comment_list .author {
            clear: both;
            display: inline-block;
            float: left;
            text-align: left;
            padding: 20px;
        }
        .comment_detail .comment_list .resdate {
            display: inline-block;
            float: right;
            text-align: right;
            padding: 20px;
        }
        .comment_detail .comment_list .content {
            clear: both;
            width: 100%;
            padding: 20px;
            line-height: 20px;
            box-sizing: border-box;
        }

        .comment_detail .btn {
            float: right;
            width: 50px;
            height: 50px;
            line-height: 50px;
            border: none;
            margin-right: 20px;
        }
        .comment_detail .line {
            clear: both;
            display: block;
            border-bottom: 1px solid #ddd;
            width: 100%;
        }
    </style>

    <link rel="stylesheet" href="<%=path5%>/css/footer.css">
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
                <p><a href="<%=path5 %>">Home</a> &gt; <a href="<%=path5 %>/board/motherboard/MotherBoardList.jsp"> 학부모 커뮤니티  </a> > <span> 학부모 커뮤니티 상세보기 </span> </p>
                <h2 class="page_tit"> 학부모 커뮤니티 상세보기 </h2>
            </div>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <!-- 5. Board 객체의 내용을 출력 -->
                <table class="view_detail color">
                    <tbody>
                    <% if(sid.equals("admin") || sid.equals(bd.getAuthor())) { %>
                    <tr>
                        <td colspan="3">
                            <a href="/board/motherboard/delMotherBoard.jsp?bno=<%=bno%>&target=board" class="btn"> 삭제 </a>
                            <a href="/board/motherboard/updateMotherBoard.jsp?bno=<%=bno%>" class="btn"> 수정 </a>
                        </td>
                    </tr>
                    <% } %>
                    <tr>
                        <td class="title" colspan="3">
                            <%=bd.getTitle() %>
                        </td>
                    </tr>
                    <tr>
                        <td class="resdate">
                            작성일 | <%=bd.getResdate()%>
                        </td>
                        <td style="width:10%; text-align: right;">
                            조회수 | <%=bd.getCnt() %>
                        </td>
                        <td style="min-width:10%; max-width: 15%; text-align: right;">
                            작성자 | <%=bd.getAuthor()%>
                        </td>
                    </tr>
                    <tr>
                        <td class="content" colspan="2">
                            <%=bd.getContent() %>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <form action="<%=path5 %>/comment/addMotherCommentPro.jsp" method="post">
                    <table class="comment_detail">
                        <tbody>
                        <tr>
                            <td class="add_comment">
                                <textarea name="content" id="content" class="input_comment" placeholder="댓글을 입력해주세요" required></textarea>
                                <input type="hidden" name="bno" id="bno" value="<%=bno %>">
                            </td>
                            <td class="sub_comment">
                                <input type="submit" class="comment_btn" value="작성">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div class="comment_detail">
                    <div class="comment_list">
                        <% for(Comment cmt:cList) { %>
                        <p class="author"><%=cmt.getAuthor()%></p>
                        <p class="resdate"><%=cmt.getResdate()%></p>
                        <p class="content"><%=cmt.getContent()%></p>
                        <% if(cmt.getAuthor().equals(sid) || sid.equals("admin")) { %>
                        <a href="<%=path5 %>/comment/delMotherCommentPro.jsp?bno=<%=bno%>&cno=<%=cmt.getCno()%>" class="btn"> [ 삭제 ] </a>
                        <% } %>
                        <span class="line"></span>
                        <% } %>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="/layout/footer.jsp" %>
    </footer>
</div>
</body>
</html>