<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="com.utils.SeparatePage"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.User"%>
<%@ page import="com.entity.Message"%>
<%@ include file="head.jsp"%>
<%
	SeparatePage sp = (SeparatePage) request.getAttribute("sp");
String spStr = sp.getSeparateString();
HttpServletResponse resp=(HttpServletResponse) response;
List<Message> userList = sp.getSearchData();
String idKey = (String) request.getAttribute("destination");
String role = (String) session.getAttribute("role");
String cols = "4";
String isAdmin = null;
if (role != null && role.equals("admin")){
	cols = "5";
	isAdmin = "true";
}
String userid = (String) session.getAttribute("currId");
%>

<!-- Javascript goes in the document HEAD -->
<link type="text/css" rel="stylesheet" href="css/table.css" />
<script type="text/javascript" src="js/exampleUtil.js"></script>
<script type="text/javascript" src="js/vis.js"></script>
<link href="js/vis.css" rel="stylesheet" type="text/css" />
<script src="js/googleAnalytics.js"></script>
<link type="text/css" rel="stylesheet" href="css/table.css" />

<div class="span10" id="datacontent">
					
		<table width="1100" class="table">
			<tr>
				<td colspan="<%=cols%>">
					<form action="showMessage?method=show" method="post">			
						Search By Receiver Node: <input type="text" name="destination" value="<%=idKey%>" />
						<input type="submit" class="check" value="Search" />
					</form></td>
			</tr>
			<%if (userList != null && userList.size() != 0) {%>
			<p><tr>
			    <th>Date</th>
				<th>Sender</th>
				<th>Receiver</th>
				<th>Content</th>

			</tr></p>


			<%
				//to get from the database
								if (userList != null && userList.size() != 0)
								{
									for (int i = 0; i < userList.size(); i++)
									 {
										Message user = userList.get(i);
											String id = user.getId();
											int ori = user.getOrigin();
											int dest = user.getDestination();
											String content = user.getContent();
			%>

			<tr>
				<td><%=id%></td>
				<td><%=ori%></td>
				<td><%=dest%></td>
				<td><%=content%></td>

			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="22"><%=spStr%></td>
			</tr>
			<%
				} 	
						else { out.println("<tr><td colspan='21'>not found </td></tr>");}
			}%>
			
		</table>
</div>
		</div>
	</div>
</body>
</html>