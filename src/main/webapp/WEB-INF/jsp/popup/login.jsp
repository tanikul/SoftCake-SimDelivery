<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url value="/j_spring_security_check" var="loginUrl" />
<%@ page import = "java.io.*,java.util.*" %>
<%-- <!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>SMSGateway</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link rel="icon" href="<c:url value="/css/img/favicon.ico" />">
   	<link rel="stylesheet" href="<c:url value="/css/bootstrap.css" />">
   	<link rel="stylesheet" href="<c:url value="/font-awesome/css/font-awesome.min.css"/>">
   	<link rel="stylesheet" href="<c:url value="/css/login.css"/>">
 	

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="<c:url value="/js/html5shiv.min.js" />"></script>
        <script src="<c:url value="/js/respond.min.js" />"></script>
    <![endif]-->
  </head>
  <body>
  <div class="container">
    <h1 class="welcome text-center">MT Daily Info</h1>
        <div class="card card-container">
        <h2 class='login_title text-center'>Login</h2>
        <hr>
		<springForm:form id="loginForm" action="${loginUrl}" method="POST" commandName="login">
			<div id="errorMsg" class="help-block has-error">
				<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
					<font color="red">
			        	<c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>
			        </font>
				</c:if>
			</div> 
		  <div class="form-group has-feedback">
			<springForm:input path="username" cssClass="form-control" placeholder="User ID" />
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
			<div class="help-block"></div>
		  </div>
		  <div class="form-group has-feedback">
			<springForm:input type="password" path="password" cssClass="form-control" placeholder="Password" />
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  	<div class="help-block"></div>
		  </div>
		  <div class="row">
			 <div class="col-xs-12">
			  <button type="submit" class="btn btn-success btn-block">Log In</button>
			</div><!-- /.col -->
		  </div>
		</springForm:form>
		</div>
	</div>
    <script src="<c:url value="/js/jquery-2.1.4.min.js" />"></script>
    <script type="text/javascript">
	$(document).ready(function() {
		var $form = $('#loginForm');
		$form.bind('submit', function(e) {
			var username = $('#username');
			var password = $('#password');
			var chk = true;
			if(username.val().trim() == ''){
				username.parent().addClass('has-error');
				username.parent().find('.help-block').html('กรุณากรอก User ID');
				chk = false;
				username.keyup(function(){
					username.parent().removeClass('has-error');
					username.parent().find('.help-block').html('');
				});
			}else{
				username.parent().removeClass('has-error');
				username.parent().find('.help-block').html('');
			}
			if(password.val().trim() == ''){
				password.parent().addClass('has-error');
				password.parent().find('.help-block').html('กรุณากรอก Password');
				chk = false;
			}else{
				password.parent().removeClass('has-error');
				password.parent().find('.help-block').html('');
				password.keyup(function(){
					password.parent().removeClass('has-error');
					password.parent().find('.help-block').html('');
				});
			}
			if(!chk){
				$form.unbind('submit');
				e.preventDefault();
				return false;
			}
		});
	});
</script>
  </body>
</html> --%>
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