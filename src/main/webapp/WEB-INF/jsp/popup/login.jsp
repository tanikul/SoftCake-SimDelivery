<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url value="/j_spring_security_check" var="loginUrl" />
<%@ page import = "java.io.*,java.util.*" %>

<link rel="stylesheet" href="<c:url value="/css/login-popup.css"/>">

<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="cont_centrar" id="loginModal">
		<div class="cont_login">
		  <div class="cont_tabs_login">
		    <ul class='ul_tabs'>
		      <li class="active"><a href="javascript:void(0);" onclick="sign_in()">SIGN IN</a><span class="linea_bajo_nom"></span></li>
			  <li><a href="javascript:void(0);" onclick="sign_up()">SIGN UP</a><span class="linea_bajo_nom"></span></li>
		    </ul>
		  </div>
		  <div class="cont_text_inputs">
		  	<div id="signup" style="display:none;">
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
							<input type="text" id="username" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 form-group">
						<div class="col-sm-2">
							<label><b>Password</b></label>
						</div>
						<div class="col-sm-4">
							<input type="password" id="password" class="form-control" />
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
					     	<button class="btn_sign" id="btn_signup">SIGN UP</button>
					    </div>
				    </div>
			    </div>
			</div>
	      </div>
	      <div id="signin">
	     <%--  <c:if test="${login ne null}"> --%>
		      <%-- <springForm:form id="loginForm" action="${loginUrl}" method="POST" commandName="login">   --%>
				<div class="form-group">
					<div class="help-block with-errors signin-display-error" id="display_error"></div>
				</div>
				  <div class="form-group">
		      		<input type="text" name="username" id="username" class="input_form_sign d_block active_inp" placeholder="USERNAME" />
			      	<div class="help-block active_inp"></div>
			      </div>
			      <div class="form-group">
			 	  	<input type="password" name="password" id="password" class="input_form_sign d_block active_inp" placeholder="PASSWORD" />
			      	<div class="help-block active_inp"></div>
			      </div>
			      <a href="#" class="link_forgot_pass d_block" >Forgot Password ?</a>  
			      
			      <div class="cont_btn" style="margin-left: 100px;margin-top: 20px;">
			     	<input type="button" class="btn_sign" id="btn_signin" value="SIGN IN">
			    </div>
		   <%--  </springForm:form> --%>
		    <%-- </c:if> --%>
	      </div>
	    </div>
	   </div>
	</div>
</div>
<script src="<c:url value="/js/login.js" />"></script>