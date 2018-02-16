<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
	<jsp:body>
	
	<link rel="stylesheet" href="<c:url value="/js/jquery-ui/jquery-ui.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/jquery.fileupload.css"/>">
	<link rel="stylesheet" href="<c:url value="/css/datatables.css"/>">
	<script src="<c:url value="/js/jquery-ui/jquery-ui.js" />"></script>
	<script src="<c:url value="/js/jquery.ui.plupload/plupload.full.min.js" />"></script>
	<script src="<c:url value="/js/jquery.ui.plupload/jquery.ui.plupload.min.js" />"></script>
	<script src="<c:url value="/js/jquery.dataTables.js" />"></script>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
              <div class="x_panel tile overflow_hidden">
                <div class="x_title">
                  <h2><i class="fa fa-user"></i> ค้นหาสมาชิก</h2>
                   <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                    </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  
					<div class="row">
						<div class="col-md-12">
							<form class="form-horizontal">
								<div class="form-group">
								    <label for="inputEmail3" class="col-sm-2 control-label">หมายเลขโทรศัพท์</label>
								    <div class="col-sm-3">
								      <input type="text" class="form-control" id="inputEmail3">
								    </div>
								     <div class="col-sm-4">
								      <button type="button" class="btn btn-primary">ค้นหา</button>
								    </div>
								</div>
							</form>
						</div>
					</div>
				 </div>
	    		</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
			              <div class="x_panel tile overflow_hidden">
			                <div class="x_title">
			                  <h2>ผลการค้นหา</h2>
			                   <ul class="nav navbar-right panel_toolbox">
			                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
			                      </li>
			                    </ul>
			                  <div class="clearfix"></div>
			                </div>
			                <div class="x_content">
					<div class="row">
						<div class="col-md-12">
						        <table id="example" class="display" cellspacing="0" width="100%">
							        <thead>
							            <tr>
							                <th>ภาพ Preview</th>
							                <th>cccc</th>
							                <th>Office</th>
							                <th>Age</th>
							                <th>Start date</th>
							                <th>Salary</th>
							            </tr>
							        </thead>
							       
							        <tbody>
							            	            
							        </tbody>
							    </table>
						      </div>
						    </div>
						</div>
					</div>
				</div>
				</div>
				</div>
				</div>	
           
	    <script type="text/javascript">
	    $(function() {
	        $('#example').DataTable();
	    });
	    </script>
	</jsp:body>
</t:master>