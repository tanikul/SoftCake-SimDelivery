function sign_up(){
	 $('#signin').hide();
	 document.querySelectorAll('.ul_tabs > li')[0].className = ""; 
	 document.querySelectorAll('.ul_tabs > li')[1].className = "active"; 
	 var username = $('#loginModal #username');
	 var password = $('#loginModal #password');
	 username.parent().removeClass('has-error');
	 username.parent().find('.help-block').html('');
	 password.parent().removeClass('has-error');
	 password.parent().find('.help-block').html('');
	 getDropDownList($('#prefix'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', '');
	 getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', '');
		
	 $('.cont_centrar').width(800);
	 $('#loginModal').css('margin-left', '-375px').css('margin-top', '-100px');
	 $('#signup').show();
	 $('#loginModal').modal('show');
}

function sign_in(){
	 $('#signup').hide();
	 document.querySelectorAll('.ul_tabs > li')[0].className = "active"; 
	 document.querySelectorAll('.ul_tabs > li')[1].className = "";
	 var username = $('#loginModal #username');
	 var password = $('#loginModal #password');
	 username.parent().removeClass('has-error');
	 username.parent().find('.help-block').html('');
	 password.parent().removeClass('has-error');
	 password.parent().find('.help-block').html('');
	 $('.cont_centrar').width(320);
	 $('#loginModal').css('margin-left', '0px');
	 $('#signin').show(); 
	 $('#loginModal').modal('show');
}

openLogin = function(){
	$('#loginModal #username').parent().removeClass('has-error');
	$('#loginModal #username').parent().find('.help-block').html('');
	$('#loginModal #password').parent().removeClass('has-error');
	$('#loginModal #password').parent().find('.help-block').html('');
	sign_in();
}

errMsg.user = {
	firstName: { id: $('#signup #firstName'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	lastName: { id: $('#signup #lastName'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	username: { id: $('#signup #username'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	password: { id: $('#signup #password'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
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
		if(chk){
			$.ajax({
				url: GetSiteRoot() + '/j_spring_security_check',
				method: "POST",
				dataType: "json",
				data: {
					username: $('input[name="username"]').val(),
					password: $('input[name="password"]').val()
				},
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				beforeSend: function (xhr) {
					xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
				},
				cache: false,
				success: function (data) {console.log(data);
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
						}
					}
				}
			});
		}
	});
	
	$('#btn_signup').click(function(){
		if(checkValidate('user')){
			sendPostAjax('/User/CheckDuplicateUser', {userId: $('#signup #username').val()}, function(data){
				if(data == 1){
					$('#signup #username').next().html('Username นี้มีในระบบแล้ว');
				}else{
					var email = $('#signup #email').val().trim();
					if(!validateEmail($('#signup #email'))){
						$('#signup #email').next().html('รูปแบบ email ไม่ถูกต้อง');
					}	
					
					var obj = { firstName: $('#signup #firstName').val().trim(),
						lastName: $('#signup #lastName').val().trim(),
						userId: $('#signup #username').val().trim(),
						password: $('#signup #password').val().trim(),
						address: $('#signup #address').val().trim(),
						province: $('#signup #province').val().trim(),
						postcode: $('#signup #postcode').val().trim(),
						mobile: $('#signup #mobile').val().trim().replaceAll('-',''),
						email: email,
						prefix: $('#signup #prefix').val()
					};
					sendPostAjax('/User/Signup', obj, function(data){
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
			});
		}
	});
	
	$('#signup #username').blur(function(){
		sendPostAjax('/User/CheckDuplicateUser', {userId: this.value}, function(data){
			if(data == '1'){
				$('#signup #username').next().html('Username นี้มีในระบบแล้ว');
				$('#signup #username').parent().parent().addClass('has-error');
			}else{
				$('#signup #username').next().html('');
				$('#signup #username').parent().parent().removeClass('has-error');
			}
		});
	});
	$('#signup #email').blur(function(){
		if(!validateEmail($('#signup #email'))){
			$('#signup #email').next().html('รูปแบบ email ไม่ถูกต้อง');
		}	
	});
	$('#signup #postcode').mask('00000');
	$('#signup #mobile').mask('000-000-0000');
});

