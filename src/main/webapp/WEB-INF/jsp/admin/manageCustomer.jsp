<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
      		<h4><b><i class="far fa-user" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> จัดการผู้ใช้งานระบบ (ลูกค้า)</b></h4>
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
		  	<div class="form-group col-md-3 col-sm-3 col-xs-12">
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
				<table id="user_table" class="table table-bordered table-striped" style="width:100%;margin-top:20px;">
                  <thead>
                      <tr>
                          <th class="text-center" width="10%"><b>No.</b></th>
                          <th class="text-center" width="20%"><b>User ID</b></th>
                          <th class="text-center" width="20%"><b>Name</b></th>
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
	<div class="modal fade" id="signup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog modal-lg">
	      <div class="modal-content">
	       <div class="modal-header">
	         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	         User Info
	       </div>
	       <div class="modal-body">
	          <div class="container-fluid form-horizontal">
				<div class="form-group">
					<label class="col-sm-2 control-label">ชือ-นามสกุล</label>
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
				<div class="form-group">
					<label class="col-sm-2 control-label">ชื่อผู้ใช้ระบบ</label>
					<div class="col-sm-4">
						<input type="text" id="username-signup" class="form-control" />
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">ที่อยู่</label>
					<div class="col-sm-4">
						<textarea id="address" class="form-control" style="height:150px;"></textarea>
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">จังหวัด</label>
					<div class="col-sm-4">
						<select id="province" class="form-control"></select>
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">รหัสไปรษณีย์</label>
					<div class="col-sm-4">
						<input type="text" id="postcode" class="form-control" />
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">เบอร์โทรศัพท์</label>
					<div class="col-sm-4">
						<input type="text" id="mobile" class="form-control" />
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">อีเมล์</label>
					<div class="col-sm-4">
						<input type="text" id="email" class="form-control" />
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Line ID</label>
					<div class="col-sm-4">
						<input type="text" id="line" class="form-control" />
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Website</label>
					<div class="col-sm-4">
						<input type="text" id="website" class="form-control" />
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">ชื่อ/ฉายาหมอดู</label>
					<div class="col-sm-4">
						<input type="text" id="nickname" class="form-control" />
						<div class="help-block with-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><b>Active Status</b></label>
					<div class="col-sm-8">
						<label class="radio-inline">
						  <input type="radio" name="activeStatus" value="Y"> Active
						</label>
						<label class="radio-inline">
						  <input type="radio" name="activeStatus" value="N"> InActive
						</label>
					</div>
				</div>
				<div class="form-group">
				<div class="col-sm-2"></div>
				<div class="col-sm-4">
					 <button class="btn btn-primary" id="btn_save">Save</button>
				     <button class="btn btn-danger" id="btn_cancel">Cancel</button>
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
				}console.log(params);
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
						"url": GetSiteRoot() + '/Admin/ManageCustomer/SearchCustomer',
						"type": "POST",
						"error" : function(jqXHR, textStatus, errorThrown){
							displayErrorAjax(jqXHR, textStatus, errorThrown);
						}
					},
					"columns": [
						{ "data": "userId" },
						{ "data": "userId" },
						{ "data": "firstName" },
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
						"targets": [1,2]
					}],
				  'order': [0, 'desc'],
				  "fnRowCallback": function(nRow, aData, index) {
					  var setting = this.fnSettings();
					  var openBooking =  "<a href='javascript:openBooking(\"" +aData.userId + "\");' title=\"View Booking\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"View Booking\"><i class='far fa-file-alt' style='font-size:1.2em; color:#8F8E8C;'></i></a>";
					  var openRequest =  "<a href='javascript:openRequest(\"" +aData.userId + "\");' title=\"View Request\" class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"View Request\"><i class='fas fa-registered' style='font-size:1.2em; color:#8F8E8C;'></i></a>";
					  var edit =  "<a href='javascript:openView(\"" +aData.userId + "\");' data-toggle=\"tooltip\" data-original-title=\"Edit\"><i class='fas fa-pencil-alt' style='font-size:1.2em; color:#8F8E8C;'></i></a>";
				      
					  if(aData.cntBooking == 0){
						 openBooking = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"No Booking\"><i class='far fa-file-alt' style='font-size:1.2em; color:#BDBDBD; cursor:not-allowed;'></i></span>";
					  }
					  if(aData.cntRequest == 0){
						 openRequest = "<span class=\"text-muted\" data-toggle=\"tooltip\" data-original-title=\"No Request\"><i class='fas fa-registered' style='font-size:1.2em; color:#BDBDBD; cursor:not-allowed;'></i></span>";
					  }
					  $('td:eq(0)', nRow).html("<center>" + (setting._iDisplayStart + parseInt(index) + 1) + "<center>");
					  $('td:eq(2)', nRow).html(aData.prefixName + aData.firstName + ' ' + aData.lastName);
					  
					  var activeStatus = (aData.activeStatus == 'Y') ? "<i class='fa fa-check-circle green'></i>&nbsp;&nbsp;" + 'Active' : "<i class='fa fa-minus-circle red'></i>&nbsp;&nbsp;" + 'Not Active';
					  $('td:eq(3)', nRow).html("<center>" + activeStatus + "</center>");
					  $('td:eq(4)', nRow).html("<center>" + edit + "&nbsp;&nbsp;" + openBooking + "&nbsp;&nbsp;" + openRequest + "<center>");
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
       	    		activeStatus: $('#activeStatus').val()
       	    	};
    	    	searchUser();
    	    });
    	    
    	    $('#btn_save').click(function(){
				var param = { userId: $('#signup #username-signup').val(), activeStatus: $("input[name='activeStatus']:checked").val() };
    	    	sendPostAjax('/Admin/ManageUser/EditUserCustomer', param, function(data){
    	    		if(data == 1){
    	    			$('#signup').modal('hide');
    	    			searchUser();
    	    		}
    	    	});
    	    	
    	    });
    	    
    	    $('#btn_cancel').click(function(){
    	    	$('#signup').modal('hide');
    	    });
    	   
	    });
	    
	    openBooking = function(id){
	    	let form = $('<form/>').attr('action', GetSiteRoot() + '/Admin/ManageBooking/Booking').attr('method', 'post').attr('target', '_blank');
			form.append($('<input/>').attr('name', 'userId').attr('type', 'hidden').attr('value', id));
			form.append($('<input/>').attr('name', '${_csrf.parameterName}').attr('type', 'hidden').attr('value', '${_csrf.token}'));
			$('body').append(form);
			form.submit();
	    }
	    
	    openView = function(id){
	    	sendGetAjax('/Admin/ManageUser/LoadUserById/' + id, function(data){
	    	 	getDropDownList($('#signup #prefix'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', data.prefix, true);
	    	 	getDropDownList($('#signup #province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', data.province, true);
	    		$('#signup #firstName').val(data.firstName).attr('disabled', 'disabled');
				$('#signup #lastName').val(data.lastName).attr('disabled', 'disabled');
				$('#signup #username-signup').val(data.userId).attr('disabled', 'disabled');
				$('#signup #address').val(data.address).attr('disabled', 'disabled');
				$('#signup #postcode').val(data.postcode).mask('00000').attr('disabled', 'disabled');
				$('#signup #mobile').val(parseSimFormat(data.mobile)).attr('disabled', 'disabled');	
				$('#signup #email').val(data.email).attr('disabled', 'disabled'); 
				if(data.activeStatus == 'Y'){
					$($("#signup input[name='activeStatus']").get(0)).attr('checked', true)
				}else{
					$($("#signup input[name='activeStatus']").get(1)).attr('checked', true)
				}
				$('#signup #line').val(data.line).attr('disabled', 'disabled'); 
				$('#signup #website').val(data.website).attr('disabled', 'disabled'); 
				$('#signup #nickname').val(data.nickname).attr('disabled', 'disabled'); 
				$('#signup').modal('show');
			});
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