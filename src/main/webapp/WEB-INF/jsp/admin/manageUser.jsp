<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
      		<h4><b><i class="fas fa-user-plus" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> จัดการผู้ใช้งานระบบ</b></h4>
    	</div>
    </div>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			 <div class="panel-round-bd">
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="userId" class="control-label">User ID</label>
			    	<input type="text" class="form-control" id="userId" placeholder="User ID">
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="firstName" class="control-label">First Name</label>
			    	<input type="text" class="form-control" id="firstName" placeholder="First Name">
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="lastName" class="control-label">Last Name</label>
			    	<input type="text" class="form-control" id="lastName" placeholder="Last Name">
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="activeStatus" class="control-label">Role</label>
			    	<select class="form-control" id="searchRole"></select>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="activeStatus" class="control-label">Active Status</label>
			    	<select class="form-control" id="activeStatus">
			    		<option value="">-- เลือกทั้งหมด --</option>
			    		<option value="Y">Active</option>
			    		<option value="N">Not Active</option>
			    	</select>
			  	</div>
			  	<div class="form-group col-md-1 col-sm-1 col-xs-1">
	 			 	<button class="btn btn-warning button-flex orange-button" id="search-btn" style="margin-top:24px;">ค้นหา</button>
	 			</div>
			 </div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
           <div class="x_panel tile overflow_hidden">
             <div class="x_content">
               <div class="panel-round-bd number-panel">
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
                          <th class="text-center" width="20%"><b>Firstname</b></th>
						  <th class="text-center" width="10%"><b>Lastname</b></th>
                          <th class="text-center" width="20%"><b>Active Status</b></th>
                          <th class="text-center" width="20%">Action</th>
                      </tr>
                  </thead>
                  <tbody>
                  </tbody>
              </table>
			  </div>
             </div>
           </div>
         </div>
    </div>
	<div class="modal fade" id="userInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog modal-lg">
	      <div class="modal-content">
	       <div class="modal-header">
	         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	         <h4 class="modal-title" id="myModalLabel">User Info</h4>
	       </div>
	       <div class="modal-body">
	          <div class="container-fluid">
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>ชือ-นามสกุล</b></label>
							</div>
							<div class="col-sm-2">
								<select id="prefix" class="form-control">
									<option value="">--คำนำหน้า--</option>
								</select>
								<div class="help-block with-errors"></div>
							</div>
							<div class="col-sm-4">
								<input type="text" id="firstName" class="form-control" placeholder="First Name" />
								<div class="help-block with-errors"></div>
							</div>
							<div class="col-sm-4">
								<input type="text" id="lastName" class="form-control" placeholder="Last Name"/>
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
								<input type="text" id="username" class="form-control" disabled="disabled"/>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
					<div class="row">
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
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2">
								<label><b>สิทธิ์ผู้ใช้ระบบ</b></label>
							</div>
							<div class="col-sm-4">
								<select id="role" class="form-control"></select>
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
								  <input type="radio" name="activeStatus" value="Y"> Enable
								</label>
								<label class="radio-inline">
								  <input type="radio" name="activeStatus" value="N"> Disable
								</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2"></div>
							<div class="col-sm-4">
								 <div class="cont_btn">
							     	<button class="btn btn-primary" id="btn_signup">Save</button>
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
						{ "data": "lastName" },
						{ "data": "activeStatus" },
						{ "data": "activeStatus" }
					],
					"drawCallback": function(settings) {
						$.LoadingOverlay("hide");
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
					  var edit =  "<a href='javascript:openEdit(\"" +aData.userId + "\");'><i class='fas fa-pencil-alt' style='font-size:1.2em; color:#8F8E8C;'></i></a>&nbsp;&nbsp;<a href='javascript:deleteUser(\"" + aData.userId + "\")'><i class='fas fa-trash-alt' style='font-size:1.2em; color:#8F8E8C;'></i></a>";
						 
					  $('td:eq(0)', nRow).html("<center>" + (setting._iDisplayStart + parseInt(index) + 1) + "<center>");
					  $('td:eq(4)', nRow).html("<center>" + (aData.activeStatus == 'Y') ? 'Active' : 'Not Active' + "<center>");
					  $('td:eq(5)', nRow).html("<center>" + edit + "<center>");
					  return nRow;
					}
				});
			}

    	    searchUser({});
    	    
    	    $('#search-btn').click(function(){
    	    	params = {
       	    		userId: $('#userId').val(),
       	    		firstName: $('#firstName').val(),
       	    		lastName: $('#lastName').val(),
       	    		activeStatus: $('activeStatus').val()
       	    	};
    	    	searchUser();
    	    });
    	    $('#add-user-btn').click(function(){
    	    	$('#add-user-modal').modal('show');
    	    });
    	    getDropDownList($('#searchRole'), '-- สิทธิ์ผู้ใช้ระบบ --', '/MasterSetup/LoadRole', 'CODE', 'DESCRIPTION', null);
	    });
	    
	    openEdit = function(id){
	    	setDefault();
	    	sendGetAjax('/Admin/ManageUser/LoadUserById/' + id, function(data){
	    	 	getDropDownList($('#prefix'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', data.prefix);
	    	 	getDropDownList($('#role'), '-- สิทธิ์ผู้ใช้ระบบ --', '/MasterSetup/LoadRole', 'CODE', 'DESCRIPTION', data.role);
	   			getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', data.province);
	    		$('#userInfo #firstName').val(data.firstName);
				$('#userInfo #lastName').val(data.lastName);
				$('#userInfo #username').val(data.userId);
				$('#userInfo #address').val(data.address);
				$('#userInfo #postcode').val(data.postcode);
				$('#userInfo #mobile').val(data.mobile);
				$('#userInfo #email').val(data.email);
				$('#userInfo').modal('show');
			});
	    }
	    
	    addUser = function(){
	    	setDefault();
    	 	getDropDownList($('#prefix'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', null);
    	 	getDropDownList($('#role'), '-- สิทธิ์ผู้ใช้ระบบ --', '/MasterSetup/LoadRole', 'CODE', 'DESCRIPTION', null);
   			getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', null);
    		$('#userInfo').modal('show');
	    }
	    
	    setDefault = function(){
	    	$('#userInfo #firstName').val('');
			$('#userInfo #lastName').val('');
			$('#userInfo #username').val('');
			$('#userInfo #address').val('');
			$('#userInfo #postcode').val('');
			$('#userInfo #mobile').val('');
			$('#userInfo #email').val('');
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