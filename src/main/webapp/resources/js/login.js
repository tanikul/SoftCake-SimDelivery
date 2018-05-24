function sign_up(){ 
	 $('#signin').hide();
	 $('#signup').show();
	 
	 document.querySelectorAll('.ul_tabs > li')[0].className = ""; 
	 document.querySelectorAll('.ul_tabs > li')[1].className = "active"; 
	 var username = $('#signup #username-signup');
	 var password = $('#signup #password-signup');
	 username.parent().removeClass('has-error');
	 username.parent().find('.help-block').html('');
	 password.parent().removeClass('has-error');
	 password.parent().find('.help-block').html('');
	 getDropDownList($('#prefix'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', '');
	 getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', '');
		
	 $('.modal-dialog').width(800);
	 //$('#loginModal').modal('show');
	 //$('#loginModal').css('margin-left', '-375px').css('margin-top', '100px');
	 //$('#loginModal').css('margin-left', '-375px');
	 //$('#loginModal').modal('hide');
	 /*$('#signup').show();
	 $('#loginModal').modal('show');*/
}

function sign_in(){
	 //$('#loginModal').modal('hide');
	 $('#signup').hide();
	 document.querySelectorAll('.ul_tabs > li')[0].className = "active"; 
	 document.querySelectorAll('.ul_tabs > li')[1].className = "";
	 var username = $('#signin #username');
	 var password = $('#signin #password');
	 username.parent().removeClass('has-error');
	 username.parent().find('.help-block').html('');
	 password.parent().removeClass('has-error');
	 password.parent().find('.help-block').html('');
	 //$('.cont_centrar').width(320);
	 //$('#loginModal').css('margin-left', '0px');
	 $('.modal-dialog').width(320);
	 $('#signin').show(); 
	 $('#loginModal').modal('show');
}

openLogin = function(){
	$('#signin #username').parent().removeClass('has-error');
	$('#signin #username').parent().find('.help-block').html('');
	$('#signin #password').parent().removeClass('has-error');
	$('#signin #password').parent().find('.help-block').html('');
	sign_in();
	//sign_up();
}

errMsg.user = {
	firstName: { id: $('#signup #firstName'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	lastName: { id: $('#signup #lastName'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	username: { id: $('#signup #username-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	password: { id: $('#signup #password-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	confirmPassword: { id: $('#signup #confirm-password-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	address: { id: $('#signup #address'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	province: { id: $('#signup #province'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	postcode: { id: $('#signup #postcode'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	mobile: { id: $('#signup #mobile'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	email: { id: $('#signup #email'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
};

$(document).ready(function(){
	if($('body').find('.cont_centrar').length > 0){
		document.querySelector('.cont_centrar').className = "cont_centrar cent_active";
	}
	
	$('#btn_signin').click(function(){
		var $form = $('#loginForm');
		var username = $('#signin #username');
		var password = $('#signin #password');
		var chk = true;
		if(username.val().trim() == ''){
			username.parent().addClass('has-error');
			username.parent().find('.help-block').html('กรุณากรอก username');
			chk = false;
			username.keyup(function(){
				username.parent().removeClass('has-error');
				username.parent().find('.help-block').html('');
			});
		}else{
			username.parent().removeClass('has-error');
			username.parent().find('.help-block').html('');
		}
		if(password.val().trim() == ''){
			password.parent().addClass('has-error');
			password.parent().find('.help-block').html('กรุณากรอก password');
			chk = false;
		}else{
			password.parent().removeClass('has-error');
			password.parent().find('.help-block').html('');
			password.keyup(function(){
				password.parent().removeClass('has-error');
				password.parent().find('.help-block').html('');
			});
		}
		if(grecaptcha.getResponse(recaptcha1) == ''){
			$('#signin #captcha1').parent().find('.help-block').html('กรุณายืนยันตัวตน');
			chk = false;
		}else{
			$('#signin #captcha1').parent().find('.help-block').html('');
		}
		if(chk){
			$.ajax({
				url: GetSiteRoot() + '/j_spring_security_check',
				method: "POST",
				dataType: "json",
				data: {
					username: $('input[name="username"]').val(),
					password: $('input[name="password"]').val(),
					recaptcha: grecaptcha.getResponse(recaptcha1) 
				},
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				beforeSend: function (xhr) {
					xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
				},
				cache: false,
				success: function (data) {
					if(data.programType == 'ADMIN'){
						location.href = GetSiteRoot() + data.redirect;
					}else{
						location.reload();
					}
				},
				error: function (jqXHR, textStatus, errorThrown) {
					if(jqXHR.status !== 200){
						if(typeof jqXHR.statusText != 'undefined'){
							$('#display_error').html(jqXHR.responseText);
							grecaptcha.reset();
						}
					}
				}
			});
		}
	});
	
	$('#btn_signup').click(function(){
		if(checkValidate('user')){
			var chk = true;
			if(grecaptcha.getResponse(recaptcha2) == ''){
				$('#signup #captcha2').parent().find('.help-block').html('กรุณายืนยันตัวตน');
				chk = false;
			}else{
				$('#signup #captcha2').parent().find('.help-block').html('');
			}
			if($('#signup #username-signup').val().length < 8){
				$('#signup #username-signup').next().html('รหัสผ่านต้องมีความยาวมากกว่า 8 ตัวอักษร');
				$('#signup #username-signup').parent().parent().addClass('has-error has-danger');
				chk = false;
			}
			if($('#signup #password-signup').val().length < 8){
				$('#signup #password-signup').next().html('รหัสผ่านต้องมีความยาวมากกว่า 8 ตัวอักษร');
				$('#signup #password-signup').parent().parent().addClass('has-error has-danger');
				chk = false;
			}
			if(!chk) return false;
			if($('#signup #confirm-password-signup').val() != $('#signup #password-signup').val()){
				$('#signup #password-signup').next().html('รหัสผ่านไม่ตรงกัน');
				$('#signup #confirm-password-signup').next().html('รหัสผ่านไม่ตรงกัน');
				$('#signup #password-signup').parent().parent().addClass('has-error has-danger');
				$('#signup #confirm-password-signup').parent().parent().addClass('has-error has-danger');
			}else{
				$('#signup #password-signup').next().html('');
				$('#signup #confirm-password-signup').next().html('');
				$('#signup #password-signup').parent().parent().addClass('');
				$('#signup #confirm-password-signup').parent().parent().addClass('');
				if($('#confirm').is(":checked") == false){
					$('#confirm').parent().next().html('กรุณาเลือกที่ช่องยอมรับเงื่อนไข');
					return false;
				}
				$('#confirm').parent().next().html('');
				sendPostAjaxWithoutLoading('/User/CheckDuplicateUser', {userId: $('#signup #username-signup').val()}, function(data){
					if(data == 1){
						$('#signup #username-signup').next().html('Username นี้มีในระบบแล้ว');
					}else{
						sendPostAjaxWithoutLoading('/User/CheckDuplicateEmail', {email: $('#signup #email').val()}, function(data){
							if(data == 1){
								$('#signup #email').next().html('Email นี้มีในระบบแล้ว');
								$('#signup #email').parent().parent().addClass('has-error');
							}else{
								$('#signup #email').next().html('');
								$('#signup #email').parent().parent().removeClass('has-error');
								var email = $('#signup #email').val().trim();
								if(!validateEmail($('#signup #email'))){
									$('#signup #email').parent().parent().addClass('has-error has-danger');
									$('#signup #email').next().html('รูปแบบ email ไม่ถูกต้อง');
								}else{
									$('#signup #email').next().html('');
									$('#signup #email').parent().parent().removeClass('has-error has-danger');
									var obj = { firstName: $('#signup #firstName').val().trim(),
										lastName: $('#signup #lastName').val().trim(),
										userId: $('#signup #username-signup').val().trim(),
										password: $('#signup #password-signup').val().trim(),
										address: $('#signup #address').val().trim(),
										province: $('#signup #province').val().trim(),
										postcode: $('#signup #postcode').val().trim(),
										mobile: $('#signup #mobile').val().trim().replaceAll('-',''),
										email: email,
										prefix: $('#signup #prefix').val(),
										nickName: $('#signup #nickname').val(),
										website: $('#signup #website').val(),
										line: $('#signup #line').val()
									};
									var re = { user: obj, recaptcha: grecaptcha.getResponse(recaptcha2) };
									sendPostAjax('/User/Signup', re, function(data){
										if(data == 1){
											$('.modal').modal('hide');
											alertModal('', 'กรุณายืนยันตัวตนของท่านที่ Email ' + email);
											$("#dialog-message").dialog({
												  modal: true,
												  buttons: {
													Ok: function() {
													  $(this).dialog("close");
													  closeOverlay();
													  //location.href = GetSiteRoot() + '/MasterSetup/Client';
													}
												  }
											});
										}
									});	
								}
							}
						});
					}
				});
			}
		}
	});
	
	$('#signup #username-signup').blur(function(){
		sendPostAjaxWithoutLoading('/User/CheckDuplicateUser', {userId: this.value}, function(data){
			if(data == '1'){
				$('#signup #username-signup').next().html('Username นี้มีในระบบแล้ว');
				$('#signup #username-signup').parent().parent().addClass('has-error');
			}else{
				$('#signup #username-signup').next().html('');
				$('#signup #username-signup').parent().parent().removeClass('has-error');
			}
		});
	});
	
	$('#signup #password-signup').blur(function(){
		if($('#signup #password-signup').val().length < 8){
			$('#signup #password-signup').next().html('รหัสผ่านต้องมีความยาวมากกว่า 8 ตัวอักษร');
			$('#signup #password-signup').parent().parent().addClass('has-error has-danger');
		}else{
			$('#signup #password-signup').next().html('');
			$('#signup #password-signup').parent().parent().removeClass('has-error has-danger');
		}
	});
	
	$('#signup #email').blur(function(){
		if(!validateEmail($('#signup #email'))){
			$('#signup #email').next().html('รูปแบบ email ไม่ถูกต้อง');
			$('#signup #email').parent().parent().addClass('has-error');
		}else{
			$('#signup #email').next().html('');
			$('#signup #email').parent().parent().removeClass('has-error');
			sendPostAjaxWithoutLoading('/User/CheckDuplicateEmail', {email: this.value}, function(data){
				if(data == 1){
					$('#signup #email').next().html('Email นี้มีในระบบแล้ว');
					$('#signup #email').parent().parent().addClass('has-error');
				}else{
					$('#signup #email').next().html('');
					$('#signup #email').parent().parent().removeClass('has-error');
				}
			});
		}	
	});
	
	$('#forgot-submit-btn').click(function(){
		errMsg.email = {
			email: { id: $('#forgot-email'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
		};
		if(checkValidate('email')){
			if(!validateEmail($('#forgot-email'))){
				$('#forgot-email').next().html('รูปแบบ email ไม่ถูกต้อง');
				$('#forgot-email').parent().addClass('has-error');
			}else{
				$('#forgot-email').next().html('');
				$('#forgot-email').parent().removeClass('has-error');
				if(grecaptcha.getResponse(recaptcha3) == ''){
					$('#forgotPassword #captcha3').parent().find('.help-block').html('กรุณายืนยันตัวตน');
					chk = false;
				}else{
					$('#forgotPassword #captcha3').parent().find('.help-block').html('');
					sendPostAjax('/User/ForgotPassword', {email : $('#forgot-email').val(), recaptcha: grecaptcha.getResponse(recaptcha3)}, function(data){
						$('#forgotPassword').modal('hide');
						if(data == 1){
							alertModal('', 'กรุณาตรวจสอบลิ้งค์ reset password ของท่านที่ email ' + $('#forgot-email').val());
						}else{
							alertModal('', 'Email ที่ท่านระบุไม่มีในระบบ กรุณาตรวจสอบอีเมล์ของท่านอีกครั้ง');
						}
					});
				}	
			}
		}
	});
	$('#signup #postcode').mask('00000');
	$('#signup #mobile').mask('000-000-0000');
});

forgotPassword = function(){
	$('.modal-dialog').css('width','');
	$('#loginModal').modal('hide');
	$('#forgotPassword').modal('show');
}

