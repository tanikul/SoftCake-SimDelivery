<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="role.checker" var="checker"/>
<spring:message code="role.viewer" var="viewer"/>
<spring:message code="role.maker" var="maker"/>
<t:master>
	<jsp:body>
	
	<link rel="stylesheet" href="<c:url value="/css/jquery.fileupload.css"/>">
	
	<script src="<c:url value="/js/jquery.ui.plupload/plupload.full.min.js" />"></script>
	<script src="<c:url value="/js/jquery.ui.plupload/jquery.ui.plupload.min.js" />"></script>
	
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
      		<h4><i class="fas fa-mobile-alt" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> <b>จัดการซิมการ์ด</b></h4>
    	</div>
    </div>
		<c:if test="${role eq maker}" >
           <div class="row">
             <div class="col-md-12 col-sm-12 col-xs-12 panel-round-bd">
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
							<div class="col-md-4 col-sm-4 col-xs-12">
								<div class="form-group">
								    <label for="exampleInputEmail1">อัพโหลดไฟล์</label>
								    <input type="file" class="form-control" id="file" name="file" accept=".xls,.xlsx"> 
								    
								 </div>				
							</div>
						</div>
						<div class="row">
							<div class="col-md-2 col-sm-2 col-xs-12">
								<label><a href="<c:url value="/Admin/ManageData/OpenExample"/>">ตัวอย่างไฟล์</a></label>
								<div class="form-group"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-1 col-sm-1 col-xs-1"> 
								<button type="submit" class="btn btn-primary">Upload</button>
							 </div>
						</div> 
					</form> 
				</div>
				<div id="type_input_2" style="display:none;">
					<div class="row">
						<div class="col-md-4 col-sm-4 col-xs-12">
							<div class="form-group">
							    <label for="exampleInputEmail1">Mobile No.</label>
							    <input type="text" class="form-control" id="mobile">
							  </div>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-6">
							<div class="form-group">
							    <label for="exampleInputEmail1">Price</label>
							    <div class="input-group">
							      <input type="text" class="form-control" id="price">
							      <div class="input-group-addon">บาท</div>
							    </div>
							  </div>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-6">
							<div class="form-group">
							    <label for="exampleInputEmail1">Credit Term</label>
							    <div class="input-group">
							      <input type="text" class="form-control" id="creditTerm">
							      <div class="input-group-addon">วัน</div>
							    </div>
							  </div>
						</div>
						<!-- <div class="col-md-3 col-sm-3 col-xs-3">
							<div class="form-group">
							    <label for="exampleInputEmail1">Recieved Date</label>
							    <div class="input-group">
							      <input type="text" class="form-control" id="recievedDate">
							      <div class="input-group-addon"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></div>
							    </div>
							  </div>
						</div> -->
					</div>
					<div class="row">
						<div class="col-md-1 col-sm-1 col-xs-1">
							<button type="button" class="btn btn-primary">Save</button>
						</div>
					</div>
				</div>
				
				</div>
			</div>
				<br/>
    		</c:if>
    		<div class="row">
    		<div class="panel-round-bd">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12">
		              <div class="x_panel tile overflow_hidden">
						    <div class="row">
								<div class="col-xs-12">
								  <div class="box box-success">
									<div class="box-header">
									  <ul class="nav nav-tabs"> 
										<li class="active" id="pendingLi"><a href="javascript:activeTab('pending');"><i class="fa fa-question-circle fa-2x text-yellow"></i>&nbsp;&nbsp;Pending</a></li> 
										<li id="activeLi"><a href="javascript:activeTab('active');"><i class="fa fa-check-circle fa-2x text-light-blue"></i>&nbsp;&nbsp;Master</a></li>  
									  </ul>
									  
									</div>
									<!-- /.box-header -->
									<div class="box-body">
										<div id="pendingTab">
										  <table id="pendingTbl" class="table table-bordered table-striped" style="width:100%">
											<thead>
											<tr>
											   <th class=" dt-body-center"><input type="checkbox" class="editor-active" id="checkall"></th>
											   <th class="text-center">Mobile No.</th>
								                <th class="text-center">Price (บาท)</th>
								                <%-- <th class="text-center">Recieved Date</th> --%>
								                <th class="text-center">Credit Term (วัน)</th>
								                <th class="text-center">Operation</th>
								                <th class="text-center">Authorize Status</th>
								                <th class="text-center">Booking Status</th>
								                <th class="text-center">Activate Status</th>
								                <th class="text-center">Action</th>
											</tr>
											</thead>
											<tbody>
												
											</tbody>
										  </table>
										</div>  
										<div id="activeTab" style="display:none;">
										  <table id="activeTbl" class="table table-bordered table-striped" style="width:100%">
											<thead>
											<tr>
											    <th class="text-center">Mobile No.</th>
								                <th class="text-center">Price (บาท)</th>
								               <%--  <th class="text-center">Recieved Date</th> --%>
								                <th class="text-center">Credit Term (วัน)</th>
								                <th class="text-center">Operation</th>
								                <th class="text-center">Authorize Status</th>
								                <th class="text-center">Booking Status</th>
								                <th class="text-center">Activate Status</th>
								                <th class="text-center">Action</th>
											</tr>
											</thead>
											<tbody>
												
											</tbody>
										  </table>
										 </div>
										  
										</div>
										<!-- /.box-body -->
									  </div>
									  <!-- /.box -->
									</div>
								<!-- /.col -->
							  </div>
								<c:if test="${role eq checker}">
								  <div class="row">
									<div class="col-sm-12">
										<div class="col-sm-4">
											 <div class="cont_btn">
										     	<button class="btn btn-primary" id="btn_approve" disabled>Approve</button>
										     	<button class="btn btn-danger" id="btn_reject" disabled>Reject</button>
										    </div>
									    </div>
								    </div>
							    </div>
						    </c:if>
						</div>
					</div>
				</div>
			</div>
	</div>	
	<div class="modal fade" id="modalSim" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	       <div class="modal-header">
	         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	         	แก้ไขซิมการ์ด
	       </div>
	       <div class="modal-body">
	          <div class="container-fluid">
	          		<div class="alert alert-danger" role="alert" id="show-reject" style="display:none;">
						
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-3">
								<label><b>Mobile No.</b></label>
							</div>
							<div class="col-sm-5">
								<input type="text" id="simNumber" class="form-control" disabled/>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-3">
								<label>Price</label>
							</div>
							<div class="col-sm-5">
								<input type="text" id="price" class="form-control" />
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<!-- <div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-3">
								<label>Recieved Date</label>
							</div>
							<div class="col-sm-5">
								<div class="input-group">
							      <input type="text" class="form-control" id="recievedDate">
							      <div class="input-group-addon"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></div>
							    </div>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div> -->
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-3">
								<label><b>Credit Term</b></label>
							</div>
							<div class="col-sm-5">
								<input type="text" id="creditTerm" class="form-control" />
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<input type="hidden" id="operationFlag">
					<input type="hidden" id="type">
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-3"></div>
							<div class="col-sm-4">
								 <div class="cont_btn">
							     	<button class="btn btn-primary" id="btn_save">Save</button>
							     	<button class="btn btn-danger" id="btn_cancel">Cancel</button>
							    </div>
						    </div>
					    </div>
				    </div>
				</div>
	       </div>
	    </div>
	   </div>
	 </div>   
	    <script type="text/javascript">
	    searchMenu = 'MANAGESIM';
	    var oldValueSearch = '';
	    var oldKeySearch = '';
	    errMsg.sim = {
			simNumber: { id: $('#modalSim #simNumber'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
			price: { id: $('#modalSim #price'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
			/* recievedDate: { id: $('#modalSim #recievedDate'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }, */
			creditTerm: { id: $('#modalSim #creditTerm'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
		};
	    
	    errMsg.sim2 = {
			mobile: { id: $('#type_input_2 #mobile'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
			price: { id: $('#type_input_2 #price'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
			/* recievedDate: { id: $('#type_input_2 #recievedDate'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }, */
			creditTerm: { id: $('#type_input_2 #creditTerm'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
		};
	    var table;
	    $(function() {
	    	listTab = new Array("pending", "active");
	        $('input[name="type_input"]').change(function(){
	        	if(this.value == 1){
	        		$('#type_input_2').hide();
	        		$('#type_input_1').show();
	        	}else{
	        		$('#type_input_1').hide();
	        		$('#type_input_2').show();
	        	}
	        });
	        $('form').on('submit', uploadFiles);
			$('input[type=file]').on('change', prepareUpload);
		
			function uploadFiles(event)
			{
			    event.stopPropagation(); 
			    event.preventDefault(); 
			
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
			        	$.LoadingOverlay("hide");
			        	if(data.hasOwnProperty('success') && data.hasOwnProperty('message')){
							if(!data.success){
								$("#dialog-confirm").dialog('close');
								$("#dialog-message").dialog('close');
								alertModal('Error', data.message);
								$('.tooltip').remove();
							}else{
								$("#dialog-confirm").dialog('close');
								$("#dialog-message").dialog('close');
								alertModal('Alert', data.message);
								$('.tooltip').remove();
							}
						}else if(data == 1){
			            	searchSimPending({});
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
			
			searchSimPending({});
			searchSim({}, 'active');
			
			$('#btn_save').click(function(){
				if(checkValidate('sim')){
					var simNumber = $('#modalSim #simNumber').val().replaceAll('-','');
			    	var price = $('#modalSim #price').val().replaceAll(',','');
			    	//var recievedDate = $("#modalSim #recievedDate").val();
			    	var creditTerm = $('#modalSim #creditTerm').val().replaceAll(',','');
			    	var params = {
			    		simNumber: simNumber,
			    		price: price,
			    		//recievedDate: parseDateForSave(recievedDate),
			    		creditTerm: creditTerm,
			    		operationFlag: $('#modalSim #operationFlag').val()
			    	};
			    	var url = ( $('#modalSim #type').val() == 'P') ? '/Admin/ManageData/UpdateSim' : '/Admin/ManageData/UpdateSimMst';
			    	sendPostAjax(url, params, function(data){
						if(data == 1){
							$('#modalSim').modal('hide');
							searchSimPending({});
						}
					  });
				}
			});
			
			$('#btn_cancel').click(function(){
				$('#modalSim').modal('hide');
			});
			
			$('#type_input_2 #mobile').mask('000-000-0000');
	    	$('#type_input_2 #price').mask("#,##0.00", {reverse: true});
	    	$("#type_input_2 #recievedDate").datepicker({
	    		format: 'dd/mm/yyyy'
	    	});
	    	$('#type_input_2 #creditTerm').mask("#,##0", {reverse: true});
	    	
	    	$('#type_input_2 .btn-primary').click(function(){
	    		if(checkValidate('sim2')){
	    			var simNumber = $('#type_input_2 #mobile').val().replaceAll('-','');
			    	var price = $('#type_input_2 #price').val().replaceAll(',','');
			    	//var recievedDate = $("#type_input_2 #recievedDate").val();
			    	var creditTerm = $('#type_input_2 #creditTerm').val().replaceAll(',','');
			    	var params = {
			    		simNumber: simNumber,
			    		price: price,
			    		//recievedDate: parseDateForSave(recievedDate),
			    		creditTerm: creditTerm,
			    		operationFlag: 'N'
			    	};
			    	sendPostAjax('/Admin/ManageData/SaveSim', params, function(data){
						if(data == 1){
							searchSimPending({});
						}
					});
	    		}
	    	});
	    	
	    	$('#btn_approve').click(function(){
	    		confirmModal('', 'Do you want to approve all you choose ? ');
				$( "#dialog-confirm" ).dialog({
					modal: true,
					resizable: false,
					height: "auto",
					width: "auto",
					open: function(ev, ui) {
					  openOverlay();
					},
					close: function(ev, ui) {
					  closeOverlay();
					},
					buttons: {
						Ok: function() {
					 		var rows = table.rows({ 'search': 'applied' }).nodes();
				    		var obj = [];
				    		$('input[type="checkbox"]', rows).each(function(i, item){
				    			if($(item).is(':checked')){
				    				var data = table.rows(i).data();
				    				obj.push(data[0]);
				    			}
				    		});
				    		if(obj.length > 0){
					    		sendPostAjax('/Admin/ManageData/ApproveAll', obj, function(data){
					    			if(data == 1){
					    				searchSimPending({});
					    				searchSim({}, 'active');
					    			}
					    		});
				    		}
				    		$(this).dialog("close");
							closeOverlay();
						},
						Cancel: function() {
						  $(this).dialog("close");
						}
					}
				});
	    	});
	    	
	    	$('#btn_reject').click(function(){
		    	confirmModal('', 'Do you want to reject all you choose ? ');
				$( "#dialog-confirm" ).dialog({
					modal: true,
					resizable: false,
					height: "auto",
					width: "auto",
					open: function(ev, ui) {
					  openOverlay();
					},
					close: function(ev, ui) {
					  closeOverlay();
					},
					buttons: {
						Ok: function() {
						 	var rows = table.rows({ 'search': 'applied' }).nodes();
				    		var obj = [];
				    		$('input[type="checkbox"]', rows).each(function(i, item){
				    			if($(item).is(':checked')){
				    				var data = table.rows(i).data();
				    				obj.push(data[0]);
				    			}
				    		});
				    		if(obj.length > 0){
					    		sendPostAjax('/Admin/ManageData/RejectAll', obj, function(data){
					    			if(data == 1){
					    				searchSimPending({});
					    				searchSim({}, 'active');
					    			}
					    		});
				    		}
				    		$(this).dialog("close");
							closeOverlay();
						},
						Cancel: function() {
						  $(this).dialog("close");
						}
					}
				});
		    });
	    });
	    
	     function searchSimPending(par) {
			if ($.fn.DataTable.isDataTable('#pendingTbl')) {
				$('#pendingTbl').DataTable().destroy();
			}
			$('#pendingTbl tbody').empty();
			if(Object.keys(par).length == 0){
				var obj = {
						dataSearch: { 
							activeStatus: ('${role}' == '<spring:message code="role.checker" />') ? 'W' : ''
						},
						order: [],
						start: 0
				};
			}else{
				var arrOrder = [];
				arrOrder[0] = {};
				arrOrder[0].column = par.order;
				arrOrder[0].dir = 'asc';
				var obj = {
					dataSearch: { 
						activeStatus: par.activeStatus,
						simNumber: par.simNumber,
						price: par.price,
						creditTerm: par.creditTerm,
						bookingStatus: par.bookingStatus,
						operationFlag: par.operationFlag
					},
					order: arrOrder,
					start: 0
				};
			}
			sendPostAjax('/Admin/ManageData/SearchSimPending', obj, function(data){
				if ($.fn.DataTable.isDataTable('#pendingTbl')) {
					$('#pendingTbl').DataTable().destroy();
				}
				$('#pendingTbl tbody').empty();
				table = $('#pendingTbl').DataTable(
				{
					"searching" : true,
					data: data.data,
					"userRole": '${role}',
					"columns" : [{  
						data:   "activeStatus",
		                render: function ( data, type, row ) {
		                    if ( type === 'display' ) {
		                        return '<input type="checkbox" class="editor-active">';
		                    }
		                    return data;
		                },
		                className: " dt-center"
		            }, {
						"data" : "simNumber"
					}, {
						"data" : "price"
					}/* , {
						"data" : "recievedDate"
					} */, {
						"data" : "creditTerm"
					}, {
						"data" : "operationFlag"
					}, {
						"data" : "activeStatus"
					}, {
						"data" : "activeStatus"
					}, {
						"data" : "activeStatus"
					}, {
						"data" : "activeStatus"
					}], 
					"initComplete" : function(settings, json) {
						var len = settings.aoData.length;
						if(len == 0){
							$('#checkall').hide();
							$('#btn_approve').attr('disabled', 'disabled');
							$('#btn_reject').attr('disabled', 'disabled');
						}else{
							$('#btn_approve').removeAttr('disabled');
							$('#btn_reject').removeAttr('disabled');
							$('#checkall').click(function(){
								var rows = table.rows({ 'search': 'applied' }).nodes();
								$('input[type="checkbox"]', rows).prop('checked', this.checked);
							});	
						}
						if(settings.oFeatures.bFilter){
							$('#selected-search-' + settings.sTableId).change(function(){
								displaySearchGroup(settings.sTableId, this.value, '')
							});
							$('#selected-search-' + settings.sTableId).val(oldKeySearch);
							displaySearchGroup(settings.sTableId, oldKeySearch, oldValueSearch);
						} 
					},
					"drawCallback" : function() {
						$("*[data-toggle=tooltip]").tooltip();
					},
					"columnDefs" : [/* {
			            orderable: false,
			            className: 'select-checkbox',
			            targets:   0
			        }, */ {
						"className" : "dt-right",
						"targets" : [2]
					}, {
						"className" : "dt-center",
						"targets" : [ 0, 1, 3, 4, 5 ]
					}, {
						"visible": false,
						"targets" : [ 6,7 ]
					}, {
						"visible": ('${role}' == '<spring:message code="role.maker" />') ? false : true,
						"targets" : [0,4]
					}, {
						"visible": ('${role}' == '<spring:message code="role.maker" />') ? true : false,
						"targets" : [5]
					}],
					"order" : [],
					"fnRowCallback" : function(nRow, aData, index) {
						var edit = "";
						var del = "";
						var view = "";
						
						var opreation = '';
						if(aData.operationFlag == 'E'){
							opreation = "<span class='label label-warning'>" + '<spring:message code="label.edit" />' + "</span>";
						}else if(aData.operationFlag == 'N'){
							opreation = "<span class='label label-primary'>" + '<spring:message code="label.new" />' + "</span>";
						}else if(aData.operationFlag == 'D'){
							opreation = "<span class='label label-danger'>" + '<spring:message code="label.delete" />' + "</span>";
						}
						
						var activeStatus = '';
						var del = '';
						var edit = '';
						if('${role}' == '<spring:message code="role.maker" />'){
							if(aData.activeStatus == 'N'){
								activeStatus = "<span class='label label-danger'>" + '<spring:message code="label.reject" />' + "</span>";
								del = "<a href=\"javascript:cancelSim('" + aData.simNumber + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Role\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
								edit = "<a href=\"javascript:editSim('" + aData.simNumber + "','" + aData.price + "','" + aData.recievedDate + "','" + aData.creditTerm + "', '" + aData.operationFlag + "', 'P', '" + aData.rejectReason + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Client\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
							}else if(aData.activeStatus == 'W'){
								activeStatus = "<span class='label label-warning'>" + '<spring:message code="label.pending" />' + "</span>";
								del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Role\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Client\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
							}
						}else{
							if('${role}' == '<spring:message code="role.checker" />'){
								if(aData.activeStatus == 'N'){
									activeStatus = "<span class='label label-danger'>" + '<spring:message code="label.reject" />' + "</span>";
									del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject User\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
									edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit User\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								}else if(aData.activeStatus == 'W'){
									activeStatus = "<span class='label label-warning'>" + '<spring:message code="label.pending" />' + "</span>";
									del = "<a href=\"javascript:rejectSim('" + aData.simNumber + "', '" + aData.operationFlag + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Sim\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
									edit = "<a href=\"javascript:approveSim('" + aData.simNumber + "', '" + aData.operationFlag + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Sim\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
								}
							}
						}
						if('${role}' == '<spring:message code="role.checker" />'){
							$('td:eq(1)', nRow).html(parseSimFormat(aData.simNumber));
							$('td:eq(2)', nRow).html(numeral(aData.price).format('0,0.00'));
							/* $('td:eq(3)', nRow).html(convertDateFormat(aData.recievedDate)); */
							$('td:eq(3)', nRow).html(numeral(aData.creditTerm).format('0,0'));
							$('td:eq(4)', nRow).html(opreation);  
							$('td:eq(5)', nRow).html("<center>" + edit + '&nbsp;&nbsp;'+ del + "</center>"); 
						}else if('${role}' == '<spring:message code="role.maker" />'){
							$('td:eq(0)', nRow).html(parseSimFormat(aData.simNumber));
							$('td:eq(1)', nRow).html(numeral(aData.price).format('0,0.00'));
							/* $('td:eq(2)', nRow).html(convertDateFormat(aData.recievedDate)); */
							$('td:eq(2)', nRow).html(numeral(aData.creditTerm).format('0,0'));
							$('td:eq(3)', nRow).html(activeStatus); 
							$('td:eq(4)', nRow).html("<center>" + edit + '&nbsp;&nbsp;'+ del + "</center>"); 
						}
						return nRow;
					}
				});
			});
		}
	     
	    function searchSim(params, type, order) {
			var url = '';
			switch(type){
				case 'pending' : url = '/Admin/ManageData/SearchSimPending'; break;
				case 'active' : url = '/Admin/ManageData/SearchSimActive'; break;
			}
			if ($.fn.DataTable.isDataTable('#' + type + 'Tbl')) {
				$('#' + type + 'Tbl').DataTable().destroy();
			}
			$('#' + type + 'Tbl tbody').empty();
			$('#' + type + 'Tbl').DataTable({
				"searching" : true,
				"processing" : true,
				"serverSide" : true,
				"userRole": '${role}',
				"ajax" : {
					"contentType" : "application/json; charset=utf-8",
					"dataType" : "json",
					"beforeSend" : function(xhr) {
						xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
					},
					"data" : function(d) {
						d.dataSearch = params;
						if(typeof order != 'undefined'){
							if(order != '' && order != null){
								d.order[0] = {
									column: order,
									dir: 'asc'
								};
							}
						} 
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
				}/* , {
					"data" : "recievedDate"
				} */, {
					"data" : "creditTerm"
				}, {
					"data" : "operationFlag"
				}, {
					"data" : "activeStatus"
				}, {
					"data" : "bookingStatus"
				}, {
					"data" : "activateFlag"
				}, {
					"data" : "activeStatus"
				} ],
				"initComplete" : function(settings, json) {
					if(settings.oFeatures.bFilter){
						$('#selected-search-' + settings.sTableId).change(function(){
							displaySearchGroup(settings.sTableId, this.value, '')
						});
						$('#selected-search-' + settings.sTableId).val(oldKeySearch);
						displaySearchGroup(settings.sTableId, oldKeySearch, oldValueSearch);
					} 
				},
				"drawCallback" : function() {
					$("*[data-toggle=tooltip]").tooltip();
				},
				"columnDefs" : [{
					"className" : "dt-right",
					"targets" : [1]
				}, {
					"className" : "dt-center",
					"targets" : [ 0, 2, 3, 4, 5 ]
				}, {
					"visible": false,
					"targets" : (type == 'pending') ? [ 6,7 ] : ('${role}' == '<spring:message code="role.maker" />') ? [3,4,6] : [3,4,6,7]
				}],
				"order" : [],
				"fnRowCallback" : function(nRow, aData, index) {
					var edit = "";
					var del = "";
					var view = "";
					$('td:eq(0)', nRow).html(parseSimFormat(aData.simNumber));
					$('td:eq(1)', nRow).html(numeral(aData.price).format('0,0.00'));
					$('td:eq(2)', nRow).html(numeral(aData.creditTerm).format('0,0'));
					//$('td:eq(2)', nRow).html(convertDateFormat(aData.recievedDate));
					if(type == 'pending'){
						var opreation = '';
						if(aData.operationFlag == 'E'){
							opreation = "<span class='label label-warning'>" + '<spring:message code="label.edit" />' + "</span>";
						}else if(aData.operationFlag == 'N'){
							opreation = "<span class='label label-primary'>" + '<spring:message code="label.new" />' + "</span>";
						}else if(aData.operationFlag == 'D'){
							opreation = "<span class='label label-danger'>" + '<spring:message code="label.delete" />' + "</span>";
						}
						$('td:eq(3)', nRow).html(opreation); 
						var activeStatus = '';
						var del = '';
						var edit = '';
						if('${role}' == '<spring:message code="role.maker" />'){
							if(aData.activeStatus == 'N'){
								activeStatus = "<span class='label label-danger'>" + '<spring:message code="label.reject" />' + "</span>";
								del = "<a href=\"javascript:cancelSim('" + aData.simNumber + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Role\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
								edit = "<a href=\"javascript:editSim('" + aData.simNumber + "','" + aData.price + "','" + aData.recievedDate + "','" + aData.creditTerm + "', '" + aData.operationFlag + "', 'P');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Client\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
							}else if(aData.activeStatus == 'W'){
								activeStatus = "<span class='label label-warning'>" + '<spring:message code="label.pending" />' + "</span>";
								del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Role\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Client\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
							}
						}else{
							if('${role}' == '<spring:message code="role.checker" />'){
								if(aData.activeStatus == 'N'){
									activeStatus = "<span class='label label-danger'>" + '<spring:message code="label.reject" />' + "</span>";
									del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject User\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
									edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit User\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								}else if(aData.activeStatus == 'W'){
									activeStatus = "<span class='label label-warning'>" + '<spring:message code="label.pending" />' + "</span>";
									del = "<a href=\"javascript:rejectSim('" + aData.simNumber + "', '" + aData.operationFlag + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Sim\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
									edit = "<a href=\"javascript:approveSim('" + aData.simNumber + "', '" + aData.operationFlag + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Sim\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
								}
							}
						}
						$('td:eq(4)', nRow).html(activeStatus); 
						$('td:eq(5)', nRow).html("<center>" + edit + '&nbsp;&nbsp;'+ del + "</center>"); 
					}else{
						var bookingStatus = '';
						if('${role}' == '<spring:message code="role.maker" />'){
							if(aData.bookingStatus == '' || aData.bookingStatus == null){
								bookingStatus = "<span class='label label-primary'>" + '<spring:message code="label.available" />' + "</span>";
								del = "<a href=\"javascript:deleteSim('" + aData.simNumber + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Sim\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
								edit = "<a href=\"javascript:editSim('" + aData.simNumber + "','" + aData.price + "','" + aData.recievedDate + "','" + aData.creditTerm + "', '" + aData.operationFlag + "', 'A');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Client\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
							}else if(aData.bookingStatus == 'Y'){
								bookingStatus = "<span class='label label-success'>" + '<spring:message code="label.bookingSuccess" />' + "</span>";
								del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Sim\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Sim\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
							}else if(aData.bookingStatus == 'P'){
								bookingStatus = "<span class='label label-default'>" + '<spring:message code="label.pendingPaid" />' + "</span>";
								del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Sim\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Sim\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
							}else if(aData.bookingStatus == 'W'){
								bookingStatus = "<span class='label label-warning'>" + '<spring:message code="label.bookingProcess" />' + "</span>";
								del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Sim\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Sim\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
							}else if(aData.bookingStatus == 'N'){
								bookingStatus = "<span class='label label-danger'>" + '<spring:message code="label.rejectBooking" />' + "</span>";
								del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Sim\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Sim\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
							}
						}else{
							if('${role}' == '<spring:message code="role.checker" />'){
								if(aData.bookingStatus == '' || aData.bookingStatus == null){
									bookingStatus = "<span class='label label-primary'>" + '<spring:message code="label.available" />' + "</span>";
									del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Sim\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
									edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Sim\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								}else if(aData.bookingStatus == 'Y'){
									bookingStatus = "<span class='label label-success'>" + '<spring:message code="label.bookingSuccess" />' + "</span>";
									del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Sim\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
									edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Sim\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								}else if(aData.bookingStatus == 'P'){
									bookingStatus = "<span class='label label-default'>" + '<spring:message code="label.pendingPaid" />' + "</span>";
									del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Sim\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
									edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Sim\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								}else if(aData.bookingStatus == 'W'){
									bookingStatus = "<span class='label label-warning'>" + '<spring:message code="label.bookingProcess" />' + "</span>";
									del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Sim\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
									edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Sim\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								}else if(aData.bookingStatus == 'N'){
									bookingStatus = "<span class='label label-danger'>" + '<spring:message code="label.rejectBooking" />' + "</span>";
									del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Sim\"><i class=\"fas fa-trash-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
									edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Sim\"><i class=\"fas fa-pencil-alt\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
								}
							}
						}
						$('td:eq(3)', nRow).html("<center>" + bookingStatus + "</center>"); 
						$('td:eq(4)', nRow).html("<center>" + edit + '&nbsp;&nbsp;'+ del + "</center>"); 
					}
					return nRow;
				}
			});
		}
	    
	    function searchManageSim(id){
			var key = $('#selected-search-' + id).val();
			var val = $('#search-box-' + id).val();
			oldKeySearch = key;
			oldValueSearch = val;
			var obj = {
				simNumber : (key.toUpperCase() == 'SIMNUMBER') ? val.replaceAll('-','') : '',
				price : (key.toUpperCase() == 'PRICE') ? val.replaceAll(',','') : '',
				creditTerm : (key.toUpperCase() == 'CREDITTERM') ? val.replaceAll(',','') : '',
				bookingStatus : (key.toUpperCase() == 'BOOKINGSTATUS') ? val : '',
				activeStatus : (key.toUpperCase() == 'AUTHORIZESTATUS') ? val : '',
				operationFlag : (key.toUpperCase() == 'OPERATION') ? val : ''
			};
			var order = '0';
			switch(key.toUpperCase()){
				case 'SIMNUMBER' : order = 0; break;
				case 'PRICE' : order = 1; break;
				case 'CREDITTERM' : order = 2; break;
				case 'AUTHORIZESTATUS' : order = 3; break;
				case 'OPERATION' : order = 4; break;
				case 'BOOKINGSTATUS' : order = 5; break;
			}
			if(id.toUpperCase() == 'ACTIVETBL'){
				searchSim(obj, 'active', order);
			}else{
				obj.order = order;
				searchSimPending(obj);
			}
		}
    
	    function displaySearchGroup(sTableId, key, value){
			var $div = $('#div-box-search-' + sTableId);
			if($div.next().next().hasClass('help-block')){
				$div.next().next().remove();
			}
			if($div.hasClass('has-error')){
				$div.removeClass('has-error').removeClass('has-danger');
			}
			$div.next().removeAttr('disabled');
			oldKeySearch = key;
			switch(key.toUpperCase()){
				case '' :
					var $inputAll = $('<input>').attr('id', 'search-box-' + sTableId).addClass('form-control input-sm').attr('style', 'width:150px;').attr('disabled','disabled');
					$div.html($inputAll);
				break;
				case 'SIMNUMBER' :
					var $str = $('<input>').attr('type','text').attr('id','search-box-' + sTableId).addClass("form-control input-sm").attr('style', 'width:150px;').attr('value',value);
					$div.html($str);
					$($str).mask('000-000-0000');
				break;
				case 'PRICE' :
					var $str = $('<input>').attr('type','text').attr('id','search-box-' + sTableId).addClass("form-control input-sm").attr('style', 'width:150px;').attr('value',value);
					$div.html($str);
	    			$($str).mask("#,##0.00", {reverse: true});
				break;
				case 'CREDITTERM' :
					var $str = $('<input>').attr('type','text').attr('id','search-box-' + sTableId).addClass("form-control input-sm").attr('style', 'width:150px;').attr('value',value);
					$div.html($str);
					$($str).mask("#,##0", {reverse: true});
				break;
				case 'AUTHORIZESTATUS' :
					var $str = $('<select>').attr('id','search-box-' + sTableId).addClass("form-control input-sm");
					$str.append($('<option>').attr('value','W').text('<spring:message code="label.pending" />'));
					$str.append($('<option>').attr('value','N').text('<spring:message code="label.reject" />'));
					$div.html((value == '') ? $str : $str.val(value));
				break;
				case 'OPERATION' :
					var $str = $('<select>').attr('id','search-box-' + sTableId).addClass("form-control input-sm").attr('style', 'width:150px;');
					$str.append($('<option>').attr('value','N').text('<spring:message code="label.new" />'));
					$str.append($('<option>').attr('value','E').text('<spring:message code="label.edit" />'));
					$str.append($('<option>').attr('value','D').text('<spring:message code="label.delete" />'));
					$div.html((value == '') ? $str : $str.val(value));
				break;
				case 'BOOKINGSTATUS' :
					var $str = $('<select>').attr('id','search-box-' + sTableId).addClass("form-control input-sm").attr('style', 'width:150px;');
					$str.append($('<option>').attr('value','').text('<spring:message code="label.available" />'));
					$str.append($('<option>').attr('value','W').text('<spring:message code="label.bookingProcess" />'));
					$str.append($('<option>').attr('value','P').text('<spring:message code="label.pendingPaid" />'));
					$str.append($('<option>').attr('value','Y').text('<spring:message code="label.bookingSuccess" />'));
					$div.html((value == '') ? $str : $str.val(value));
				break;
			}
		}
    
	    function editSim(simNumber, price, recievedDate, creditTerm, operationFlag, type, rejectReason){
	    	$('#modalSim #simNumber').val(parseSimFormat(simNumber)).mask('000-000-0000');
	    	$('#modalSim #price').val(numeral(price).format('0,0.00')).mask("#,##0.00", {reverse: true});
	    	/* $("#modalSim #recievedDate").datepicker({
	    		format: 'dd/mm/yyyy'
	    	}); */
	    	//$("#modalSim #recievedDate").datepicker( "setDate" , convertDateFormat(recievedDate));
	    	/* */console.log(typeof rejectReason);
	    	if(typeof rejectReason != 'undefined'){
	    		$('#show-reject').html('<strong>เหตุผลในการยกเลิก : ' + rejectReason + '</strong>').show(); 
	    	}else{
	    		$('#show-reject').html('').hide();
	    	}
	    	$('#modalSim #operationFlag').val(operationFlag);
	    	$('#modalSim #type').val(type);
	    	$('#modalSim #creditTerm').val(creditTerm).mask("#,##0", {reverse: true});
	    	$('#modalSim').modal('show');
	    }
	    
	    function rejectSim(simNumber, operationFlag){
			var str = '<div id="dialog-confirm" title="Alert" style="display:none;">';
			str += '<p><span class="ui-icon ui-icon-alert" style="float:left; margin:2px 12px 11px 0;"></span>Do you want to reject Mobile No. ' + parseSimFormat(simNumber) + '</p>';
			str += '<div class="form-group">';
			str += '<label for="rejectReason">Reject Reason</label>';
			str += '<textarea id="rejectReason" style="width:100%;height:100px;" maxlength="255"></textarea>';
			str += '<div class="help-block with-errors"></div>';
			str += '</div>';
			str += '</div>';
			$('body').find('#dialog-confirm').remove();
			$('body').append(str);
			$("#dialog-confirm" ).dialog({
				modal: true,
				resizable: false,
				height: "auto",
				width: "auto",
				open: function(ev, ui) {
				  openOverlay();
				},
				close: function(ev, ui) {
				  closeOverlay();
				},
				buttons: {
					Ok: function() {
						  var rejectReason = $('#rejectReason').val();
						  if(rejectReason.trim() == ''){
							 $('#rejectReason').parent().addClass('has-error has-danger');
							 $('#rejectReason').next().html('<ul class="list-unstyled"><li>กรุณากรอก Reject Reason</li></ul>');
						  }else{
							 $('#rejectReason').parent().removeClass('has-error has-danger');
							 $('#rejectReason').next().html('');
							 var params = { 
									rejectReason: rejectReason,
									simNumber: simNumber,
									operationFlag: operationFlag
								};
							 var url = '/Admin/ManageData/RejectSim';							
							 sendPostAjax(url, params, function(data){
								if(data == 1){
									$( "#dialog-confirm" ).dialog('close');
									searchSimPending({});
									searchSim({}, 'active');	
								}
							  });
						  }
					},
					Cancel: function() {
					  $(this).dialog("close");
					}
				}
			});
		}
		
		function approveSim(simNumber, operationFlag){
			confirmModal('', 'Do you want to approve Mobile No. ' + parseSimFormat(simNumber));
			$( "#dialog-confirm" ).dialog({
				modal: true,
				resizable: false,
				height: "auto",
				width: "auto",
				open: function(ev, ui) {
				  openOverlay();
				},
				close: function(ev, ui) {
				  closeOverlay();
				},
				buttons: {
					Ok: function() {
					  sendGetAjax('/Admin/ManageData/ApproveSim/' + simNumber + '/' + operationFlag , function(data){
						if(data == 1){
							$( "#dialog-confirm" ).dialog('close');
							searchSimPending({});
							searchSim({}, 'active');
						}
					  });
					},
					Cancel: function() {
					  $(this).dialog("close");
					}
				}
			});
		}
		
		function cancelSim(simNumber){
			confirmModal('', 'Do you want to Cancel operation Mobile No. ' + simNumber);
			$( "#dialog-confirm" ).dialog({
				modal: true,
				resizable: false,
				height: "auto",
				width: "auto",
				open: function(ev, ui) {
				  openOverlay();
				},
				close: function(ev, ui) {
				  closeOverlay();
				},
				buttons: {
					Ok: function() {
					  sendGetAjax('/Admin/ManageData/CancelSim/' + simNumber , function(data){
						if(data == 1){
							$( "#dialog-confirm" ).dialog('close');
							searchSimPending({});
						}
					  });
					},
					Cancel: function() {
					  $(this).dialog("close");
					}
				}
			});
		}
		
		function deleteSim(simNumber){
			confirmModal('', 'Do you want to Delete Mobile No. ' + simNumber);
			$( "#dialog-confirm" ).dialog({
				modal: true,
				resizable: false,
				height: "auto",
				width: "auto",
				open: function(ev, ui) {
				  openOverlay();
				},
				close: function(ev, ui) {
				  closeOverlay();
				},
				buttons: {
					Ok: function() {
					  sendGetAjax('/Admin/ManageData/DeleteSim/' + simNumber , function(data){
						if(data == 1){
							$( "#dialog-confirm" ).dialog('close');
							searchSimPending({});
							searchSim({}, 'active');
						}
					  });
					},
					Cancel: function() {
					  $(this).dialog("close");
					}
				}
			});
		}
	    </script>
	</jsp:body>
</t:master>