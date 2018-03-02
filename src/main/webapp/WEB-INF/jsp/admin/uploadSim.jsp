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
							 <form method="POST" id="uploadForm" enctype="multipart/form-data" action="<c:url value="/Admin/ManageData/UploadExcelFile"/>">
								  <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
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
						        <table id="simTable" class="table table-bordered table-striped" cellspacing="0" width="100%">
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
		
	        $('form').on('submit', uploadFiles);
			$('input[type=file]').on('change', prepareUpload);
		
			function uploadFiles(event)
			{
			    event.stopPropagation(); // Stop stuff happening
			    event.preventDefault(); // Totally stop stuff happening
			
			    var form = document.forms[1];
    			var formData = new FormData(form);
			    $.ajax({
			        url: $('#uploadForm').attr('action'),
			        type: 'POST',
			        data: formData,
			        cache: false,
			        dataType: 'json',
			        processData: false, // Don't process the files
			        contentType: false, // Set content type to false as jQuery will tell the server its a query string request
			        beforeSend: function (xhr) {
						xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
						$.LoadingOverlay("show");
						lastActivity = new Date().getTime();
					},
			        success: function(data, textStatus, jqXHR)
			        {
			            if(data == 1){
			            	$.LoadingOverlay("hide");
			            }
			        },
			        error: function(jqXHR, textStatus, errorThrown)
			        {
			            displayErrorAjax(jqXHR, textStatus, errorThrown);
			        }
			    });
			}
			function prepareUpload(event)
			{
			  files = event.target.files;
			}
			function searchSim(params) {
				if ($.fn.DataTable.isDataTable('#simTable')) {
					$('#simTable').DataTable().destroy();
				}
				$('#simTable tbody').empty();
				var url = '/Admin/ManageData/SearchSim';
				var table = $('#simTable').DataTable(
				{
					"searching" : true,
					"processing" : true,
					"serverSide" : true,
					"ajax" : {
						"contentType" : "application/json; charset=utf-8",
						"dataType" : "json",
						"beforeSend" : function(xhr) {
							xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
						},
						"data" : function(d) {
							d.dataSearch = params;
						},
						"url" : GetSiteRoot() + url,
						"type" : "POST",
						"error" : function(jqXHR, textStatus, errorThrown) {
							$("#dialog-confirm").dialog('close');
							 $("#dialog-message").dialog('close');
							 closeOverlay();
							 $('.tooltip').remove();
							 if(typeof jqXHR.responseJSON != 'undefined'){
								 if(typeof jqXHR.responseJSON.errorMessage != 'undefined'){
									 $("#dialog-confirm").dialog('close');
									 $("#dialog-message").dialog('close');
									 alertModal('Warning', jqXHR.responseJSON.errorMessage);
									 $("#dialog-message").dialog({
										  modal: true,
										  buttons: {
											Ok: function() {
											  $(this).dialog("close");
											  closeOverlay();
											}
										  },
										  close: function(){
											  closeOverlay();
										  }
									});
								}
							}
						}
					},
					"columns" : [ {
						"data" : "simNumber"
					}, {
						"data" : "price"
					}, {
						"data" : "activeFlag"
					}, {
						"data" : "effectiveDate"
					}, {
						"data" : "merchantId"
					}, {
						"data" : "activeStatus"
					}, {
						"data" : "activeStatus"
					} ],
					"initComplete" : function(settings, json) {
						
					},
					"drawCallback" : function() {
						
					},
					"columnDefs" : [ {
						"className" : "dt-left",
						"targets" : [1]
					}, {
						"className" : "dt-right",
						"targets" : [ ]
					}, {
						"className" : "dt-center",
						"targets" : [ 0, 2, 3, 5 ]
					}],
					"order" : [],
					"fnRowCallback" : function(nRow, aData, index) {
						var edit = "";
						var del = "";
						var view = "";
						
						/* view = "<a href=\"javascript:viewRole('" + aData.roleId+ "','" + aData.roleName + "');\">" + aData.roleName + "</a>"
						if('${role}' == '<spring:message code="role.maker" />'){
							edit = "<a href=\"javascript:editRole('" + aData.roleId+ "','" + aData.roleName + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Role\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	 
							if (aData.disableDeleteFlg == true) {
								del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Role\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></span>";
							} else {
								del = "<a href=\"javascript:deleteRole('" + aData.roleName + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Role\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
							}
						}
						var setting = this.fnSettings();
						$('td:eq(0)', nRow).html("<center>" + (setting._iDisplayStart + index + 1) + "<center>");
						$('td:eq(1)', nRow).html(view);
						$('td:eq(2)', nRow).html("<center>" + edit + '&nbsp;&nbsp;'+ del + "</center>"); */
						return nRow;
					}
				});
			}
			searchSim({});
	    });
	    </script>
	</jsp:body>
</t:master>