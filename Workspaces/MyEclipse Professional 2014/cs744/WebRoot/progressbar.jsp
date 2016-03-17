<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<link href="css/bootstrap-slider.min.css" rel="stylesheet">
			<div class="span10" id="datacontent">
				<form id="form2" action="inactivateNode" method="post">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Delete Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span2">Control for randomness:</td>
								<td class="span3"><input id="random" name="random" type="text" data-slider-id='ex1Slider' data-slider-min="0" data-slider-max="100" data-slider-step="1" data-slider-value="0"/></td>
								<td class="span5">
									<button class="btn btn-primary" type="submit">Submit</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div id="mynetwork" ></div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
				<script type="text/javascript" src="js/jquery-1.9.1.min.js" charset="UTF-8"></script>
				<script type="text/javascript" src="js/modernizr.js"></script>
				<script type="text/javascript" src="js/bootstrap-slider.min.js" charset="UTF-8"></script>
				<script type="text/javascript">
				$("#random").slider({
					formatter: function(value) {
						return 'Current value: ' + value;
					},
					tooltip: 'always'
				});
				</script>
</body>
</html>
