<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	<br/>
		<div class="panel panel-warning">
      <div class="panel-heading">
        <h3 class="panel-title">
      		<i class="fas fa-user" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> <b>โปรไฟล์</b>
    	</h3>
      </div>
      <div class="panel-body">
        <div class="container-fluid" id="userInfo">
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
					<div class="col-sm-2"></div>
					<div class="col-sm-4">
				     	<button class="btn btn-primary" id="btn_signup">Save</button>
				     	<button type="button" class="btn btn-danger">Cancel</button>
				    </div>
			    </div>
		    </div>
		</div>
      </div>
    </div>
    <br/>
    <script>
	    $(document).ready(function(){
	    	var data = ('${data}' != null && '${data}' != '') ? JSON.parse('${data}') : '${data}';
	    	console.log(data);
	    	getDropDownList($('#prefix'), '-- คำนำหน้า --', '/MasterSetup/LoadMasterSetup/PREFIX', 'CODE', 'DESCRIPTION', data.prefix);
	  		getDropDownList($('#province'), '-- เลือกจังหวัด --', '/MasterSetup/LoadProvince', 'CODE', 'DESCRIPTION', data.province);
	   		$('#userInfo #firstName').val(data.firstName);
			$('#userInfo #lastName').val(data.lastName);
			$('#userInfo #username').val(data.userId);
			$('#userInfo #address').val(data.address);
			$('#userInfo #postcode').val(data.postcode);
			$('#userInfo #mobile').val(data.mobile);
			$('#userInfo #email').val(data.email);
	    });
    </script>
	</jsp:body>
</t:master>