<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	<script src="<c:url value="/js/sim.js" />"></script>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<ul class="progress-tracker"> 
	   			<li class="step-0-title progress-tracker-visited"> 
	   				<span class="visible-md-block visible-lg-block desktop">1. เลือกเบอร์โทรศัพท์</span> 
	   				<small class="visible-xs-block visible-sm-block mobile" >เลือก</small> 
	   			</li> 
	   			<li class="step-1-title progress-tracker-active"> 
	   				<span class="visible-md-block visible-lg-block desktop" >2. แสดงเบอร์ที่จอง</span> 
	   				<small class="visible-xs-block visible-sm-block mobile">เบอร์ที่จอง</small> 
	   			</li>
	   			<li class="step-2-title"> 
	   				<span class="visible-md-block visible-lg-block desktop">3. ยืนยันการจอง</span> 
	   				<small class="visible-xs-block visible-sm-block mobile">ยืนยัน</small> 
	   			</li> 
	   			<li class="step-3-title"> 
	   				<span class="visible-md-block visible-lg-block desktop" >4. การจองเสร็จสมบูรณ์!</span> 
	   				<small class="visible-xs-block visible-sm-block mobile">เสร็จสิ้น</small> 
	   			</li>
	   		</ul>
	   	</div>
	</div>
	<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
              <div class="x_panel tile overflow_hidden">
              	<div class="row" style="margin:10px">
              		<div class="col-md-6 col-sm-6 col-xs-6">
		                  <b id="logo-phone"><img src="<c:url value="/images/phone.png" />"/> เบอร์โทรศัพท์ <img src="<c:url value="/images/truemove.png" />" id="truemove-logo"/></b>
	                 </div>
	                  <div class="col-md-6 col-sm-6 col-xs-6">
	                  	<button class="btn-lg btn-round-solid bg-blue-weight pull-right btn-select-num" onclick="jumpToSim();">
						  <i class="fa fa-chevron-left"></i> <span> กลับไปเลือกเบอร์ใหม่</span>
						</button>
	                  </div>
	                
                </div>
                <div class="x_content">
					<div class="panel-round-bd selected-panel">

                  <div class="clearfix" style="height:10px"></div>
                  <div class="head">
                    <div class="col-xxs-6 col-xs-5 col-sm-4 col-md-3">เบอร์สวย </div>
                    <div class="col-sm-4 col-md-3 hidden-xs hidden-xxs">ประเภทซิม  </div>
                    <div class="col-xxs-5 col-xs-4 col-sm-2 col-md-4 text-center">ผลรวม </div>
                  	<div class="col-xxs-1 col-xs-3 col-sm-2 col-md-2 text-right"></div>
				  </div>
				  <c:forEach var="item" items="${sims}">
				   	  <div class="selected-item disable" id="mobile-${item.key}">
	                    <div class="row">
	                      <input type="radio" class="option-input radio" name="selected" value="${item.key}">
                          <div class="col-xxs-6 col-xs-5 col-sm-4 col-md-3 txt-number">${item.key}</div>
                          <div class="col-sm-4 col-md-3 hidden-xs hidden-xxs txt-category">PLATINUM NUMBER</div>
	                      <div class="col-xxs-5 col-xs-4 col-sm-2 col-md-4 text-center">${item.value.sumNumber}</div>
	                      <div class="col-xxs-1 col-xs-3 col-sm-2 col-md-2 text-right txt-close">
	                        <i class="fa fa-times-circle" style="cursor:pointer;" onclick="removeMobile('${item.key}');"></i>
	                      </div>
	                    </div>
	                  </div>
				</c:forEach>             
                  <div class="row">
                      <div class="col-xxs-12 col-xs-12 col-sm-12 col-md-12">
                      	<div class="text-center" style="margin-top:20px;">
	                      	<button class="btn-round-solid bg-gd-submit" id="submit-btn">
							   <span>ยืนยันการจอง</span>
							</button>
						</div>
                      </div>
                  </div>                  
                 <!--                  <div class="clearfix" style="height:30px"></div>
                <div class="font-c-red text-center">
                  การลงทะเบียนจองหมายเลขในระบบเป็นขั้นตอนเพื่ออำนวยความสะดวกกับลูกค้าเบื้องต้นเท่านั้น ความเป็นเจ้าของเลขหมายจะสมบูรณ์ต่อเมื่อผู้จองได้ดำเนินการจดทะเบียน ตามขั้นตอนที่บริษัทฯกำหนดครบถ้วนทุกประการ หากผู้จองยังมิได้ดำเนินการจดทะเบียน จะไม่สามารถเรียกร้องจากบริษัทฯ สำหรับความเสียหายใดทั้งสิ้น                </div>

                <div class="clearfix" style="margin-top:40px"></div>
                <a href="javascript:;" id="btn-privilege2" class="btn-md btn-round-solid bg-gd-pnk font-c-white center-block text-center btn-privilege2" style="">
                  ตรวจสอบสิทธิ์ในการซื้อเบอร์สวย                </a>
                <div class="btn-md btn-round-solid bg-gd-pnk font-c-white center-block text-center btn-select-package disable" id="btn-select-package" style="display:none">
                  เลือกแพ็คเกจ                </div> -->
 				  </div>
                </div>
              </div>
            </div>
	    </div>
	    <br/>
		<br/>
	    <script>
	    
	    $(document).ready(function(){
    	    $('#submit-btn').click(function(){
    	    	sendGetAjax('/CheckSessionLogin', function(data){
    	    		if(data == 0){
    	    			openLogin();
    	    		}else{
    	    			var global = new Global();
	    				window.location = global.contextPath() + 'SubmitConfirm'; 
    	    		}
    	    	});
    	    });
	    });
	    function jumpToSim(){
	    	var global = new Global();
	    	window.location = global.contextPath();
	    }
	    
	    function removeMobile(id){
	    	var obj = {
	    		simNumber: id
	    	};
	    	sendPostAjax('/Sim/RemoveSesionSim', obj, function(data){
	    		$("#mobile-" + id).fadeOut("slow");
	    		if(data == '' || data == 0){
	    			window.location = global.contextPath();
	    		}
	    	});
	    }
	    </script>
	</jsp:body>
</t:master>