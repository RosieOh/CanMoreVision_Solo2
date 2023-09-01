<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.chunjae_pro01.util.*" %>
<%@ page import="com.chunjae_pro01.dto.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/setting/encoding.jsp"%>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    DBC con = new MariaDBCon();
    conn = con.connect();
    String sql = "SELECT * FROM board ORDER BY bno DESC LIMIT 0, 5";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();

    List<Board> boardList = new ArrayList<>();
    while(rs.next()) {
        Board bd = new Board();
        bd.setBno(rs.getInt("bno"));
        bd.setTitle(rs.getString("title"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date d = sdf.parse(rs.getString("resdate"));
        bd.setResdate(sdf.format(d));
        boardList.add(bd);
    }
    rs.close();
    pstmt.close();

    sql = "SELECT * FROM motherBoard ORDER BY cnt DESC, bno DESC LIMIT 0, 5";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();

    List<MotherBoard> mbList = new ArrayList<>();
    while(rs.next()) {
        MotherBoard mb = new MotherBoard();
        mb.setBno(rs.getInt("bno"));
        mb.setTitle(rs.getString("title"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date d = sdf.parse(rs.getString("resdate"));
        mb.setResdate(sdf.format(d));
        mbList.add(mb);
    }
    con.close(rs, pstmt, conn);
%>

<style>
    <!--공지사항과 이벤트 게시판 스타일-->
    #page3 {clear : both; background-color: gray;}
    .board_lst { background-color: rgba(240, 240, 240, 0.5); margin-top : 100px; }
    .board_wrap { width: 1250px; margin: 0px auto; padding: 10px; }
    .board { display : inline-block; margin: 60px; vertical-align: top; }
    .board_title { display : inline-block; position: relative; width: 500px; }
    .notice_title {margin : 5px; font-size: 20px; font-weight: bold;}
    .notice_more { position : absolute; top: 5px; right :0;}
    .events_title {margin : 5px; font-size: 20px; font-weight: bold;}
    .lst_group { display: flex; justify-content : space-between; margin-top : 10px; }
    .lst_group a { line-height: 25px; width: 400px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: block; }
    .board_subject1::before { content:"🔉 공지"; margin-right: 5px; padding-right: 5px; border-radius: 50px; background-color: #333;
        color:#fff; font-size: 10px; text-align: center; height: 25px; line-height: 25px; padding-left: 5px; display: inline-block }
    .board_subject2::before { content:"🔉 공지"; margin-right: 5px; padding-right: 5px; border-radius: 50px; background-color: #333;
        color:#fff; font-size: 10px; text-align: center; height: 25px; line-height: 25px; padding-left: 5px; display: inline-block}
    a { text-decoration: none; display : flex; color : #333; }
    .lst { border-top:2px solid #333; margin:0; width : 500px; padding: 0; border-style: dashed; }
    .board_notice {
        font-size: 40px;
        text-align: center;
    }
</style>

<section class="page" id="page3">
    <div class="board_lst">
        <div class="board_wrap">
            <!--공지사항 게시판(공지사항, 더보기(공지사항 연결링크), 글목록 )-->
            <h2 class="board_notice">공지사항 한 눈에 보기</h2>
            <div class="board">
                <div class="board_title">
                    <h2 class="notice_title"> 📢 공지사항</h2>
                    <a href="/cs/board/boardList.jsp?page=1" class="notice_more" >더보기 + </a>
                </div>
                <ul class="lst">
                    <%  int i = 1;
                        for(Board bd : boardList) { %>
                        <li class="lst_group">
                            <% if(sid == null) {%>
                                <a href="javascript:alert('로그인 후 다시 시도해주세요.')" class="board_subject<%=i%>"><%=bd.getTitle()%></a>
                            <% } else { %>
                                <a href="/cs/board/getBoard.jsp?bno=<%=bd.getBno()%>" class="board_subject<%=i%>"><%=bd.getTitle()%></a>
                            <% } %>
                            <div class="board_date"><%=bd.getResdate()%></div>
                        </li>
                    <%  i++;
                        }
                    %>
                </ul>
            </div>

            <!--이벤트 게시판(이벤트, 더보기(커뮤니티 연결링크), 글목록 )-->
            <div class="board">
                <div class="board_title">
                    <h2 class="events_title"> 📢 학부모 커뮤니티 인기 글 </h2>
                    <a href="/board/motherboard/MotherBoardList.jsp" class="notice_more">더보기 + </a>
                </div>
                <ul class="lst">
                    <% for(MotherBoard bd : mbList) { %>
                        <li class="lst_group">
                            <% if(sid == null) {%>
                            <a href="javascript:alert('로그인 후 다시 시도해주세요.')" class="board_subject"><%=bd.getTitle()%></a>
                            <% } else { %>
                            <a href="/board/motherboard/getMotherBoard.jsp?bno=<%=bd.getBno()%>" class="event_subject"><%=bd.getTitle()%></a>
                            <% } %>
                            <div class="board_date"><%=bd.getResdate()%></div>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>

    </div>
</section>