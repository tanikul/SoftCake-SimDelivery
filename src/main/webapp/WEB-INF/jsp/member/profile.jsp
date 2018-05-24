<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	<br/>
		<div class="panel panel-warning">
      <div class="panel-heading">
        <h3 class="panel-title">
      		<i class="fas fa-user" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> ข้อมูลส่วนตัว
    	</h3>
      </div>
      <div class="panel-body">
        <div class="container-fluid form-horizontal" id="userInfo">
			<div class="form-group">
				<label class="col-sm-2 control-label"><b>ชือ-นามสกุล</b></label>
				<div class="col-sm-2">
					<select id="prefix" class="form-control">
						<option value="">--คำนำหน้า--</option>
					</select>
					<div class="help-block with-errors"></div>
				</div>
				<div class="col-sm-4">
					<input type="text" id="firstName" class="form-control" placeholder="First Name" />
					<div class="help-block with-errors"></div>
				</div>
				<div class="col-sm-4">
					<input type="text" id="lastName" class="form-control" placeholder="Last Name"/>
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Username</label>
				<div class="col-sm-4">
					<input type="text" id="username" class="form-control" disabled="disabled"/>
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">ที่อยู่</label>
				<div class="col-sm-4">
					<textarea id="address" class="form-control" style="height:150px;"></textarea>
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">จังหวัด</label>
				<div class="col-sm-4">
					<select id="province" class="form-control"></select>
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label"><b>รหัสไปรษณีย์</b></label>
				<div class="col-sm-4">
					<input type="text" id="postcode" class="form-control" />
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">เบอร์โทรศัพท์</label>
				<div class="col-sm-4">
					<input type="text" id="mobile" class="form-control" />
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">อีเมล์</label>
				<div class="col-sm-4">
					<input type="text" id="email" class="form-control" />
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Line ID</label>
				<div class="col-sm-4">
					<input type="text" id="line" class="form-control" />
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Website</label>
				<div class="col-sm-4">
					<input type="text" id="website" class="form-control" />
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">ชื่อ/ฉายาหมอดู</label>
				<div class="col-sm-4">
					<input type="text" id="nickname" class="form-control" />
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-2"></div>
				<div class="col-sm-4">
			     	<button class="btn btn-primary" id="btn_signup">Save</button>
			     	<button type="button" class="btn btn-danger" id="btn_cancel">Cancel</button>
			    </div>
		    </div>
		</div>
      </div>
    </div>
    <br/>
    <script>
	    $(document).ready(function(){
	    	var data = ('${data}' != null && '${data}' != '') ? JSON.parse('${data}') : '${data}';
	    	getDropDownList($('#prefix'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', data.prefix);
	  		getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', data.province);
	   		$('#userInfo #firstName').val(data.firstName);
			$('#userInfo #lastName').val(data.lastName);
			$('#userInfo #username').val(data.userId);
			$('#userInfo #address').val(data.address);
			$('#userInfo #postcode').val(data.postcode);
			$('#userInfo #mobile').val(parseSimFormat(data.mobile));
			$('#userInfo #email').val(data.email);
			$('#userInfo #postcode').mask('00000');
			$('#userInfo #mobile').mask('000-000-0000');
			$('#userInfo #line').val(data.line);
			$('#userInfo #website').val(data.website);
			$('#userInfo #nickname').val(data.nickName);
			$('#userInfo #email').blur(function(){
				if(!validateEmail($('#userInfo #email'))){
					$('#userInfo #email').next().html('รูปแบบ email ไม่ถูกต้อง');
				}	
			});
			$('#btn_cancel').click(function(){
				location.href = GetSiteRoot();
			});
			errMsg.user = {
				firstName: { id: $('#userInfo #firstName'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				lastName: { id: $('#userInfo #lastName'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				username: { id: $('#userInfo #username'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				address: { id: $('#userInfo #address'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				province: { id: $('#userInfo #province'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				postcode: { id: $('#userInfo #postcode'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				mobile: { id: $('#userInfo #mobile'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				email: { id: $('#userInfo #email'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
			};
			$('#btn_signup').click(function(){
				if(checkValidate('user')){
					var email = $('#userInfo #email').val().trim();
					if(!validateEmail($('#userInfo #email'))){
						$('#userInfo #email').parent().parent().addClass('has-error has-danger');
						$('#userInfo #email').next().html('รูปแบบ email ไม่ถูกต้อง');
					}else{
						$('#userInfo #email').next().html('');
						$('#userInfo #email').parent().parent().removeClass('has-error has-danger');
						var obj = { 
							firstName: $('#userInfo #firstName').val().trim(),
							lastName: $('#userInfo #lastName').val().trim(),
							userId: $('#userInfo #username').val().trim(),
							address: $('#userInfo #address').val().trim(),
							province: $('#userInfo #province').val().trim(),
							postcode: $('#userInfo #postcode').val().trim(),
							mobile: $('#userInfo #mobile').val().trim().replaceAll('-',''),
							email: email,
							prefix: $('#userInfo #prefix').val(),
							nickName: $('#userInfo #nickname').val(),
							website: $('#userInfo #website').val(),
							line: $('#userInfo #line').val()
						};
						sendPostAjax('/Profile/UpdateUser', obj, function(data){
							if(data == 1){
								$('.modal').modal('hide');
								alertModal('', 'Save User Successful.');
								$("#dialog-message").dialog({
									  modal: true,
									  buttons: {
										Ok: function() {
										  $(this).dialog("close");
										  	closeOverlay();		
										}
									 }
								});
							}
						});	
					}
				}
			});
	    });
    </script>
	</jsp:body>
</t:master>