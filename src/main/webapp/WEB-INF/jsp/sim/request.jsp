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
	      		<h4><b><i class="fas fa-registered" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> ขอเบอร์ที่ไม่มีในระบบ</b></h4>
	    	</div>
	    </div>
    	<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12 x_panel panel-round-bd">
			  	<div class="form-group col-md-3 col-sm-3 col-xs-12">
			    	<label for="filter_1" class="control-label">ระบุเลขนำหน้าที่ต้องการ</label>
			    	<select class="form-control" id="filter_1">
			    		<option value="">ทั้งหมด</option>
			    		<option value="061">061</option>
			    		<option value="062">062</option>
			    		<option value="063">063</option>
			    		<option value="065">065</option>
			    		<option value="080">080</option>
			    		<option value="081">081</option>
			    		<option value="082">082</option>
			    		<option value="083">083</option>
			    		<option value="084">084</option>
			    		<option value="085">085</option>
			    		<option value="086">086</option>
			    		<option value="087">087</option>
			    		<option value="088">088</option>
			    		<option value="089">089</option>
			    		<option value="090">090</option>
			    		<option value="091">091</option>
			    		<option value="092">092</option>
			    		<option value="094">094</option>
			    		<option value="095">095</option>
			    		<option value="099">099</option>
			    	</select>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-3 col-xs-12">
			    	<label for="filter_2" class="control-label">ระบุหมายเลข</label>
			    	<select class="form-control" id="filter_2">
			    		<option value="">ทั้งหมด</option>
			    		<option value="0000">0000</option>
			    		<option value="1111">1111</option>
			    		<option value="2222">2222</option>
			    		<option value="3333">3333</option>
			    		<option value="4444">4444</option>
			    		<option value="5555">5555</option>
			    		<option value="6666">6666</option>
			    		<option value="7777">7777</option>
			    		<option value="8888">8888</option>
			    		<option value="9999">9999</option>
			    	</select>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-3 col-xs-12">
			    	<label for="filter_3" class="control-label">ระบุเลขที่ต้องการ</label>
			    	<div class="form-inline">
			    		<input type="text" class="input-one" id="filter_3">
			    		<input type="text" class="input-one" id="filter_4">
			    		<input type="text" class="input-one" id="filter_5">
			    		<input type="text" class="input-one" id="filter_6">	
			    	</div>
			  	</div>
				<div class="form-group col-md-2 col-sm-3 col-xs-12">
			    	<label for="filter_7" class="control-label">ระบุเลขที่ไม่ต้องการ</label>
			    	<div class="form-inline">
			    		<input type="text" class="input-one" id="filter_7">
			    		<input type="text" class="input-one" id="filter_8">
			    		<input type="text" class="input-one" id="filter_9">
			    		<input type="text" class="input-one" id="filter_10">	
			    	</div>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-12">
			    	<label for="filter_11" class="control-label">ผลรวมของเบอร์</label>
			    	<input type="text" class="form-control" id="filter_11"/>
			  	</div>
			  	<div class="col-md-4 col-sm-4 col-xs-4">
				   <div class="form-group">
					    <label for="bookingNo">เบอร์โทรศัพท์</label>
					    <input type="text" class="form-control" id="mobileNo">
					    <div class="help-block with-errors"></div>
					  </div>
				 </div>
				 <div class="col-md-3 col-sm-3 col-xs-3">
				    <button type="button" class="btn btn-warning" style="margin-top:28px;" id="request-btn">ส่งคำขอ</button>
				 </div>
			      <div class="col-md-5 col-sm-5 col-xs-5" style="margin-top:10px;display:none;" id="div-select-sim">
                  	<button class="btn-lg btn-round-solid bg-blue-weight pull-right btn-select-num">
					  <span>เบอร์ที่คุณเลือก</span>
					  <div class="badge" id="selected_sim">0</div>
					</button>
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
									   <th class="text-center">Request No.</th>
									   <th class="text-center">เงื่อนไขการ Request</th>
									   <th class="text-center">วันที่ทำการ Request</th>
									   <th class="text-center">Request Status</th>
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
 			<c:if test="${sessionScope.userInfo.userId ne null}">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12">
						<button type="button" class="btn btn-warning" id="submit-btn">ดำเนินการต่อ</button>
						<button type="button" class="btn btn-danger">ยกเลิก</button>
					</div>
				</div>
			</c:if>
		</div>
		<script type="text/javascript">

		var table = null;
		searchMenu = 'REQUESTSIM';
		var oldValueSearch = '';
		var oldKeySearch = '';
		var checkedSim = [];
		var simRequest = ('${simRequest}' != null && '${simRequest}' != '') ? JSON.parse('${simRequest}') : '${simRequest}';
		
		function format ( d ) {
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
			str += '<table class="table table-bordered table-striped" id="table-' + d.requestId + '">';
			str += '<thead><tr>';
			str += '<th style=\"text-align:center;\">Mobile No.</th>';
			str += '<th style=\"text-align:center;\">Price</th>';
			str += '<th style=\"text-align:center;\">Credit Term</th>';
			str += '<th style=\"text-align:center;\">ผลรวมเบอร์</th>';
			str += '<th style=\"text-align:center;\">Status</th>';
			str += '<th class=\"text-center\">จอง/ยกเลิก</th>';
			str += '</tr></thead><tbody>';
			for(var x in d.requestSim){
				var requestStatus = d.requestSim[x].requestStatus;
				if(checkedSim[d.requestSim[x].simNumber] != undefined){
					requestStatus = checkedSim[d.requestSim[x].simNumber];
				}else if(simRequest.indexOf(d.requestSim[x].simNumber) > -1){
					requestStatus = 'B';
				}
				console.log(simRequest.indexOf(d.requestSim[x].simNumber));
				var booking = '';
				var deleteBooking = '';
				var approve = '';
				var reject = '';
				if(requestStatus == 'A'){
					requestStatus = "<span class='label label-danger'>" + '<spring:message code="label.availableTH" />' + "</span>";
					reject = "<a href=\"javascript:cancelBookingSim('" + d.requestSim[x].simNumber + "', '" + d.requestId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิก\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
					approve = "<a href=\"javascript:bookingSim('" + d.requestSim[x].simNumber + "', '" + d.requestId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"จอง\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
				}else if(requestStatus == 'B'){
					requestStatus = "<span class='label label-warning'>" + '<spring:message code="label.bookingTH" />' + "</span>";
					reject = "<a href=\"javascript:cancelBookingSim('" + d.requestSim[x].simNumber + "', '" + d.requestId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิก\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
					approve = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"จอง\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
				}else if(requestStatus == 'Y'){
					requestStatus = "<span class='label label-success'>" + '<spring:message code="label.bookingAlreadyTH" />' + "</span>";
					reject = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิก\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
					approve = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"จอง\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
				}
				str += '<tr id="tr-' + d.requestId + '-' + d.requestSim[x].simNumber+ '">';
		        str += '<td style=\"text-align:center;\">' + parseSimFormat(d.requestSim[x].simNumber) + '</td>';
		        str += '<td style=\"text-align:right;\">' + numeral(d.requestSim[x].price).format('0,0.00') + '</td>';
		        str += '<td style=\"text-align:center;\">' + d.requestSim[x].creditTerm + '</td>';
		        str += '<td style=\"text-align:center;\">' + d.requestSim[x].sumNumber + '</td>';
		        str += '<td style=\"text-align:center;\">' + requestStatus + '</td>';
		        str += '<td style=\"text-align:center;\">' + approve + '&nbsp;&nbsp;' + reject + '</td>';
		        str += '</tr>';
			}
			str += '</tbody></table></div></div>'; 	 
			str += '<div class="col-md-10" style="float:right;">';
			//str += "<button type=\"button\" class=\"btn btn-warning\" onclick=\"bookingSim(\'" + d.requestId + "\', this);\">ยืนยันการทำรายการ</button>&nbsp;&nbsp;<button type=\"button\" class=\"btn btn-danger\">ยกเลิก</button>";
		    str += '</div>';
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
						d.dataSearch = params;
						if(typeof order != 'undefined'){
							if(order != '' && order != null){
								d.order[0].column = order;
								d.order[0].dir = 'asc';
							}
						}
					},
					"url": GetSiteRoot() + '/RequestSimCard/SearchRequestSim',
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
					{ "data": "requestStatus" }/* ,
					{ "data": null } */
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
						reject = "<a href=\"javascript:cancelRequest('" + aData.simNumber + "', '" + aData.requestStatus + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Reject Request\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
						approve = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Approve Request\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
					}else if(aData.requestStatus == 'A'){
						requestStatus = "<span class='label label-info'>" + '<spring:message code="label.addSimAlready" />' + "</span>";
						reject = "<a href=\"javascript:cancelRequest('" + aData.simNumber + "', '" + aData.requestStatus + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิก Request\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
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
					/* $('td:eq(5)', nRow).html("<center>" + approve + '&nbsp;&nbsp;' + reject + "</center>");  */
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
	
		function approveRequest(requestId, status){
			if(status == 'A'){
				confirmModal('', 'ยืนยันการการจองเบอร์ เบอร์ที่ request ทั้งหมด ');
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
						  sendPostAjax('/ManageRequest/ApproveRequestSim', obj, function(data){
							if(data == 1){
								$("#dialog-confirm" ).dialog('close');
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
			}
		}
	
		function cancelRequest(requestId){
			confirmModal('', 'คุณต้องการยกเลิกการ Request No. ' + requestId);
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
						 requestId: requestId
					  };
					  sendPostAjax('/RequestSimCard/CancelRequestSim', obj, function(data){
						if(data != null){
							$( "#dialog-confirm" ).dialog('close');
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
		
		function canceltSim(simNumber){
			confirmModal('', 'คุณต้องการยกเลิกการจองเบอร์ ' + parseSimFormat(simNumber));
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
						 simNumber: simNumber
					  };
					  sendPostAjax('/RequestSimCard/CancelRequestSim', obj, function(data){
						if(data != null){
							$( "#dialog-confirm" ).dialog('close');
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
		
		flyToElement = function (flyer, flyingTo) {
	    	var $func = $(this);$('#div-select-sim').show();
	    	var divider = 3;
	    	var flyerClone = $(flyer).clone();
	    	$(flyer).addClass('active');
	    	$( "#dialog-confirm" ).dialog('close');
	    	$(flyerClone).css({position: 'absolute', top: $(flyer).offset().top + "px", left: $(flyer).offset().left + "px", opacity: 1, 'z-index': 1000});
	    	$('body').append($(flyerClone));
	    	var gotoX = $(flyingTo).offset().left + ($(flyingTo).width() / 2) - ($(flyer).width()/divider)/2;
	    	var gotoY = $(flyingTo).offset().top + ($(flyingTo).height() / 2) - ($(flyer).height()/divider)/2;
			
	    	$(flyerClone).animate({
	    		opacity: 0,
	    		left: gotoX,
	    		top: gotoY,
	    		width: $(flyer).width(),
	    		height: $(flyer).height()
	    	}, 700,
	    	function () {
	    		$(flyingTo).fadeOut('fast', function () {
	    			$(flyingTo).fadeIn('fast', function () {
	    				$(flyerClone).fadeOut('fast', function () {
	    					$('#selected_sim').html(checkedSim.length);
	    					/* loadTable({ exceptSimNumber : checkedSim });
	    					if(num > 0){
	    						$('#btn-book').show();
	    					} */
	    				});
	    			});
	    		});
	    	});
	    }
			
		function bookingSim(simNumber, requestId){
			checkedSim[simNumber] = 'B';
			var tr = $('#table-' + requestId).find('tbody > tr#tr-' + requestId + '-' + simNumber);
			tr.find('td:eq(4)').html("<span class='label label-warning'>" + '<spring:message code="label.bookingTH" />' + "</span>");
			var reject = "<a href=\"javascript:cancelBookingSim('" + simNumber + "', '" + requestId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิก\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
			var approve = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"จอง\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD; cursor:not-allowed;\"></i></span>";
			tr.find('td:eq(5)').html(approve + '&nbsp;&nbsp;' + reject);
			$('#div-select-sim').show();
			$('#selected_sim').html(Object.keys(checkedSim).length);
		}
	
		function cancelBookingSim(simNumber, requestId){
			delete checkedSim[simNumber];
			var tr = $('#table-' + requestId).find('tbody > tr#tr-' + requestId + '-' + simNumber);
			tr.find('td:eq(4)').html("<span class='label label-danger'>" + '<spring:message code="label.availableTH" />' + "</span>");
			var reject = "<a href=\"javascript:cancelBookingSim('" + simNumber + "', '" + requestId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิก\"><i class=\"fa fa-times fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
			var approve = "<a href=\"javascript:bookingSim('" + simNumber + "', '" + requestId + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"จอง\"><i class=\"fa fa-check fa-2x\"  style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";	
			tr.find('td:eq(5)').html(approve + '&nbsp;&nbsp;' + reject);
			if(checkedSim.length == 0){
				$('#div-select-sim').hide();
			}
			$('#selected_sim').html(Object.keys(checkedSim).length);
		}
		
		$(document).ready(function() {
		    loadTable({});
		    $('#request-btn').click(function(){
	    		errMsg.sim = {
					mobileNo: { id: $('#mobileNo'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
				};
	    		
	    		var filter_1 = $('#filter_1').val().trim();
	    		var filter_2 = $('#filter_2').val().trim();
	    		var filter_3 = $('#filter_3').val().trim();
	    		var filter_4 = $('#filter_4').val().trim();
	    		var filter_5 = $('#filter_5').val().trim();
	    		var filter_6 = $('#filter_6').val().trim();
	    		var filter_7 = $('#filter_7').val().trim();
	    		var filter_8 = $('#filter_8').val().trim();
	    		var filter_9 = $('#filter_9').val().trim();
	    		var filter_10 = $('#filter_10').val().trim();
	    		var filter_11 = $('#filter_11').val().trim();
	    		var mobileNo = $('#mobileNo').val().trim();
	    		if(filter_1 == '' && filter_2 == '' && filter_3 == '' && filter_4 == '' && filter_5 == '' && filter_6 == '' && filter_7 == '' && filter_8 == '' && filter_9 == '' && filter_10 == '' && filter_11 == '' && mobileNo == ''){
	    			alertModal('Warning', 'กรุณาระบุเงื่อนไขการขอเบอร์โทรศัพท์');
	    			return false;
	    		}
	    		var chkFilter = 0;
	    		if(filter_1 != '') chkFilter++;
	    		if(filter_2 != '') chkFilter++;
	    		if(filter_3 != '' || filter_4 != '' || filter_5 != '' || filter_6 != '') chkFilter++;
	    		if(filter_7 != '' || filter_8 != '' || filter_9 != '' || filter_10 != '') chkFilter++;
	    		if(filter_11 != '') chkFilter++;
	    		if(mobileNo != '') chkFilter++;
	    		if(chkFilter > 1){
	    			alertModal('Warning', 'กรุณาระบุเงื่อนไขเพียง 1 เงื่อนไข');
	    			return false;
	    		}
	    		var reqeustType = '';
	    		var reqeustValue = '';
	    		if(filter_1 != ''){
	    			reqeustType = 1;
	    			reqeustValue = filter_1;
	    		}else if(filter_2 != ''){
	    			reqeustType = 2;
	    			reqeustValue = filter_2;
	    		}else if(filter_3 != '' || filter_4 != '' || filter_5 != '' || filter_6 != ''){
	    			reqeustType = 3;
	    			reqeustValue = filter_3 + filter_4 + filter_5 + filter_6;
	    		}else if(filter_7 != '' || filter_8 != '' || filter_9 != '' || filter_10 != ''){
	    			reqeustType = 4;
	    			reqeustValue = filter_7 + filter_8 + filter_9 + filter_10;
	    		}else if(filter_11 != ''){
	    			reqeustType = 5;
	    			reqeustValue = filter_11;
	    		}else if(mobileNo != ''){
	    			reqeustType = 6;
	    			reqeustValue = mobileNo.replaceAll('-','');
	    		}
	    		var obj = {
	    			requestType: reqeustType,
	    			requestValue: reqeustValue
	    		};
				sendGetAjax('/CheckSessionLogin', function(data){
		    		if(data == '1'){
		    			confirmModal('', 'คุณต้องการส่งคำขอเบอร์ โทรศัพท์ ?');
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
									if(reqeustType == 6){
									 	sendGetAjax('/RequestSimCard/CheckSimNumberBeforeRequest/' + $('#mobileNo').val().replaceAll('-',''), function(data){
							    			if(data == '0'){		
							    				sendPostAjax('/RequestSimCard/SaveRequestSim', obj, function(data){
							    					$( "#dialog-confirm" ).dialog("close");
													loadTable({});
												});
							    			}else{
							    				$( "#dialog-confirm" ).dialog("close");
							    				alertModal('Warning', 'ไม่สามารถส่งคำขอได้ เบอร์นี้มีในระบบแล้ว');
							    			}
							    		});
									}else{
										sendPostAjax('/RequestSimCard/SaveRequestSim', obj, function(data){
					    					$( "#dialog-confirm" ).dialog("close");
											loadTable({});
										});
									}
								},
								Cancel: function() {
								  $(this).dialog("close");
								}
							}
						});
		    		}else{
		    			openLogin();
		    		}
		    	});
		    });
		    
		    $('#submit-btn').click(function(){
		    	if(Object.keys(checkedSim).length == 0){
					confirmModal('Warning', 'เบอร์โทรศัพท์ที่ท่านเลือกจะถูกลบออกทั้งหมด');
				}else{
					confirmModal('Warning', 'เบอร์โทรศัพท์ที่ท่านเลือกจะถูกบันทึก');
				}
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
							var dia = this;
							var obj = [];
							for(var x in checkedSim){
								obj[obj.length] = x;
							}
							sendPostAjax('/Sim/SaveSesionSim', obj, function(data){
								if(obj.length == 0){
									checkedSim = [];
				    				loadTable({});
				    				$(dia).dialog("close");
								}else{
									var global = new Global();
									window.location = global.contextPath() + 'SelectNumber';	
								}
							});
						},
						Cancel: function() {
						  $(this).dialog("close");
						}
					}
				});
		    });

		    $('.btn-danger').click(function(){
		    	confirmModal('Warning', 'เบอร์โทรศัพท์ที่ท่านเลือกจะถูกลบออกทั้งหมด');
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
							var dia = this;
							var obj = [];
							sendPostAjax('/Sim/SaveSesionSim', obj, function(data){
								checkedSim = [];
			    				loadTable({});
			    				$(dia).dialog("close");
							}); 
							
						},
						Cancel: function() {
						  $(this).dialog("close");
						}
					}
				});
		    });
		    
		    $('#mobileNo').mask('000-000-0000');
		    $('#bookingNo').mask('0000000000');
		    $('#filter_3').mask('0', { onComplete: function(cep) {
	    		$('#filter_4').focus();
	    	}});
	    	$('#filter_4').mask('0', { onComplete: function(cep) {
	    		$('#filter_5').focus();
	    	}});
	    	$('#filter_5').mask('0', { onComplete: function(cep) {
	    		$('#filter_6').focus();
	    	}});
	    	$('#filter_6').mask('0', { onComplete: function(cep) {
	    		
	    	}});
	    	
	    	$('#filter_7').mask('0', { onComplete: function(cep) {
	    		$('#filter_8').focus();
	    	}});
	    	$('#filter_8').mask('0', { onComplete: function(cep) {
	    		$('#filter_9').focus();
	    	}});
	    	$('#filter_9').mask('0', { onComplete: function(cep) {
	    		$('#filter_10').focus();
	    	}});
	    	$('#filter_10').mask('0', { onComplete: function(cep) {
	    		
	    	}});
	    	
	    	$('#filter_11').mask('00', { onComplete: function(cep) {
	    		
	    	}});
		 });
		</script>
	</jsp:body>
</t:master>