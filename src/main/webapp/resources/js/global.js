Global = function(){
	
	this.contextPath = function(){
		var loc = window.location;
	    var pathName = loc.pathname.substring(0, loc.pathname.lastIndexOf('/') + 1);
	    return loc.href.substring(0, loc.href.length - ((loc.pathname + loc.search + loc.hash).length - pathName.length));
	};
}

var global = new Global();

var urlValidate = [];
var addNewTxt = '';
var addNewIdModal = '';

var errMsg = {
	instruction : {
		corporationCode: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		client: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		instructionName: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		level: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		memberAccount: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		masterAccount: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		min: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'], exceptBlur : true },
		max: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'], exceptBlur : true },
		sweepRate: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		deficitRate: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		priority: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		effectiveDate: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
	},
	client : {
		corporationCode: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		clientCode: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		clientName: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		cisId: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'], exceptBlur : true }
	},
	account : {
		corporationCode: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		clientCode: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
		accountNo: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'], exceptBlur : true },
		accountLevel: { rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] }
	}
};

var listTab = new Array();
var searchMenu = '';
function sendPostAjax(url, params, funcName){
	$.ajax({
		url: GetSiteRoot() + url,
		method: "POST",
		dataType: "json",
		data: JSON.stringify(params),
		contentType: "application/json; charset=utf-8",
		beforeSend: function (xhr) {
			xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
			$.LoadingOverlay("show");
		},
		cache: false,
		success: function (data) {
			$.LoadingOverlay("hide");
			if(data.hasOwnProperty('success') && data.hasOwnProperty('message')){
				if(!data.success){
					$("#dialog-confirm").dialog('close');
					$("#dialog-message").dialog('close');
					alertModal('Warning', data.message);
					$('.tooltip').remove();
				}else{
					$("#dialog-confirm").dialog('close');
					$("#dialog-message").dialog('close');
					alertModal('Alert', data.message);
					$('.tooltip').remove();
				}
			}else if(typeof funcName == 'function'){
				funcName(data);
			}
			$('.tooltip').remove();
		},
		error: function (jqXHR, textStatus, errorThrown) {
			$.LoadingOverlay("hide");
			if(jqXHR.status !== 200){
				if(typeof jqXHR.responseJSON != 'undefined'){
					if(typeof jqXHR.responseJSON.errorMessage != 'undefined'){
						if(jqXHR.responseJSON.errorMessage.toUpperCase() == 'JAVAX.SERVLET.SERVLETEXCEPTION: INVALIDAUTHORIZATIONTOKEN' || 
								jqXHR.responseJSON.errorMessage.toUpperCase() == 'INVALIDAUTHORIZATIONTOKEN'){
							 $("#logoutForm").submit();
							 return false;
						}
						$('.modal').modal('hide');
						$("#dialog-confirm").dialog('close');
						$("#dialog-message").dialog('close');
						alertModal('Warning', jqXHR.responseJSON.errorMessage);
						$('.tooltip').remove();
					}
				}else{
					if(typeof jqXHR.statusText != 'undefined'){
						$('.modal').modal('hide');
						$("#dialog-confirm").dialog('close');
						$("#dialog-message").dialog('close');
						alertModal('Error', jqXHR.status + ' ' +  jqXHR.statusText);
						$('.tooltip').remove();
					}
				}
			}
		}
	});
}

function sendGetAjax(url, funcName){
	$.ajax({
		url: GetSiteRoot() + url,
		method: "GET",
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		cache: false,
		beforeSend: function (xhr) {
			xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
		},
		success: function (data) {
			if(data.hasOwnProperty('success') && data.hasOwnProperty('message')){
				if(!data.success){
					$('.modal').modal('hide');
					$("#dialog-confirm").dialog('close');
					$("#dialog-message").dialog('close');
					alertModal('Warning', data.message);
					$('.tooltip').remove();
				}else{
					$('.modal').modal('hide');
					$("#dialog-confirm").dialog('close');
					$("#dialog-message").dialog('close');
					alertModal('Alert', data.message);
					$('.tooltip').remove();
				}
			}else if(typeof funcName == 'function'){
				funcName(data);
			}
			$('.tooltip').remove();
		},
		error: function (jqXHR, textStatus, errorThrown) {console.log(jqXHR);
			if(jqXHR.status !== 200){
				if(typeof jqXHR.responseJSON != 'undefined'){
					if(typeof jqXHR.responseJSON.errorMessage != 'undefined'){
						if(jqXHR.responseJSON.errorMessage.toUpperCase() == 'JAVAX.SERVLET.SERVLETEXCEPTION: INVALIDAUTHORIZATIONTOKEN' ||
								jqXHR.responseJSON.errorMessage.toUpperCase() == 'INVALIDAUTHORIZATIONTOKEN'){
							 $("#logoutForm").submit();
							 return false;
						}
						$("#dialog-confirm").dialog('close');
						$("#dialog-message").dialog('close');
						alertModal('Warning', jqXHR.responseJSON.errorMessage);
						$('.tooltip').remove();
					}
				}else{
					if(typeof jqXHR.statusText != 'undefined'){
						$("#dialog-confirm").dialog('close');
						$("#dialog-message").dialog('close');
						alertModal('Error', jqXHR.status + ' ' + jqXHR.statusText);
						$('.tooltip').remove();
					}
				}
			}
		}
	});
}

