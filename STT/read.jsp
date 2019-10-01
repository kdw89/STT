<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.Date" %>

<%
request.setCharacterEncoding("UTF-8");
String isRead = request.getParameter("isRead");

String db_Addr = "localhost/aramdan";     // db 주소
String ID = "kopoctc";                    // db 접속 ID
String PW = "kopoctc";                 // db 접속 PW
%>

<HTML>
<HEAD>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <style media="screen">
        table {
            width: 90%;
            max-width: 1000px;
            table-layout: fixed;
        }
    </style>
</HEAD>
<BODY>
    <div id="dbcontent">
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://" + db_Addr, ID, PW);
PreparedStatement pstmt = null;
String sql = "";
sql = "select text, tts_flag, isRead from tts_table order by id asc;";
pstmt = conn.prepareStatement(sql);
ResultSet rset = pstmt.executeQuery();

int[] audio_ck = new int[5];
int num = 0;
int count = 0;
%>

<table border="1">

<%
for(int i = 1 ; i < 6 ; i++){
    rset.next();
    String id = "t" + String.valueOf(i);
    String flag = "f" + String.valueOf(i);
	String read = "r" + String.valueOf(i);
	String mcount = "c" + String.valueOf(i);
    %>
    <tr>
        <td id="<%=id%>"><%=rset.getString(1)%></td>
        <td id="<%=flag%>"><%=rset.getInt(2)%></td>
        <td id="<%=read%>"><%=rset.getInt(3)%></td>
		<%
			if(rset.getInt(2) == 1){
				count++;
			}
		%>
		<td id="<%=mcount%>"><%=count%></td>
    </tr>
    <%
}

%>
</table>
<%
rset.close();
pstmt.close();
conn.close();
%>
    </div>
    <script>
        function refresh_start(){
            location.href="read.jsp";
        }
        var timer = setInterval('refresh_start()', 1000);
    </script>

</BODY>
</HTML>
