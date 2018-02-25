<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	
	<link rel="stylesheet" href="<c:url value="/css/jquery.fileupload.css"/>">
	
	<script src="<c:url value="/js/jquery.ui.plupload/plupload.full.min.js" />"></script>
	<script src="<c:url value="/js/jquery.ui.plupload/jquery.ui.plupload.min.js" />"></script>
	
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
      		<h4><b><i class="fas fa-tablet-alt" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> จัดการเบอร์โทร</b></h4>
    	</div>
    </div>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
             <div class="x_panel tile overflow_hidden">
               <div class="x_content">
                 	<div class="panel-round-bd">
                 		<div class="form-group">
	                 		<label class="radio-inline">
							  <input type="radio" name="type_input" value="1" checked="checked"> <b>เพิ่มเบอร์โดยการอัพโหลดไฟล์</b>
							</label>
							<label class="radio-inline">
							  <input type="radio" name="type_input" value="2"> <b>เพิ่มเบอร์โดยการกรอกข้อมูล</b>
							</label>
						</div>
						<div id="type_input_1">
							 <form method="POST" enctype="multipart/form-data" action="<c:url value="/Admin/UploadExcelFile" />">
								  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								 <div class="row">
									<div class="col-md-4 col-sm-4 col-xs-4">
										<div class="form-group">
										    <label for="exampleInputEmail1">อัพโหลดไฟล์</label>
										    <input type="file" class="form-control" id="file" name="file" accept=".xls,.xlsx">
										 </div>				
									</div>
								</div>
								<div class="row">
									<div class="col-md-1 col-sm-1 col-xs-1"> 
										<button type="submit" class="btn btn-primary">อัพโหลดไฟล์</button>
									 </div>
								</div> 
							</form> 
						</div>
						<div id="type_input_2" style="display:none;">
							<div class="row">
								<div class="col-md-3 col-sm-3 col-xs-3">
									<div class="form-group">
									    <label for="exampleInputEmail1">เบอร์โทร</label>
									    <input type="text" class="form-control" id="mobile">
									  </div>
								</div>
								<div class="col-md-3 col-sm-3 col-xs-3">
									<div class="form-group">
									    <label for="exampleInputEmail1">ราคา</label>
									    <div class="input-group">
									      <input type="text" class="form-control" id="price">
									      <div class="input-group-addon">บาท</div>
									    </div>
									  </div>
								</div>
								<div class="col-md-3 col-sm-3 col-xs-3">
									<div class="form-group">
									    <label for="exampleInputEmail1">Credit Term</label>
									    <div class="input-group">
									      <input type="text" class="form-control" id="creditTerm">
									      <div class="input-group-addon">วัน</div>
									    </div>
									  </div>
								</div>
								<div class="col-md-3 col-sm-3 col-xs-3">
									<div class="form-group">
									    <label for="exampleInputEmail1">วันที่เปิดจอง</label>
									    <div class="input-group">
									      <input type="text" class="form-control" id="exampleInputAmount">
									      <div class="input-group-addon"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></div>
									    </div>
									  </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-1 col-sm-1 col-xs-1">
									<button type="button" class="btn btn-primary">บันทึกข้อมูล</button>
								</div>
							</div>
						</div>
				</div>
			 </div>
    		</div>
    		<br/>
    		<div class="panel-round-bd">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12">
		              <div class="x_panel tile overflow_hidden">
						<div class="row">
							<div class="col-md-12">
						        <table id="example" class="table table-bordered table-striped" cellspacing="0" width="100%">
							        <thead>
							            <tr>
							                <th class="text-center">เบอร์โทรศัพท์</th>
							                <th class="text-center">ราคา</th>
							                <th class="text-center">สถานะการจอง</th>
							                <th class="text-center">วันที่เปิดจอง</th>
							                <th class="text-center">ลูกค้าที่จอง</th>
							                <th class="text-center">Activate Status</th>
							                <th class="text-center">Action</th>
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
		</div>
	</div>	
       <br/><br/>    
	    <script type="text/javascript">
	    $(function() {
	        $('#example').DataTable();
	        $('input[name="type_input"]').change(function(){
	        	if(this.value == 1){
	        		$('#type_input_2').hide();
	        		$('#type_input_1').show();
	        	}else{
	        		$('#type_input_1').hide();
	        		$('#type_input_2').show();
	        	}
	        });
	        $('#exampleInputAmount').datepicker({
			    format: 'mm/dd/yyyy',
			    startDate: '-3d'
			});
	    });
	    </script>
	</jsp:body>
</t:master>