<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="https://vipsim.co/jsp/tlds/customTags" prefix="custom"%>

<t:master>
	<jsp:body>
	<script src="<c:url value="/js/sim.js" />"></script>
	<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
              	<c:choose>
              		<c:when test="${data.bookingStatus eq 'N'}">
              			<div class="alert alert-danger" role="alert">
							<strong>เหตุผลในการยกเลิก : ${data.rejectReason}</strong>
						</div>
						<div class="panel panel-danger">
              		</c:when>
              		<c:otherwise>
              			<div class="panel panel-success">
              		</c:otherwise>
              	</c:choose>
			      <div class="panel-heading">
			        <h3 class="panel-title">รายละเอียดการจอง Booking No. ${data.bookingId} </h3>
			      </div>
			      <div class="panel-body">
			      	<div class="row">
			      		<div class="col-md-8"></div>
			      		<div class="col-md-4">
			      			<div class="panel panel-success">
						      <div class="panel-body">
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
				                  	<c:forEach var="item" items="${data.bookingDetails}" varStatus="counter">
				                  		<tr>
				                  			<td style="text-align:center;">${counter.count}</td>
				                  			<td style="text-align:center;">${app.parseSimFormat(item.simNumber)}</td>
				                  			<td style="text-align:center;">${item.creditTerm}</td>
				                  			<td style="text-align:right;"><fmt:formatNumber type="currency" currencySymbol="" value="${item.price}"/></td>
				                  		</tr>
				                  	</c:forEach>
				                  	<tr>
				                  		<td colspan="3" style="text-align:right;">รวม</td>
				                  		<td style="text-align:right;"><fmt:formatNumber type="currency" currencySymbol="" value="${data.sumPrice}"/></td>
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
													<input type="text" id="address" class="form-control" value="${data.address}" disabled/>
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
													<input type="text" id="postcode" class="form-control" value="${data.postcode}" disabled/>
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
												<input type="radio" name="payType" value="1" checked disabled>
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
						<div class="col-md-10 col-md-offset-5">
						<button type="button" class="btn btn-danger" id="cancel-btn">ปิดหน้าต่าง</button>
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
	    	getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', '${data.province}', true);
	    	$('#postcode').mask('00000');
			sendGetAjax('/MasterSetup/LoadMasterSetup/BANK', function(data){
    	    	var str = '';
    	    	str += '<option value="">-- เลือกบัญชีธนาคาร--</option>';
    	    	var url = '<c:url value="/" />';
    	    	var desc = [];
    	    	for(var i = 0; i < data.length; i++){
    	    		if('${data.bank}' == data[i].CODE){
    	    			str += '<option data-thumbnail="' + url + data[i].IMAGE + '" value="' + data[i].CODE + '" selected>' + data[i].DESCRIPTION + '</option>';
    	    		}else{
    	    			str += '<option data-thumbnail="' + url + data[i].IMAGE + '" value="' + data[i].CODE + '">' + data[i].DESCRIPTION + '</option>';
    	    		}
    	    		desc['x' + i] = data[i].SUB_DESCRIPTION;
    	    	}
    	    	$('#chnageBank').html(str).selectpicker({width: '300px'}).attr('disabled', 'disabled');
    	    	$('#bookbank').html(desc['x' + '${data.bank}']);
    	    });
			if('${data.payType}' == '1'){
				$('input[name=add-chk]').attr('checked', 'checked').attr('disabled', 'disabled');
			}else{
				$('input[name=add-chk]').attr('disabled', 'disabled');
			}
    	    
    	    
    	    $("#show_data label").checkbox({
	            checked: '<c:url value="/images/checkbox.png" />',
	            check: '<c:url value="/images/uncheckbox.png" />',
				onChange: function() {
					
				}
	        });    	    
    	    
    	    $('#cancel-btn').click(function(){
    	    	confirmModal('Warning', 'คุณต้องการปิดหน้าต่างนี้ ?');
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
						  window.close();
						},
						Cancel: function() {
						  $(this).dialog("close");
						}
					}
				});
    	    });
	    });
	    
	    </script>
	</jsp:body>
</t:master>