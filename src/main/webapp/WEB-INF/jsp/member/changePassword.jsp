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
      		<i class="fas fa-key" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> แก้ไข Password
    	</h3>
      </div>
      <div class="panel-body">
        <div class="container-fluid form-horizontal" id="userInfo">
			<div class="form-group">
				<label class="col-sm-2 control-label">Old password</label>
				<div class="col-sm-4">
					<input type="password" id="oldPassword" class="form-control"/>
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">New password</label>
				<div class="col-sm-4">
					<input type="password" id="newPassword" class="form-control"/>
					<div class="help-block with-errors"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Confirm password</label>
				<div class="col-sm-4">
					<input type="password" id="confirmPassword" class="form-control"/>
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
	    	
			errMsg.password = {
				oldPassword: { id: $('#userInfo #oldPassword'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				newPassword: { id: $('#userInfo #newPassword'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				confirmPassword: { id: $('#userInfo #confirmPassword'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
			};
			$('#btn_signup').click(function(){
				if(checkValidate('password')){
					if($('#userInfo #newPassword').val().length < 8){
						$('#userInfo #newPassword').next().html('รหัสผ่านต้องมีความยาวมากกว่า 8 ตัวอักษร');
						$('#userInfo #newPassword').parent().parent().addClass('has-error has-danger');
					}else{
						if($('#userInfo #confirmPassword').val().trim() != $('#userInfo #newPassword').val().trim()){
							$('#userInfo #confirmPassword').parent().parent().addClass('has-error has-danger');
							$('#userInfo #confirmPassword').next().html('Pasword not match');
							$('#userInfo #newPassword').parent().parent().addClass('has-error has-danger');
							$('#userInfo #newPassword').next().html('Pasword not match');
						}else{
							$('#userInfo #confirmPassword').next().html('');
							$('#userInfo #confirmPassword').parent().parent().removeClass('has-error has-danger');
							$('#userInfo #newPassword').next().html('');
							$('#userInfo #newPassword').parent().parent().removeClass('has-error has-danger');
							
							var obj = { 
								oldPassword: $('#userInfo #oldPassword').val().trim(),
								newPassword: $('#userInfo #newPassword').val().trim()
							};
							sendPostAjax('/ChangePassword/UpdatePassword', obj, function(data){
								if(data == 1){
									$('.modal').modal('hide');
									alertModal('', 'บันทึกข้อมูลเรียบร้อย');
									$("#dialog-message").dialog({
										  modal: true,
										  buttons: {
											Ok: function() {
											  $(this).dialog("close");
											  	closeOverlay();		
											}
										 }
									});
								}else{
									$('.modal').modal('hide');
									alertModal('', 'old password ไม่ถูกต้อง');
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
				}
			});
			
			$('#btn_cancel').click(function(){
				$('#userInfo #confirmPassword').val('');
				$('#userInfo #oldPassword').val('');
				$('#userInfo #newPassword').val('');
				$('#userInfo #confirmPassword').next().html('');
				$('#userInfo #confirmPassword').parent().parent().removeClass('has-error has-danger');
				$('#userInfo #newPassword').next().html('');
				$('#userInfo #newPassword').parent().parent().removeClass('has-error has-danger');
			});
	    });
    </script>
	</jsp:body>
</t:master>