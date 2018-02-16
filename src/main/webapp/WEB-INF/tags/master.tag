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
	<link rel="stylesheet" href="<c:url value="/css/daterangepicker.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/menu.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/content.css"/>">
	
	<script src="<c:url value="/js/jquery-2.1.4.min.js" />"></script>
	<script src="<c:url value="/js/jquery-ui/jquery-ui.js" />"></script>
	<script src="<c:url value="/js/bootstrap.js" />"></script>
	<script src="<c:url value="/js/bootstrap-select.min.js" />"></script>
	<script src="<c:url value="/js/global.js" />"></script>
	<script src="<c:url value="/js/loadingoverlay.js" />"></script>
    <script src="<c:url value="/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js" />"></script>
    <script src="<c:url value="/vendors/iCheck/icheck.min.js" />"></script>
    <script src="<c:url value="/vendors/DateJS/build/date.js" />"></script>
    <script src="<c:url value="/vendors/bootstrap-daterangepicker/daterangepicker.js" />"></script>
    <script src="<c:url value="/js/jquery-validate.bootstrap-tooltip.min.js" />"></script>
    <script src="<c:url value="/font-awesome/svg-with-js/js/fontawesome-all.js" />"></script>
    <script src="<c:url value="/js/script.js" />"></script>
	
 	</head>
 	<body>
  		<div id="dtac-header">
  			<div class="header-wrapper">
  				<header>
  					<div class="top-menu-wrapper">
  						<div class="wrapper clearfix">
  							<div class="logo pull-left">
  								<a href="/"><img src="<c:url value="/images/logo.png" />"></a>
  							</div>
  							
  							<div class="top-right-menu pull-right">
  								<img src="<c:url value="/images/user.png" />"style="width: 45px;height: 45px;"> 
  								<c:choose>
  									<c:when test="${sessionScope.userInfo.userId eq null}">
  										<a href="javascript:openLogin();" ><span>Login / Sign up</span></a>
  									</c:when>
  									<c:otherwise>
  										<ul class="nav navbar-nav pull-right">
		  									<li class="dropdown">
								                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">${sessionScope.userInfo.userId} <span class="caret"></span></a>
								                <ul class="dropdown-menu">
								                  <li><a href="<c:url value="/Profile" />"><i class="fas fa-user" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>Profile</a></li>
								                   <c:if test="${sessionScope.userInfo.role eq 'ADMIN'}">
								  						<li><a href="<c:url value="/Admin/ManageUser" />"><i class="fas fa-users" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i> จัดการผู้ใช้งานระบบ</a></li>
									  					<li><a href="<c:url value="/" />"><i class="fas fa-tablet-alt" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>จัดการเบอร์โทร</a></li>
									  					<li><a href="<c:url value="/" />"><i class="fas fa-tablet-alt" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>Import Data</a></li>
								  					</c:if>
								                  <li><a href="javascript:signOut();"><i class="fas fa-sign-out-alt" style="font-size:1.6em; color:Tomato;margin-right:10px;"></i>Logout</a></li>
							  						
								                </ul>
		             					 	</li>
		  								</ul>	
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
			  					<li id="m15" class="current"><a href="<c:url value="/" />">เบอร์สวยคัดพิเศษ</a></li>
			  					<li id="m15"><a href="<c:url value="/" />">รูปแบบเบอร์สวย</a></li>
			  					<li id="m15"><a href="<c:url value="/" />">เบอร์มงคล</a></li>
			  					<li id="m15"><a href="<c:url value="/Predict" />">คำนวณผลรวมเบอร์</a></li>
		  					</ul>
		  					<!-- </div></li><li class="has-submenu" id="m14"><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เติมเงิน','EventLabel':'th-dt-hh-mm-06-t-http://www.dtac.co.th/prepaid/'});" href="https://www.dtac.co.th/prepaid/">ดีแทคเติมเงิน</a><div class="sub-menu"><ul class="list-bl-grey"><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เติมเงิน','EventLabel':'th-dt-hh-mm-061-t-https://www.dtac.co.th/prepaid/products/sim-go-plearn.html'});" href="https://www.dtac.co.th/prepaid/products/sim-go-plearn.html">ซิมดีแทคเติมเงิน</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เติมเงิน','EventLabel':'th-dt-hh-mm-062-t-https://www.dtac.co.th/prepaid/products/all-main-packages.html'});" href="https://www.dtac.co.th/prepaid/products/all-main-packages.html">โปรโมชั่นหลัก</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เติมเงิน','EventLabel':'th-dt-hh-mm-063-t-https://www.dtac.co.th/prepaid/products/recommended-add-on.html'});" href="https://www.dtac.co.th/prepaid/products/recommended-add-on.html">โปรโมชั่นเสริม</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เติมเงิน','EventLabel':'th-dt-hh-mm-064-t-https://my.dtac.co.th/esv/quickRefill'});" href="https://my.dtac.co.th/esv/quickRefill">เติมเงินทันที</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เติมเงิน','EventLabel':'th-dt-hh-mm-065-t-https://www.dtac.co.th/prepaid/services/jai-dee.html'});" href="https://www.dtac.co.th/prepaid/services/jai-dee.html">บริการใจดี</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เติมเงิน','EventLabel':'th-dt-hh-mm-065-t-https://www.dtac.co.th/prepaid/services/mnp-prepaid.html'});" href="https://www.dtac.co.th/prepaid/services/mnp-prepaid.html">ย้ายเครือข่ายเบอร์เดิม</a></li></ul></div></li><li class="has-submenu" id="m21"><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการต่างประเทศ','EventLabel':'th-dt-hh-mm-09-t-http://www.dtac.co.th/postpaid/services/roaming/'});" href="https://www.dtac.co.th/ir/">บริการต่างประเทศ</a><div class="sub-menu"><ul class="list-bl-grey"><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-ดีแทครายเดือน','EventLabel':'th-dt-hh-mm-091-t-https://www.dtac.co.th/postpaid/services/roaming/'});" href="https://www.dtac.co.th/postpaid/services/roaming/">ดีแทครายเดือน</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-ดีแทคเติมเงิน','EventLabel':'th-dt-hh-mm-092-t-https://www.dtac.co.th/prepaid/services/roaming/'});" href="https://www.dtac.co.th/prepaid/services/roaming/">ดีแทคเติมเงิน</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-ซิม GO!อินเตอร์','EventLabel':'th-dt-hh-mm-093-t-https://www.dtac.co.th/gointer'});" href="https://www.dtac.co.th/gointer">ซิม GO! อินเตอร์</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการโทรไปต่างประเทศ','EventLabel':'th-dt-hh-mm-094-t-https://www.dtac.co.th/ir-prepaid/'});" href="https://www.dtac.co.th/ir-prepaid/">บริการโทรไปต่างประเทศ</a></li></ul></div></li><li class="has-submenu" id="m16"><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-dtac reward','EventLabel':'th-dt-hh-mm-08-t-http://www.dtac.co.th/dtacreward/'});" href="https://www.dtac.co.th/dtacreward/">dtac reward</a><div class="sub-menu"><ul class="list-bl-grey"><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-dtac reward','EventLabel':'th-dt-hh-mm-081-t-https://www.dtac.co.th/dtacreward/condition.html'});" href="https://www.dtac.co.th/dtacreward/condition.html">รู้จัก dtac reward</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-dtac reward','EventLabel':'th-dt-hh-mm-082-t-https://www.dtac.co.th/dtacreward/dining'});" href="https://www.dtac.co.th/dtacreward/dining">Dining</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-dtac reward','EventLabel':'th-dt-hh-mm-083-t-https://www.dtac.co.th/dtacreward/travel'});" href="https://www.dtac.co.th/dtacreward/travel">Travel</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-dtac reward','EventLabel':'th-dt-hh-mm-084-t-https://www.dtac.co.th/dtacreward/lifestyle'});" href="https://www.dtac.co.th/dtacreward/lifestyle">Lifestyle</a></li><li><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-dtac reward','EventLabel':'th-dt-hh-mm-085-t-http://www.dtac.co.th/campaign/dtacreward/weeklydeal.html'});" href="http://www.dtac.co.th/campaign/dtacreward/weeklydeal.html">พุธ! สุดคุ้ม</a></li></ul></div></li><li id="m22"><a onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-Best Deal','EventLabel':'th-dt-hh-mm-08-t-http://www.dtac.co.th/camp/device/best-deal.html'});" href="https://www.dtac.co.th/camp/device/best-deal.html">Best Deal</a></li>  -->
		  					</ul> 
	  					</nav> 
  					</div>
  					</div>
	  			</header>
	  		</div>
  		</div>
  		
  		<div class="wrapper">
  		<div class="row">
  			<jsp:doBody/>
  		</div>
  		</div>
  		<div class="footer-wrapper">
  		<footer  >
  		<!-- <div class="row"><div class="col-sm-12 col-md-4 col-social"> <div class="logo"><a href="/"><span>dtac</span></a></div><div class="social-icon"> <ul class="clearfix"> <li class="ico-fb"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Facebook','EventLabel': 'th-dt-hh-so-01-i-https://www.facebook.com/dtac'});" href="https://www.facebook.com/dtac" target="_blank"><img src="/images/2017/icon-fb.png" alt=""></a></li><li class="ico-tw"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Twitter','EventLabel': 'th-dt-hh-so-02-i-https://twitter.com/dtac'});" href="https://twitter.com/dtac" target="_blank"><img src="/images/2017/icon-twt.png" alt=""></a></li><li class="ico-ig"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Instagram','EventLabel': 'th-dt-hh-so-04-i-http://instagram.com/dtac'});" href="http://instagram.com/dtac" target="_blank"><img src="/images/2017/icon-ig.png" alt=""></a></li><li class="ico-in"><a onclick="dataLayer.push({'event':'click','EventAction': 'click','EventCategory': 'hh-Linked in','EventLabel': 'th-dt-hh-so-05-i-http://www.linkedin.com/company/dtac?trk=tyah&amp;trkInfo=tarId%3A1412152724451%2Ctas%3Adtac%2Cidx%3A2-1-4'});" href="http://www.linkedin.com/company/dtac?trk=tyah&amp;trkInfo=tarId%3A1412152724451%2Ctas%3Adtac%2Cidx%3A2-1-4" target="_blank"><img src="/images/2017/icon-in.png" alt=""></a></li></ul> </div></div><div class="col-sm-12 col-md-8 col-footer-nav"><div class="col-sm-4 col-nav"><h3>เกี่ยวกับดีแทค</h3><ul class="footer_ul"><li><a href="https://www.dtac.co.th/network/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-01-i-https://www.dtac.co.th/network/'});">dtac Network</a></li><li><a href="https://www.dtac.co.th/about/about-dtac.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-02-i-https://www.dtac.co.th/about/about-dtac.html'});">เกี่ยวกับเรา</a></li><li><a href="https://www.dtac.co.th/jobs/index.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-03-i-https://www.dtac.co.th/jobs/index.html'});">ทำงานที่ดีแทค</a></li><li><a href="https://www.dtac.co.th/jobs/apply" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/jobs/apply'});">สมัครงาน</a></li><li><a href="https://www.dtac.co.th/contract.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-เกี่ยวกับดีแทค','EventLabel':'th-dt-hh-fo-05-i-https://www.dtac.co.th/contract.html'});">สัญญาการใช้บริการ</a></li></ul></div><div class="col-sm-4 col-nav"><h3>บริการลูกค้า</h3><ul class="footer_ul"><li><a href="https://www.dtac.co.th/mnp/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-01-i-https://www.dtac.co.th/mnp/'});">ย้ายเครือข่ายเบอร์เดิม</a></li><li><a href="https://my.dtac.co.th/esv/login" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-02-i-https://my.dtac.co.th/esv/login'});">mydtac</a></li><li><a href="http://dtac.co.th/dtacapp" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-03-i-http://dtac.co.th/dtacapp'});">dtac app</a></li><li><a href="https://www.dtac.co.th/info/dtac-call.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/info/dtac-call.html'});">dtac call</a></li><li><a href="https://www.dtac.co.th/info/familycare.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-05-i-https://www.dtac.co.th/info/familycare.html'});">dtac Family Care</a></li><li><a href="https://www.dtac.co.th/musicinfinite/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-06-i-https://www.dtac.co.th/musicinfinite/'});">Music Infinite</a></li><li><a href="https://www.dtac.co.th/help/store-locations.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-07-i-https://www.dtac.co.th/help/store-locations.html'});">ศูนย์บริการดีแทค</a></li><li><a href="https://www.dtac.co.th/postpaid/services/dtacnumber.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-08-i-https://www.dtac.co.th/postpaid/services/dtacnumber.html'});">หมายเลขน่ารู้ดีแทครายเดือน</a></li><li><a href="https://www.dtac.co.th/prepaid/services/happynumber.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-09-i-https://www.dtac.co.th/prepaid/services/happynumber.html'});">หมายเลขน่ารู้ดีแทคเติมเงิน</a></li><li><a href="https://store.dtac.co.th/tracking" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-10-i-https://store.dtac.co.th/tracking'});">เช็คสถานะการสั่งซื้อ</a></li><li><a href="https://www.dtac.co.th/postpaid/payment.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-11-i-https://www.dtac.co.th/postpaid/payment.html'});">ช่องทางชำระค่าบริการ</a></li><li><a href="https://www.dtac.co.th/prepaid/services/refill-channel.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-12-i-https://www.dtac.co.th/prepaid/services/refill-channel.html'});">ช่องทางการเติมเงิน</a></li><li><a href="https://www.dtac.co.th/info/prompt-pay.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hh-บริการลูกค้า','EventLabel':'th-dt-hh-fo-13-i-https://www.dtac.co.th/info/prompt-pay.html'});">บริการพร้อมเพย์</a></li></ul></div><div class="col-sm-4 col-nav"><h3>คุณคือ...</h3><ul class="footer_ul"><li><a href="http://dtac-th.listedcompany.com/home.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-01-i-http://dtac-th.listedcompany.com/home.html'});">นักลงทุน</a></li><li><a href="https://www.dtac.co.th/business/?c_lang=th&amp;c_module=business&amp;c_pagename=index.php" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-02-i-https://www.dtac.co.th/business/?c_lang=th&amp;c_module=business&amp;c_pagename=index.php'});">ลูกค้าองค์กร</a></li><li><a href="https://www.dtac.co.th/pressroom/" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-03-i-https://www.dtac.co.th/pressroom/'});">สื่อมวลชน</a></li><li><a href="https://www.dtac.co.th/prepaid/services/prepaid-retailer.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-04-i-https://www.dtac.co.th/prepaid/services/prepaid-retailer.html'});">คนขายดีแทคเติมเงิน</a></li><li><a href="https://goo.gl/3ip9eb" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-05-i-https://goo.gl/3ip9eb'});">dtac Online Community</a></li><li><a href="https://www.dtac.co.th/info/retailer-directory.html" onclick="dataLayer.push({'event':'click','EventAction':'click','EventCategory':'hhคุณคือ','EventLabel':'th-dt-hh-fo-06-i-https://www.dtac.co.th/info/retailer-directory.html'});">ตัวแทนผู้ให้บริการ</a></li></ul></div></div><p class="copyright">© 2560 บมจ.โทเทิ่ล แอ็คเซ็ส คอมมูนิเคชั่น</p></div>
  		 --></footer></div>
  		
  		<jsp:include page="/WEB-INF/jsp/login.jsp" />
  		
  	</body>
</html>