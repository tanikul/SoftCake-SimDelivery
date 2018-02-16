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
	<br/>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				 <div class="x_panel panel-round-bd">
				  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
				    	<label for="exampleInputName2" class="control-label">ระบุเลขนำหน้าที่ต้องการ</label>
				    	<select class="form-control" id="exampleInputName2">
				    		<option value="">ทั้งหมด</option>
				    	</select>
				  	</div>
				  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
				    	<label for="exampleInputName2" class="control-label">ระบุหมายเลข</label>
				    	<select class="form-control" id="exampleInputName2">
				    		<option value="">ทั้งหมด</option>
				    	</select>
				  	</div>
				  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
				    	<label for="exampleInputName2" class="control-label">ระบุเลขที่ต้องการ</label>
				    	<div class="form-inline">
				    		<input type="text" class="input-one" id="exampleInputName2">
				    		<input type="text" class="input-one" id="exampleInputName2">
				    		<input type="text" class="input-one" id="exampleInputName2">
				    		<input type="text" class="input-one" id="exampleInputName2">	
				    	</div>
				  	</div>
					<div class="form-group col-md-2 col-sm-2 col-xs-2">
				    	<label for="exampleInputName2" class="control-label">ระบุเลขที่ไม่ต้องการ</label>
				    	<div class="form-inline">
				    		<input type="text" class="input-one" id="exampleInputName2">
				    		<input type="text" class="input-one" id="exampleInputName2">
				    		<input type="text" class="input-one" id="exampleInputName2">
				    		<input type="text" class="input-one" id="exampleInputName2">	
				    	</div>
				  	</div>
				  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
				    	<label for="exampleInputName2" class="control-label">ผลรวมของเบอร์</label>
				    	<input type="text" class="form-control" />
				  	</div>
				  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
				  	
  		 			 	<button class="btn btn-warning button-flex orange-button" style="margin-top:24px;">ค้นหา</button>
  		 			</div>
				 </div>
			</div>
		</div>
	<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
              <div class="x_panel tile overflow_hidden">
              	<div class="row" style="margin:10px">
              		<div class="col-md-6 col-sm-6 col-xs-6">
		                <div class="x_title">
		                  <h3><img src="<c:url value="/images/phone.png" />" style="height: 40px;margin-bottom: 10px;"/> เบอร์โทรศัพท์ <img src="<c:url value="/images/truemove.png" />" style="height: 40px;margin-bottom: 10px;"/></h3>
		                  <div class="clearfix"></div>
	                  </div>
	                 </div>
	                  <div class="col-md-6 col-sm-6 col-xs-6">
	                  	<button class="btn-lg btn-round-solid bg-blue-weight pull-right btn-select-num" onclick="jumpToSelectNumber();">
						  <span>เบอร์ที่คุณเลือก</span>
						  <div class="badge" id="selected_sim">0</div>
						</button>
	                  </div>
	                
                </div>
                <div class="x_content">
                  <div class="panel-round-bd number-panel">
  <div class="number-block" id="sim_list"></div>
  <div class="clearfix"></div>
  <nav class="paginations-block text-center hidden-xxs hidden-xs" id="nav_page_list_desktop">
  	<div class="paginations"></div>
  </nav>
  <nav class="paginations-block text-center visible-xxs visible-xs" id="nav_page_list_mobile"><div class="paginations"><div class="page btn-number active"><p>1</p></div><a class="page btn-number" onclick="getMobileList(2,'N')">2</a><a class="page btn-number" onclick="getMobileList(3,'N')">3</a><a class="page btn-number" onclick="getMobileList(4,'N')">4</a><a class="page btn-number" onclick="getMobileList(5,'N')">5</a><a class="page btn-number" onclick="getMobileList(6,'N')">6</a><a class="page btn-number" onclick="getMobileList(7,'N')">7</a><a class="page btn-next" onclick="getMobileList(2,'N')"><i class="ic-angle-right"></i></a><a class="page btn-last" onclick="getMobileList(376,'N')"><i class="ic-angle-right2"></i></a></div></nav>
  <div class="clearfix" style="height:10px"></div>
  <div class="font-c-red">
  </div>
  </div>
                </div>
              </div>
            </div>
	    </div>
	    <script>
	    
	    $(document).ready(function(){
    	    var sim = new Sim();
    	    sim.loadSims(1);
	    	
	    });
	    	
	    </script>
	</jsp:body>
</t:master>