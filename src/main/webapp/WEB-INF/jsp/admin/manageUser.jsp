<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	<link rel="stylesheet" href="<c:url value="/css/datatables.css"/>"/>
	<script src="<c:url value="/js/jquery.dataTables.js" />"></script>
	<br/>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			 <div class="x_panel panel-round-bd">
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="userId" class="control-label">User ID</label>
			    	<input type="text" class="form-control" id="userId" placeholder="User ID">
			  	</div>
			  	<div class="form-group col-md-3 col-sm-3 col-xs-3">
			    	<label for="firstName" class="control-label">First Name</label>
			    	<input type="text" class="form-control" id="firstName" placeholder="First Name">
			  	</div>
			  	<div class="form-group col-md-3 col-sm-3 col-xs-3">
			    	<label for="lastName" class="control-label">Last Name</label>
			    	<input type="text" class="form-control" id="lastName" placeholder="Last Name">
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="activeStatus" class="control-label">Active Status</label>
			    	<select class="form-control" id="activeStatus">
			    		<option value="">-- เลือกทั้งหมด --</option>
			    		<option value="Y">Active</option>
			    		<option value="N">Not Active</option>
			    	</select>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
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
					<div class="col-md-12 col-sm-12 col-xs-12">
              			 <button class="btn btn-default pull-right" id="add-user-btn"><i class="fa fa-plus-circle"></i>&nbsp;&nbsp; Add User</button>
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
                          <th class="text-center" width="20%"><span data-toggle="tooltip" data-original-title="Add Interest" style="font-size:26px;top:8px;cursor:pointer;color:#02A94F;display:none;" id="add-interest-btn" class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span></th>
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
	<div class="modal fade" id="add-user-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		 <div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header confirm ">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
					</button>
					<h4 class="modal-title">Add User</h4>
				</div>
				<div class="modal-body">
					<div class="confirm_body">
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-12 form-group">
									<div class="col-sm-3">
										<label><b>ชือ-นามสกุล</b></label>
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
									<div class="col-sm-3">
										<label><b>Username</b></label>
									</div>
									<div class="col-sm-8">
										<input type="text" id="username" class="form-control" />
										<div class="help-block with-errors"></div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12 form-group">
									<div class="col-sm-3">
										<label><b>ที่อยู่</b></label>
									</div>
									<div class="col-sm-8">
										<textarea id="address" class="form-control"></textarea>
										<div class="help-block with-errors"></div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12 form-group">
									<div class="col-sm-3">
										<label><b>จังหวัด</b></label>
									</div>
									<div class="col-sm-8">
										<select id="province" class="form-control"></select>
										<div class="help-block with-errors"></div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12 form-group">
									<div class="col-sm-3">
										<label><b>รหัสไปรษณีย์</b></label>
									</div>
									<div class="col-sm-8">
										<input type="text" id="postcode" class="form-control" />
										<div class="help-block with-errors"></div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12 form-group">
									<div class="col-sm-3">
										<label><b>เบอร์โทรศัพท์</b></label>
									</div>
									<div class="col-sm-8">
										<input type="text" id="mobile" class="form-control" />
										<div class="help-block with-errors"></div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12 form-group">
									<div class="col-sm-3">
										<label><b>อีเมล์</b></label>
									</div>
									<div class="col-sm-8">
										<input type="text" id="email" class="form-control" />
										<div class="help-block with-errors"></div>
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
	    
	    $(document).ready(function(){
	    	$('#user_table').DataTable();
    	    searchUser = function(params){
				var data = {
					dataSearch: params
				};
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
						"url": GetSiteRoot() + '/Admin/SearchUser',
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
					  $('td:eq(0)', nRow).html("<center>" + (setting._iDisplayStart + parseInt(index) + 1) + "<center>");
					  $('td:eq(4)', nRow).html("<center>" + (aData.activeStatus == 'Y') ? 'Active' : 'Not Active' + "<center>");
					  return nRow;
					}
				});
			}
    	    searchUser({});
    	    $('#search-btn').click(function(){
    	    	searchUser({
    	    		userId: $('#userId').val(),
    	    		firstName: $('#firstName').val(),
    	    		lastName: $('#lastName').val(),
    	    		activeStatus: $('activeStatus').val()
    	    	});
    	    });
    	    $('#add-user-btn').click(function(){
    	    	$('#add-user-modal').modal('show');
    	    })
	    });
	    	
	    </script>
	</jsp:body>
</t:master>