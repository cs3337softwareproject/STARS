<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<meta http-equiv="refresh" content="5" />
<title>${currentCourse} Attendance View</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

</head>
<body>
<div  class="container">

<a href="Courses"><button class="btn btn-success btn-lg">Back to Courses</button></a>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/stars"
     user=""  password=""/>

<sql:update dataSource="${snapshot}">
CREATE TABLE temp LIKE ${currentCourse}_${instructorID};
</sql:update>

<sql:update dataSource="${snapshot}"> 
INSERT temp SELECT * FROM ${currentCourse}_${instructorID};
</sql:update>

<sql:update dataSource="${snapshot}">
ALTER TABLE temp
DROP firstname , DROP lastname;
</sql:update>

<sql:query dataSource="${snapshot}" var="result">
SELECT * FROM temp;
</sql:query>

<sql:update dataSource="${snapshot}">
DROP TABLE temp;
</sql:update>


<table class="table table-bordered table-hover" border="1">
	<tr>
		<c:forEach var="col" items="${result.columnNames}">
			<th>${col}</th>
		</c:forEach>
	</tr>
	<c:forEach var="row" items="${result.rowsByIndex}">
		<tr>
			<td>${row[0]}</td>
			<td>${row[1]}</td>
		</tr>
	</c:forEach>
</table>
</div>
</body>
</html>