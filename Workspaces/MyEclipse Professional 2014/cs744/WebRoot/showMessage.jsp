<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ page import="com.utils.SeparatePage"%>
<%@ page import="com.entity.Message"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="head.jsp"%>
<%
SeparatePage sp = (SeparatePage) request.getAttribute("sp");
String spStr = sp.getSeparateString();
List<Message> messageList = sp.getSearchData();
String idKey = (String) request.getAttribute("id");
String role = (String) session.getAttribute("role");
String cols = "4";
%>
<html>
	<head>
		<title>manage information</title>
	</head>
	<body>
		<strong>your current id:</strong>
		<td>
			<center>
				<h3>
					users information&nbsp;
					<br>
				</h3>
				<table border="2" width="100%">
					<tr>
						<td colspan="<%=cols %>">
						
						</td>
					</tr>
					<tr>
						<td>
							time
						</td>
						<td>
							sender node
						</td>
						<td>
							receiver node
						</td>
						<td>
							message
						</td>
					</tr>
						<%
				
				if (messageList != null && messageList.size() != 0){
					for (int i = 0; i < messageList.size(); i++) {
						Message message = messageList.get(i);
							Date date = message.getId();
							String content = message.getContent();
							int ori = message.getOrigin();
							int dest = message.getDestination();						
				%>
					<tr>

						<td><%=date%></td>
						<td><%=ori%></td>
						<td><%=dest%></td>
						<td><%=content%></td>
					</tr>
					<%} %>
					<tr>
						<td colspan="22"><%=spStr %></td>
					</tr>
					<%} else { out.println("<tr><td colspan='21'>not found </td></tr>");} %>
				</table>

				<a href="JumpBack">return</a>&nbsp;
				<a href="ValidS">log off </a>
			</center>
	</body>
</html>
<script type="text/javascript">
	function check() {
		if ( form2.n2.value ==""&& form2.n1.value =="") {
			return true;
		}
		if (form2.gid.value == form2.n1.value) {
			alert("The node1 can't be the connector!");
			return false;
		}if (form2.gid.value == form2.n2.value) {
			alert("The node2 can't be the connector!");
			return false;
		}if (form2.n1.value == form2.n2.value && form2.n1.value != "" && form2.n2.value != "") {
			alert("The node1 and node2 can't be the same!");
			return false;
		}
		var nubmer1 = parseInt(document.getElementById("n1").value);
		var nubmer2 = parseInt(document.getElementById("n2").value);
		if (form2.n1.value !=""&&(nubmer1<=0||!(/^\d+$/.test(nubmer1)))){
				 alert("Please enter a Integer!");
	     return false;
			}
			if (form2.n2.value !=""&&(nubmer2<=0||!(/^\d+$/.test(nubmer2)))){
				alert("Please enter a Integer!");
				return false;
			}
		return true;
	}
</script>
			<div class="span10" id="datacontent">

				<form id="form2" action="AddNode" method="post" onsubmit ="return check()">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Non-connector Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Pattern:</td>
								<td>Check Which Node?：</td>
								<td class="input"><input name="n" id= "n" class="input-small"
									size="10" type="text" value=""></input></td>
								<td>
									<button class="btn btn-primary" type="submit" onclick="return check();">Add</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<%@ include file="footer.jsp"%>