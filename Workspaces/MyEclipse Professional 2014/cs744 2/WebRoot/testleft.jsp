<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
				<ul class="nav nav-tabs nav-stacked">
					<%if (request.getSession().getAttribute("firstname") == "admin"){%>
					<% out.print("<li><a href=\"addUser.jsp\">Add a User</a></li>");%>
					<% out.print("<li><a href=\"listUser.action\">Check Users</a></li>");}%>
      				<li><s:a href="addNode.jsp">Add Non-Connector Node</s:a></li>
      				<li><s:a onclick = "addNode();">Add Non-Connector Node</s:a></li>
					<li><s:a href="addConnector.jsp">Add Pattern</s:a></li>			
  					<li><s:a href="deleteNode.jsp">Delete Node</s:a></li>
  					<li><s:a href="sendMessage.jsp">Send Message</s:a></li>
  					<li><s:a href="showMessage?method=show">Show Message</s:a></li>
				</ul>
			</div>

