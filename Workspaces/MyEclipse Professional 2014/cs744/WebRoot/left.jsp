<%@ include file="head_without_jsp.jsp"%>
<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
				<ul class="nav nav-tabs nav-stacked">
					<%if (request.getSession().getAttribute("firstname") == "admin"){%>
					<% out.print("<li><a href=\"addUser.jsp\" target=\"frame3\">Add a User</a></li>");%>
					<% out.print("<li><a href=\"listUser.action\" target=\"frame3\">Check Users</a></li>");}%>
      				<li><s:a href="addNode.jsp" target="mainframe">Add Non-Connector Node</s:a></li>
					<li><s:a href="addConnector.jsp" target="mainframe">Add Pattern</s:a></li>			
  					<li><s:a href="deleteNode.jsp" target="mainframe">Delete Node</s:a></li>
  					<li><s:a href="sendMessage.jsp" target="mainframe">Send Message</s:a></li>
  					<li><s:a href="showMessagehead.jsp" target="mainframe">Show Message</s:a></li>
  					<li><s:a href="activateNode.jsp" target="mainframe">Activate Node</s:a></li>
  					<li><s:a href="inactivateNode.jsp" target="mainframe">Inactivate Node</s:a></li>
  					<li><s:a href="footer.jsp" target="frame3">Show Network</s:a></li>
				</ul>
			</div>

