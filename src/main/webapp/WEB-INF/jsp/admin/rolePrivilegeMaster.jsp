<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="role.maker" var="maker"/>
<t:master>
	<jsp:body>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			 <input type="hidden" id="roleTitle" value="Role and Privilege"> 
			<section class="content-header">
				<h1 class="page-header" id="page-header">
					<i class="fa fa-address-book-o"></i>&nbsp;&nbsp;<label for="roleTitle" style="vertical-align: middle" ></label>
				</h1>
			</section>
			<section class="content">
				<div class="row">
					<!-- left column -->
					<div class="col-xs-12">
						<div class="box box-success">
							<div class="box-header">
								<ul class="nav">
									<li style="float: right;">
										<button class="btn btn-default"
											onclick="openModalAdd('AddRolePrivilege');">
											<i class="fa fa-plus-circle green"></i>&nbsp;&nbsp; Add Role
										</button>
									</li>
								</ul>
		
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
									<div class="col-md-12">
										<table id="roleTbl" class="table table-bordered table-striped"
											style="width:100%">
											<thead>
												<tr  style="background:#def2e9"  >
													<th width="20%">No</th>
													<th style="text-align: center;">Role</th>
													<th width="20%">Action</th>
												</tr>
											</thead>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<div id="img-out"></div>
		</div>
		
		<script type="text/javascript">
		
			addNewIdModal = 'roleAndPrivilege';
			var oldValueSearch = '';
			var oldKeySearch = '';
			
			function searchRoleAndPrivilege(params) {
				if ($.fn.DataTable.isDataTable('#roleTbl')) {
					$('#roleTbl').DataTable().destroy();
				}
				$('#roleTbl tbody').empty();
				var url = '/Admin/RolePrivilege/SearchRoleAndPrivilege';
				var table = $('#roleTbl').DataTable(
				{
					"searching" : true,
					"processing" : true,
					"serverSide" : true,
					"userRole": '${role}',
					"ajax" : {
						"contentType" : "application/json; charset=utf-8",
						"dataType" : "json",
						"crossDomain" : true,
						"beforeSend" : function(xhr) {
							xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
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
					"columns" : [ {
						"data" : "roleId"
					}, {
						"data" : "roleName"
					}, {
						"data" : "roleName"
					} ],
					"initComplete" : function(settings, json) {
						$(json.data).each(function(i, item) {
							if (item.no == 1) {
								json.data[i].no = 10;
							}
						});
						if (settings.oFeatures.bFilter) {
							//$('#selected-search-' + settings.sTableId).change(function(){
							//	displaySearchGroup(settings.sTableId, this.value, '')
							//});
							//$('#selected-search-' + settings.sTableId).val(oldKeySearch);
							//displaySearchGroup(settings.sTableId, oldKeySearch, oldValueSearch);
							displaySearchGroup(settings.sTableId, this.value, oldValueSearch);
						}
					},
					"drawCallback" : function() {
						
					},
					"columnDefs" : [ {
						"targets" : [ 0, 2 ],
						"orderable" : false
					}, {
						"className" : "dt-left",
						"targets" : [1]
					}, {
						"className" : "dt-right",
						"targets" : [ ]
					}, {
						"className" : "dt-center",
						"targets" : [ 0, 2 ]
					}, {
						"targets" : [2],
						"visible" : ('${role}' == '<spring:message code="role.maker" />') ? true : false
					} ],
					"order" : [],
					"fnRowCallback" : function(nRow, aData, index) {
						var edit = "";
						var del = "";
						var view = "";
						
						view = "<a href=\"javascript:viewRole('" + aData.roleId+ "','" + aData.roleName + "');\">" + aData.roleName + "</a>"
						if('${role}' == '<spring:message code="role.maker" />'){
							edit = "<a href=\"javascript:editRole('" + aData.roleId+ "','" + aData.roleName + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Edit Role\"><i class=\"fa fa-pencil fa-2x\"></i></a>";	
							if (aData.disableDeleteFlg == true) {
								del = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Role\"><i class=\"fa fa-trash fa-2x fa-disabled\"></i></span>";
							} else {
								del = "<a href=\"javascript:deleteRole('" + aData.roleName + "');\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"Delete Role\"><i class=\"fa fa-trash fa-2x\"></i></a>";
							}
						}
						var setting = this.fnSettings();
						$('td:eq(0)', nRow).html("<center>" + (setting._iDisplayStart + index + 1) + "<center>");
						$('td:eq(1)', nRow).html(view);
						$('td:eq(2)', nRow).html("<center>" + edit + del + "</center>");
						return nRow;
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
		
			function editRole(roleId, roleName) {
				let form = $('<form/>').attr('action', GetSiteRoot() + '/Admin/RolePrivilege/EditRolePrivilegeDetail').attr('method', 'post');
				form.append($('<input/>').attr('name', 'roleId').attr('type', 'hidden').attr('value', roleId));
				form.append($('<input/>').attr('name', 'roleName').attr('type', 'hidden').attr('value', roleName));
				form.append($('<input/>').attr('name', '${_csrf.parameterName}').attr('type', 'hidden').attr('value', '${_csrf.token}'));
				$('body').append(form);
				form.submit();
			}
			
			function viewRole(roleId, roleName) {
				let form = $('<form/>').attr('action', GetSiteRoot() + '/Admin/RolePrivilege/ViewRolePrivilegeDetail').attr('method', 'post');
				form.append($('<input/>').attr('name', 'roleId').attr('type', 'hidden').attr('value', roleId));
				form.append($('<input/>').attr('name', 'roleName').attr('type', 'hidden').attr('value', roleName));
				form.append($('<input/>').attr('name', '${_csrf.parameterName}').attr('type', 'hidden').attr('value', '${_csrf.token}'));
				$('body').append(form);
				form.submit();	
			}
		
			function deleteRole(roleName) {
				confirmModal('', 'Do you want to delete Role : ' + roleName);
				$("#dialog-confirm").dialog(
				{
					resizable : false,
					height : "auto",
					width : "auto",
					modal : true,
					buttons : {
						"OK" : function() {
							var url = "";
							url = '/Admin/RolePrivilege/deleteKbankRoleByRoleName/'+ roleName;
							sendGetAjax(url, function(data) {
								if (data == 1) {
									$("#dialog-confirm").dialog('close');
									//alertModal("Success", "Delete role success.");
									oldValueSearch = '';
									 var params = { };
									searchRoleAndPrivilege(params);
								} else {
									alertModal('Warning', "Can't delete this role.");
								}
							});
						},
						Cancel : function() {
							$(this).dialog("close");
						}
					},
					open : function(ev, ui) {
						openOverlay();
					},
					close : function(ev, ui) {
						closeOverlay();
					}
				});
			}
		
			function searchBtn(id) {
				var val = $('#search-box-' + id).val();
				oldValueSearch = val;
				var params = {
					roleName : val
				};
				searchRoleAndPrivilege(params);
			}
			
			function openModalRoleAndPrivilegeByRoleGroup(id) {
				var url = '';
				location.href = GetSiteRoot() + '/Admin/RolePrivilege/' + id;	
			}
		
			function openModalAdd(){
				location.href = GetSiteRoot() + '/Admin/RolePrivilege/AddRolePrivilege';
			}
		
			$(function() {
				
				var obj = { };
				searchRoleAndPrivilege(obj);
			});
			
			
		</script>
	</jsp:body>
</t:master>