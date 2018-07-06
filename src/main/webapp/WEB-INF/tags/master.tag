<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>เบอร์มงคล เบอร์ดี vipsim.co</title>
	<meta name="description" content="เบอร์มงคล เบอร์ดี  เบอร์รวย เบอร์หวย เบอร์แพลทตินัม">
	<meta name="csrf-token" content="${_csrf.token}">
	<link rel="icon" href="<c:url value="/css/img/favicon.ico" />">
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value="/bootstrap/css/bootstrap.css" />">
	<link rel="stylesheet" href="<c:url value="/js/jquery-ui/jquery-ui.css" />">
	<link rel="stylesheet" href="<c:url value="/css/bootstrap-select.min.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/bootstrap-datepicker3.min.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/dataTables.bootstrap.min.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/menu.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/content.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/responsive.css"/>">
	
	<script src="<c:url value="/js/jquery-2.1.4.min.js" />"></script>
	<script src="<c:url value="/bootstrap/js/bootstrap.js" />"></script>
	<script src="<c:url value="/js/jquery-ui/jquery-ui.js" />"></script>
	<script src="<c:url value="/js/bootstrap-select.min.js" />"></script>
	<script src="<c:url value="/js/global.js" />"></script>
	<script src="<c:url value="/js/loadingoverlay.js" />"></script>
	<script src="<c:url value="/js/jquery.mask.min.js" />"></script>
	<script src="<c:url value="/js/jquery.dropotron.js" />"></script>
    <script src="<c:url value="/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js" />"></script>
    <script src="<c:url value="/vendors/iCheck/icheck.min.js" />"></script>
    <script src="<c:url value="/vendors/DateJS/build/date.js" />"></script>
    <script src="<c:url value="/js/jquery-validate.bootstrap-tooltip.min.js" />"></script>
    <script src="<c:url value="/font-awesome/svg-with-js/js/fontawesome-all.js" />"></script>
    <script src="<c:url value="/js/bootstrap-datepicker.min.js" />"></script>
    <script src="<c:url value="/js/jquery.dataTables.js" />"></script>
    <script src="<c:url value="/js/dataTables.bootstrap.min.js" />"></script>
    <script src="<c:url value="/js/numeral.min.js" />"></script>
    <script src="<c:url value="/js/jquery-dateFormat.min.js" />"></script>
    <script src="<c:url value="/js/jquery.checkbox.js" />"></script>
    <script src="<c:url value="/js/script.js" />"></script>
	<script>
		$(function() {
			
			// Note: make sure you call dropotron on the top level <ul>
			$('.main-nav > ul').dropotron({ 
				offsetY: -10 // Nudge up submenus by 10px to account for padding
			});
		
		});
	</script>
 	</head>
 	<body> 
 			<div class="header-wrapper">
 				<header>
					<c:if test="${sessionScope.userInfo.userId eq null}">
						<jsp:include page="/WEB-INF/jsp/popup/login.jsp" />
					</c:if>
 					<div class="top-menu-wrapper">
 						<div class="wrapper clearfix">
 							<div class="logo pull-left">
 								<a href="/"><img src="<c:url value="/images/logo.png" />"></a>
 							</div>
 							<div class="top-right-menu pull-right">
 								<img src="<c:url value="/images/user.png" />"> 
 								<c:choose>
 									<c:when test="${sessionScope.userInfo.userId eq null}">
 										<a href="javascript:openLogin();" id="not-login"><span>เข้าสู่ระบบ / สมัครสมาชิก</span></a>
 									</c:when>
 									<c:otherwise>
 									
 										<ul class="nav navbar-nav pull-right" id="login-pass">								
									        <li class="dropdown">
									          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${sessionScope.userInfo.firstName} ${sessionScope.userInfo.lastName} &nbsp;&nbsp;<span class="caret"></span></a>
									          <ul class="dropdown-menu" style="min-width:100%;">
									          	<c:choose>
										          	<c:when test="${sessionScope.userInfo.userType eq 'CUSTOMER'}">
											            <li><a href="<c:url value="/Profile" />"><span class="glyphicon glyphicon glyphicon-user" aria-hidden="true"></span> &nbsp;&nbsp;ข้อมูลส่วนตัว</a></li>
											            <li><a href="<c:url value="/ChangePassword" />"><span class="fas fa-key" aria-hidden="true"></span> &nbsp;&nbsp;แก้ไข Password</a></li>
											            <li><a href="<c:url value="/MyBooking" />"><span class="far fa-file" aria-hidden="true"></span> &nbsp;&nbsp;ข้อมูลการจอง</a></li>
										            </c:when>
										            <c:otherwise>
										            	<%-- <li><a href="<c:url value="/Profile" />"><span class="glyphicon glyphicon glyphicon-user" aria-hidden="true"></span> &nbsp;&nbsp;ข้อมูลส่วนตัว</a></li> --%>
										            	<li><a href="<c:url value="/ChangePassword" />"><span class="fas fa-key" aria-hidden="true"></span> &nbsp;&nbsp;แก้ไข Password</a></li>	
										            </c:otherwise>
									            </c:choose>
									            <li role="separator" class="divider"></li>
									            <li style="float:right;margin-right:5px;">
									            	<button class="btn btn-default" onclick="signOut();"><i class="fas fa-share-square"></i> Sign out</button>
									            </li>
									          </ul>
									        </li>
      
 										 </ul>
		  								<c:url value="/j_spring_security_logout" var="logoutUrl" />
  										<form action="${logoutUrl}" method="post" id="logoutForm">
										 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									  </form>
 									</c:otherwise>
 								</c:choose> 
 							</div>
 						</div>
 					</div>
 					<div class="bottom-menu-wrapper"> 
 						<div class="wrapper clearfix"> 
	 						<nav class="main-nav cf" style="display:none;"> 
	 							<a href="#" id="openup">MENU</a>
			  					<ul class="cf"> 
				  					<%-- <li class="current"><a href="<c:url value="/" />">เบอร์สวยคัดพิเศษ</a></li>
				  					<li><a href="<c:url value="/" />">ขอเบอร์ที่ไม่มีในระบบ</a></li>
				  					<li><a href="<c:url value="/Predict" />">คำนวณผลรวมเบอร์</a></li>
				  					<li><a href="<c:url value="/Predict" />">คำนวณผลรวมเบอร์</a>
				  						<div class="sub-menu"><ul class="list-bl-grey"><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-086-t-https://www.dtac.co.th/postpaid/products/new-number.html'});" href="https://www.dtac.co.th/postpaid/products/new-number.html">เปิดเบอร์ใหม่</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-054-t-https://www.dtac.co.th/mnp/'});" href="https://www.dtac.co.th/mnp/">ย้ายเครือข่ายเบอร์เดิม</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-051-t-https://www.dtac.co.th/postpaid/products/go-no-limit.html'});" href="https://www.dtac.co.th/postpaid/products/go-no-limit.html">แพ็กเกจหลัก</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-052-t-https://www.dtac.co.th/postpaid/products/recommended-add-on-package.html'});" href="https://www.dtac.co.th/postpaid/products/recommended-add-on-package.html">แพ็กเกจเสริม</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-053-t-https://my.dtac.co.th/esv/quickPayment'});" href="https://my.dtac.co.th/esv/quickPayment">ชำระค่าบริการรายเดือน</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-รายเดือน','EventLabel':'th-dt-hh-mm-057-t-https://www.dtac.co.th/campaign/pre-to-post.html#Tab2'});" href="https://www.dtac.co.th/campaign/pre-to-post.html#Tab2">เปลี่ยนจากเติมเงินเป็นรายเดือน</a></li></ul></div>
				  					</li>
				  					<li><a href="#">จัดการผู้ใช้</a>
				  						<div class="sub-menu">
				  							<ul class="list-bl-grey">
				  								<li><a href="<c:url value="/Admin/RolePrivilege" />">กำหนดสิทธิ์</a></li>
				  							</ul>
				  						</div>
				  					</li> --%>
				  					<%=request.getSession().getAttribute("generateMenu") %>
				  					
			  					</ul>
		  					</nav> 
 						</div>
 					</div>
  			</header>
  		</div>
  		
  		<div class="wrapper">
  			<jsp:doBody/>
  		</div>
  		<%-- <div class="footer-wrapper">
  			<footer>
	  			<div class="row">
	  			<div class="wrapper clearfix">
	  			<nav class="main-nav"><ul class="clearfix"><%=request.getSession().getAttribute("generateMenu") %></ul></nav>
	  			</div>
	  				<!-- <div class="col-sm-12 col-md-8 col-footer-nav"> -->
	  				<!-- <div class="col-sm-12 col-md-4 col-social"> 
	  					<div class="logo">
	  						<a href="/"><span>dtac</span></a>
	  					</div>
	  					<div class="social-icon"> 
	  						<ul class="clearfix"> 
	  							<li class="ico-fb"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Facebook','EventLabel': 'th-dt-hh-so-01-i-https://www.facebook.com/dtac'});" href="https://www.facebook.com/dtac" target="_blank"><img src="/images/2017/icon-fb.png" alt=""></a></li>
	  							<li class="ico-tw"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Twitter','EventLabel': 'th-dt-hh-so-02-i-https://twitter.com/dtac'});" href="https://twitter.com/dtac" target="_blank"><img src="/images/2017/icon-twt.png" alt=""></a></li>
	  							<li class="ico-ig"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Instagram','EventLabel': 'th-dt-hh-so-04-i-http://instagram.com/dtac'});" href="http://instagram.com/dtac" target="_blank"><img src="/images/2017/icon-ig.png" alt=""></a></li>
	  							<li class="ico-in"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Linked in','EventLabel': 'th-dt-hh-so-05-i-http://www.linkedin.com/company/dtac?trk=tyah&amp;trkInfo=tarId%3A1412152724451%2Ctas%3Adtac%2Cidx%3A2-1-4'});" href="http://www.linkedin.com/company/dtac?trk=tyah&amp;trkInfo=tarId%3A1412152724451%2Ctas%3Adtac%2Cidx%3A2-1-4" target="_blank"><img src="/images/2017/icon-in.png" alt=""></a></li>
	  						</ul> 
	  					</div>
	  				</div>
	  				<div class="col-sm-12 col-md-8 col-footer-nav">
	  					<div class="col-sm-4 col-nav"><h3>เกี่ยวกับดีแทค</h3>
	  						<ul class="footer_ul">
	  							<li><a href="https://www.dtac.co.th/network/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-01-i-https://www.dtac.co.th/network/'});">dtac Network</a></li>
	  							<li><a href="https://www.dtac.co.th/about/about-dtac.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-02-i-https://www.dtac.co.th/about/about-dtac.html'});">เกี่ยวกับเรา</a></li>
	  							<li><a href="https://www.dtac.co.th/jobs/index.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-03-i-https://www.dtac.co.th/jobs/index.html'});">ทำงานที่ดีแทค</a></li>
	  							<li><a href="https://www.dtac.co.th/jobs/apply" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/jobs/apply'});">สมัครงาน</a></li>
	  							<li><a href="https://www.dtac.co.th/contract.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-05-i-https://www.dtac.co.th/contract.html'});">สัญญาการใช้บริการ</a></li>
	  						</ul>
	  					</div>
	  					<div class="col-sm-4 col-nav">
	  						<h3>บริการลูกค้า</h3>
	  						<ul class="footer_ul">
	  							<li><a href="https://www.dtac.co.th/mnp/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-01-i-https://www.dtac.co.th/mnp/'});">ย้ายเครือข่ายเบอร์เดิม</a></li>
	  							<li><a href="https://my.dtac.co.th/esv/login" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-02-i-https://my.dtac.co.th/esv/login'});">mydtac</a></li>
	  							<li><a href="http://dtac.co.th/dtacapp" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-03-i-http://dtac.co.th/dtacapp'});">dtac app</a></li>
	  							<li><a href="https://www.dtac.co.th/info/dtac-call.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/info/dtac-call.html'});">dtac call</a></li>
	  							<li><a href="https://www.dtac.co.th/info/familycare.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-05-i-https://www.dtac.co.th/info/familycare.html'});">dtac Family Care</a></li>
	  							<li><a href="https://www.dtac.co.th/musicinfinite/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-06-i-https://www.dtac.co.th/musicinfinite/'});">Music Infinite</a></li>
	  							<li><a href="https://www.dtac.co.th/help/store-locations.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-07-i-https://www.dtac.co.th/help/store-locations.html'});">ศูนย์บริการดีแทค</a></li>
	  							<li><a href="https://www.dtac.co.th/postpaid/services/dtacnumber.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-08-i-https://www.dtac.co.th/postpaid/services/dtacnumber.html'});">หมายเลขน่ารู้ดีแทครายเดือน</a></li>
	  							<li><a href="https://www.dtac.co.th/prepaid/services/happynumber.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-09-i-https://www.dtac.co.th/prepaid/services/happynumber.html'});">หมายเลขน่ารู้ดีแทคเติมเงิน</a></li>
	  							<li><a href="https://store.dtac.co.th/tracking" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-10-i-https://store.dtac.co.th/tracking'});">เช็คสถานะการสั่งซื้อ</a></li>
	  							<li><a href="https://www.dtac.co.th/postpaid/payment.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-11-i-https://www.dtac.co.th/postpaid/payment.html'});">ช่องทางชำระค่าบริการ</a></li>
	  							<li><a href="https://www.dtac.co.th/prepaid/services/refill-channel.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-12-i-https://www.dtac.co.th/prepaid/services/refill-channel.html'});">ช่องทางการเติมเงิน</a></li>
	  							<li><a href="https://www.dtac.co.th/info/prompt-pay.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-13-i-https://www.dtac.co.th/info/prompt-pay.html'});">บริการพร้อมเพย์</a></li>	
	  						</ul>
	  					</div>
	  				<div class="col-sm-4 col-nav">
	  					<h3>คุณคือ...</h3>
	  					<ul class="footer_ul">
	  						<li><a href="http://dtac-th.listedcompany.com/home.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-01-i-http://dtac-th.listedcompany.com/home.html'});">นักลงทุน</a></li>
	  						<li><a href="https://www.dtac.co.th/business/?c_lang=th&amp;c_module=business&amp;c_pagename=index.php" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-02-i-https://www.dtac.co.th/business/?c_lang=th&amp;c_module=business&amp;c_pagename=index.php'});">ลูกค้าองค์กร</a></li>
	  						<li><a href="https://www.dtac.co.th/pressroom/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-03-i-https://www.dtac.co.th/pressroom/'});">สื่อมวลชน</a></li><li><a href="https://www.dtac.co.th/prepaid/services/prepaid-retailer.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/prepaid/services/prepaid-retailer.html'});">คนขายดีแทคเติมเงิน</a></li>
	  						<li><a href="https://goo.gl/3ip9eb" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-05-i-https://goo.gl/3ip9eb'});">dtac Online Community</a></li><li><a href="https://www.dtac.co.th/info/retailer-directory.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-06-i-https://www.dtac.co.th/info/retailer-directory.html'});">ตัวแทนผู้ให้บริการ</a></li>
	  					</ul>
	  				</div>
	  			</div> -->
	  			<p class="copyright">© 2560 บมจ.โทเทิ่ล แอ็คเซ็ส คอมมูนิเคชั่น</p>
	  		</div>
	  		 
	  		 	<div class="row"><div class="col-sm-12 col-md-4"><%=request.getSession().getAttribute("generateFooter") %></div></div>
	  		 
	  		  
  		    </footer>
  		</div> --%>
  		<footer>
  			
  	<div class="footer-wrapper">
	  			<div class="row">
	  			<div class="wrapper clearfix">
	  			<%-- <div class="main-nav"><ul class="clearfix"><%=request.getSession().getAttribute("generateMenu") %></ul></div> --%>
	  			</div>
	  				
	  			<p>© Copyright 2018 vipsim.co</p>
	  		</div>
	  		 </div>
	  		  
  		    </footer>
  		<script>activeUrl();</script>
  		<script type="text/javascript">
  			$(function() {
				 menu = $('nav ul');
			
			  $('#openup').on('click', function(e) {
			    e.preventDefault(); menu.slideToggle();
			  });
			  
			 /*  $(window).resize(function(){
			    var w = $(this).width(); if(w > 480 && menu.is(':hidden')) {
			      menu.removeAttr('style');
			    }
			  }); */
			  
			  $('nav li').on('click', function(e) {                
			    var w = $(window).width(); if(w < 480 ) {
			      menu.slideToggle(); 
			    }
			  });
			  $('.open-menu').height($(window).height()); 
			});
  		</script>
  	</body>
  			
  		
</html>