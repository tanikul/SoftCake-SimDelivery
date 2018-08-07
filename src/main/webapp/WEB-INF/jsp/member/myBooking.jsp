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
	      		<h4><b><i class="far fa-file" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> ข้อมูลการจอง</b></h4>
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
				 <div class="col-md-3 col-sm-3 col-xs-12">
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
						                <th class="text-center">Price</th>
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
		<div class="modal fade" id="booking-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog modal-lg">
		      <div class="modal-content">
		       <div class="modal-header">
		         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		       	<span id="modal-txt"></span>
		       </div>
		       <input type="hidden" id="mode">
		       <div class="modal-body">
		          <div class="container-fluid">
		          	   <form method="POST" id="uploadForm" enctype="multipart/form-data" action="<c:url value="/MyBooking/UploadSlip"/>">
							<div class="row">
								<div class="col-sm-12 form-group">
									<div class="col-sm-4">
										<input type="file" class="form-control" id="file" name="file" accept="image/*">
										<div>เฉพาะไฟล์ .png, .jpg, .jpeg</div>
										<div class="help-block with-errors"></div>
									</div>
								</div>
							</div>
							<input type="hidden" id="bookingId" name="bookingId"/>
							<input type="hidden" id="bookingDetailId" name="bookingDetailId"/>
							<div class="row">
								<div class="col-sm-12 form-group">
									<div class="col-sm-4">
										 <div class="cont_btn">
									     	<button type="submit" class="btn btn-primary">อัพโหลด</button>
									    </div>
								    </div>
							    </div>
						    </div>
					    </form>
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
			str += '<div class="col-md-10" style="float:right;">';
			str += '<table class="table table-bordered table-striped">';
			str += '<thead><tr>';
			str += '<th style=\"text-align:center;\">Booking Detail No.</th>';
			str += '<th style=\"text-align:center;\">Mobile No.</th>';
			str += '<th style=\"text-align:center;\">Price</th>';
			str += '<th style=\"text-align:center;\">Activate Status</th>';
			str += '<th style=\"text-align:center;\">ID card</th>';
			str += '<th style=\"text-align:center;\">Action</th>';
			str += '</tr></thead><tbody>';
			for(var x in d.bookingDetails){
				var customerId = (d.bookingDetails[x].customerId == null) ? '-' : d.bookingDetails[x].customerId;
				var activateFlag = "<i class='fa fa-minus-circle red'></i>&nbsp;&nbsp;" + '<spring:message code="label.noActivate" />';
				if(d.bookingDetails[x].activateFlag == 'Y'){
					activateFlag = "<i class='fa fa-check-circle green'></i>&nbsp;&nbsp;" + '<spring:message code="label.activate" />';
				}else if(d.bookingDetails[x].activateFlag == 'W'){
					activateFlag = "<i class='glyphicon glyphicon-time' style='color:tomato;'></i>&nbsp;&nbsp;" + '<spring:message code="label.wait" />';
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
					str += '<td style=\"text-align:center;\"><a href="' + url + 'MyBooking/OpenIDCard/' + d.bookingDetails[x].bookingDetailId + '" target="_blank"><i class="far fa-address-card" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a></td>';
				}
		        var action = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"อัพโหลดบัตรประชาชน\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
		        if(d.bookingStatus == 'Y' && d.bookingDetails[x].activateFlag == 'N'){
		        	action = "<a href=\"javascript:openUploadCustomer('" + d.bookingDetails[x].bookingDetailId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"อัพโหลดบัตรประชาชน\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
		        }
		        str += '<td style=\"text-align:center;\">' + action + '</td>';
		        str += '</tr>';
			}
			str += '</tbody></table></div></div>';
		    return str;
		}

		openUpload = function(id){
			$('#bookingId').val(id);
			$('#bookingDetailId').val('');
			$('#modal-txt').html('อัพโหลดสลิป');
	    	/* setDefault();
	    	sendGetAjax('/Admin/ManageUser/LoadUserById/' + id, function(data){
	    	 	getDropDownList($('#prefix-signup'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', data.prefix);
	    	 	getDropDownList($('#role-signup'), '-- สิทธิ์ผู้ใช้ระบบ --', '/MasterSetup/LoadRole', 'CODE', 'DESCRIPTION', data.role);
	   			//getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', data.province);
	   			$('#signup #mode').val('U');
	    		$('#signup #firstName-signup').val(data.firstName);
				$('#signup #lastName-signup').val(data.lastName);
				$('#signup #username-signup').val(data.userId).attr('disabled', 'disabled');
				$('#passworddiv').hide();
				if(data.activeStatus == 'Y'){
					$($("#signup input[name='activeStatus']").get(0)).attr('checked', true)
				}else{
					$($("#signup input[name='activeStatus']").get(1)).attr('checked', true)
				} */
				$('#booking-modal').modal('show');
			//});
	    }
		
		openUploadCustomer = function(id){
			$('#bookingId').val('');
			$('#bookingDetailId').val(id);
			$('#modal-txt').html('อัพโหลดบัตรประชาชน');
			$('#booking-modal').modal('show');
		}
	
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
				},
		        success: function(data, textStatus, jqXHR)
		        {
		        	loadTable(data);
		        	$('#booking-modal').modal('hide');
		            $.LoadingOverlay("hide");
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
		            { "data": "bookingId" },
		            { "data": "sumPrice" }
		        ],
		        "columnDefs" : [{
					"className" : "dt-center",
					"targets" : [1]
				},{
					"className" : "dt-right",
					"targets" : [3]
				}],
		        //"order": [[1, 'asc']]
				"drawCallback": function(settings) {
					$("*[data-toggle=tooltip]").tooltip();
				},
		    	"fnRowCallback" : function(nRow, aData, index) {
		    		var bookingStatus = "";
					var upload = '';
					var del = '';
		    		var edit = "<a href=\"javascript:viewBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"View Booking\"><i class=\"far fa-file-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
					if(aData.bookingStatus == 'N'){
						bookingStatus = "<span class='label label-danger'>" + '<spring:message code="label.rejectBooking" />' + "</span>";
						upload = "<a href=\"javascript:openUpload('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Upload Slip\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
						del = "<a href=\"javascript:rejectBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Booking\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
					}else if(aData.bookingStatus == 'W'){
						bookingStatus = "<span class='label label-warning'>" + '<spring:message code="label.wait" />' + "</span>";
						upload = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Upload Slip\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
						del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Cancel Booking\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
					}else if(aData.bookingStatus == 'Y'){
						del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Cancel Booking\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
						upload = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Upload Slip\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
						bookingStatus = "<span class='label label-success'>" + '<spring:message code="label.approveBooking" />' + "</span>";
					}else if(aData.bookingStatus == 'P'){
						bookingStatus = "<span class='label label-default'>" + '<spring:message code="label.pendingPaid" />' + "</span>";
						upload = "<a href=\"javascript:openUpload('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Upload Slip\"><i class=\"fas fa-cloud-upload-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
						del = "<a href=\"javascript:rejectBooking('" + aData.bookingId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Cancel Booking\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
					}
					var url = '<c:url value="/" />';
		    		$('td:eq(2)', nRow).html("<center>" + bookingStatus + "<center>");
					$('td:eq(3)', nRow).html(numeral(aData.sumPrice).format('0,0.00'));
					if(aData.slip == '' || aData.slip == null){
						$('td:eq(4)', nRow).html('<center>-</center>');
					}else{
						$('td:eq(4)', nRow).html('<center><a href="' + url + 'MyBooking/OpenSlip/' + aData.bookingId + '" target="_blank"><i class="far fa-credit-card" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a></center>');
					}
					$('td:eq(5)', nRow).html("<center>" + upload + '&nbsp;&nbsp;'+ edit + '&nbsp;&nbsp;' + del + "</center>"); 
		    		return nRow;
		    	},"initComplete": function(settings, json) {
					
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
		
		function rejectBooking(bookingId){
			confirmModal('', 'คุณต้องการยกเลิกการจองหมายเลข ' + bookingId);
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
					  sendGetAjax('/MyBooking/CancelBooking/' + bookingId, function(data){
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
		
		function viewBooking(bookingId){
			let form = $('<form/>').attr('action', GetSiteRoot() + '/MyBooking/ViewBooking').attr('method', 'post').attr("target", "_blank");
			form.append($('<input/>').attr('name', 'bookingId').attr('type', 'hidden').attr('value', bookingId));
			form.append($('<input/>').attr('name', '${_csrf.parameterName}').attr('type', 'hidden').attr('value', '${_csrf.token}'));
			$('body').append(form);
			form.submit();	
		}
		
		$(document).ready(function() {
			$('form').on('submit', uploadFiles);
			$('input[type=file]').on('change', prepareUpload);
		    var data = ('${data}' == 'null' || '${data}' == '') ? null : JSON.parse('${data}');
		    loadTable(data);
		    
		    $('#search-btn').click(function(){
		    	var obj = {
		    		bookingId: $('#bookingNo').val(),
		    		mobileNo: $('#mobileNo').val().replaceAll('-','')
		    	};
		    	sendPostAjax('/MyBooking/SearchBooking', obj, function(data){
					loadTable(data);
				});
		    });
		    
		    $('#mobileNo').mask('000-000-0000');
		    $('#bookingNo').mask('0000000000');
		 });
		</script>
	</jsp:body>
</t:master>