function sendPostAjaxWithoutLoading(url, params, funcName){
	$.ajax({
		url: GetSiteRoot() + url,
		method: "POST",
		dataType: "json",
		data: JSON.stringify(params),
		contentType: "application/json; charset=utf-8",
		beforeSend: function (xhr) {
			xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
		},
		cache: false,
		success: function (data) {
			$.LoadingOverlay("hide");
			if(data.hasOwnProperty('success') && data.hasOwnProperty('message')){
				if(!data.success){
					$("#dialog-confirm").dialog('close');
					$("#dialog-message").dialog('close');
					alertModal('Warning', data.message);
					$('.tooltip').remove();
				}else{
					$("#dialog-confirm").dialog('close');
					$("#dialog-message").dialog('close');
					alertModal('Alert', data.message);
					$('.tooltip').remove();
				}
			}else if(typeof funcName == 'function'){
				funcName(data);
			}
			$('.tooltip').remove();
		},
		error: function (jqXHR, textStatus, errorThrown) {
			$.LoadingOverlay("hide");
			if(jqXHR.status !== 200){
				if(typeof jqXHR.responseJSON != 'undefined'){
					if(typeof jqXHR.responseJSON.errorMessage != 'undefined'){
						if(jqXHR.responseJSON.errorMessage.toUpperCase() == 'JAVAX.SERVLET.SERVLETEXCEPTION: INVALIDAUTHORIZATIONTOKEN' || 
								jqXHR.responseJSON.errorMessage.toUpperCase() == 'INVALIDAUTHORIZATIONTOKEN'){
							 $("#logoutForm").submit();
							 return false;
						}
						$('.modal').modal('hide');
						$("#dialog-confirm").dialog('close');
						$("#dialog-message").dialog('close');
						alertModal('Warning', jqXHR.responseJSON.errorMessage);
						$('.tooltip').remove();
					}
				}else{
					if(typeof jqXHR.statusText != 'undefined'){
						$('.modal').modal('hide');
						$("#dialog-confirm").dialog('close');
						$("#dialog-message").dialog('close');
						alertModal('Error', jqXHR.status + ' ' +  jqXHR.statusText);
						$('.tooltip').remove();
					}
				}
			}
		}
	});
}

function GetSiteRoot() {
    var rootPath = window.location.protocol + "//" + window.location.host;
    console.log(rootPath);
    if (window.location.hostname == "localhost") {
        var path = window.location.pathname;
        if (path.indexOf("/") == 0) {
            path = path.substring(1);
        }
        
        path = path.split("/", 1);
        if (path != "") {
            rootPath = rootPath + "/" + path;
        }
    }else{
    	/*var web = window.location.pathname.split("/", 2);
    	console.log(window.location.pathname);
    	console.log(web);
    	rootPath = rootPath + '/' + web[1];
    	console.log(rootPath);*/
    	rootPath = 'https://vipsim.co';
    }
    return rootPath;
}

function displayErrorAjax(jqXHR, textStatus, errorThrown){
	 $("#dialog-confirm").dialog('close');
	 $("#dialog-message").dialog('close');
	 $.LoadingOverlay("hide");
	 $('.tooltip').remove();
	 if(jqXHR.status == 500){
		 if(typeof jqXHR.responseJSON != 'undefined'){
			 if(typeof jqXHR.responseJSON.errorMessage != 'undefined'){
				 if(jqXHR.responseJSON.errorMessage.toUpperCase() == 'JAVAX.SERVLET.SERVLETEXCEPTION: INVALIDAUTHORIZATIONTOKEN' || 
						 jqXHR.responseJSON.errorMessage.toUpperCase() == 'INVALIDAUTHORIZATIONTOKEN'){
					 $("#logoutForm").submit();
					 return false;
				 }
				 alertModal('Error', jqXHR.responseJSON.errorMessage);
				 $('.tooltip').remove();
			}
		}
	 }else{
		 alertModal('Error', jqXHR.statusText);
		 $('.tooltip').remove();
	 }
}

function checkErrorTokenAjax(jqXHR, textStatus, errorThrown){
	 if(jqXHR.status == 500){
		 if(typeof jqXHR.responseJSON != 'undefined'){
			 if(typeof jqXHR.responseJSON.errorMessage != 'undefined'){
				 if(jqXHR.responseJSON.errorMessage.toUpperCase() == 'JAVAX.SERVLET.SERVLETEXCEPTION: INVALIDAUTHORIZATIONTOKEN' || 
						 jqXHR.responseJSON.errorMessage.toUpperCase() == 'INVALIDAUTHORIZATIONTOKEN'){
					 $("#logoutForm").submit();
					 return false;
				 }
			}
		}
	 }
}
