<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="role.maker" var="maker"/>
<spring:message code="role.viewer" var="viewer"/>
<t:master>
	<jsp:body>
		<div class="content-wrapper">
			<section class="content-header">
				<h1 class="page-header">
					<i class="fa fa-address-book-o"></i>&nbsp;&nbsp; <label for="roleTitle" style="vertical-align: middle" ></label>
				</h1>
			</section>
			 <input type="hidden" id="roleGroup" value=""> 
		   	 <input type="hidden" id="roleTitle" value="Role and Privilege"> 
			<section class="content">
		
				<!-- left column -->
				<div class="row">
				<div class="col-md-12">
					<!-- programPrivilege info form elements -->
					<div class="box box-success" id="programPrivilege">
						<div class="box-body">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>Role Name: <span class="mandatory">*</span></label>
										<input type="text" class="form-control" id="roleNameText" maxlength="255" />
										<div class="help-block with-errors"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="box-header">
							<h3 class="box-title">Privilege</h3>
						</div>
		
						<div class="box-body">
							<table id="privilegeTbl" class="table table-bordered table-striped" >
								<thead>
									<tr style="background:#def2e9" >
										<th width="50%">Program</th>
										<th width="10%">None</th>
										<th width="10%">View</th>
										<th width="15%">Add/Edit/Delete</th>
										<th width="15%">Approve/Reject</th>
										<th>GroupLevel</th>
									</tr>
								</thead>
		
							</table>
						</div>
					</div>
					
							<!-- Customer info form elements -->
					<div class="box box-success" id="userPrivilegeBox">
						<div class="box-header">
							<h3 class="box-title">User</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
								<table id="userTbl" class="table table-bordered table-striped" >
									<thead>
										<tr style="background:#def2e9" >
											<th style="text-align: center;">No</th>
											<th style="text-align: center;">User ID</th>
											<th style="text-align: center;">First name</th>
											<th style="text-align: center;">Last name</th>
										</tr>
									</thead>
								</table>
						</div>
					</div>
					<div class="row">
						<div class="box-body">
							<c:choose>
								<c:when test="${role eq maker}">
									<button class="btn btn-success" id="save-btn" style="width: 100px;" disabled="disabled">Save</button>
									<button class="btn btn-default" id="cancel-bnt" style="width: 100px;">Cancel</button>
								</c:when>
								<c:otherwise>
									<button class="btn btn-default" id="cancel-bnt" style="width: 100px;">Back</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
		
				</div>
				</div>
		
			</section>
		</div>
		
		<script type="text/javascript">
			errMsg.addRole = {
				roleName: { id: $('#roleNameText'), rule : ['require'], msg : ['Please input your role name']}
			};
			
			var oldValueSearch = '';
			var oldKeySearch = '';
			var programList = [];
			var parameter = {};
			var roleMode = '${roleMode}';
			var roleId = '${roleId}';
			var roleName = '${roleName}';
			roleName = decodeURIComponent(escape(roleName));
			$('#roleGroup').val('${roleGroup}');
			
		//	if('${role}' == '<spring:message code="role.maker" />'){
				$('#add-data').show();
		//	}
		
			function searchUserByUserRole(pUserName) {		
				var vRoleGroup = $('#roleGroup').val();
				var params = {
					userId : pUserName,
					userRole: roleId
				}
				if ($.fn.DataTable.isDataTable('#userTbl')) {
					$('#userTbl').DataTable().destroy();
				}
				$('#userTbl tbody').empty();
				addNewIdModal = 'AddRoleAndPrivilege';
				var url = '';
				if(vRoleGroup == 'BANK'){
					url = '/UserManagement/RolePrivilege/SearchUserByUserRole';	
				}else{
					url = '/MasterSetup/RolePrivilege/SearchUserByUserRole';
				}
				
				var table = $('#userTbl').DataTable(
				{
					"searching" : true,
					"processing" : true,
					"serverSide" : true,
					"ajax" : {
						"contentType" : "application/json; charset=utf-8",
						"dataType" : "json",
						"crossDomain" : true,
						"beforeSend" : function(xhr) {
							xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
							checkTimeOut();
						},
						"data" : function(d) {
							d.dataSearch = params;
						},
						"url" : GetSiteRoot() + url,
						"type" : "POST",
						"error" : function(jqXHR, textStatus, errorThrown) {
							$("#dialog-confirm").dialog('close');
							 $("#dialog-message").dialog('close');
							 closeOverlay();
							 $('.tooltip').remove();
							 if(typeof jqXHR.responseJSON != 'undefined'){
								 if(typeof jqXHR.responseJSON.errorMessage != 'undefined'){
									 $("#dialog-confirm").dialog('close');
									 $("#dialog-message").dialog('close');
									 alertModal('Warning', jqXHR.responseJSON.errorMessage);
									 $("#dialog-message").dialog({
										  modal: true,
										  buttons: {
											Ok: function() {
											  $(this).dialog("close");
											  closeOverlay();
											}
										  },
										  close: function(){
											  closeOverlay();
										  }
									});
								}
							}
						}
					},
					"columns" : [
						{"data" : "userId"},
						{"data" : "userId"},
						{"data" : "firstName"},
						{"data" : "lastName"}
					],
					"initComplete" : function(settings, json) {
						$(json.data).each(function(i, item) {
							if (item.no == 1) {
								json.data[i].no = 10;
							}
						});
						if (settings.oFeatures.bFilter) {
							displaySearchGroup(settings.sTableId, this.value, oldValueSearch);
						}
					},
					"drawCallback" : function() {
						setHeightSideBar();
					},
					"columnDefs" : [ 
						{ "targets" : [0, 3], "orderable" : false }, 
						{ "className" : "dt-left", "targets" : [1] },
						{ "className" : "dt-right", "targets" : [] },
						{ "className" : "dt-center", "targets" : [0] } 
					],
					"order" : [],
					"fnRowCallback" : function(nRow, aData, index) {
						var setting = this.fnSettings();
						$('td:eq(0)', nRow).html( "<center>" + (setting._iDisplayStart + index + 1) + "<center>");
						$('td:eq(1)', nRow).html(aData.userId);
						$('td:eq(2)', nRow).html(aData.firstName);
						$('td:eq(3)', nRow).html(aData.lastName);
						return nRow;
					}
				});
			}
			
			function searchPrivilegeProgram(roleMode) {
				var vRoleGroup = $('#roleGroup').val();
				var params = { 
						 mode: roleMode ,
						 roleId : roleId
					};
				if ($.fn.DataTable.isDataTable('#privilegeTbl')) {
					$('#privilegeTbl').DataTable().destroy();
				}
				$('#privilegeTbl tbody').empty();
				addNewIdModal = '';
				if(vRoleGroup == 'BANK'){
					var url = '/UserManagement/RolePrivilege/SearchProgramMaster';	
				}else{
					var url = '/MasterSetup/RolePrivilege/SearchProgramMaster';	
				}
				var columnGroup = 5;	
				var table = $('#privilegeTbl').DataTable( {
				    "paging":   false,
					"ordering": false,
					"info":     false,
				//	"searching" : true,
					"processing" : true,
				//	"serverSide" : true,
					"ajax" : {
						"contentType" : "application/json; charset=utf-8",
						"dataType" : "json",
						"beforeSend" : function(xhr) {
							xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
							checkTimeOut();
						},
						"data" : function(d) {
							d.dataSearch = params;
						},
						"url" : GetSiteRoot() + url,
						"type" : "POST",
						"error" : function(jqXHR, textStatus, errorThrown) {
							$("#dialog-confirm").dialog('close');
							 $("#dialog-message").dialog('close');
							 closeOverlay();
							 $('.tooltip').remove();
							 if(typeof jqXHR.responseJSON != 'undefined'){
								 if(typeof jqXHR.responseJSON.errorMessage != 'undefined'){
									 $("#dialog-confirm").dialog('close');
									 $("#dialog-message").dialog('close');
									 alertModal('Warning', jqXHR.responseJSON.errorMessage);
									 $("#dialog-message").dialog({
										  modal: true,
										  buttons: {
											Ok: function() {
											  $(this).dialog("close");
											  closeOverlay();
											}
										  },
										  close: function(){
											  closeOverlay();
										  }
									});
								}
							}
						}
					},
					"columns" : [
						{"data" : "programName"},
						{"data" : "none"},
						{"data" : "viewer"},
						{"data" : "maker"},
						{"data" : "checker"},
						{"data" : "programGroup"}
					],
					
					"createdRow": function ( row, data, index ) {
						var group_name = data.programGroup.replace(/\s/g,'');
						$(row).addClass( 'collapse in '+group_name );
						$('td', row).eq(0).html('<div style="padding-left: 20px;">'+data.programName+'</div>');
						$('td', row).eq(1).html('<div class="radio"><input type="radio" id="none'+data.programId+'"name="'+ data.programId +'"></div>');
						$('td', row).eq(2).html('<div class="radio"><input type="radio" id="viewer'+data.programId+'"name="'+ data.programId +'"></div>');
						$('td', row).eq(3).html('<div class="radio"><input type="radio" id="maker'+data.programId+'"name="'+ data.programId +'"></div>');
						$('td', row).eq(4).html('<div class="radio"><input type="radio" id="checker'+data.programId+'"name="'+ data.programId +'"></div>');
						$('td', row).eq(5).html('<b>'+ data.programGroup +'</b>');
						programList[index] = data.programId;
					 } ,
					 "drawCallback": function(){
						setHeightSideBar();
					},
					"initComplete" : function(settings, json) {
						$(json.data).each(function(i, item) {
							/*** check disabled radio group */
							if("VIEW" == roleMode){
								// View mode is view only.
								   $('#none'+item.programId).prop('disabled', true);
								   $('#viewer'+item.programId).prop('disabled', true);
								   $('#maker'+item.programId).prop('disabled', true);
								   $('#checker'+item.programId).prop('disabled', true);
							}else{
								// add and edit mode is check validate database.
								if(item.viewer == "N"){
								   $('#viewer'+item.programId).prop('disabled', true);
								}
								if(item.maker == "N"){
								   $('#maker'+item.programId).prop('disabled', true);
								}
								if(item.checker == "N"){
								   $('#checker'+item.programId).prop('disabled', true);
								}
								
							}
							
							/*** check tick radio group */
							if(item.defaultViewer == "Y"){
					           $('#viewer'+item.programId).prop('checked', true);
							} else if(item.defaultMaker == "Y"){
					           $('#maker'+item.programId).prop('checked', true);
							} else if(item.defaultChecker == "Y"){
					           $('#checker'+item.programId).prop('checked', true);
							} else {
					           $('#none'+item.programId).prop('checked', true);
							}
						});
						
					},
					"drawCallback" : function() {
						setHeightSideBar();
						var api = this.api();
						var rows = api.rows( {page:'current'} ).nodes();
						var last=null;
					    api.column(columnGroup, {page:'current'} ).data().each( function ( group, i ) {
					    	var group_name = group.replace(/\s/g,'');
		                    if ( last !== group ) {
		                        $(rows).eq( i ).before('<tr class="group clickable" data-toggle="collapse" id="'+group_name+'" data-target=".'+group_name+'"><td colspan="'+columnGroup+' "><b>'+group+'</b></td></tr>');
		                        last = group;
		                    }
		                });
					},
					
					"columnDefs" : [ 
						{ "orderable" : false, "targets" : [] }, 
						{ "className" : "dt-left", "targets" : [0] }, 
						{ "className" : "dt-right", "targets" : [] }, 
						{ "className" : "dt-center", "targets" : [1,2,3,4] } ,
						{ "visible": false, "targets":  columnGroup }
						],
					
					"order" : [],
		
					"fnRowCallback" : function(nRow, aData, index) {
					//	$('td', nRow).eq(0).html(data.programName);
					//	$('td', nRow).eq(1).html('<div class="radio"><input checked type="radio" name="'+ aData.programId +'"></div>');
					//	$('td', nRow).eq(2).html('<div class="radio"><input type="radio" name="'+ aData.programId +'"></div>');
					//	$('td', nRow).eq(3).html('<div class="radio"><input type="radio" name="'+ aData.programId +'"></div>');
					//	$('td', nRow).eq(4).html('<div class="radio"><input type="radio" name="'+ aData.programId +'"></div>');
					//	$('td', nRow).eq(5).html('<b>'+ aData.programGroup +'</b>');	
					}
				});
			}
		
			function displaySearchGroup(sTableId, key, value) {
				var $div = $('#div-box-search-' + sTableId);
				if ($div.next().next().hasClass('help-block')) {
					$div.next().next().remove();
				}
				if ($div.hasClass('has-error')) {
					$div.removeClass('has-error').removeClass('has-danger');
				}
				$div.next().removeAttr('disabled');
				oldKeySearch = key;
				var $inputAll = $('<input>').attr('id', 'search-box-' + sTableId)
						.addClass('form-control input-sm')
						.attr('style', 'width:150px;').attr('value', value);
				$div.html($inputAll);
		
			}
			
			$('#cancel-bnt').on('click', function(){
				var vRoleGroup = $('#roleGroup').val();
				
				if("BANK" == vRoleGroup){
					window.location.href = GetSiteRoot() + '/UserManagement/RolePrivilege';
				}else if("CORP" == vRoleGroup){
					window.location.href = GetSiteRoot() + '/MasterSetup/RolePrivilege';
				}	
				
			});
			
			$('#roleNameText').blur(function(){
				var roleNameText = $(this).val();
				checkValidate('addRole');
				if(roleNameText == '') {
					$('#save-btn').attr('disabled','disabled');
				}else{
					$('#save-btn').removeAttr('disabled');
				}
			}).on("keypress", function(e) {
				e.keyCode = e.key.charCodeAt(0);
				var key = e.keyCode;
				if (key == 39 || key == 34 || key == 60 || key == 62 || key == 38 || key == 35 || key == 37) {
				    e.preventDefault();
				}
			}).bind("paste", function(e){
			    // access the clipboard using the api
				var pastedData = e.originalEvent.clipboardData.getData('text');
			    for(var i = 0 ; i < pastedData.length ; i++){
			    	var key = pastedData.charCodeAt(i);	
					if (key == 39 || key == 34 || key == 60 || key == 62 || key == 38 || key == 35 || key == 37) {
						return false;
					}
			    }
			} );
			
			$('#save-btn').on('click', function(){
				var vRoleGroup = $('#roleGroup').val();
				//if(checkValidate('addRole')){
					var data = [];
					for(var i = 0; i < programList.length; i++) {
					data[i] = {
						programId : programList[i],
						none : $('#none'+programList[i]).prop("checked")?"Y":"N",
						viewer : $('#viewer'+programList[i]).prop("checked")?"Y":"N",
						maker : $('#maker'+programList[i]).prop("checked")?"Y":"N",
						checker : $('#checker'+programList[i]).prop("checked")?"Y":"N"
						}
					}
					parameter = {
						roleName : $('#roleNameText').val(),
						programPrivilegeList : data,
						mode : roleMode
					}
					var url = '';
					if(vRoleGroup == 'BANK'){
						url = '/UserManagement/RolePrivilege/SaveRoleAndPrivilege';
					}else{
						url = '/MasterSetup/RolePrivilege/SaveRoleAndPrivilege';
					}
					sendPostAjax(url, parameter, function(data){
						if(data == 1){
							alertModal('', 'Save Role Successful.');
							$("#dialog-message").dialog({
								  modal: true,
								  buttons: {
									Ok: function() {
									  $(this).dialog("close");
									  closeOverlay();
										if("BANK" == vRoleGroup){
										  location.href = GetSiteRoot() + '/UserManagement/RolePrivilege';
										}else if("CORP" == vRoleGroup){
										  location.href = GetSiteRoot() + '/MasterSetup/RolePrivilege';
										}			
									}
								  }
								});
							}else{
							   alertModal('', 'error : please contact admin!!');
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
				//}
			});
		
			function searchBtn(id) {
				var val = $('#search-box-' + id).val();
				oldValueSearch = val;
				searchUserByUserRole(val);
			}
			
			function setTitleValueByGroupRole(pRoleGroup) {
				var roleTitle = $('#roleTitle').val();
				if(typeof(roleTitle) == "undefined" || roleTitle == ''  ){
					$("label[for='roleTitle']").html("Role and Privilege");
				}else{
		
				var groupLabel = "";	
		
				if("BANK" == pRoleGroup){
					groupLabel = "( KBANK )";
				}else if("CORP" == pRoleGroup){
					groupLabel = "( Customer )";
				}
					$("label[for='roleTitle']").html(roleTitle+groupLabel);
				}
			}
			//########################################################                 ###################################### //
			//########################################################  Start Function ###################################### //
			//########################################################                 ###################################### //
		
			$(function() {
				
				var roleGroup = $('#roleGroup').val();
				setTitleValueByGroupRole(roleGroup);
				
				if("EDIT" == roleMode ){
					$('#save-btn').removeAttr('disabled');
					/* set roleName */
					$('#roleNameText').val(roleName);
					document.getElementById('roleNameText').disabled = true;
					document.getElementById('userPrivilegeBox').style.visibility = 'visible';
					searchUserByUserRole('');
					searchPrivilegeProgram(roleMode);
		
				}else if("ADD" == roleMode ){
					$('#userPrivilegeBox').hide();
					searchPrivilegeProgram(roleMode);
				}else if("VIEW" == roleMode ){
					$('#roleNameText').val(roleName);
					document.getElementById('roleNameText').disabled = true;
					$('#save-btn').attr('disabled','disabled');
					
					document.getElementById('userPrivilegeBox').style.visibility = 'visible';
					searchUserByUserRole('');
					searchPrivilegeProgram(roleMode);
				}
			});
		
		</script>
	</jsp:body>
</t:master>
