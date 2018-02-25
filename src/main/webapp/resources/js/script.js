function signOut(){
	sendPostAjax('/Logout', '', function(data){
		if(data == 1){
			window.location.href = GetSiteRoot();
		}
	});
}

alertModal = function(title, msg){
	
	if(title == null || title == ''){
		title = 'Alert'
	}
	var str = '<div id="dialog-message" title="' + title + '">';
	str += msg + '</div>';
	$('body').find('#dialog-message').remove();
	$('body').append(str);
	
	
	//openOverlay();
	$("#dialog-message").dialog({
	  modal: true,
	  width:'auto',
	  draggable: true,
	  resizable: false,
	  buttons: {
		Ok: function() {
		  $(this).dialog("close");
		  closeOverlay();
		}
	  },
	  close: function( event, ui ) { closeOverlay(); }
	});
}

alertModalRedirectToPage = function(title, msg,urlPage){
	
	if(title == null || title == ''){
		title = 'Alert'
	}
	var str = '<div id="dialog-message" title="' + title + '">';
	str += msg + '</div>';
	$('body').find('#dialog-message').remove();
	$('body').append(str);
	
	
	//openOverlay();
	$("#dialog-message").dialog({
	  modal: true,
	  width:'auto',
	  draggable: true,
	  resizable: false,
	  buttons: {
		Ok: function() {
		  $(this).dialog("close");
		  closeOverlay();
		  window.location.href = urlPage;
		}
	  },
	  close: function( event, ui ) { closeOverlay(); }
	});
}

function openOverlay(){
	$('body').append('<div class="overlay" id="overlay" style="display:none;"></div>');
	$('#overlay').fadeIn('fast',function(){});
}

function closeOverlay(){
	$('#overlay').fadeOut('fast',function(){});
	$('body').find('#overlay').remove();
}

function convertStringToPhone(str){
	return str.slice(0, 3, '-') + str.slice(3, 6, '-') + str.slice(6, 10, '-');
}

function getDropDownList (obj, title, url, key, value, selected, disabled){
	sendGetAjax(url, function(data){
		var str = '';
		if(typeof selected == 'undefined'){
			$(data).each(function(i, item){
				str += '<option value="' + item[key] + '">' + item[value] + '</option>';
			});
		}else{
			$(data).each(function(i, item){
				var sel = (item[key] == selected) ? 'selected' : '';
				str += '<option value="' + item[key] + '"' + sel + '>' + item[value] + '</option>';
			});
		}

		$(obj).html('');
		if(title != '' && title != null){
			str = '<option value="">' + title + '</option>' + str;
		}
		$(obj).append(str);
		if(disabled){
			$('.selectpicker').attr('disabled',true).selectpicker('refresh');
		}else{
			$('.selectpicker').selectpicker('refresh');
		}
		
		if(typeof disabled == 'undefined'){
			if($(obj).is(':disabled')){
				$(obj).removeAttr('disabled');
			}
		}else if(disabled){
			$(obj).attr('disabled','disabled');
			if($(obj).prev().prev().hasClass('btn-default-select')){
				$(obj).prev().prev().attr('disabled','disabled');
			}
		}else if(!disabled){
			$(obj).removeAttr('disabled');
		}
		
	});		
}

function getDropDownListNonMapText (obj, title, url, key, value, selected, disabled){
	sendGetAjax(url, function(data){
		var str = '';
		if(typeof selected == 'undefined'){
			$(data).each(function(i, item){
				str += '<option value="' + item[key] + '">' + item[value] + '</option>';
			});
		}else{
			$(data).each(function(i, item){
				var sel = (item[key] == selected) ? 'selected' : '';
				str += '<option value="' + item[key] + '"' + sel + '>' + item[value] + '</option>';
			});
		}
		
		$(obj).html('');
		if(title != '' || title != null){
			str = '<option value="">' + title + '</option>' + str;
		}
		$(obj).append(str);
		$('.selectpicker').selectpicker('refresh');

		if(typeof disabled == 'undefined'){
			if($(obj).is(':disabled')){
				$(obj).removeAttr('disabled');
			}
		}else if(disabled){
			$(obj).attr('disabled','disabled');
			if($(obj).prev().prev().hasClass('btn-default-select')){
				$(obj).prev().prev().attr('disabled','disabled');
			}
		}else if(!disabled){
			$(obj).removeAttr('disabled');
		}
		
	});		
}

