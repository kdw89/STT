<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import= "java.io.*" %>
<%@ page import= "java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import= "java.util.regex.Matcher, java.util.regex.Pattern" %>

<%

String type = request.getParameter("type");

String db_Addr = "localhost/aramdan";     // db 주소
String ID = "kopoctc";                    // db 접속 ID
String PW = "kopoctc";                 // db 접속 PW

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://" + db_Addr, ID, PW);
PreparedStatement pre = null;
Statement stmt = conn.createStatement();

if(type.equals("insert")){
    String text = request.getParameter("text");

    String deleteSql = "delete from tts_table where id = 1";
    stmt.execute(deleteSql);

    String updateSql = "update tts_table set id = (id - 1)";
    stmt.execute(updateSql);

    String insertSql = "insert into tts_table(id, text, tts_flag, isRead) values(?, ?, ?, 0)";
    pre = conn.prepareStatement(insertSql);
    pre.setString(1, "5");
    pre.setString(2, text);
    pre.setString(3, "1");
    pre.execute();

    pre.close();
} else if ( type.equals("update")) {
    String i = request.getParameter("i");
    String updateSql = "update tts_table set tts_flag = 0 where id = ?";
    pre = conn.prepareStatement(updateSql);
    pre.setString(1, i);
    pre.execute();

    pre.close();
} else if( type.equals("voice")) {
    String text = request.getParameter("text");

    String voiceSql = "update tts_table set isRead = ?";
    pre = conn.prepareStatement(voiceSql);
    pre.setString(1, text);
    pre.execute();

    pre.close();
} else if( type.equals("all")) {
    // String text = request.getParameter("text");
    String voiceSql = "update tts_table set tts_flag = 1, isRead = 1";
    pre = conn.prepareStatement(voiceSql);
    // pre.setString(1, "1");
	// pre.setString(2, "1");
    pre.execute();

    pre.close();
} else if ( type.equals("flag")){
    String id = request.getParameter("id");
    String text = request.getParameter("text");

    String flagSql = "update tts_table set tts_flag = ? where id = ?";
    pre = conn.prepareStatement(flagSql);
    pre.setString(1, text);
    pre.setString(2, id);
    pre.execute();

    pre.close();
} else if (type.equals("clearAll")){
    String updateSql = "update tts_table set text = ?";
    pre = conn.prepareStatement(updateSql);
    pre.setString(1, "");
    pre.execute();
} else if (type.equals("clearOne")){
    String updateSql = "update tts_table set text = ? where id = 5";
    pre = conn.prepareStatement(updateSql);
    pre.setString(1, "");
    pre.execute();
}

stmt.close();
conn.close();
%>
