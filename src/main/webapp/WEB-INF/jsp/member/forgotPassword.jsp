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
      		<i class="fas fa-key" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> Reset Password
    	</h3>
      </div>
      <div class="panel-body">
        <div class="container-fluid form-horizontal" id="resetPassword">
			<div class="form-group">
				<label class="col-sm-2 control-label">Username</label>
				<div class="col-sm-4">
					<input type="text" id="userId" class="form-control" value="${user.userId}"disabled="disabled"/>
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
			     	<button class="btn btn-primary" id="save">Save</button>
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
				userId: { id: $('#resetPassword #userId'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				newPassword: { id: $('#resetPassword #newPassword'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				confirmPassword: { id: $('#resetPassword #confirmPassword'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
			};
			$('#save').click(function(){
				if(checkValidate('password')){
					if($('#resetPassword #newPassword').val().length < 8){
						$('#resetPassword #newPassword').next().html('รหัสผ่านต้องมีความยาวมากกว่า 8 ตัวอักษร');
						$('#resetPassword #newPassword').parent().parent().addClass('has-error has-danger');
					}else{
						$('#resetPassword #newPassword').next().html('');
						$('#resetPassword #newPassword').parent().parent().removeClass('has-error has-danger');
						if($('#resetPassword #confirmPassword').val().trim() != $('#resetPassword #newPassword').val().trim()){
							$('#resetPassword #confirmPassword').parent().parent().addClass('has-error has-danger');
							$('#resetPassword #confirmPassword').next().html('Pasword not match');
							$('#resetPassword #newPassword').parent().parent().addClass('has-error has-danger');
							$('#resetPassword #newPassword').next().html('Pasword not match');
						}else{
							$('#resetPassword #confirmPassword').next().html('');
							$('#resetPassword #confirmPassword').parent().parent().removeClass('has-error has-danger');
							$('#resetPassword #newPassword').next().html('');
							$('#resetPassword #newPassword').parent().parent().removeClass('has-error has-danger');
							
							var obj = { 
								userId: $('#resetPassword #userId').val().trim(),
								password: $('#resetPassword #newPassword').val().trim()
							};
							sendPostAjax('/ForgotPassword/SaveResetPassword', obj, function(data){
								if(data == 1){
									$('.modal').modal('hide');
									alertModal('', 'บันทึกข้อมูลเรียบร้อย');
									$("#dialog-message").dialog({
										  modal: true,
										  buttons: {
											Ok: function() {
											  $(this).dialog("close");
											  	closeOverlay();
											  	window.location = global.contextPath();
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
				$('#resetPassword #confirmPassword').val('');
				$('#resetPassword #oldPassword').val('');
				$('#resetPassword #newPassword').val('');
				$('#resetPassword #confirmPassword').next().html('');
				$('#resetPassword #confirmPassword').parent().parent().removeClass('has-error has-danger');
				$('#resetPassword #newPassword').next().html('');
				$('#resetPassword #newPassword').parent().parent().removeClass('has-error has-danger');
			});
	    });
    </script>
	</jsp:body>
</t:master>