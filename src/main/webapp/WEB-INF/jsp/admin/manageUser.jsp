<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
      		<h4><b><i class="fas fa-user" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> จัดการผู้ใช้งานระบบ</b></h4>
    	</div>
    </div>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12 panel-round-bd">
			  	<div class="form-group col-md-3 col-sm-3 col-xs-12">
			    	<label for="userId" class="control-label">User ID</label>
			    	<input type="text" class="form-control" id="userId" placeholder="User ID">
			  	</div>
			  	<div class="form-group col-md-3 col-sm-3 col-xs-12">
			    	<label for="firstName" class="control-label">Name</label>
			    	<input type="text" class="form-control" id="name" placeholder="Name">
			  	</div>
			  	<div class="form-group col-md-3 col-sm-3 col-xs-6">
			    	<label for="activeStatus" class="control-label">Role</label>
			    	<select class="form-control" id="searchRole"></select>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-6">
			    	<label for="activeStatus" class="control-label">Active Status</label>
			    	<select class="form-control" id="activeStatus">
			    		<option value="">-- เลือกทั้งหมด --</option>
			    		<option value="Y">Active</option>
			    		<option value="N">Not Active</option>
			    	</select>
			  	</div>
			  	<div class="form-group col-md-1 col-sm-1 col-xs-1">
	 			 	<button class="btn btn-warning button-flex orange-button" id="search-btn">ค้นหา</button>
	 			</div>
		</div>
	</div>
	<br/>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12 panel-round-bd">
           <div class="x_panel tile overflow_hidden">
             <div class="x_content">
               <div class="row">
               	<div class="col-md-12">
               	<div class="pull-right">
               		<button class="btn btn-default" onclick="addUser();"><i class="fa fa-plus-circle green"></i>&nbsp;&nbsp; Add User</button>
               	</div>
               	</div>
               </div>
				<table id="user_table" class="table table-bordered table-striped" style="width:100%;margin-top:20px;">
                  <thead>
                      <tr>
                          <th class="text-center" width="10%"><b>No.</b></th>
                          <th class="text-center" width="20%"><b>User ID</b></th>
                          <th class="text-center" width="20%"><b>Name</b></th>
                          <th class="text-center" width="15%"><b>Role</b></th>
                          <th class="text-center" width="20%"><b>Active Status</b></th>
                          <th class="text-center" width="10%">Action</th>
                      </tr>
                  </thead>
                  <tbody>
                  </tbody>
              </table>
             </div>
           </div>
         </div>
    </div>
	<div class="modal fade" id="signup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog modal-lg">
	      <div class="modal-content">
	       <div class="modal-header">
	         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	         User Info
	       </div>
	       <input type="hidden" id="mode">
	       <div class="modal-body">
	          <div class="container-fluid">
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>ชือ-นามสกุล</b></label>
							</div>
							<div class="col-sm-2">
								<select id="prefix-signup" class="form-control">
									<option value="">--คำนำหน้า--</option>
								</select>
								<div class="help-block with-errors"></div>
							</div>
							<div class="col-sm-4">
								<input type="text" id="firstName-signup" class="form-control" placeholder="First Name" />
								<div class="help-block with-errors"></div>
							</div>
							<div class="col-sm-4">
								<input type="text" id="lastName-signup" class="form-control" placeholder="Last Name"/>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>Username</b></label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="username-signup" class="form-control" />
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row" id="passworddiv">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>Password</b></label>
							</div>
							<div class="col-sm-4">
								<input type="password" id="password-signup" class="form-control" />
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<%-- <div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>ที่อยู่</b></label>
							</div>
							<div class="col-sm-4">
								<textarea id="address" class="form-control"></textarea>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>จังหวัด</b></label>
							</div>
							<div class="col-sm-4">
								<select id="province" class="form-control"></select>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>รหัสไปรษณีย์</b></label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="postcode" class="form-control" />
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>เบอร์โทรศัพท์</b></label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="mobile" class="form-control" />
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>อีเมล์</b></label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="email" class="form-control" />
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div> --%>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>สิทธิ์ผู้ใช้ระบบ</b></label>
							</div>
							<div class="col-sm-4">
								<select id="role-signup" class="form-control"></select>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>Active Status</b></label>
							</div>
							<div class="col-sm-8">
								<label class="radio-inline">
								  <input type="radio" name="activeStatus" value="Y" checked> Active
								</label>
								<label class="radio-inline">
								  <input type="radio" name="activeStatus" value="N"> InActive
								</label>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2"></div>
							<div class="col-sm-4">
								 <div class="cont_btn">
							     	<button class="btn btn-primary" id="btn_register">Save</button>
							    </div>
						    </div>
					    </div>
				    </div>
				</div>
	       </div>
	    </div>
	   </div>
	 </div>

	<script>
		var params = {};
	    $(document).ready(function(){
	    	$('#user_table').DataTable();
    	    searchUser = function(){
				if ( $.fn.DataTable.isDataTable('#user_table') ) {
				  $('#user_table').DataTable().destroy();
				}
				$('#user_table tbody').empty();
				$('#user_table').DataTable({
					"bFilter": false,
					"bLengthChange": false,
					"bInfo": false,
					"processing": false,
					"serverSide": true,
					"ajax": {
						"contentType": "application/json; charset=utf-8",
						"dataType": "json",
						"beforeSend": function (xhr) {
							xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
							$.LoadingOverlay("show");
						},
						"data": function ( d ) {
							d.dataSearch = params;
						},
						"url": GetSiteRoot() + '/Admin/ManageUser/SearchUser',
						"type": "POST",
						"error" : function(jqXHR, textStatus, errorThrown){
							displayErrorAjax(jqXHR, textStatus, errorThrown);
						}
					},
					"columns": [
						{ "data": "userId" },
						{ "data": "userId" },
						{ "data": "firstName" },
						{ "data": "roleJson.roleName" },
						{ "data": "activeStatus" },
						{ "data": "activeStatus" }
					],
					"drawCallback": function(settings) {
						$.LoadingOverlay("hide");
						$("*[data-toggle=tooltip]").tooltip();
					},
					"initComplete": function(settings, json) {
					},
					"preDrawCallback": function( settings ) {
						interestList = [];
					},
					"columnDefs": [ {
						"targets": [0],
						"orderable": true
					},
					{
						"className": "dt-left", 
						"targets": [1,2,3]
					}],
				  'order': [0, 'desc'],
				  "fnRowCallback": function(nRow, aData, index) {
					  var setting = this.fnSettings();
					  var edit =  "<a href='javascript:openEdit(\"" +aData.userId + "\");'  data-toggle=\"tooltip\" data-original-title=\"Edit\"><i class='fas fa-pencil-alt' style='font-size:1.2em; color:#8F8E8C;'></i></a>&nbsp;&nbsp;<a href='javascript:deleteUser(\"" + aData.userId + "\")' data-toggle=\"tooltip\" data-original-title=\"Delete\"><i class='fas fa-trash-alt' style='font-size:1.2em; color:#8F8E8C;'></i></a>";
				      var activeStatus = (aData.activeStatus == 'Y') ? "<i class='fa fa-check-circle green'></i>&nbsp;&nbsp;" + 'Active' : "<i class='fa fa-minus-circle red'></i>&nbsp;&nbsp;" + 'Not Active';
					  
					  $('td:eq(0)', nRow).html("<center>" + (setting._iDisplayStart + parseInt(index) + 1) + "<center>");
					  $('td:eq(2)', nRow).html(aData.prefixName + aData.firstName + ' ' + aData.lastName);
					  $('td:eq(4)', nRow).html("<center>" + activeStatus + "<center>");
					  $('td:eq(5)', nRow).html("<center>" + edit + "<center>");
					  return nRow;
					}
				});
			}

    	    searchUser();
    	    
    	    $('#search-btn').click(function(){
    	    	params = {
       	    		userId: $('#userId').val(),
       	    		firstName: $('#name').val(),
       	    		lastName: $('#name').val(),
       	    		activeStatus: $('#activeStatus').val(),
       	    		role: $('#searchRole').val()
       	    	};
    	    	searchUser();
    	    });
    	    $('#add-user-btn').click(function(){
    	    	$('#add-user-modal').modal('show');
    	    });
    	    getDropDownList($('#searchRole'), '-- สิทธิ์ผู้ใช้ระบบ --', '/MasterSetup/LoadRole', 'CODE', 'DESCRIPTION', null);
    	    
    	    $('#btn_register').click(function(){
    	    	errMsg.user = {
					firstName: { id: $('#signup #firstName-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
					lastName: { id: $('#signup #lastName-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
					username: { id: $('#signup #username-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
					password: { id: $('#signup #password-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
					role: { id: $('#signup #role-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
					prefix: { id: $('#signup #prefix-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
				};
				if($('#mode').val() == 'A'){
					if(checkValidate('user')){
						sendPostAjaxWithoutLoading('/User/CheckDuplicateUser', {userId: $('#signup #username-signup').val()}, function(data){
							if(data == 1){
								 $('#signup #username-signup').parent().addClass('has-error has-danger');
								$('#signup #username-signup').next().html('Username นี้มีในระบบแล้ว');
							}else{
								$('#signup #username-signup').parent().removeClass('has-error has-danger');
								$('#signup #username-signup').next().html('');
								/* var email = $('#signup #email').val().trim();
								if(!validateEmail($('#signup #email'))){
									$('#signup #email').next().html('รูปแบบ email ไม่ถูกต้อง');
								}	 */
								
								var obj = { firstName: $('#signup #firstName-signup').val().trim(),
									lastName: $('#signup #lastName-signup').val().trim(),
									userId: $('#signup #username-signup').val().trim(),
									password: $('#signup #password-signup').val().trim(),
									/* address: $('#signup #address').val().trim(),
									province: $('#signup #province').val().trim(),
									postcode: $('#signup #postcode').val().trim(),
									mobile: $('#signup #mobile').val().trim().replaceAll('-',''),
									email: email,*/
									prefix: $('#signup #prefix-signup').val(),
									activeStatus: $("input[name='activeStatus']:checked").val(),
									role: $('#role-signup').val()
								};
								sendPostAjax('/Admin/ManageUser/Register', obj, function(data){
									if(data == 1){
										$('.modal').modal('hide');
										alertModal('', 'Save User Successful.');
										$("#dialog-message").dialog({
											  modal: true,
											  buttons: {
												Ok: function() {
												  $(this).dialog("close");
												  	closeOverlay();
													searchUser();			
												}
											 }
										});
									}
								});	
							}
						});
					}
				}else if($('#mode').val() == 'U'){
					errMsg.user = {
						firstName: { id: $('#signup #firstName-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
						lastName: { id: $('#signup #lastName-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
						username: { id: $('#signup #username-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
						role: { id: $('#signup #role-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
						prefix: { id: $('#signup #prefix-signup'), rule : ['require'], msg : ['กรุุณากรอกข้อมูล'] },
					};
					if(checkValidate('user')){
						var obj = { 
							firstName: $('#signup #firstName-signup').val().trim(),
							lastName: $('#signup #lastName-signup').val().trim(),
							userId: $('#signup #username-signup').val().trim(),
							/* address: $('#signup #address').val().trim(),
							province: $('#signup #province').val().trim(),
							postcode: $('#signup #postcode').val().trim(),
							mobile: $('#signup #mobile').val().trim().replaceAll('-',''),
							email: email,*/
							prefix: $('#signup #prefix-signup').val(),
							activeStatus: $("input[name='activeStatus']:checked").val(),
							role: $('#role-signup').val()
						};
						sendPostAjax('/Admin/ManageUser/UpdateUser', obj, function(data){
							if(data == 1){
								$('.modal').modal('hide');
								alertModal('', 'Save User Successful.');
								$("#dialog-message").dialog({
									  modal: true,
									  buttons: {
										Ok: function() {
										  $(this).dialog("close");
										  	closeOverlay();
											searchUser();			
										}
									 }
								});
							}
						});	
					}
				}
			});
    	    
    	    $('#signup #username-signup').blur(function(){
    	    	if(this.value.trim() != ''){
					sendPostAjaxWithoutLoading('/User/CheckDuplicateUser', {userId: this.value}, function(data){
						if(data == '1'){
							$('#signup #username-signup').next().html('Username นี้มีในระบบแล้ว');
							$('#signup #username-signup').parent().parent().addClass('has-error');
						}else{
							$('#signup #username-signup').next().html('');
							$('#signup #username-signup').parent().parent().removeClass('has-error');
						}
					});
    	    	}
			});
	    });
	    
	    openEdit = function(id){
	    	setDefault();
	    	sendGetAjax('/Admin/ManageUser/LoadUserById/' + id, function(data){
	    	 	getDropDownList($('#prefix-signup'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', data.prefix);
	    	 	getDropDownList($('#role-signup'), '-- สิทธิ์ผู้ใช้ระบบ --', '/MasterSetup/LoadRole', 'CODE', 'DESCRIPTION', data.role);
	   			//getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', data.province);
	   			$('#signup #mode').val('U');
	    		$('#signup #firstName-signup').val(data.firstName);
				$('#signup #lastName-signup').val(data.lastName);
				$('#signup #username-signup').val(data.userId).attr('disabled', 'disabled');
				$('#passworddiv').hide();
				/* $('#signup #address').val(data.address);
				$('#signup #postcode').val(data.postcode).mask('00000');
				$('#signup #mobile').val(parseSimFormat(data.mobile));	
				$('#signup #email').val(data.email); */
				if(data.activeStatus == 'Y'){
					$($("#signup input[name='activeStatus']").get(0)).attr('checked', true);
				}else{
					$($("#signup input[name='activeStatus']").get(1)).attr('checked', true);
				}
				$('#signup').modal('show');
			});
	    }
	    
	    addUser = function(){
	    	setDefault();
    	 	getDropDownList($('#prefix-signup'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', null);
    	 	getDropDownList($('#role-signup'), '-- สิทธิ์ผู้ใช้ระบบ --', '/MasterSetup/LoadRole', 'CODE', 'DESCRIPTION', null);
    	 	$('#passworddiv').show();
   			//getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', null);
   			$('#signup #mode').val('A');
    		$('#signup').modal('show');
	    }
	    
	    setDefault = function(){
	    	$('#signup #firstName-signup').val('');
			$('#signup #lastName-signup').val('');
			$('#signup #username-signup').val('').removeAttr('disabled');
			$('#signup #password-signup').val('').removeAttr('disabled');
			/* $('#signup #address').val('');
			$('#signup #postcode').val('');
			$('#signup #mobile').val('');
			$('#signup #email').val(''); */
			$($("#signup input[name='activeStatus']").get(0)).attr('checked', true);
	    }
	    
	    deleteUser = function(id){
	    	confirmModal('', 'Do you want to delete User ' + id);
			$( "#dialog-confirm" ).dialog({
			  resizable: false,
			  height: "auto",
			  width: "auto",
			  modal: true,
			  buttons: {
				"OK": function() {
					sendGetAjax('/Admin/ManageUser/DeleteUserById/' + id, function(data){
						if(data == 1){
							$( "#dialog-confirm" ).dialog('close');
							searchUser();
						}
					});
				},
				Cancel: function() {
				  $( this ).dialog( "close" );
				}
			  },
			  open: function(ev, ui) {
				  openOverlay();
			  },
			  close: function(ev, ui) {
				  closeOverlay();
			  }
			});	
	    }
	    </script>
	</jsp:body>
</t:master>