function truncateDate(date) {
  return new Date(date.getFullYear(), date.getMonth(), date.getDate());
}

function checkValidate(type){
	var chk = true;
	for(var x in errMsg[type]){
		var rule = errMsg[type][x].rule;
		var msg = errMsg[type][x].msg;
		var url = errMsg[type][x].url;
		var divTmp = errMsg[type][x].id;
		$(divTmp).each(function(i, div){
			if(!$(div).is(':disabled')){
				for(var j = 0; j < rule.length; j++){
					if(typeof rule[j] == 'string'){
						if(rule[j] == 'require'){
							if($(div).val() == ''){
								if($(div).parent().hasClass('form-group')){
									$(div).parent().addClass('has-error has-danger');
									$(div).next().html('<ul class="list-unstyled"><li>' + msg[j] + '</li></ul>');
									if(typeof errMsg[type][x].exceptBlur != 'boolean'){
										$(div).on('blur', function(){
											if($(this).val() != ''){
												$(this).parent().removeClass('has-error has-danger');
												$(this).next().html('');
											}
										});
									}
								}else if($(div).parent().parent().hasClass('form-group')){
									$(div).parent().parent().addClass('has-error has-danger');
									if($(div).next().hasClass('form-group')){
										$(div).parent().next().html('<ul class="list-unstyled"><li>' + msg[j] + '</li></ul>');
										if(typeof errMsg[type][x].exceptBlur != 'boolean'){
											$('.bootstrap-select').on('change', function(){
												var selectVal = $(this).find('select').val();
																					
												if(selectVal != ''){
													$(this).parent().removeClass('has-error has-danger');
													$(this).next().html('');
												}
											});
										}
									}else if($(div).parent().next().hasClass('help-block')){
										$(div).parent().next().html('<ul class="list-unstyled"><li>' + msg[j] + '</li></ul>');
										if(typeof errMsg[type][x].exceptBlur != 'boolean'){
											$('.bootstrap-select').on('change', function(){
												var selectVal = $(this).find('select').val();
																					
												if(selectVal != ''){
													$(this).parent().removeClass('has-error has-danger');
													$(this).next().html('');
												}
											});
										}	
									}else{
										$(div).next().html('<ul class="list-unstyled"><li>' + msg[j] + '</li></ul>');
										if(typeof errMsg[type][x].exceptBlur != 'boolean'){
											$(div).on('blur', function(){
												if($(this).val() != ''){
													$(this).parent().parent().removeClass('has-error has-danger');
													$(this).next().html('');
												}
											});
										}
									}
								}/*else if($(div).parent().parent().hasClass('form-group')){
									$(div).parent().parent().addClass('has-error has-danger');
									$(div).next().html('<ul class="list-unstyled"><li>' + msg[j] + '</li></ul>');
									if(typeof errMsg[type][x].exceptBlur != 'boolean'){
										$(div).on('blur', function(){
											if($(this).val() != ''){
												$(this).parent().parent().removeClass('has-error has-danger');
												$(this).next().html('');
											}
										});
									}
								}*/
								chk = false;
							}
						}
					}
				}
			}
			if($(div).parent().hasClass('has-error')){
				chk = false;
			}
		});
	}
	return chk;
}

function parseCommas(str){
	if(str == null || str == ''){
		str = '0';
	}
	return parseFloat(str.replace(/,/g , ""));
}

confirmModal = function(title, msg){
	if(title == null || title == ''){
		title = 'Confirm Alert'
	}
	var str = '<div id="dialog-confirm" title="' + title + '" style="display:none;">';
	str += '<p><span class="ui-icon ui-icon-alert" style="float:left; margin:2px 12px 11px 0;"></span>' + msg + '</p>';
	str += '</div>';
	$('body').find('#dialog-confirm').remove();
	$('body').append(str);
}

function validateEmail(obj){
	var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test($(obj).val());
}
