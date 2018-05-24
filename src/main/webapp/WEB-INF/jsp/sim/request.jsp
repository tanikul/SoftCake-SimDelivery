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
	    <div class="panel-round-bd">
			<div class="row">
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
									   <th class="text-center">เบอร์โทรศัพท์</th>
									   <th class="text-center">ผลรวมเบอร์</th>
									   <th class="text-center">ราคา</th>
									   <th class="text-center">Credit Term</th>
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
			<div class="row" id="btn-book" style="display:none;">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<button type="button" class="btn btn-primary">ดำเนินการต่อ</button>
					<button type="button" class="btn btn-danger">ยกเลิก</button>
				</div>
			</div>
		</div>
		<script type="text/javascript">

		var table = null;
		searchMenu = 'REQUESTSIM';
		var oldValueSearch = '';
		var oldKeySearch = '';
		var checkedSim = [];
		 
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
					{ "data": "simNumber" },
					{ "data": "sumNumber" },
					{ "data": "price" },
					{ "data": "creditTerm" },
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
					var requestStatus = '';
					var del = '';
					var booking = '';
					var creditTerm = '-';
					var price = '<center>-</center>';
					if(aData.requestStatus == 'W'){
						requestStatus = "<span class='label label-warning'>" + '<spring:message code="label.waitRequest" />' + "</span>";
						del = "<a href=\"javascript:rejectSim('" + aData.simNumber + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิกคำขอ\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
						booking = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ทำการจอง\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
					}else if(aData.requestStatus == 'C'){
						requestStatus = "<span class='label label-danger'>" + '<spring:message code="label.cancelRequest" />' + "</span>";
						del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิกคำขอ\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
						booking = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ทำการจอง\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#BDBDBD;cursor:not-allowed;\"></i></span>";	
					}else if(aData.requestStatus == 'Y'){
						requestStatus = "<span class='label label-success'>" + '<spring:message code="label.approveRequest" />' + "</span>";
						del = "<a href=\"javascript:rejectSim('" + aData.simNumber + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ยกเลิกคำขอ\"><i class=\"fa fa-trash-alt fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
						booking = "<a href=\"javascript:void(0);\" onclick=\"booking('" + aData.simNumber + "', this);\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"ทำการจอง\"><i class=\"fa fa-check fa-2x\" style=\"font-size:1.2em; color:#8F8E8C;\"></i></a>";
						creditTerm = aData.creditTerm;
						price = '<span style="float:right">' + numeral(aData.price).format('0,0.00') + '</span>';
					}
					$('td:eq(0)', nRow).html(parseSimFormat(aData.simNumber));
					$('td:eq(2)', nRow).html(price);
					$('td:eq(3)', nRow).html("<center>" + creditTerm + "</center>");
					$('td:eq(4)', nRow).html("<center>" + requestStatus + "<center>");
					$('td:eq(5)', nRow).html("<center>" + del + '&nbsp;&nbsp;' + booking + "</center>");  
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
			}
		}
	
		function rejectSim(simNumber){
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
		
		flyToElement = function (flyer, flyingTo, simNumber) {
	    	var $func = $(this);
	    	var divider = 3;
	    	var flyerClone = $(flyer).clone();
	    	$(flyer).addClass('active');
	    	checkedSim[checkedSim.length] = simNumber;
	    	$( "#dialog-confirm" ).dialog('close');
	    	$(flyerClone).css({position: 'absolute', top: $(flyer).offset().top + "px", left: $(flyer).offset().left + "px", opacity: 1, 'z-index': 1000});
	    	$('body').append($(flyerClone));
	    	var gotoX = $(flyingTo).offset().left + ($(flyingTo).width() / 2) - ($(flyer).width()/divider)/2;
	    	var gotoY = $(flyingTo).offset().top + ($(flyingTo).height() / 2) - ($(flyer).height()/divider)/2;
			$('#div-select-sim').show();
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
	    					var num = parseInt($('#selected_sim').html()) + 1;
	    					$('#selected_sim').html(num);
	    					loadTable({ exceptSimNumber : checkedSim });
	    					if(num > 0){
	    						$('#btn-book').show();
	    					}
	    				});
	    			});
	    		});
	    	});
	    }
			
		function booking(simNumber, obj){
			confirmModal('', 'คุณต้องการจองเบอร์ ' + parseSimFormat(simNumber));
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
					  
					  var itemImg = $(obj);
	    			  flyToElement($(itemImg), $('.btn-select-num'), simNumber);
					},
					Cancel: function() {
					  $(this).dialog("close");
					}
				}
			});
		}
	
		$(document).ready(function() {
		    loadTable({});
		    $('#request-btn').click(function(){
	    		errMsg.sim = {
					mobileNo: { id: $('#mobileNo'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
				};
				if(checkValidate('sim')){
					sendGetAjax('/CheckSessionLogin', function(data){
			    		if(data == '1'){
			    			confirmModal('', 'คุณต้องการส่งคำขอเบอร์ ' + parseSimFormat($('#mobileNo').val().replaceAll('-','')));
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
							    			simNumber: $('#mobileNo').val().replaceAll('-','')
								    	};
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
					
				}
		    });
		    
		    $('.btn-primary').click(function(){
		    	if(checkedSim.length == 0){
					alertModal('Warning', 'ท่านยังไม่ได้เลือกเบอร์โทรศัพท์');
				}else{
					sendPostAjax('/Sim/SaveSesionSim', checkedSim, function(data){
						var global = new Global();
						window.location = global.contextPath() + 'SelectNumber';	
					});
				}
		    });

		    $('.btn-danger').click(function(){
		    	checkedSim = [];
		    	loadTable({});
		    });
		    $('#mobileNo').mask('000-000-0000');
		    $('#bookingNo').mask('0000000000');
		 });
		</script>
	</jsp:body>
</t:master>