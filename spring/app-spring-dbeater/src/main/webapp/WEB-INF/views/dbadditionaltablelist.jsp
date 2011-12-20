<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<html>
<head>
    <title>Database tables may have been Modified!</title>
</head>
<body>
   <h1>Database tables may have been Modified!!</h1>

   <h4>Database Info:</h4>
       DataSource: <c:out value="${dbInfo}"/></br>

   <h4>Could we modify db tables?</h4>
       <p>
           <c:out value="${itemExists}"/></br>
       </p>

       <c:if test="${not empty allTables}">
           <p>
           <c:forEach var="table" items="${allTables}">
               <c:if test="${fn:contains(table,'other_categories_')}">
                      <p>PASS: other_categories table(s) found. </p>
               </c:if>
               <c:out value="${table}"/></br>
           </c:forEach>
           </p>
       </c:if>
       <c:if test="${empty allTables}">
           <p>FAIL: No Tables found</p>
       </c:if>
</body>
</html>