<%@ include file="head_without_jsp.jsp"%>
<link href="css/bootstrap-slider.min.css" rel="stylesheet">
			<div class="span10" id="datacontent">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Control for randomness</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span3"><input id="random" name="random" type="text" data-slider-id='ex1Slider' data-slider-min="0" data-slider-max="100" data-slider-step="1" data-slider-value="0"/></td>
								<td class="span5">
									<button class="btn btn-primary" type="submit">Submit</button>
								</td>
							</tr>
						</tbody>
					</table>
		</div>
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
