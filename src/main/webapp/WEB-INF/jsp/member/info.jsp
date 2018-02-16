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
	                <h2><i class="fa fa-user"></i> ค้นฐานข้อมูลสมาชิก</h2>
	                 <ul class="nav navbar-right panel_toolbox">
	                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
	                    </li>
	                  </ul>
	                <div class="clearfix"></div>
	              </div>
	              <div class="x_content">
					<form class="form-horizontal">
						<div class="form-group">
						    <label for="inputEmail3" class="col-sm-3 control-label">สมัครตั้งแต่</label>
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
						    <label for="inputEmail3" class="col-sm-2 control-label">ถึงวันที่</label>
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
						</div>
						<div class="form-group">
						    <label for="inputEmail3" class="col-sm-3 control-label">หรือ ยกเลิกตั้งแต่</label>
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
						    <label for="inputEmail3" class="col-sm-2 control-label">ถึงวันที่</label>
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
						</div>
						<div class="form-group">
						    <label for="inputEmail3" class="col-sm-3 control-label">เลือกบริการ</label>
						    <div class="col-sm-3">
						    	<select class="form-control selectpicker">
								  <option>ทุกบริการ</option>
								  <option>Ketchup</option>
								  <option>Relish</option>
								</select>
						    </div>
						    
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">เลือกเครือข่าย </label>
						    <div class="col-sm-3">
						    	<select class="form-control selectpicker">
								  <option>ทุกเครือข่าย</option>
								  <option>Ketchup</option>
								  <option>Relish</option>
								</select>
						    </div>
					   	</div>
					   	<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">เลือกสถานะสมาชิกปัจจุบัน</label>
						    <div class="col-sm-3">
						    	<select class="form-control selectpicker">
								  <option>ทุกสถานะ</option>
								  <option>Ketchup</option>
								  <option>Relish</option>
								</select>
						    </div>
					   	</div>
						<div class="form-group" style="margin-left:10px;">
						    <div class="col-sm-3"></div>
						    <div class="col-sm-6">
						      <button type="button" class="btn btn-primary">ค้นหา</button>
						      <button type="button" class="btn btn-success">Export Data</button>
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
								<table id="example" class="display" cellspacing="0" width="100%">
							        <thead>
							            <tr>
							                <th>ภาพ Preview</th>
							                <th>cccc</th>
							                <th>Office</th>
							                <th>Age</th>
							                <th>Start date</th>
							                <th>Salary</th>
							            </tr>
							        </thead>
							       
							        <tbody>
							            	            
							        </tbody>
							    </table>
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
	   	});
	    </script>
	</jsp:body>
</t:master>