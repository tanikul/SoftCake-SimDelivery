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
			 <div class="x_panel panel-round-bd">
			  	<div class="form-group col-md-3 col-sm-3 col-xs-3">
			    	<label for="filter_1" class="control-label">ระบุเลขนำหน้าที่ต้องการ</label>
			    	<select class="form-control" id="filter_1">
			    		<option value="">ทั้งหมด</option>
			    		<option value="061">061</option>
			    		<option value="062">062</option>
			    		<option value="063">063</option>
			    		<option value="065">065</option>
			    		<option value="080">080</option>
			    		<option value="081">081</option>
			    		<option value="082">082</option>
			    		<option value="083">083</option>
			    		<option value="084">084</option>
			    		<option value="085">085</option>
			    		<option value="086">086</option>
			    		<option value="087">087</option>
			    		<option value="088">088</option>
			    		<option value="089">089</option>
			    		<option value="090">090</option>
			    		<option value="091">091</option>
			    		<option value="092">092</option>
			    		<option value="094">094</option>
			    		<option value="095">095</option>
			    		<option value="099">099</option>
			    	</select>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="filter_2" class="control-label">ระบุหมายเลข</label>
			    	<select class="form-control" id="filter_2">
			    		<option value="">ทั้งหมด</option>
			    		<option value="0000">0000</option>
			    		<option value="1111">1111</option>
			    		<option value="2222">2222</option>
			    		<option value="3333">3333</option>
			    		<option value="4444">4444</option>
			    		<option value="5555">5555</option>
			    		<option value="6666">6666</option>
			    		<option value="7777">7777</option>
			    		<option value="8888">8888</option>
			    		<option value="9999">9999</option>
			    	</select>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="filter_3" class="control-label">ระบุเลขที่ต้องการ</label>
			    	<div class="form-inline">
			    		<input type="text" class="input-one" id="filter_3">
			    		<input type="text" class="input-one" id="filter_4">
			    		<input type="text" class="input-one" id="filter_5">
			    		<input type="text" class="input-one" id="filter_6">	
			    	</div>
			  	</div>
				<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="filter_7" class="control-label">ระบุเลขที่ไม่ต้องการ</label>
			    	<div class="form-inline">
			    		<input type="text" class="input-one" id="filter_7">
			    		<input type="text" class="input-one" id="filter_8">
			    		<input type="text" class="input-one" id="filter_9">
			    		<input type="text" class="input-one" id="filter_10">	
			    	</div>
			  	</div>
			  	<div class="form-group col-md-2 col-sm-2 col-xs-2">
			    	<label for="filter_11" class="control-label">ผลรวมของเบอร์</label>
			    	<input type="text" class="form-control" id="filter_11"/>
			  	</div>
			  	<div class="form-group col-md-1 col-sm-1 col-xs-1">
	 			 	<button class="btn btn-warning button-flex orange-button" id="search-btn" style="margin-top:24px;">ค้นหา</button>
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
    	    simsJson = ('${simsJson}' == 'null' || '${simsJson}' == '') ? null : JSON.parse('${simsJson}');
			if(simsJson != null){
				for(var x in simsJson){
					checkedSim[checkedSim.length] = x;
				}
			}
    	    sim.loadSims(1);
	    	
    	    $('#filter_3').mask('0', { onComplete: function(cep) {
	    		$('#filter_4').focus();
	    	}});
	    	$('#filter_4').mask('0', { onComplete: function(cep) {
	    		$('#filter_5').focus();
	    	}});
	    	$('#filter_5').mask('0', { onComplete: function(cep) {
	    		$('#filter_6').focus();
	    	}});
	    	$('#filter_6').mask('0', { onComplete: function(cep) {
	    		
	    	}});
	    	
	    	$('#filter_7').mask('0', { onComplete: function(cep) {
	    		$('#filter_8').focus();
	    	}});
	    	$('#filter_8').mask('0', { onComplete: function(cep) {
	    		$('#filter_9').focus();
	    	}});
	    	$('#filter_9').mask('0', { onComplete: function(cep) {
	    		$('#filter_10').focus();
	    	}});
	    	$('#filter_10').mask('0', { onComplete: function(cep) {
	    		
	    	}});
	    	
	    	$('#filter_11').mask('00', { onComplete: function(cep) {
	    		
	    	}});
	    	$('#search-btn').click(function(){
				var obj = {
					filter_1: $('#filter_1').val(),
					filter_2: $('#filter_2').val(),
					filter_3: $('#filter_3').val() + $('#filter_4').val() + $('#filter_5').val() + $('#filter_6').val(),
					filter_4: $('#filter_7').val() + $('#filter_8').val() + $('#filter_9').val() + $('#filter_10').val(),
					filter_5: $('#filter_11').val()
				};
				var sim = new Sim();
				sim.params.filter = obj;
				sim.loadSims(1);
			});
	    });
	    	
	    </script>
	</jsp:body>
</t:master>