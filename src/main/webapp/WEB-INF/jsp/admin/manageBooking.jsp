<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="https://vipsim.co/jsp/tlds/customTags" prefix="custom"%>
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
			<c:choose>
         		<c:when test="${user eq null}">
         			<h4><i class="far fa-file" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> <b>จัดการการจองเบอร์โทร</b></h4>
				</c:when>
	      		<c:otherwise>
	      			<h4><i class="far fa-file" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> <b>${user.prefixName}${user.firstName} ${user.lastName}</b></h4>
	      		</c:otherwise>
	      	</c:choose>
	    	</div>
	    </div>
	    <div class="panel-round-bd">
			<div class="row">
				<div class="col-md-4 col-sm-4 col-xs-12">
				   <div class="form-group">
				    <label for="bookingNo">Booking No.</label>
				    <input type="text" class="form-control" id="bookingNo">
				  </div>
				</div>
				<div class="col-md-4 col-sm-4 col-xs-12">
				   <div class="form-group">
					    <label for="bookingNo">Mobile No.</label>
					    <input type="text" class="form-control" id="mobileNo">
					  </div>
				 </div>
				 <div class="col-md-3 col-sm-3 col-xs-3">
				    <button type="button" class="btn btn-warning" id="search-btn">Search</button>
				 </div>
			</div>
		</div>
		<br/>
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
									   <th class="text-center">Booking No.</th>
						                <th class="text-center">Booking Status</th>
						                <th class="text-center">Price (บาท)</th>
						                <th class="text-center">Slip</th>
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
		<script type="text/javascript">
		function format ( d ) {
			var str = '';
			if(d.bookingStatus == 'N'){
				str += '<div class="row">';
				str += '<div class="col-md-3">';
				str += '<div class="panel panel-danger">';
				str += '<div class="panel-heading">';
   	     		str += '<div class="panel-title" style="font-size:12px;">Reject Reason</div>';
      			str += '</div>';
      			str += '<div class="panel-body">' + d.rejectReason + '</div></div>';
				str += '</div>';
			}
			str += '<div class="col-md-9" style="float:right;">';
			str += '<table class="table table-bordered table-striped">';
			str += '<thead><tr>';
			str += '<th style=\"text-align:center;\">Booking Detail No.</th>';
			str += '<th style=\"text-align:center;\">Mobile No.</th>';
			str += '<th style=\"text-align:center;\">Price (บาท)</th>';
			str += '<th style=\"text-align:center;\">Activate Status</th>';
			str += '<th style=\"text-align:center;\">ID Card</th>';
			str += '<th style=\"text-align:center;\">Action</th>';
			str += '</tr></thead><tbody>';
			for(var x in d.bookingDetails){
				var customerId = '';console.log(d.bookingDetails[x].activateFlag + ' ' + d.bookingDetails[x].customerId);
				var reject = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Booking\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
				var approve = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Booking\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
				var activateFlag = "<i class='fa fa-minus-circle red'></i>&nbsp;&nbsp;" + '<spring:message code="label.noActivate" />';
				if(d.bookingDetails[x].activateFlag == 'Y'){
					activateFlag = "<i class='fa fa-check-circle green'></i>&nbsp;&nbsp;" + '<spring:message code="label.activate" />';
				}else if(d.bookingDetails[x].activateFlag == 'W'){
					activateFlag = "<i class='glyphicon glyphicon-time' style='color:tomato;'></i>&nbsp;&nbsp;" + '<spring:message code="label.wait" />';
					reject = "<a href=\"javascript:rejectIDCard('" + d.bookingDetails[x].bookingDetailId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject ID Card\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
					approve = "<a href=\"javascript:approveIDCard('" + d.bookingDetails[x].bookingDetailId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve ID Card\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
				}else if(d.bookingDetails[x].activateFlag == 'N' && d.bookingDetails[x].customerId != '' && d.bookingDetails[x].customerId != null){
					activateFlag = "<span class='label label-danger'>" + '<spring:message code="label.reject" />' + "</span>";
				}
				str += '<tr>';
		        str += '<td style=\"text-align:center;\">' + d.bookingDetails[x].bookingDetailId + '</td>';
		        str += '<td style=\"text-align:center;\">' + parseSimFormat(d.bookingDetails[x].simNumber) + '</td>';
		        str += '<td style=\"text-align:right;\">' + numeral(d.bookingDetails[x].price).format('0,0.00') + '</td>';
		        str += '<td style=\"text-align:center;\">' + activateFlag + '</td>';
		        if(d.bookingDetails[x].customerId == '' || d.bookingDetails[x].customerId == null){
					str += '<td style=\"text-align:center;\">-</td>';
				}else{
					var url = '<c:url value="/" />';
					str += '<td style=\"text-align:center;\"><a href="' + url + 'ManageBooking/OpenIDCard/' + d.bookingDetails[x].bookingDetailId + '" target="_blank"><i class="far fa-address-card" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a></td>';
				}
		        		
		        str += '<td style=\"text-align:center;\">' + approve + '&nbsp;&nbsp;' + reject + '</td>';
		        str += '</tr>';
			}
			str += '</tbody></table></div></div>';
		    return str;
		}

		var table = null;
		function loadTable(data){
			if ($.fn.DataTable.isDataTable('#bookingTbl')) {
				$('#bookingTbl').DataTable().destroy();
			}
			$('#bookingTbl tbody').empty();
			table = $('#bookingTbl').DataTable( {
				"searching": false,
		        "data": data,
		        "columns": [
		            {
		                "className":      'details-control',
		                "orderable":      false,
		                "data":           null,
		                "defaultContent": ''
		            },
		            { "data": "bookingId" },
		            { "data": "bookingStatus" },
		            { "data": "sumPrice" },
		            { "data": "sumPrice" },
		            { "data": "sumPrice" }
		        ],
		        "columnDefs" : [{
					"className" : "dt-center",
					"targets" : [1]
				},{
					"className" : "dt-right",
					"targets" : [3]
				}],
				"drawCallback": function(settings) {
					$("*[data-toggle=tooltip]").tooltip();
				},
		        //"order": [[1, 'asc']]
		    	"fnRowCallback" : function(nRow, aData, index) {
		    		var bookingStatus = "";
		    		var edit = '';
					var del = '';
					if(aData.bookingStatus == 'N'){
						bookingStatus = "<span class='label label-danger'>" + '<spring:message code="label.rejectBooking" />' + "</span>";
					}else if(aData.bookingStatus == 'W'){
						bookingStatus = "<span class='label label-warning'>" + '<spring:message code="label.wait" />' + "</span>";
					}else if(aData.bookingStatus == 'Y'){
						bookingStatus = "<span class='label label-success'>" + '<spring:message code="label.approveBooking" />' + "</span>";
					}else if(aData.bookingStatus == 'P'){
						bookingStatus = "<span class='label label-default'>" + '<spring:message code="label.pendingPaid" />' + "</span>";
					}
					if('${role}' == '<spring:message code="role.checker" />'){
						if(aData.bookingStatus == 'N' || aData.bookingStatus == 'Y' || aData.bookingStatus == 'P'){
							del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Booking\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
							edit = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Booking\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
						}else if(aData.bookingStatus == 'W'){
							del = "<a href=\"javascript:rejectBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Booking\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
							edit = "<a href=\"javascript:approveBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Booking\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
						}
					}
					var url = '<c:url value="/" />';
					if(aData.slip == '' || aData.slip == null){
						$('td:eq(4)', nRow).html('<center>-</center>');
					}else{
						$('td:eq(4)', nRow).html('<center><a href="' + url + 'Admin/ManageBooking/OpenSlip/' + aData.bookingId + '/' + aData.merchantId + '" target="_blank"><i class="far fa-credit-card" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a></center>');
					}
					var viewBooking = "<a href=\"javascript:viewBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"View Booking\"><i class=\"far fa-file-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
					$('td:eq(5)', nRow).html("<center>" + edit + '&nbsp;&nbsp;'+ del + '&nbsp;&nbsp;' + viewBooking + "</center>"); 
					$('td:eq(2)', nRow).html("<center>" + bookingStatus + "<center>");
					$('td:eq(3)', nRow).html(numeral(aData.sumPrice).format('0,0.00'));
		    		return nRow;
		    	}
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
		$(document).ready(function() {
		    var data = ('${data}' == 'null' || '${data}' == '') ? null : JSON.parse('${data}'); 
			loadTable(data);
			 $('#search-btn').click(function(){
		    	var obj = {
		    		bookingId: $('#bookingNo').val(),
		    		mobileNo: $('#mobileNo').val().replaceAll('-',''),
		    		merchantId: '${user.userId}'
		    	};
		    	sendPostAjax('/Admin/ManageBooking/SearchBooking', obj, function(data){
					loadTable(data);
				});
		    });
		    
		    $('#mobileNo').mask('000-000-0000');
		    $('#bookingNo').mask('0000000000');
		});
		
		function viewBooking(bookingId){
			let form = $('<form/>').attr('action', GetSiteRoot() + '/Admin/ManageBooking/ViewBooking').attr('method', 'post').attr("target", "_blank");
			form.append($('<input/>').attr('name', 'bookingId').attr('type', 'hidden').attr('value', bookingId));
			form.append($('<input/>').attr('name', '${_csrf.parameterName}').attr('type', 'hidden').attr('value', '${_csrf.token}'));
			$('body').append(form);
			form.submit();	
		}
		
		function rejectIDCard(bookingDetailId){
			var str = '<div id="dialog-confirm" title="Alert" style="display:none;">';
			str += '<p><span class="ui-icon ui-icon-alert" style="float:left; margin:2px 12px 11px 0;"></span>Do you want to reject </p>';
			str += '<div class="form-group">';
			str += '<label for="rejectReason">Reject Reason</label>';
			str += '<textarea id="rejectReason2" style="width:100%;height:100px;" maxlength="255"></textarea>';
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
						  var rejectReason = $('#rejectReason2').val();
						  if(rejectReason.trim() == ''){
							 $('#rejectReason2').parent().addClass('has-error has-danger');
							 $('#rejectReason2').next().html('<ul class="list-unstyled"><li>กรุณากรอก Reject Reason</li></ul>');
						  }else{
							 $('#rejectReason2').parent().removeClass('has-error has-danger');
							 $('#rejectReason2').next().html('');
							 var params = { 
									rejectReason: rejectReason,
									bookingDetailId: bookingDetailId
								};
							 var url = '/Admin/ManageBooking/RejectIdCard';							
							 sendPostAjax(url, params, function(data){
								if(data != null){
									$( "#dialog-confirm" ).dialog('close');
									loadTable(data);	
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
		
		function approveIDCard(bookingDetailId){
			confirmModal('', 'Do you want to approve ');
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
					  sendPostAjax('/Admin/ManageBooking/ApproveIdCard', { bookingDetailId: bookingDetailId }, function(data){
						if(data != null){
							$( "#dialog-confirm" ).dialog('close');
							loadTable(data);
						}
					  });
					},
					Cancel: function() {
					  $(this).dialog("close");
					}
				}
			});
		}
		
		function rejectBooking(bookingId){
			var str = '<div id="dialog-confirm" title="Alert" style="display:none;">';
			str += '<p><span class="ui-icon ui-icon-alert" style="float:left; margin:2px 12px 11px 0;"></span>Do you want to reject Booking No. ' + bookingId + '</p>';
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
									bookingId: bookingId
								};
							 var url = '/Admin/ManageBooking/RejectBooking';							
							 sendPostAjax(url, params, function(data){
								if(data != null){
									$( "#dialog-confirm" ).dialog('close');
									loadTable(data);	
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
		
		function approveBooking(bookingId){
			confirmModal('', 'Do you want to approve Booking No. ' + bookingId);
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
					  sendGetAjax('/Admin/ManageBooking/ApproveBooking/' + bookingId, function(data){
						if(data != null){
							$( "#dialog-confirm" ).dialog('close');
							loadTable(data);
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