<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="https://vipsim.co/jsp/tlds/customTags" prefix="custom"%>
<spring:message code="role.checker" var="checker"/>
<spring:message code="role.viewer" var="viewer"/>
<spring:message code="role.maker" var="maker"/>
<t:master>
	<jsp:body>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
	      		<h4><b><i class="fas fa-registered" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> จัดการคำขอเบอร์ที่ไม่มีในระบบ</b></h4>
	    	</div>
	    </div>
		<div class="panel-round-bd">
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
	              <div class="x_panel tile overflow_hidden">
					    <div class="row">
							<div class="col-xs-12">
								<div class="box-body">
								  <table id="bookingTbl" class="table table-bordered table-striped" style="width:100%">
									<thead>
									<tr>
									   <th class="text-center" style="width:5%;"></th>
									   <th class="text-center">Request No.</th>
									   <th class="text-center">เงื่อนไขการ Request</th>
									   <th class="text-center">วันที่ทำการ Request</th>
									   <th class="text-center">Request Status</th>
									   <th class="text-center">รหัสลูกค้า</th>
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
		<div class="modal fade" id="detail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		       <div class="modal-header">
		         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		         	รายละเอียด
		       </div>
		       <input type="hidden" id="mode">
		       <div class="modal-body">
					<div class="row">
			             <div class="col-md-12 col-sm-12 col-xs-12">
			               	<div class="form-group">
			                		<label class="radio-inline">
								  <input type="radio" name="type_input" value="1" checked="checked"> <b>เพิ่มเบอร์โดยการอัพโหลดไฟล์</b>
								</label>
								<label class="radio-inline">
								  <input type="radio" name="type_input" value="2"> <b>เพิ่มเบอร์โดยการกรอกข้อมูล</b>
								</label>
							</div>
							<div id="type_input_1">
								 <form method="POST" id="uploadForm" enctype="multipart/form-data" action="<c:url value="/Admin/ManageRequest/UploadExcelFile"/>">
									  <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
									 <input type="hidden" name="requestMstId" id="requestMstId" value=""/>
									 <div class="row">
										<div class="col-md-8 col-sm-8 col-xs-12">
											<div class="form-group">
											    <label for="exampleInputEmail1">อัพโหลดไฟล์</label>
											    <input type="file" class="form-control" id="file" name="file" accept=".xls,.xlsx"> 
											    
											 </div>				
										</div>
									</div>
									<div class="row">
										<div class="col-md-8 col-sm-8 col-xs-12">
											<label><a href="<c:url value="/Admin/ManageRequest/OpenExample"/>">ตัวอย่างไฟล์</a></label>
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
									<div class="col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
										    <label for="exampleInputEmail1">Mobile No.</label>
										    <input type="text" class="form-control" id="mobile">
										  </div>
									</div>
									<div class="col-md-3 col-sm-3 col-xs-12">
										<div class="form-group">
										    <label for="exampleInputEmail1">Price</label>
										    <div class="input-group">
										      <input type="text" class="form-control" id="price">
										      <div class="input-group-addon">บาท</div>
										    </div>
										  </div>
									</div>
									<div class="col-md-3 col-sm-3 col-xs-12">
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
		       </div>
		    </div>
		   </div>
		 </div>
		<script type="text/javascript">

		var table = null;
		searchMenu = 'REQUESTSIMADMIN';
		var oldValueSearch = '';
		var oldKeySearch = '';
		  
		function format ( d ) {console.log(d);
			 var str = '';
			if(d.requestStatus == 'R'){
				str += '<div class="row">';
				str += '<div class="col-md-3">';
				str += '<div class="panel panel-danger">';
				str += '<div class="panel-heading">';
   	     		str += '<div class="panel-title" style="font-size:12px;">Reject Reason</div>';
      			str += '</div>';
      			str += '<div class="panel-body">' + d.rejectReason + '</div></div>';
				str += '</div>';
			}
			str += '<div class="col-md-10" style="float:right;">';
			str += '<table class="table table-bordered table-striped">';
			str += '<thead><tr>';
			str += '<th style=\"text-align:center;\">Mobile No.</th>';
			str += '<th style=\"text-align:center;\">Price</th>';
			str += '<th style=\"text-align:center;\">Credit Term</th>';
			str += '<th style=\"text-align:center;\">ผลรวมเบอร์</th>';
			str += '<th style=\"text-align:center;\">Status</th>';
			str += '</tr></thead><tbody>';
			for(var x in d.requestSim){
				str += '<tr>';
		        str += '<td style=\"text-align:center;\">' + parseSimFormat(d.requestSim[x].simNumber) + '</td>';
		        str += '<td style=\"text-align:right;\">' + numeral(d.requestSim[x].price).format('0,0.00') + '</td>';
		        str += '<td style=\"text-align:center;\">' + d.requestSim[x].creditTerm + '</td>';
		        str += '<td style=\"text-align:center;\">' + d.requestSim[x].sumNumber + '</td>';
		        str += '<td style=\"text-align:center;\">' + d.requestSim[x].requestStatus + '</td>';
		        str += '</tr>';
			}
			
			str += '</tbody></table></div></div>'; 	 
		    return str;
		}
		
		function loadTable(params){
			if ($.fn.DataTable.isDataTable('#bookingTbl')) {
				$('#bookingTbl').DataTable().destroy();
			}
			$('#bookingTbl tbody').empty();
			table = $('#bookingTbl').DataTable( {
				"searching": true,
				"processing": true,
				"serverSide": true,
				"ajax": {
					"contentType": "application/json; charset=utf-8",
					"dataType": "json",
					"beforeSend": function (xhr) {
						xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
						$.LoadingOverlay("show");
					},
					"data": function ( d ) {
						var exceptStatus = [];
						exceptStatus[0] = 'A';
						params.requestSim = new Array();
						params.requestSim[0] = {};
						params.requestSim[0].exceptStatus = exceptStatus;
						d.dataSearch = params;
						if(typeof order != 'undefined'){
							if(order != '' && order != null){
								d.order[0].column = order;
								d.order[0].dir = 'asc';
							}
						}
					},
					"url": GetSiteRoot() + '/Admin/ManageRequest/SearchRequestSim',
					"type": "POST",
					"error" : function(jqXHR, textStatus, errorThrown){
						displayErrorAjax(jqXHR, textStatus, errorThrown);
					} 
				},  
				"columns": [
					{
		                "className":      'details-control',
		                "orderable":      false,
		                "data":           null,
		                "defaultContent": ''
		            },
					{ "data": "requestId" },
					{ "data": "requestTypeStr" },
					{ "data": "requestDate" },
					{ "data": "requestStatus" },
					{ "data": "merchantId" },
					{ "data": null }
				],
		        "columnDefs" : [{
					"className" : "dt-center",
					"targets" : [0,1]
				}],
		        "order": [[0, 'asc']],
		        "drawCallback": function(settings) {
					$.LoadingOverlay("hide");
					$("*[data-toggle=tooltip]").tooltip();
				},
		    	"fnRowCallback" : function(nRow, aData, index) {
					var requestStatus = '';
					var reject = '';
					var approve = '';
					if(aData.requestStatus == 'W'){
						requestStatus = "<span class='label label-warning'>" + '<spring:message code="label.waitRequest" />' + "</span>";
						reject = "<a href=\"javascript:rejectRequest('" + aData.simNumber + "', '" + aData.requestStatus + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Request\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
						approve = "<a href=\"javascript:approveRequest('" + aData.requestId + "', '" + aData.requestStatus + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Request\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
					}else if(aData.requestStatus == 'C'){
						requestStatus = "<span class='label label-danger'>" + '<spring:message code="label.cancelRequest" />' + "</span>";
						reject = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Request\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
						approve = "<a href=\"javascript:approveRequest('" + aData.requestId + "', '" + aData.requestStatus + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Request\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
					}else if(aData.requestStatus == 'Y'){
						requestStatus = "<span class='label label-success'>" + '<spring:message code="label.approveRequest" />' + "</span>";
						reject = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Request\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
						approve = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Request\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
					}
					$('td:eq(2)', nRow).html(aData.requestTypeStr + ' - ' + aData.requestValue);
					$('td:eq(3)', nRow).html("<center>" + convertDateFormat(aData.requestDate) + "</center>");
					$('td:eq(4)', nRow).html("<center>" + requestStatus + "<center>");
					$('td:eq(6)', nRow).html("<center>" + approve + '&nbsp;&nbsp;' + reject + "</center>"); 
					if(aData.requestSim.length == 0){
						$('td:eq(0)', nRow).removeClass('details-control sorting_1');
					}
					return nRow;
		    	},"initComplete": function(settings, json) {
					if(settings.oFeatures.bFilter){
						$('#selected-search-' + settings.sTableId).change(function(){
							displaySearchGroup(settings.sTableId, this.value, '')
						});
						$('#selected-search-' + settings.sTableId).val(oldKeySearch);
						displaySearchGroup(settings.sTableId, oldKeySearch, oldValueSearch);
					}
		    	},
		    });
			
			$('#bookingTbl tbody').unbind('click');
			$('#bookingTbl tbody').on('click', 'td.details-control', function () {
		        var tr = $(this).closest('tr');
		        var row = table.row( tr );
		        if ( row.child.isShown() ) {
		            // This row is already open - close it
		            row.child.hide();
		            tr.removeClass('shown');
		        }
		        else {
		            // Open this row
		            row.child( format(row.data()) ).show();
		            tr.addClass('shown');
		        }
		        $("*[data-toggle=tooltip]").tooltip();
		     }); 
		}
		
		function searchRequestSim(){
			var key = $('#selected-search-bookingTbl').val();
			var val = $('#search-box-bookingTbl').val();
			oldKeySearch = key;
			oldValueSearch = val;
			var obj = {
				simNumber : (key.toUpperCase() == 'SIMNUMBER') ? val.replaceAll('-','') : '',
				requestStatus : (key.toUpperCase() == 'REQUESTSTATUS') ? val : ''
			};
			var order = '0';
			switch(key.toUpperCase()){
				case 'SIMNUMBER' : order = 0; break;
				case 'REQUESTSTATUS' : order = 2; break;
			}
			loadTable(obj);
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
					var $inputAll = $('<input>').attr('id', 'search-box-' + sTableId).addClass('form-control input-sm').attr('style', 'width:150px;').removeAttr('disabled');
					$div.html($inputAll);
					$($inputAll).mask('000-000-0000');
				break;
				case 'REQUESTSTATUS' :
					var $str = $('<select>').attr('id','search-box-' + sTableId).addClass("form-control input-sm");
					$str.append($('<option>').attr('value','W').text('<spring:message code="label.wait" />'));
					$str.append($('<option>').attr('value','N').text('<spring:message code="label.reject" />'));
					$div.html((value == '') ? $str : $str.val(value));
				break;
				case 'MERCHANTID' :
					var $inputAll = $('<input>').attr('id', 'search-box-' + sTableId).addClass('form-control input-sm').attr('style', 'width:150px;').removeAttr('disabled');
					$div.html($inputAll);
				break;
			}
		}
	
		function rejectRequest(simNumber){
			confirmModal('', 'ยืนยันการยกเลิกการจองเบอร์ ' + parseSimFormat(simNumber));
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
					  var obj = {
						 simNumber: simNumber,
						 requestStatus: 'C'
					  };
					  sendPostAjax('/Admin/ManageRequest/ApproveRequestSim', obj, function(data){
						if(data == 1){
							$("#dialog-confirm" ).dialog('close');
							loadTable({});
						}
					  });
					},
					Cancel: function() {
					  $(this).dialog("close");
					}
				}
			});
		}
		
		function approveRequest(requestId, status){
			if(status == 'C'){
				confirmModal('', 'ยืนยันการยกเลิกการจองเบอร์ ' + parseSimFormat(simNumber));
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
						  var obj = {
							 simNumber: simNumber,
							 requestStatus: status
						  };
						  sendPostAjax('/Admin/ManageRequest/ApproveRequestSim', obj, function(data){
							if(data == 1){
								$("#dialog-confirm" ).dialog('close');
								loadTable({});
							}
						  });
						},
						Cancel: function() {
						  $(this).dialog("close");
						}
					}
				});
			}else if(status == 'W'){
				$('#detail #mobileNo').val('');
				$('#detail #price').val('').mask("#,##0.00", {reverse: true});
				$('#detail #creditTerm').val('').mask("#,##0", {reverse: true});
				$('#uploadForm #requestMstId').val(requestId);
				$('#detail #save-btn').click(function(){
					errMsg.sim = {
						price: { id: $('#detail #price'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
						creditTerm: { id: $('#detail #creditTerm'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
					};
					if(checkValidate('sim')){
						var obj = {
							 simNumber: simNumber,
							 requestStatus: status,
							 price: $('#detail #price').val().replaceAll(',',''),
							 creditTerm: $('#detail #creditTerm').val().replaceAll(',',''),
						};
						sendPostAjax('/Admin/ManageRequest/ApproveRequestSim', obj, function(data){
							if(data == 1){
								$("#detail" ).modal('hide');
								loadTable({});
							 }
						 });
					}
				});
				$('#detail').modal('show');
			}
		}
		
		$(document).ready(function() {
		    loadTable({});
		    $('#type_input_2 #mobile').mask('000-000-0000');
	    	$('#type_input_2 #price').mask("#,##0.00", {reverse: true});
	    	$("#type_input_2 #recievedDate").datepicker({
	    		format: 'dd/mm/yyyy'
	    	});
	    	$('#type_input_2 #creditTerm').mask("#,##0", {reverse: true});
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
					},
			        success: function(data, textStatus, jqXHR)
			        {
			        	$.LoadingOverlay("hide");
			        	$('#detail').modal('hide');
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
			            	loadTable({});
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
		 });
		</script>
	</jsp:body>
</t:master>