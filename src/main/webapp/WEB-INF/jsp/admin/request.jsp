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
									   <th class="text-center">เบอร์โทรศัพท์</th>
									   <th class="text-center">ผลรวมเบอร์</th>
									   <th class="text-center">ราคา</th>
									   <th class="text-center">Credit Term</th>
									   <th class="text-center">รหัสลูกค้า</th>
						                <th class="text-center">Request Status</th>
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
		          <div class="container-fluid">
						<div class="row">
							<div class="col-sm-12 form-group">
								<div class="col-sm-3">
									<label><b>เบอร์โทรศัพท์</b></label>
								</div>
								<div class="col-sm-5">
									<input type="text" id="mobileNo" class="form-control" disabled/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 form-group">
								<div class="col-sm-3">
									<label><b>ราคา</b></label>
								</div>
								<div class="col-sm-5">
									<input type="text" id="price" class="form-control" /> 
									<div class="help-block with-errors"></div>
								</div>
								<div class="col-sm-1">บาท</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 form-group">
								<div class="col-sm-3">
									<label><b>Credit Term</b></label>
								</div>
								<div class="col-sm-5">
									<input type="text" id="creditTerm" class="form-control" />
									<div class="help-block with-errors"></div>
								</div>
								<div class="col-sm-1"> วัน</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 form-group">
								<div class="col-sm-3"></div>
								<div class="col-sm-5">
									 <div class="cont_btn">
								     	<button class="btn btn-primary" id="save-btn">Save</button>
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
					{ "data": "simNumber" },
					{ "data": "sumNumber" },
					{ "data": "price" },
					{ "data": "creditTerm" },
					{ "data": "merchantId" },
					{ "data": "requestStatus" },
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
		    		/* var bookingStatus = "";
					var upload = '';
					var del = '';
		    		var edit = '';
					if(aData.bookingStatus == 'N'){
						bookingStatus = "<span class='label label-danger'>" + '<spring:message code="label.rejectBooking" />' + "</span>";
						upload = "<a href=\"javascript:openUpload('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Upload Slip\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
						del = "<a href=\"javascript:rejectBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Booking\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
						edit = "<a href=\"javascript:viewBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"View Booking\"><i class=\"far fa-file-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
					}else if(aData.bookingStatus == 'W'){
						bookingStatus = "<span class='label label-warning'>" + '<spring:message code="label.wait" />' + "</span>";
						upload = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Upload Slip\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
						del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Cancel Booking\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
						edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"View Booking\"><i class=\"far fa-file-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";
					}else if(aData.bookingStatus == 'Y'){
						del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Cancel Booking\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
						upload = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Upload Slip\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
						bookingStatus = "<span class='label label-success'>" + '<spring:message code="label.approveBooking" />' + "</span>";
						edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"View Booking\"><i class=\"far fa-file-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
					}else if(aData.bookingStatus == 'P'){
						bookingStatus = "<span class='label label-default'>" + '<spring:message code="label.pendingPaid" />' + "</span>";
						upload = "<a href=\"javascript:openUpload('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Upload Slip\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
						del = "<a href=\"javascript:rejectBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Cancel Booking\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
						edit = "<a href=\"javascript:viewBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"View Booking\"><i class=\"far fa-file-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
					}
					var url = '<c:url value="/" />';
		    		$('td:eq(2)', nRow).html("<center>" + bookingStatus + "<center>");
					$('td:eq(3)', nRow).html(numeral(aData.sumPrice).format('0,0.00'));
					if(aData.slip == '' || aData.slip == null){
						$('td:eq(4)', nRow).html('<center>-</center>');
					}else{
						$('td:eq(4)', nRow).html('<center><a href="' + url + 'MyBooking/OpenSlip/' + aData.bookingId + '" target="_blank"><i class="far fa-credit-card" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a></center>');
					}
					$('td:eq(5)', nRow).html("<center>" + upload + '&nbsp;&nbsp;'+ edit + '&nbsp;&nbsp;' + del + "</center>");  */
					var requestStatus = '';
					var reject = '';
					var approve = '';
					var creditTerm = '<center>-</center>';
					var price = '<center>-</center>';
					if(aData.requestStatus == 'W'){
						requestStatus = "<span class='label label-warning'>" + '<spring:message code="label.waitRequest" />' + "</span>";
						reject = "<a href=\"javascript:rejectRequest('" + aData.simNumber + "', '" + aData.requestStatus + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Request\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
						approve = "<a href=\"javascript:approveRequest('" + aData.simNumber + "', '" + aData.requestStatus + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Request\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
					}else if(aData.requestStatus == 'C'){
						creditTerm = '<span style="float:right">' + aData.creditTerm + '</span>';
						price = '<span style="float:right">' + numeral(aData.price).format('0,0.00') + '</span>';
						requestStatus = "<span class='label label-danger'>" + '<spring:message code="label.cancelRequest" />' + "</span>";
						reject = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Request\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
						approve = "<a href=\"javascript:approveRequest('" + aData.simNumber + "', '" + aData.requestStatus + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Request\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
					}else if(aData.requestStatus == 'Y'){
						creditTerm = '<span style="float:right">' + aData.creditTerm + '</span>';
						price = '<span style="float:right">' + numeral(aData.price).format('0,0.00') + '</span>';
						requestStatus = "<span class='label label-success'>" + '<spring:message code="label.approveRequest" />' + "</span>";
						reject = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Request\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
						approve = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Request\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
					}
					$('td:eq(0)', nRow).html(parseSimFormat(aData.simNumber));
					$('td:eq(2)', nRow).html(price);
					$('td:eq(3)', nRow).html(creditTerm);
					$('td:eq(5)', nRow).html("<center>" + requestStatus + "<center>");
					$('td:eq(6)', nRow).html("<center>" + approve + '&nbsp;&nbsp;' + reject + "</center>"); 
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
		
		function approveRequest(simNumber, status){
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
				$('#detail #mobileNo').val(parseSimFormat(simNumber));
				$('#detail #price').val('').mask("#,##0.00", {reverse: true});
				$('#detail #creditTerm').val('').mask("#,##0", {reverse: true});
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
		 });
		</script>
	</jsp:body>
</t:master>