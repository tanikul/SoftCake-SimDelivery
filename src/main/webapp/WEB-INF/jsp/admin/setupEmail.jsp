<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="https://vipsim.co/jsp/tlds/customTags" prefix="custom"%>

<t:master>
	<jsp:body>
		<script src="<c:url value="/js/tinymce/tinymce.min.js" />"></script>
		
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
	      		<h4><b><i class="fas fa-user-plus" style="font-size:1.8em; color:Tomato;margin-right:10px;"></i> จัดการคำทำนาย</b></h4>
	    	</div>
	    </div>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				 <div class="panel-round-bd">
				 	<div class="row">
					 	<div class="col-md-2 col-sm-2 col-xs-2">
						  	<div class="form-group">
						    	<label for="predictId" class="control-label">ระบุตัวเลข</label>
						    	<select class="form-control" id="predictId">
						    		<option value="0">--เลือกตัวเลข--</option>
						    		<c:forEach var = "i" begin = "1" end = "99">
								         <option value="${i}">${i}</option>
								    </c:forEach>
						    	</select>
						  	</div>
					  	</div>
				  	</div>
				  	<div class="row">
					 	<div class="col-md-8 col-sm-8 col-xs-8">
						  	<div class="form-group" id="predictContents">
						    	<label for="predictContent" class="control-label">คำทำนาย</label>
						    	<textarea class="form-control" id="predictContent" placeholder="พิมพ์ข้อความที่นี่" style="height:150px;"></textarea>
						  	</div>
					  	</div>
				  	</div>
				  	<div class="row">
					 	<div class="col-md-2 col-sm-2 col-xs-2">
						  	<div class="form-group">
				 			 	<button class="btn btn-primary button-flex" id="save-btn" style="margin-top:24px;">Save</button>
				 			</div>
		 				</div>
		 			</div>
				 </div>
			</div>
		</div>
		<script type="text/javascript">
			$(function() {
				//$('#predictContent').html('<b>xxx</b>');
				function loadTinymce(){
					tinymce.init({
					  selector: 'textarea',
					  height: 500,
					  theme: 'modern',
					  plugins: 'print preview fullpage searchreplace autolink directionality visualblocks visualchars fullscreen image link media template codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists textcolor wordcount imagetools contextmenu colorpicker textpattern help',
					  toolbar1: 'formatselect | bold italic strikethrough forecolor backcolor | link | alignleft aligncenter alignright alignjustify  | numlist bullist outdent indent  | removeformat',
					  image_advtab: true,
					  templates: [
					    { title: 'Test template 1', content: 'Test 1' },
					    { title: 'Test template 2', content: 'Test 2' }
					  ],
					  content_css: [
					    '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
					    '//www.tinymce.com/css/codepen.min.css'
					  ]
					});
				}
				loadTinymce();
				
				$('#predictId').change(function(){
					var val = this.value;
					sendGetAjax('/Admin/ManagePredict/GetPredictById/' + val, function(data){
						console.log(data)
						$('#predictContents').remove('textarea');
						var str = '<textarea class="form-control" id="predictContent" placeholder="พิมพ์ข้อความที่นี่" style="height:150px;"></textarea>';
						$('#predictContents').html(str);
						$('#predictContent').html(data.predictContent);			
						loadTinymce();
					});
				});
				
				$('#save-btn').click(function(){
					var obj = {
						predictId: $('#predictId').val(),
						predictContent: $('#predictContent').val()
					};
					sendPostAjax('/Admin/ManagePredict/UpdatePredict', obj, function(data){
						if(data == 1){
							alertModal('', 'บันทึกข้อมูลสำเร็จ');
							$("#dialog-message").dialog({
								  modal: true,
								  buttons: {
									Ok: function() {
									  $(this).dialog("close");
									  closeOverlay();
									}
								  }
							});
						}
					});
				});
			});
		</script>
	</jsp:body>
</t:master>