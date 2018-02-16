<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	
	<link rel="stylesheet" href="<c:url value="/js/jquery-ui/jquery-ui.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/jquery.fileupload.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/datatables.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/bootstrap-select.min.css"/>">
	<script src="<c:url value="/js/jquery-ui/jquery-ui.js" />"></script>
	<script src="<c:url value="/js/jquery.ui.plupload/plupload.full.min.js" />"></script>
	<script src="<c:url value="/js/jquery.ui.plupload/jquery.ui.plupload.min.js" />"></script>
	<script src="<c:url value="/js/jquery.dataTables.js" />"></script>
	<script src="<c:url value="/js/bootstrap-select.min.js" />"></script>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
	            <div class="x_panel">
	              <div class="x_title">
	                <h2><i class="fa fa-bar-chart"></i> Truemove Report</h2>
	                 <ul class="nav navbar-right panel_toolbox">
	                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
	                    </li>
	                  </ul>
	                <div class="clearfix"></div>
	              </div>
	              <div class="x_content">
					<form class="form-horizontal">
						<div class="form-group">
						    <label for="inputEmail3" class="col-sm-1 control-label">ตั้งแต่วันที่</label>
						    <div class="col-sm-3">
		                         <div class="control-group">
		                           <div class="controls">
		                             <div class="col-md-11 xdisplay_inputx form-group has-feedback">
		                               <input type="text" class="form-control has-feedback-left" id="single_cal4" aria-describedby="inputSuccess2Status4">
		                               <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
		                               <span id="inputSuccess2Status4" class="sr-only">(success)</span>
		                             </div>
		                           </div>
		                         </div>
						    </div>
						    <label for="inputEmail3" class="col-sm-1 control-label">ถึงวันที่</label>
						    <div class="col-sm-3">
		                         <div class="control-group">
		                           <div class="controls">
		                             <div class="col-md-11 xdisplay_inputx form-group has-feedback">
		                               <input type="text" class="form-control has-feedback-left" id="single_cal5" aria-describedby="inputSuccess2Status5">
		                               <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
		                               <span id="inputSuccess2Status5" class="sr-only">(success)</span>
		                             </div>
		                           </div>
		                         </div>
						    </div>
						    <div class="col-sm-3">
						    	<button type="button" class="btn btn-primary">ค้นหา</button>
						    </div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="form-group">
								    <label class="col-sm-4 align-left">000: จำนวนครั้งที่ Success </label>
								    <label class="col-sm-4 align-left">003: จำนวนครั้งที่ Fail เงินไม่พอ </label>
								    <label class="col-sm-4 align-left">004: จำนวนครั้งที่ Fail Storage Partition </label>
								    
								</div> 
								<div class="form-group">
								    <label class="col-sm-4 align-left">002: จำนวนครั้งที่ Fail ลูกค้าไม่เป็นสมาชิกแล้ว </label>
								    <label class="col-sm-4 align-left">410: จำนวนครั้งที่ Fail postpaid ระงับชั่วคราว </label>
								    <label class="col-sm-4 align-left">412: จำนวนครั้งที่ Fail prepaid ระงับชั่วคราว </label>
								</div> 
								<div class="form-group">
								<label class="col-sm-4 align-left">413: จำนวนครั้งที่ Fail เบอร์ถูกระงับให้บริการ</label>
								</div>
							</div>
						</div>
					</form>
				 </div>
		   		</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
			              <div class="x_panel tile overflow_hidden">
			                <div class="x_title">
			                  <h2>Report</h2>
			                   <ul class="nav navbar-right panel_toolbox">
			                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
			                      </li>
			                    </ul>
			                  <div class="clearfix"></div>
			                </div>
				            <div class="x_content">
								<canvas id="barChart"></canvas>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	
           
	    <script type="text/javascript">
	    $(function() {
	    	$("#single_cal4").daterangepicker({singleDatePicker:!0,singleClasses:"picker_4"});
	    	$("#single_cal5").daterangepicker({singleDatePicker:!0,singleClasses:"picker_4"});
	    	$('#example').DataTable();
	    	var f=document.getElementById("barChart");
	    	new Chart(f,{type:"bar",data:{labels:["January","February","March","April","May","June","July"],datasets:[{label:"My First dataset",backgroundColor:"rgba(38, 185, 154, 0.31)",borderColor:"rgba(38, 185, 154, 0.7)",pointBorderColor:"rgba(38, 185, 154, 0.7)",pointBackgroundColor:"rgba(38, 185, 154, 0.7)",pointHoverBackgroundColor:"#fff",pointHoverBorderColor:"rgba(220,220,220,1)",pointBorderWidth:1,data:[31,74,6,39,20,85,7]},{label:"My Second dataset",backgroundColor:"rgba(3, 88, 106, 0.3)",borderColor:"rgba(3, 88, 106, 0.70)",pointBorderColor:"rgba(3, 88, 106, 0.70)",pointBackgroundColor:"rgba(3, 88, 106, 0.70)",pointHoverBackgroundColor:"#fff",pointHoverBorderColor:"rgba(151,187,205,1)",pointBorderWidth:1,data:[82,23,66,9,99,4,2]}]}})
	    });
	    </script>
	</jsp:body>
</t:master>