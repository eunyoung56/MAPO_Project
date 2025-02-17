<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	/**
* @ Class Name : WorkResult.jsp
* @ Desciption : WorkResult 화면
* @ Modification Infomation
* @ 
* @  수정일 		수정자		수정내용 
* @  ----------  ---------  ------------------
* @  2021.09.28	이은영		최초 생성
* @  2021.09.28				레이아웃 & 기능 개발
* @  2021.10.07 			승인완료, 수정요청 기능 추가
*  
*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>마포구청 업무 사이트</title>


<!-- Custom fonts for this template-->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrapthema/vendor/fontawesome-free/css/all.min.css"/>">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link rel="stylesheet" href="<c:url value="/css/bootstrapthema/css/sb-admin-2.css"/>">

<!-- 공통 CSS 호출 -->
<link rel="stylesheet" href="<c:url value="/css/mapo/custom.css"/>">

<!-- Font-Awesome 5 호출 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<!-- favicon -->
<link rel="shortcut icon" type="image/x-icon" href="<c:url value="/css/mapo/favicon.ico"/>">

</head>
<body>
	<div id="wrapper">

		<!-- Sidebar -->
		<c:import url="../MapoMainLeft.jsp" />

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">

				<!-- Topbar -->
				<c:import url="../MapoMainTop.jsp" />

				<!-- Main Content -->
				<div class="container col-auto">
					<div class="row">
						<div class="col-sm-6">
							<p class="pageTitle">| 업무배포결과 상세</p>
						</div>
						<div class="col-sm-6 text-right mt-2">
							<div class="row text-right" style="background:rgba( 255, 255, 255, 0.5 ); float:right; margin-right:0px; margin-bottom:10px;">
									<!-- 승인완료 -->	
									<button class="btn btn-primary mr-2" type="button" onclick="return approved()" id = "approvedButton" class = "approvedButton">승인완료</button>
									<!-- 수정요청 -->	
									<button class="btn btn-info mr-2" type="button" onclick="return updateRequest()" id = "updateButton" class ="updateButton">수정요청</button>
									<!-- 엑셀 다운로드 -->						
									<form name="excelForm" id="excelForm" method="POST" action="<c:url value='excelDown.do?taskId=${taskId }'/>" >
								    	<input type="submit" class="btn btn-success " id="excelDown" value="ExcelDown"/>
									</form>
							</div>
						</div>
					</div>
					
					<!-- 항목 제목 갯수  -->
					<input id="selectResultItemSize" name="selectResultItemSize" value="${selectResultItemSize}" type="hidden">

					<!-- 배포결과 리스트 확인 -->
					<form name="resultForm" id="resultForm" class="resultForm" action="<c:url value='workResultDetail.do'/>" method="post">
						<div class="card">
							<!-- START : 업무 확인 리스트 -->
							<div class="card-body" id ="heightSize" style="height: 690px; overflow: auto;">
								<div class="div-wrap" id ="widthSize" style="width:2500px; overflow: auto;">
									<div style="float: left;"><!-- 왼쪽 테이블(제목,내용..) -->
										<table class="table">
											<thead>
												<tr>
													<th align="center">업무ID</th>
													<th>진행상태</th>
													<!-- 전체 선택  -->
													<th><input type="checkbox" name="checkAll" class="check2"></th>
													<th>업무구분</th>
													<th>업무제목</th>
													<th>기관명</th>
													<th>최초확인자(ID)</th>
													<th>최초확인일시</th>
													<th>승인요청자(ID)</th>
													<th>승일요청일시</th>
												</tr>
											</thead>

											<tbody>
												<%-- <c:set var="total" value="${selectResultTotal }" /> --%>
												<c:forEach var="result" items="${selectResultList }" varStatus="status">
													<tr>
														<!-- 업무ID -->
														<td align="center">${result.taskId }</td>
														<input id="taskId" name="taskId" type="hidden" value="${result.taskId}" />
														<!-- 진행상태 -->
														<%-- <td>${result.codeNm }</td> --%>
														<td>
															<c:choose>
																<c:when test="${result.step eq 'STE040'}">
																	${result.stepNm }
																</c:when>
																<c:otherwise>
																	${result.codeNm }
																</c:otherwise>
															</c:choose>
														</td>
														<!-- 체크박스 -->
														<td>
															<c:choose>
																<c:when test="${result.approval eq 'REQ010'}">
																	<input type="checkbox" name="rowCheck" value="${result.orgId}" disabled/>
																</c:when>
																<c:when test="${result.approval eq 'REQ020'}">
																	<input type="checkbox" name="rowCheck" value="${result.orgId}" disabled/>
																</c:when>
																<c:when test="${result.step eq 'STE040'}">
																	<input type="checkbox" name="rowCheck" value="${result.orgId}" disabled/>
																</c:when>
																<c:otherwise>
																	<input type="checkbox" name="rowCheck" value="${result.orgId}" />
																</c:otherwise>
															</c:choose>
														</td>
														<input id="approval" name="approval" type="hidden" value="${result.approval}" />
														<!-- 업무구분 -->
														<td>${result.tasNm }</td>
														<!-- 업무제목 -->
														<td>${result.taskNm }</td>
														<!-- 기관명 -->
														<td>${result.orgNm }</td>
														<!-- 최초일자 -->
														<td><c:if test="${!empty result.frstReadId }">${result.userNm }(${result.frstReadId })</c:if></td>
														<!-- 최초확인일 -->
														<td>${result.frstReadDt }</td>
														<!-- 승인요청자(ID) -->
														<td><c:if test="${!empty result.updateId }">${result.updateNm }(${result.updateId })</c:if></td>
														<!-- 승인요청일시 -->
														<td>${result.updateDt }</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
									<div style="float: left;"><!-- 오른쪽 테이블(항목값 ) -->
										<table class="table">
											<thead>
												<tr>
													<c:forEach var="result" items="${selectResultItem }" varStatus="status">
														<th>${result.itemNm }</th>
													</c:forEach>
												</tr>
											</thead>

											<tbody>
												<c:forEach var="result" items="${selectresultItemValue }" varStatus="status">
													<tr>
														<c:choose>
															<c:when test="${result.item1 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item1}</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item2 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td  style = "text-align:center">${result.item2 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item3 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item3 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item4 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item4 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item5 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td  style = "text-align:center">${result.item5 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item6== null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td  style = "text-align:center">${result.item6 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item7 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td  style = "text-align:center">${result.item7 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item8 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td  style = "text-align:center">${result.item8 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item9 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item9 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item10 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item10 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item11 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item11 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item12 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item13 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item14 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item14 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item15 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item15 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item16 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item16 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item17 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item17 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item18 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item18 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item19 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item19 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item20 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item20 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item20 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item20 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item21 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item21 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item22 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item22 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item23 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item23 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item24 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item24 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item25 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item25 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item26 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item26 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item27 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item27 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item28 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item28 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item29 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item29 }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${result.item30 == null}">
																<td>&nbsp;</td>
															</c:when>
															<c:otherwise>
																<td style = "text-align:center">${result.item30 }</td>
															</c:otherwise>
														</c:choose>
													</tr>
													<!-- 일단 임시로 item10까지만 만들고 WorkVO객체에 item이 추가되면 직접 추가 -->
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div><!-- 자식  -->
							</div><!-- 부모 -->
							<!-- END : 업무 확인 리스트 -->			
									
							<div class="card-footer">
				        		 <div class="row">
				        			<!-- 하단 버튼 --> 
									<div class="col-sm-12 text-left">
										<!-- <button type="button" class="btn btn-outline-primary">목록</button> -->
										<a href="<c:url value='/mapo/workResult.do' />" class="btn btn-outline-primary" title="" style ="float:right;">목록</a>
									</div>
								</div>
							</div>
						</div>
						<!--  END CARD -->
					</form>

				</div>
				<!-- Main Content END-->
			</div>
			<!-- Content END -->
		</div>
		<!-- Content Wrapper END-->
	</div>
	<!-- wrapper END-->

	<!-- Modal & Script-->
	<%@ include file="../modal/common.jsp"%>

	<!-- script 호출 -->
	<script src="<c:url value="/js/mapo/checkWork.js"/>"></script>
	<script src="<c:url value="/js/mapo/jquery.fileDownload.js"/>"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			
			// 왼쪽 메뉴 아이콘 활성화
			$("#menuWorkResult").addClass("active");
			
			/* 항목 제목 갯수 추가시 동적으로 500씩 증가 (만약 항목명이 길어진다면 위에 widthSize 사이즈를 늘려준다. )*/ 
			var widthSize = $("#widthSize").width();
			console.log("widthSize Size : " + widthSize);
			
			var dbSize = $("#selectResultItemSize").val();
			console.log("selectResultItemSize Count : " + dbSize);
            
            var sum = 0;
            sum = parseInt(widthSize) + parseInt(dbSize * 500) /* (만약 항목명이 길어진다면 위에 500 숫자 사이즈를 늘려준다.)*/
            console.log("sum Count : " + sum);
            $("#widthSize").width(sum);
			
			
			var approvalValue = $("#approval").val();
			
			console.log("approval value : " + approval);
			
			if(approvalValue == "STE040"){
				$("#approvedButton").hide();
				$("#updateButton").hide();
			}else{
				$("#approvedButton").show();
				$("#updateButton").show();
			}
			
			/* 전체 선택 */
			$("input[name = checkAll]").click(function(){
				var chk = $(this).is(":checked")
				if(chk){
					$("input[name='rowCheck']").each(function(){ //체크한 갯수만큼 for문 돈다.
						var opt = $(this).prop("disabled"); //현재 상태 체크
						if(!opt){	//prop을 통해 true,false 값을 return 받고, disabled이 아닌 박스들만 체크한다.
							$(this).attr("checked",true);	
						}
					});
				}else{
					$("input[name='rowCheck']").attr("checked",false);
				}
			});
			
		});


		/* 승인 완료  */
		function approved() {
			var taskId = $("#taskId").val();

			var valueArr = new Array();
			var list = $("input[name = 'rowCheck']");
			for (var i = 0; i < list.length; i++) {
				if (list[i].checked) {
					valueArr.push(list[i].value);
				}
			}
			if (valueArr.length == 0) {
				alert("선택된 글이 없습니다.");
			} else {
				if (!confirm("승인 완료하시겠습니까?")) {
					return false;
				}
				$.ajax({
					url : "workResultApproved.do",
					type : "POST",
					traditional : true,
					data : {
						"taskId" : taskId,
						"valueArr" : valueArr
					},
					dataType : "text",
					success : function(data) {
						console.log(data);
						if (data == "OK") {
							alert("승인이 완료되었습니다.");
							location = "workResultDetail.do?taskId=${taskId}"
						} else {
							alert("승인 실패");
						}
					},
					error : function() {
						alert("오류발생")
					}
				});
				return false; //ajax 새로고침 방지 
			}
		}

		/* 수정요청 */
		function updateRequest() {
			var taskId = $("#taskId").val();

			var valueArr = new Array();
			var list = $("input[name = 'rowCheck']");
			for (var i = 0; i < list.length; i++) {
				if (list[i].checked) {
					valueArr.push(list[i].value);
				}
			}
			if (valueArr.length == 0) {
				alert("선택된 글이 없습니다.");
			} else {
				if (!confirm("수정하시겠습니까?")) {
					return false;
				}
				$.ajax({
					url : "workResultUpdateRequest.do",
					type : "POST",
					traditional : true,
					data : {
						"taskId" : taskId,
						"valueArr" : valueArr
					},
					dataType : "text",
					success : function(data) {
						console.log(data);
						if (data == "OK") {
							alert("수정요청에 성공하였습니다.");
							location = "workResultDetail.do?taskId=${taskId}"
						} else {
							alert("수정요청 실패");
						}
					},
					error : function() {
						alert("오류발생")
					}
				});
				return false; //ajax 새로고침 방지 
			}
		}

		/*  엑셀 다운로드 */
		 function excelDownload() {
			var taskId = $("#taskId").val();
			
			$.ajax({
				url : "listResultExcelDownload.do",
				type : "POST",
				dataType : "json",
				/*  traditional : true,  */
				data : {
					"taskId" : taskId
				},
				
				success : function(data) {
					console.log("성공?!");
					console.log("data.filename : " + data.filename);
					console.log("data.dataMap : " + data.dataMap);
				},
				error : function() {
					alert("오류발생")
				}
			});
			return false; //ajax 새로고침 방지  
		} 
	
	</script>
</body>
</html>