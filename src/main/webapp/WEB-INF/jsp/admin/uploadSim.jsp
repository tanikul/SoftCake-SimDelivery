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
                  <h2><i class="fa fa-laptop"></i> Upload เบอร์โทรศัพท์มือถือ</h2>
                   <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                    </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  	<div class="panel-round-bd">
						<div class="row">
							<div class="col-md-12">
								<form class="form-horizontal">
									<div class="form-group">
									    <label for="inputEmail3" class="col-sm-2 control-label">อัพโหลดไฟล์</label>
									    <div class="col-sm-4">
									      <input type="file" class="form-control" id="inputEmail3">
									    </div>
									    <div class="col-sm-3">(.gif หรือ .jpg ขนาด 320x240)</div>
									</div>
									<div class="form-group">
									    <div class="col-sm-2"></div>
									    <div class="col-sm-4">
									      <button type="button" class="btn btn-primary">Save</button>
									    </div>
									    
									</div>
								</form>
							</div>
						</div>
					</div>
				 </div>
	    		</div>
	    		<br/>
	    		<div class="panel-round-bd">
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
			              <div class="x_panel tile overflow_hidden">
			                <div class="x_title">
			                  <h2>รายการที่อัพโหลด</h2>
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
									            <tr>
									                <td><img src="<c:url value="/images/detail121.jpg" />"></td>
									                <td>Systems Administrator</td>
									                <td>New York</td>
									                <td>59</td>
									                <td>2009/04/10</td>
									                <td><a href="#" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i> View </a></td>
									            </tr>
									                     
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
		</div>	
           
	    <script type="text/javascript">
	    $(function() {
	        $('#example').DataTable();
	    });
	    </script>
	</jsp:body>
</t:master>