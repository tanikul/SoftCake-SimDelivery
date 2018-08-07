<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import = "java.io.*,java.util.*" %>

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
 <script>
 $(document).ready(function(){
 	$('#btn_signup').click(function(){
		if(checkValidate('user')){
			var email = $('#signup #email').val();
			var obj = { firstName: $('#signup #firstName').val(),
				lastName: $('#signup #lastName').val(),
				userId: $('#signup #username').val(),
				password: $('#signup #password').val(),
				address: $('#signup #address').val(),
				province: $('#signup #province').val(),
				postcode: $('#signup #postcode').val(),
				mobile: $('#signup #mobile').val(),
				email: email
			};
			sendPostAjax('/User/UpdateUser', obj, function(data){
				if(data == 1){
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
 });
 </script>