<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Softcake</title>
	<meta name="description" content="">
	<meta name="csrf-token" content="${_csrf.token}">
	<link rel="icon" href="<c:url value="/css/img/favicon.ico" />">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link rel="stylesheet" href="<c:url value="/css/bootstrap.css" />">
	<link rel="stylesheet" href="<c:url value="/js/jquery-ui/jquery-ui.css" />">
	<link rel="stylesheet" href="<c:url value="/css/menu.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/content.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/bootstrap-select.min.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/bootstrap-datepicker3.min.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/dataTables.bootstrap.min.css"/>">
	<script src="<c:url value="/js/jquery-2.1.4.min.js" />"></script>
	<script src="<c:url value="/js/jquery-ui/jquery-ui.js" />"></script>
	<script src="<c:url value="/js/bootstrap.js" />"></script>
	<script src="<c:url value="/js/bootstrap-select.min.js" />"></script>
	<script src="<c:url value="/js/global.js" />"></script>
	<script src="<c:url value="/js/loadingoverlay.js" />"></script>
	<script src="<c:url value="/js/jquery.mask.min.js" />"></script>
    <script src="<c:url value="/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js" />"></script>
    <script src="<c:url value="/vendors/iCheck/icheck.min.js" />"></script>
    <script src="<c:url value="/vendors/DateJS/build/date.js" />"></script>
    <script src="<c:url value="/js/jquery-validate.bootstrap-tooltip.min.js" />"></script>
    <script src="<c:url value="/font-awesome/svg-with-js/js/fontawesome-all.js" />"></script>
    <script src="<c:url value="/js/bootstrap-datepicker.min.js" />"></script>
    <script src="<c:url value="/js/jquery.dataTables.js" />"></script>
    <script src="<c:url value="/js/dataTables.bootstrap.min.js" />"></script>
    <script src="<c:url value="/js/script.js" />"></script>
	
 	</head>
 	<body>
 			<div class="header-wrapper">
 				<header>
 					<div class="top-menu-wrapper">
 						<div class="wrapper clearfix">
 							<div class="logo pull-left">
 								<a href="/"><img src="<c:url value="/images/logo.png" />"></a>
 							</div>
 							
 							<div class="top-right-menu pull-right">
 								<img src="<c:url value="/images/user.png" />"style="width: 45px;height: 45px;margin-right:15px;"> 
 								<c:choose>
 									<c:when test="${sessionScope.userInfo.userId eq null}">
 										<a href="javascript:openLogin();" id="not-login"><span>Login / Sign up</span></a>
 										<jsp:include page="/WEB-INF/jsp/popup/login.jsp" />
 									</c:when>
 									<c:otherwise>
 										 <ul class="nav navbar-nav pull-right" id="login-pass">
		  									<li class="dropdown">
		  										<li class="dropdown user user-menu">
										            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
										              <span class="hidden-xs">
									             	  <!-- K000001 - นายกสิกร รักษ์ไทย -->
									 					${sessionScope.userInfo.userId } - ${sessionScope.userInfo.firstName} ${sessionScope.userInfo.lastName}
										              </span>
													  
										            </a>
										            <ul class="dropdown-menu">
										              <li class="user-header">
										                <img src="<c:url value="/images/user.png" />" class="img-circle" alt="User Image">
										
										                <p>
									                <!-- 
									                  K000001<br/> นายกสิกร  รักษ์ไทย <br/>
									                 -->
									                  ${sessionScope.userInfo.userId } <br/>
									                  ${sessionScope.userInfo.firstName} ${sessionScope.userInfo.lastName} <br/>
									                 
										                </p>
										              </li>
										              <li class="user-footer">
										              <!-- 
										                <div class="pull-left">
										                  <a href="javascript:void(0);" class="btn btn-default btn-flat">Profile</a>
										                </div>
										               -->
										                <div class="pull-right">
										                <c:url value="/j_spring_security_logout" var="logoutUrl" />
										                  <a href="javascript:signOut();" class="btn btn-default btn-flat">Sign out</a>
										                  <c:url value="/j_spring_security_logout" var="logoutUrl" />
														  <form action="${logoutUrl}" method="post" id="logoutForm">
															 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														  </form>
										                </div>
										              </li>
										            </ul>
										          </li>
								                <%-- <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">${sessionScope.userInfo.userId}<span class="caret"></span></a>
								                <ul class="dropdown-menu">
								                  <li><a href="<c:url value="/Profile" />"><i class="fas fa-user" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>โปรไฟล์</a></li>
								                   <c:if test="${sessionScope.userInfo.role eq 'ADMIN'}">
								  						<li><a href="<c:url value="/Admin/ManageUser" />"><i class="fas fa-user-plus" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i> จัดการผู้ใช้งานระบบ</a></li>
									  					<li><a href="<c:url value="/Admin/ManageData" />"><i class="fas fa-tablet-alt" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>จัดการเบอร์โทร</a></li>
									  					<li><a href="<c:url value="/Admin/ManageData" />"><i class="fas fa-tablet-alt" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>จัดการข้อมูลคำทำนาย</a></li>
									  					<li><a href="<c:url value="/Admin/ManageData" />"><i class="fas fa-tablet-alt" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>Setup Email</a></li>
								  					</c:if>
								                  <li>
								                  <a href="javascript:signOut();"><i class="fas fa-sign-out-alt" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>Logout</a></li>
								                </ul> --%>
		  								</ul>	 
		  								
		  								
  							<%-- 	<div class="navbar-custom-menu">
		    <ul class="nav navbar-nav">
	          <li class="dropdown user user-menu">
	            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
	              <span class="hidden-xs">
             	  <!-- K000001 - นายกสิกร รักษ์ไทย -->
 					${sessionScope.userInfo.userId } - ${sessionScope.userInfo.firstName} ${sessionScope.userInfo.lastName}
	              </span>
				  <img src="<c:url value="/css/img/human.png" />" class="user-image" alt="User Image">
	            </a>
	            <ul class="dropdown-menu">
	              <li class="user-header">
	                <img src="<c:url value="/css/img/avatar5.png" />" class="img-circle" alt="User Image">
	
	                <p>
                <!-- 
                  K000001<br/> นายกสิกร  รักษ์ไทย <br/>
                 -->
                  ${sessionScope.userInfo.userId } <br/>
                  ${sessionScope.userInfo.firstName} ${sessionScope.userInfo.lastName} <br/>
                 
	                </p>
	              </li>
	              <li class="user-footer">
	              <!-- 
	                <div class="pull-left">
	                  <a href="javascript:void(0);" class="btn btn-default btn-flat">Profile</a>
	                </div>
	               -->
	                <div class="pull-right">
	                  <a href="javascript:signOut();" class="btn btn-default btn-flat">Sign out</a>
	                  <c:url value="/j_spring_security_logout" var="logoutUrl" />
					  <form action="${logoutUrl}" method="post" id="logoutForm">
						 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					  </form>
	                </div>
	              </li>
	            </ul>
	          </li>
	        </ul>
	      </div>  --%>
	      
 									</c:otherwise>
 								</c:choose> 
 							</div>
 							<div class="my-dtac-mobile visible-xs visible-sm"><a href="#">xxxx</a></div> 
 							<div class="btn-menu-mobile visible-xs visible-sm"> 
 								<a href="#"> 
 									<i class="menu-line-top"></i> 
 									<i class="menu-line-middle"></i> 
 									<i class="menu-line-bottom"></i> 
 									<span>เมนู</span> 
 								</a> 
 							</div>
 						</div>
 					</div>
 					<div class="bottom-menu-wrapper"> <div class="wrapper clearfix"> 
 						<nav class="main-nav"> 
	  					<ul class="clearfix"> 
		  					<li class="current"><a href="<c:url value="/" />">เบอร์สวยคัดพิเศษ</a></li>
		  					<li><a href="<c:url value="/" />">ขอเบอร์ที่ไม่มีในระบบ</a></li>
		  					<li><a href="<c:url value="/Predict" />">คำนวณผลรวมเบอร์</a></li>
		  					<li><a href="<c:url value="/Predict" />">คำนวณผลรวมเบอร์</a>
		  						<div class="sub-menu"><ul class="list-bl-grey"><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-086-t-https://www.dtac.co.th/postpaid/products/new-number.html'});" href="https://www.dtac.co.th/postpaid/products/new-number.html">เปิดเบอร์ใหม่</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-054-t-https://www.dtac.co.th/mnp/'});" href="https://www.dtac.co.th/mnp/">ย้ายเครือข่ายเบอร์เดิม</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-051-t-https://www.dtac.co.th/postpaid/products/go-no-limit.html'});" href="https://www.dtac.co.th/postpaid/products/go-no-limit.html">แพ็กเกจหลัก</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-052-t-https://www.dtac.co.th/postpaid/products/recommended-add-on-package.html'});" href="https://www.dtac.co.th/postpaid/products/recommended-add-on-package.html">แพ็กเกจเสริม</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-053-t-https://my.dtac.co.th/esv/quickPayment'});" href="https://my.dtac.co.th/esv/quickPayment">ชำระค่าบริการรายเดือน</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-057-t-https://www.dtac.co.th/campaign/pre-to-post.html#Tab2'});" href="https://www.dtac.co.th/campaign/pre-to-post.html#Tab2">เปลี่ยนจากเติมเงินเป็นรายเดือน</a></li></ul></div>
		  					</li>
		  					<li><a href="#">จัดการผู้ใช้นะบบ</a>
		  						<div class="sub-menu">
		  							<ul class="list-bl-grey">
		  								<li><a onclick="" href="<c:url value="/Admin/RoleAndPrivilege" />">เปิดเบอร์ใหม่</a></li>
		  							</ul>
		  						</div>
		  					</li>
	  					</ul>
  					</nav> 
 					</div>
 					</div>
  			</header>
  		</div>
  		
  		<div class="wrapper">
  			<jsp:doBody/>
  		</div>
  		<div class="footer-wrapper">
  		<footer  >
  		<!-- <div class="row"><div class="col-sm-12 col-md-4 col-social"> <div class="logo"><a href="/"><span>dtac</span></a></div><div class="social-icon"> <ul class="clearfix"> <li class="ico-fb"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Facebook','EventLabel': 'th-dt-hh-so-01-i-https://www.facebook.com/dtac'});" href="https://www.facebook.com/dtac" target="_blank"><img src="/images/2017/icon-fb.png" alt=""></a></li><li class="ico-tw"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Twitter','EventLabel': 'th-dt-hh-so-02-i-https://twitter.com/dtac'});" href="https://twitter.com/dtac" target="_blank"><img src="/images/2017/icon-twt.png" alt=""></a></li><li class="ico-ig"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Instagram','EventLabel': 'th-dt-hh-so-04-i-http://instagram.com/dtac'});" href="http://instagram.com/dtac" target="_blank"><img src="/images/2017/icon-ig.png" alt=""></a></li><li class="ico-in"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Linked in','EventLabel': 'th-dt-hh-so-05-i-http://www.linkedin.com/company/dtac?trk=tyah&amp;trkInfo=tarId%3A1412152724451%2Ctas%3Adtac%2Cidx%3A2-1-4'});" href="http://www.linkedin.com/company/dtac?trk=tyah&amp;trkInfo=tarId%3A1412152724451%2Ctas%3Adtac%2Cidx%3A2-1-4" target="_blank"><img src="/images/2017/icon-in.png" alt=""></a></li></ul> </div></div><div class="col-sm-12 col-md-8 col-footer-nav"><div class="col-sm-4 col-nav"><h3>เกี่ยวกับดีแทค</h3><ul class="footer_ul"><li><a href="https://www.dtac.co.th/network/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-01-i-https://www.dtac.co.th/network/'});">dtac Network</a></li><li><a href="https://www.dtac.co.th/about/about-dtac.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-02-i-https://www.dtac.co.th/about/about-dtac.html'});">เกี่ยวกับเรา</a></li><li><a href="https://www.dtac.co.th/jobs/index.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-03-i-https://www.dtac.co.th/jobs/index.html'});">ทำงานที่ดีแทค</a></li><li><a href="https://www.dtac.co.th/jobs/apply" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/jobs/apply'});">สมัครงาน</a></li><li><a href="https://www.dtac.co.th/contract.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-05-i-https://www.dtac.co.th/contract.html'});">สัญญาการใช้บริการ</a></li></ul></div><div class="col-sm-4 col-nav"><h3>บริการลูกค้า</h3><ul class="footer_ul"><li><a href="https://www.dtac.co.th/mnp/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-01-i-https://www.dtac.co.th/mnp/'});">ย้ายเครือข่ายเบอร์เดิม</a></li><li><a href="https://my.dtac.co.th/esv/login" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-02-i-https://my.dtac.co.th/esv/login'});">mydtac</a></li><li><a href="http://dtac.co.th/dtacapp" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-03-i-http://dtac.co.th/dtacapp'});">dtac app</a></li><li><a href="https://www.dtac.co.th/info/dtac-call.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/info/dtac-call.html'});">dtac call</a></li><li><a href="https://www.dtac.co.th/info/familycare.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-05-i-https://www.dtac.co.th/info/familycare.html'});">dtac Family Care</a></li><li><a href="https://www.dtac.co.th/musicinfinite/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-06-i-https://www.dtac.co.th/musicinfinite/'});">Music Infinite</a></li><li><a href="https://www.dtac.co.th/help/store-locations.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-07-i-https://www.dtac.co.th/help/store-locations.html'});">ศูนย์บริการดีแทค</a></li><li><a href="https://www.dtac.co.th/postpaid/services/dtacnumber.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-08-i-https://www.dtac.co.th/postpaid/services/dtacnumber.html'});">หมายเลขน่ารู้ดีแทครายเดือน</a></li><li><a href="https://www.dtac.co.th/prepaid/services/happynumber.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-09-i-https://www.dtac.co.th/prepaid/services/happynumber.html'});">หมายเลขน่ารู้ดีแทคเติมเงิน</a></li><li><a href="https://store.dtac.co.th/tracking" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-10-i-https://store.dtac.co.th/tracking'});">เช็คสถานะการสั่งซื้อ</a></li><li><a href="https://www.dtac.co.th/postpaid/payment.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-11-i-https://www.dtac.co.th/postpaid/payment.html'});">ช่องทางชำระค่าบริการ</a></li><li><a href="https://www.dtac.co.th/prepaid/services/refill-channel.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-12-i-https://www.dtac.co.th/prepaid/services/refill-channel.html'});">ช่องทางการเติมเงิน</a></li><li><a href="https://www.dtac.co.th/info/prompt-pay.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-13-i-https://www.dtac.co.th/info/prompt-pay.html'});">บริการพร้อมเพย์</a></li></ul></div><div class="col-sm-4 col-nav"><h3>คุณคือ...</h3><ul class="footer_ul"><li><a href="http://dtac-th.listedcompany.com/home.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-01-i-http://dtac-th.listedcompany.com/home.html'});">นักลงทุน</a></li><li><a href="https://www.dtac.co.th/business/?c_lang=th&amp;c_module=business&amp;c_pagename=index.php" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-02-i-https://www.dtac.co.th/business/?c_lang=th&amp;c_module=business&amp;c_pagename=index.php'});">ลูกค้าองค์กร</a></li><li><a href="https://www.dtac.co.th/pressroom/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-03-i-https://www.dtac.co.th/pressroom/'});">สื่อมวลชน</a></li><li><a href="https://www.dtac.co.th/prepaid/services/prepaid-retailer.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/prepaid/services/prepaid-retailer.html'});">คนขายดีแทคเติมเงิน</a></li><li><a href="https://goo.gl/3ip9eb" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-05-i-https://goo.gl/3ip9eb'});">dtac Online Community</a></li><li><a href="https://www.dtac.co.th/info/retailer-directory.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-06-i-https://www.dtac.co.th/info/retailer-directory.html'});">ตัวแทนผู้ให้บริการ</a></li></ul></div></div><p class="copyright">© 2560 บมจ.โทเทิ่ล แอ็คเซ็ส คอมมูนิเคชั่น</p></div>
  		 --></footer></div>
  		
  		
  	</body>
</html>