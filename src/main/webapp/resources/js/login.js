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
	var $form = $('#loginForm');
	$form.bind('submit', function(e) {
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
		if(!chk){
			$form.unbind('submit');
			e.preventDefault();
			return false;
		}
	});
	
	$('#btn_signup').click(function(){
		if(checkValidate('user')){
			var obj = { firstName: $('#signup #firstName').val(),
				lastName: $('#signup #lastName').val(),
				userId: $('#signup #username').val(),
				password: $('#signup #password').val(),
				address: $('#signup #address').val(),
				province: $('#signup #province').val(),
				postcode: $('#signup #postcode').val(),
				mobile: $('#signup #mobile').val(),
				email: $('#signup #email').val()
			};
			sendPostAjax('/User/Signup', obj, function(data){
				if(data == 1){
					alertModal('', 'กรุณายืนยัน Email');
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
});

