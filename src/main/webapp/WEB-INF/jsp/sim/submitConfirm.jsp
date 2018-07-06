<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<t:master>
	<jsp:body>
	<script src="<c:url value="/js/sim.js" />"></script>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
	   		<ul class="progress-tracker"> 
	   			<li class="step-0-title progress-tracker-visited"> 
	   				<span class="visible-md-block visible-lg-block desktop">1. เลือกเบอร์โทรศัพท์</span> 
	   				<small class="visible-xs-block visible-sm-block mobile" >เลือก</small> 
	   			</li> 
	   			<li class="step-1-title progress-tracker-visited"> 
	   				<span class="visible-md-block visible-lg-block desktop" >2. แสดงเบอร์ที่จอง</span> 
	   				<small class="visible-xs-block visible-sm-block mobile">เบอร์ที่จอง</small> 
	   			</li>
	   			<li class="step-2-title progress-tracker-active"> 
	   				<span class="visible-md-block visible-lg-block desktop">3. ยืนยันการจอง</span> 
	   				<small class="visible-xs-block visible-sm-block mobile">ยืนยัน</small> 
	   			</li> 
	   			<li class="step-3-title"> 
	   				<span class="visible-md-block visible-lg-block desktop" >4. การจองเสร็จสมบูรณ์!</span> 
	   				<small class="visible-xs-block visible-sm-block mobile">เสร็จสิ้น</small> 
	   			</li>
	   		</ul>               
     	</div>
     </div>
	<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
              	
                <div class="panel panel-warning">
			      <div class="panel-heading">
			        <h3 class="panel-title">รายละเอียดการจอง </h3>
			      </div>
			      <div class="panel-body">
			      	<div class="row">
			      		<div class="col-md-8"></div>
			      		<div class="col-md-4">
			      			<div class="panel panel-success">
						      <div class="panel-body" style="font-size:16px;">
						      	<b>ข้อมูลส่วนตัว</b><br/>
						       	 <b>ชื่อ-นามสกุล :</b> ${user.prefixName} ${user.firstName} ${user.lastName}<br/>
						         <b>ชื่อหมอดู / ฉายาหมอดู :</b> ${user.nickName}<br/> 
						         <b>ที่อยู่ :</b> ${user.address} ${user.provinceStr}  ${user.postcode}<br/>               
						         <b>เบอร์โทรศัพท์ : </b> ${user.mobile}<br/>
						         <b>อีเมล์: </b> ${user.email}<br/>
						         <b>Line ID : </b> ${user.mobile}<br/>
						         <b>Website :</b> ${user.website}<br/>
						      </div>
						    </div>
			      		</div>
			      	</div>
			        <div class="row">
			        	<div class="col-md-1"></div>
						<div class="col-md-9">
							<table id="user_table" class="table table-bordered" style="width:100%;margin-top:20px;">
				                 <thead>
				                      <tr>
				                      	  <th class="text-center" width="10%"><b>No.</b></th>
				                          <th class="text-center" width="20%"><b>เบอร์โทรศัพท์</b></th>
				                          <th class="text-center" width="10%"><b>Credit Term (วัน)</b></th>
				                          <th class="text-center" width="10%"><b>ราคา (บาท)</b></th>
				                      </tr>
				                  </thead>
				                  <tbody>
				                    <c:set var="sumTotal" value="0" scope="page" />
				                  	<c:forEach var="item" items="${sims}" varStatus="counter">
				                  		<c:set var="sumTotal" value="${sumTotal + item.price}" scope="page"/>
				                  		<tr>
				                  			<td style="text-align:center;">${counter.count}</td>
				                  			<td style="text-align:center;">${app.parseSimFormat(item.simNumber)}</td>
				                  			<td style="text-align:center;">${item.creditTerm}</td>
				                  			<td style="text-align:right;"><fmt:formatNumber type="currency" currencySymbol="" value="${item.price}"/></td>
				                  		</tr>
				                  	</c:forEach>
				                  	<tr>
				                  		<td colspan="3" style="text-align:right;">รวม</td>
				                  		<td style="text-align:right;"><fmt:formatNumber type="currency" currencySymbol="" value="${sumTotal}"/></td>
				                  	</tr>
				                  </tbody>
				              </table>
						</div>
						<div class="col-md-2"></div>
					</div>
					<div class="row">
						<div class="col-md-1"></div>
							<div class="col-md-9">
								<div class="panel panel-default">
							  		<div class="panel-heading"><i class="fas fa-home" style="font-size:1.2em;"></i>&nbsp;&nbsp;ที่อยู่ในการจัดส่ง/ใบกำกับภาษี</div>
							  		<div class="panel-body">
							    	<div class="row">
							    		<div class="col-md-5">
						    				<div class="radio" id="show_data2">
						    					<label>
													<input type="checkbox" name="add-chk" value="1">
												</label>&nbsp;&nbsp;ใช้ที่อยู่เดียวกับที่สมัครไว้ 
											</div>	
							    		</div>
							  		</div>
							  		<div class="container-fluid form-horizontal">
							  			<div class="row">
						    				<div class="form-group">
									  			<label class="col-sm-2 control-label">ที่อยู่</label>
												<div class="col-sm-4">
													<input type="text" id="address" class="form-control" />
													<div class="help-block with-errors"></div>
												</div>
											
												<label class="col-sm-2 control-label">จังหวัด</label>
												<div class="col-sm-4">
													<select id="province" class="form-control"></select>
													<div class="help-block with-errors"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<label class="col-sm-2 control-label">รหัสไปรษณีย์</label>
												<div class="col-sm-4">
													<input type="text" id="postcode" class="form-control" />
													<div class="help-block with-errors"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
						 	</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-1"></div>
							<div class="col-md-9">
							<div class="panel panel-default">
							  <div class="panel-heading"><i class="far fa-credit-card" style="font-size:1.2em;"></i>&nbsp;&nbsp;ช่องทางการชำระเงิน</div>
							  <div class="panel-body">
							    <div class="row">
							    	<div class="col-md-5">
					    				<div class="radio" id="show_data">
											<label>
												<input type="radio" name="payType" value="1" checked>
											</label>&nbsp;&nbsp;โอนเงินผ่านธนาคาร 
										</div>
										<select style="width:300px;display:none;" id="chnageBank">
											<%-- <option value="">-- เลือกบัญชีธนาคาร--</option>
										  	<option data-thumbnail="<c:url value="/images/bbl.png" />" value="1">ธนาคารกรุงเทพ </option>
										  	<option data-thumbnail="<c:url value="/images/scb.png" />" value="2">ธนาคารกรุงเทพ เลขบัญชี 000-0000-000</option>
										  	<option data-thumbnail="<c:url value="/images/kbank.png" />" value="1">ธนาคารกรุงเทพ เลขบัญชี 000-0000-000</option>
										  	<option data-thumbnail="<c:url value="/images/ktb.png" />" value="1">ธนาคารกรุงเทพ เลขบัญชี 000-0000-000</option>
										  	<option data-thumbnail="<c:url value="/images/tmb.png" />" value="1">ธนาคารกรุงเทพ เลขบัญชี 000-0000-000</option>
										  	<option data-thumbnail="<c:url value="/images/aycap.png" />" value="1">ธนาคารกรุงเทพ เลขบัญชี 000-0000-000</option> --%>
										</select>
										<div class="help-block with-errors" style="margin-left:10px;"></div>
							    	</div>
							    </div>
							    <div class="row">
							    	<div class="col-md-5">
							    		<div class="form-group">
							    		<div id="bookbank" style="margin:10px;"></div>
							    		</div>
							    	</div>
							    </div>
							  </div>
							</div>
						</div>
						<div class="col-md-2"></div>
					</div>
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-10">
						<button type="button" class="btn btn-primary" id="submit-btn">ยืนยันการจอง</button>
						<button type="button" class="btn btn-danger" id="cancel-btn">ยกเลิก</button>
						</div>
					</div>
      			  </div>
    			</div>
            </div>
	    </div>
	    <br/>
		<br/>
	    <script>
	    
	    $(document).ready(function(){
	    	getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', '');
	    	$('#postcode').mask('00000');
			sendGetAjax('/MasterSetup/LoadMasterSetup/BANK', function(data){
    	    	var str = '';
    	    	str += '<option value="">-- เลือกบัญชีธนาคาร--</option>';
    	    	var url = '<c:url value="/" />';
    	    	var desc = [];
    	    	for(var i = 0; i < data.length; i++){
    	    		str += '<option data-thumbnail="' + url + data[i].IMAGE + '" value="' + data[i].CODE + '">' + data[i].DESCRIPTION + '</option>';
    	    		desc['x' + i] = data[i].SUB_DESCRIPTION;
    	    	}
    	    	$('#chnageBank').html(str).selectpicker({width: '300px'});
    	    	$('#chnageBank').change(function(){
    	    		if(this.value == ''){
    	    			$('#bookbank').html('');
    	    		}else{
    	    			$('#bookbank').html(desc['x' + this.value]);
    	    			$('#chnageBank').parent().removeClass('has-error');
						$('#chnageBank').next().next().html('');
    	    		}
    	   	 	});
    	    });
    	    errMsg.user = {
				address: { id: $('#address'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				province: { id: $('#province'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				postcode: { id: $('#postcode'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
			};
			$('#submit-btn').click(function(){
				if(checkValidate('user')){
					if($('#chnageBank').val() == ''){
						$('#chnageBank').parent().addClass('has-error');
						$('#chnageBank').next().next().html('กรุณาเลือกธนาคาร');
					}else{
						$('#chnageBank').parent().removeClass('has-error');
						$('#chnageBank').next().next().html('');
							  	
						confirmModal('Warning', 'ยืนยันการจอง');
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
									var sims = ('${simsJson}' == 'null' || '${simsJson}' == '') ? null : JSON.parse('${simsJson}');
					    	    	var obj = [];
					    	    	for(var x in sims){
										var tmp = {
											simNumber: sims[x].simNumber.replaceAll('-',''),
											payType: $('input[name=payType]:checked').val(),
											bank: $('#chnageBank').val(),
											address: $('#address').val(),
											province: $('#province').val(),
											postcode: $('#postcode').val(),
											flagSim: sims[x].flagSim
										};	
										obj[obj.length] = tmp
					    	    	}
					    	    	sendPostAjax('/Sim/SaveBooking', obj, function(data){
					    	    		if(data != ''){
					    	    			var form = $('<form/>').attr('action', GetSiteRoot() + '/BookingSuccess').attr('method', 'post');
											form.append($('<input/>').attr('name', 'bookingId').attr('type', 'hidden').attr('value', data));
											form.append($('<input/>').attr('name', '${_csrf.parameterName}').attr('type', 'hidden').attr('value', '${_csrf.token}'));
											$('body').append(form);
											form.submit();
					    	    		}
					    	    	});
								},
								Cancel: function() {
								  $(this).dialog("close");
								}
							}
						});
					}
				}
    	    });
    	    
    	    $("#show_data label").checkbox({
	            checked: '<c:url value="/images/checkbox.png" />',
	            check: '<c:url value="/images/uncheckbox.png" />',
				onChange: function() {
					
				}
	        });    	    
    	    
    	    $("#show_data2 label").checkbox({
	            checked: '<c:url value="/images/checkbox.png" />',
	            check: '<c:url value="/images/uncheckbox.png" />',
				onChange: function() {
					if($('input[name="add-chk"]:checked').val() == '1'){
						$('#address').val('${user.address}').attr('disabled', 'disabled');
						$('#province').val('${user.province}').attr('disabled', 'disabled');
						$('#postcode').val('${user.postcode}').attr('disabled', 'disabled');
						$('#address').parent().parent().removeClass('has-error has-danger');
						$('#province').parent().parent().removeClass('has-error has-danger');
						$('#postcode').parent().parent().removeClass('has-error has-danger');
						$('#address').next().html('');
						$('#province').next().html('');
						$('#postcode').next().html('');
					}else{
						$('#address').removeAttr('disabled').val('');
						$('#province').removeAttr('disabled').val('');
						$('#postcode').removeAttr('disabled').val('');
					}
				}
	        });
    	    
    	    $('#cancel-btn').click(function(){
    	    	confirmModal('Warning', 'คุณต้องการยกเลิกการจอง');
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
						  sendGetAjax('/BookingSuccess/CancelBookingSess' , function(data){
							if(data == 1){
								$( "#dialog-confirm" ).dialog('close');
								var global = new Global();
	    						window.location = global.contextPath();
							}
						  });
						},
						Cancel: function() {
						  $(this).dialog("close");
						}
					}
				});
    	    });
	    });
	    
	    function jumpToSim(){
	    	var global = new Global();
	    	window.location = global.contextPath();
	    }
	    </script>
	</jsp:body>
</t:master>