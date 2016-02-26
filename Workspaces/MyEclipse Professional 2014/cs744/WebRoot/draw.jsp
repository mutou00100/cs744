<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="head.jsp"%>
<%String error = "";
	NodeDao nd = new NodeDao();
	ArrayList<Integer> res = nd.getAllC();
	List<Node> allnodes = nd.getAllNodes();
	List<Edge> edge = nd.getCEdges();
	List<Edge> edgeCC = nd.getEdgesForC();
	List<Edge> edgeNN = nd.getEdgesForN();
	List<Edge> edgeCN = nd.getCEdges();
	edge.addAll(nd.getNEdges());
	List<Integer> allPatterns = nd.getAllC();%>
<link type="text/css" rel="stylesheet" href="css/table.css" />
<script type="text/javascript" src="js/exampleUtil.js"></script>
<script type="text/javascript" src="js/vis.js"></script>
<link href="js/vis.css" rel="stylesheet" type="text/css" />
<script src="js/googleAnalytics.js"></script>
<% 
if (request.getAttribute("error") == null) {
	} else {
			 error = (String) request.getAttribute("error");
				%>
   <script>
    alert("<%=error%>");</script>
   <% }
%>
<script type="text/javascript">
    var nodes = null;
    var edges = null;
    var network = null;
    var DIR = '<%=path%>/img/';
	var EDGE_LENGTH_MAIN = 300;
	var EDGE_LENGTH_SUB = 80;

	function draw() {
		nodes = [];
		edges = [];
<%
  		if(allnodes != null) { 
  			for (int i=0;i<allnodes.size();i++){%>
	
				<%if (allnodes.get(i).getType().equals("c")){%>
				nodes.push({id :<%=allnodes.get(i).getnID()%>, label : 'Pattern' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Network-Pipe-icon.png',shape : 'image'
				});
				<%}else {%>
				nodes.push({id :<%=allnodes.get(i).getnID()%>,label : 'Node' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Hardware-My-Computer-3-icon.png',shape : 'image'});
<%}%>
	
<%}
  		}%>
	
		<%
  		if(edge != null) { // 有信息返
  			for (int i=0;i<edgeCC.size();i++){
  			%>
  			
			edges.push({from :<%=edgeCC.get(i).getNode1()%>, to :<%=edgeCC.get(i).getNode2()%>,smooth:false,length : EDGE_LENGTH_MAIN,dashes:true});
			<%}
			for (int i=0;i<edgeCN.size();i++){
  			%>			
			edges.push({from :<%=edgeCN.get(i).getNode1()%>, to :<%=edgeCN.get(i).getNode2()%>,smooth:false,length : EDGE_LENGTH_SUB});
			<%}
			for (int i=0;i<edgeNN.size();i++){%>
  			
			edges.push({from :<%=edgeNN.get(i).getNode1()%>, to :<%=edgeNN.get(i).getNode2()%>,smooth: {type: 'dynamic'}});
			<%}
  		}%>
	// create a network
		var container = document.getElementById('mynetwork');
		var data = {
			nodes : nodes,
			edges : edges
		};
		var options ={layout:{randomSeed:1}};
		network = new vis.Network(container, data, options);
	}
</script>