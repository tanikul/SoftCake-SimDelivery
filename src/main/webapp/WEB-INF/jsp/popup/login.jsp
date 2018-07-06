<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url value="/j_spring_security_check" var="loginUrl" />
<%@ page import = "java.io.*,java.util.*" %>
<%@page import="com.softcake.sim.common.FBConnection"%>
<%
	FBConnection fbConnection = new FBConnection();
%>
<spring:message code="captcha.siteKey" var="siteKey"/>
<link rel="stylesheet" href="<c:url value="/css/login-popup.css"/>">

<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="cont_centrar">
			<div class="cont_login">
			  <div class="cont_tabs_login">
			    <ul class='ul_tabs'>
			      <li class="active"><a href="javascript:void(0);" onclick="sign_in()">เข้าสู่ระบบ</a><span class="linea_bajo_nom"></span></li>
				  <li><a href="javascript:void(0);" onclick="sign_up()">สมัครสมาชิก</a><span class="linea_bajo_nom"></span></li>
			    </ul>
			  </div>
			  <div class="cont_text_inputs">
			  	<div id="signup" style="display:none;">
			      <div class="container-fluid form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">ชือ-นามสกุล</label>
						<div class="col-sm-2 col-xs-12">
							<select id="prefix" class="form-control">
								<option value="">--คำนำหน้า--</option>
							</select>
							<div class="help-block with-errors"></div>
						</div>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="firstName" class="form-control" placeholder="First Name" />
							<div class="help-block with-errors"></div>
						</div>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="lastName" class="form-control" placeholder="Last Name"/>
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">ชื่อผู้ใช้ระบบ</label>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="username-signup" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">รหัสผ่าน</label>
						<div class="col-sm-4 col-xs-12">
							<input type="password" id="password-signup" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">ยืนยันรหัสผ่าน</label>
						<div class="col-sm-4 col-xs-12">
							<input type="password" id="confirm-password-signup" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">ที่อยู่</label>
						<div class="col-sm-4 col-xs-12">
							<textarea id="address" class="form-control" style="height:150px;"></textarea>
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">จังหวัด</label>
						<div class="col-sm-4 col-xs-12">
							<select id="province" class="form-control"></select>
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">รหัสไปรษณีย์</label>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="postcode" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">เบอร์โทรศัพท์</label>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="mobile" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">อีเมล์</label>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="email" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">Line ID</label>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="line" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">Website</label>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="website" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-12 control-label">ชื่อ/ฉายาหมอดู</label>
						<div class="col-sm-4 col-xs-12">
							<input type="text" id="nickname" class="form-control" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 col-xs-12"></div>
						<div class="col-sm-4 col-xs-12">
							<div id="captcha2"></div>
						    <div class="help-block with-errors"></div>
					    </div>
				    </div>
					<div class="form-group">
						<div class="col-sm-2 col-xs-12"></div>
						<div class="col-sm-4 checkbox">
						    <label>
						      <input type="checkbox" id="confirm"> ยอมรับ <a href="<c:url value="/Condition"/>" target="_blank">เงื่อนไขการใช้บริการ</a>
						    </label>
						    <div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 col-xs-12"></div>
						<div class="col-sm-4 col-xs-12">
						     <button class="btn_sign" id="btn_signup">สมัครเข้าใช้บริการ</button>
					    </div>
				    </div>
				</div>
		      </div>
		      <div id="signin">
				<div class="form-group">
					<div class="help-block with-errors signin-display-error" id="display_error"></div>
				</div>
				  <div class="form-group">
		      		<input type="text" name="username" id="username" class="input_form_sign d_block active_inp" placeholder="USERNAME" />
			      	<div class="help-block" style="margin-left:15px;font-size:12px;"></div>
			      </div>
			      <div class="form-group">
			 	  	<input type="password" name="password" id="password" class="input_form_sign d_block active_inp" placeholder="PASSWORD" />
			      	<div class="help-block" style="margin-left:15px;font-size:12px;"></div>
			      </div>
			      <div class="form-group" style="margin-top:30px;margin-left:10px;">
				      <div id="captcha1"></div>
					  <div class="help-block" style="margin-left:15px;font-size:12px;"></div>
			      </div>
			      <div class="form-group">
			      	<a href="javascript:fb_login();" > <img id="fb-login-btn" src="<c:url value="/images/facebookloginbutton.png" />" /></a>
				  </div>
			      <div class="form-group">
			      	<a href="javascript:forgotPassword();" class="link_forgot_pass d_block" >ลืมพาสเวิร์ด</a>  
			      </div>
			      <div class="form-group">
				      <div class="cont_btn" style="margin-left: 100px;margin-top: 20px;">
				     	<input type="button" class="btn_sign" id="btn_signin" value="เข้าสู่ระบบ">
				      </div>
			    </div>
		      </div>
		    </div>
		   </div>
	   </div>
	</div>
</div>
<div class="modal fade" id="forgotPassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        	 ลืมพาสเวิร์ด
       </div>
       <input type="hidden" id="mode">
       <div class="modal-body">
          <div class="container-fluid">
				<div class="form-group">
			      <label for="forgot-emal">ระบุอีเมล์ของท่าน</label>
			      <input type="email" class="form-control" id="forgot-email" placeholder="Email">
			      <div class="help-block with-errors"></div>
			    </div>
			    <div class="form-group">
			      <div id="captcha3"></div>
				  <div class="help-block with-errors"></div>
		        </div>
		        <div class="form-group">
			      <button class="btn btn-primary" id="forgot-submit-btn">ตกลง</button>
			    </div>
			</div>
       </div>
    </div>
   </div>
 </div>
 <script src="https://www.google.com/recaptcha/api.js?onload=myCallBack&render=explicit" async defer></script>
 <script>
      var recaptcha1;
      var recaptcha2;
      var recaptcha3;
      var myCallBack = function() {
        //Render the recaptcha1 on the element with ID "recaptcha1"
        recaptcha1 = grecaptcha.render('captcha1', {
          'sitekey' : '${siteKey}', //Replace this with your Site key
          'theme' : 'light'
        });
        
        //Render the recaptcha2 on the element with ID "recaptcha2"
        recaptcha2 = grecaptcha.render('captcha2', {
          'sitekey' : '${siteKey}', //Replace this with your Site key
          'theme' : 'light'
        });
        
        recaptcha3 = grecaptcha.render('captcha3', {
          'sitekey' : '${siteKey}', //Replace this with your Site key
          'theme' : 'light'
        });
      };
    </script>
    
<script src="<c:url value="/js/login.js" />"></script>