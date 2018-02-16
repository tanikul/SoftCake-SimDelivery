<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	<script src="<c:url value="/js/sim.js" />"></script>
	<br/>
	<br/>
		
	<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
              <div class="x_panel tile overflow_hidden">
              	<div class="row" style="margin:10px">
              		<div class="col-md-6 col-sm-6 col-xs-6">
		                <div class="x_title">
		                  <h3><img src="<c:url value="/images/phone.png" />" style="height: 40px;margin-bottom: 10px;"/> เบอร์ที่คุณเลือก</h3>
		                  <div class="clearfix"></div>
	                  </div>
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
                    <div class="col-xxs-6 col-xs-6 col-sm-6 col-md-3">เบอร์สวย </div>
                    <div class="col-xxs-3 col-xs-3 col-sm-3 col-md-3 hidden-sm hidden-xs hidden-xxs">ประเภทซิม  </div>
                    <div class="col-xxs-2 col-xs-2 col-sm-2 col-md-4 text-center hidden-xs hidden-xxs">ผลรวม </div>
                  	<div class="col-xxs-2 col-xs-2 col-sm-2 col-md-2 text-right"></div>
				  </div>
                  <div class="selected-item disable">
                    <div class="row">
                      <input type="radio" class="option-input radio" name="selected" value="061-714-8888">
                      <div class="col-xxs-6 col-xs-6 col-sm-6 col-md-6">
                        <div class="row">
                          <div class="col-xxs-12 col-xs-12 col-sm-16 col-md-6 txt-number">061-714-8888</div>
                          <div class="col-xxs-12 col-xs-12 col-sm-16 col-md-6 txt-category">PLATINUM NUMBER</div>
                        </div>
                      </div>
                      <div class="col-xxs-2 col-xs-2 col-sm-2 col-md-4 text-center txt-sum hidden-xxs">
                        <div class="visible-xxs visible-xs visible-sm" style="margin-top:5px"></div>
                        51</div>
                      <div class="col-xxs-2 col-xs-2 col-sm-2 col-md-2 text-right txt-close pull-right">
                        <div class="visible-xxs visible-xs visible-sm" style="margin-top:5px"></div>
                        <i class="fa fa-times-circle"></i>
                      </div>
                    </div>
                  </div>
                  <div class="selected-item disable">
                    <div class="row">
                      <input type="radio" class="option-input radio" name="selected" value="061-714-8888">
                      <div class="col-xxs-6 col-xs-6 col-sm-6 col-md-6">
                        <div class="row">
                          <div class="col-xxs-12 col-xs-12 col-sm-16 col-md-6 txt-number">061-714-8888</div>
                          <div class="col-xxs-12 col-xs-12 col-sm-16 col-md-6 txt-category">PLATINUM NUMBER</div>
                        </div>
                      </div>
                      <div class="col-xxs-2 col-xs-2 col-sm-2 col-md-4 text-center txt-sum hidden-xxs">
                        <div class="visible-xxs visible-xs visible-sm" style="margin-top:5px"></div>
                        51</div>
                      <div class="col-xxs-2 col-xs-2 col-sm-2 col-md-2 text-right txt-close pull-right">
                        <div class="visible-xxs visible-xs visible-sm" style="margin-top:5px"></div>
                        <i class="fa fa-times-circle"></i>
                      </div>
                    </div>
                  </div>
                  <div class="selected-item disable">
                    <div class="row">
                      <input type="radio" class="option-input radio" name="selected" value="061-714-8888">
                      <div class="col-xxs-6 col-xs-6 col-sm-6 col-md-6">
                        <div class="row">
                          <div class="col-xxs-12 col-xs-12 col-sm-16 col-md-6 txt-number">061-714-8888</div>
                          <div class="col-xxs-12 col-xs-12 col-sm-16 col-md-6 txt-category">PLATINUM NUMBER</div>
                        </div>
                      </div>
                      <div class="col-xxs-2 col-xs-2 col-sm-2 col-md-4 text-center txt-sum hidden-xxs">
                        <div class="visible-xxs visible-xs visible-sm" style="margin-top:5px"></div>
                        51</div>
                      <div class="col-xxs-2 col-xs-2 col-sm-2 col-md-2 text-right txt-close pull-right">
                        <div class="visible-xxs visible-xs visible-sm" style="margin-top:5px"></div>
                        <i class="fa fa-times-circle"></i>
                      </div>
                    </div>
                  </div>                 
                  <div class="row">
                      <div class="col-xxs-12 col-xs-12 col-sm-12 col-md-12">
                      	<div class="text-center" style="margin-top:20px;">
	                      	<button class="btn-lg btn-round-solid bg-gd-submit">
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
    	    
	    });
	    function jumpToSim(){
	    	var global = new Global();
	    	window.location = global.contextPath();
	    }
	    </script>
	</jsp:body>
</t:master>