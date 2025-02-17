<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	/**
* @ Class Name 	: WorkResult.jsp
* @ Description 	: WorkResult 화면
* @ Modification Information
* @
* @  수정일             	 수정자              수정내용
* @ -----------  --------    ---------------------------
* @ 2021.10.01 	서지혜              최초 생성
* @ 2021.10.15 	이은영              업무완료 기능 추가
* @ 
*  
*/
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
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
<style>
#loading {
  position: fixed;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
 /* opacity: 0.7;
  background-color: #fff; */
  background-color:rgba(0, 0, 0, 0.8);
  z-index: 98;
}

#loading-image {
  z-index: 100;
 /*  width: 100px;
  height: 100px; */
}
</style>
</head>


<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<c:import url="../MapoMainLeft.jsp" />

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">

				<!-- Topbar -->
				<c:import url="../MapoMainTop.jsp" />

				<!-- 메인 컨테이너  -->
				<div class="container col-auto" id="containerResult">
					<div class="row">
						<div class="col-sm-6 text-left">
							<p class="pageTitle">| 업무배포결과</p>
						</div>
						<div class="col-sm-6 text-right">
							<button class="btn btn-primary mr-2" type="button" id="fn_submit" onclick="return workComplete()">업무완료</button>
						</div>
					</div>


					<!-- 업무 검색 -->
					<form name="searchForm" action="<c:url value='workResult.do'/>" method="post">

						<div class="card">
							<div class="card-header">

								<!-- 업무검색 1행 -->
								<div class="form-group row">
									<label for="step" class="col-sm-1 col-form-label text-right"><strong>업무진행</strong></label>
									<div class="col-sm-2">
										<select name="step" id="step" class="form-control" aria-label="Default select example">
											<option value="">전체</option>
											<c:forEach var="resultStep" items="${resultStep}" varStatus="status">
												<option value="${resultStep.code}" ${resultStep.code == step ? 'selected="selected"' : ''}>${resultStep.codeNm}</option>
											</c:forEach>
										</select>
									</div>

									<!-- 검색 : 마감일 시작일 선택 -->
									<label for="title" class="col-sm-1 col-form-label text-right"><strong>마감기간 </strong></label>
									<div class="col-sm-4 form-inline">
										<div class="form-group">
											<div class="input-group date mr-2" data-target-input="nearest">
												<input type="text" class="form-control datetimepicker-input" data-target="#startDt" id="startDt" name="startDt" />
												<div class="input-group-append" data-target="#startDt" data-toggle="datetimepicker">
													<div class="input-group-text">
														<i class="fa fa-calendar"></i>
													</div>
												</div>
											</div>
											~
											<!-- 검색 : 마감일 최종일 선택 -->
											<div class="input-group date ml-2" data-target-input="nearest">
												<input type="text" class="form-control datetimepicker-input" data-target="#endDt" id="endDt" name="endDt" />
												<div class="input-group-append" data-target="#endDt" data-toggle="datetimepicker">
													<div class="input-group-text">
														<i class="fa fa-calendar"></i>
													</div>
												</div>
											</div>
										</div>
									</div>


									<!-- 검색 : 업무담당자 선택 -->
									<%-- <label for="manager" class="col-md-1 col-form-label text-right"><strong>담당자</strong></label>
				<div class="col-md-2">
					<select name="manager" id="manager" class="form-control">
						<option value="">전체</option>
						<c:forEach var="resultManager" items="${resultManager}" varStatus="status">
							<option value="${resultManager.codeNm}" ${resultManager.codeNm == manager ? 'selected="selected"' : ''}>${resultManager.codeNm}</option>
						</c:forEach>
					</select>
				</div>		 --%>
								</div>

								<!-- 업무검색 2행 -->
								<div class="form-group row" style="margin-bottom: 0px;">
									<!-- 검색 : 업무구분 선택 -->
									<label for="taskIdx" class="col-sm-1 col-form-label text-right"><strong>업무구분</strong></label>
									<div class="col-sm-2">
										<select name="taskIdx" id="taskIdx" class="form-control" onchang="">
											<option value="">전체</option>
											<c:forEach var="resultGubun" items="${resultGubun}" varStatus="status">
												<option value="${resultGubun.code}" ${resultGubun.code == taskIdx ? 'selected="selected"' : ''}>${resultGubun.codeNm}</option>
												<%-- <option value="TAS020" ${ TAS020 == taskIdx ? 'selected="selected"' : '' }>TAS020</option> --%>
											</c:forEach>
										</select>
									</div>


									<!-- 검색 : 검색어 입력 -->
									<label for="taskNm" class="col-sm-1 col-form-label text-right"><strong>제목/내용</strong></label>
									<div class="col-sm-4">
										<input type="text" class="form-control" name="taskNm" id="taskNm" maxlength=255 value="${taskNm }" placeholder="검색어를 입력하세요.">
									</div>
									<button id="btnSearch" type="submit" class="btn btn-primary">검색</button>
								</div>
							</div>
							<!--  card-header -->


							<!-- START : 업무 확인 리스트 -->
							<div class="card-body">
								<!-- <div class="card-body" style="height:64vh;overflow-y:scroll;"> -->
								<div class="table-responsive">
									<table class="table table-hover mt-2 ">
										<colgroup>
											<col style="width: 5%;">
											<col style="width: 7%;">
											<col style="width: 1%;">
											<col style="width: 10%;">
											<!-- 업무구분  -->
											<col style="width: 10%;">
											<!-- 업무제목  -->
											<col style="width: 35%;">
											<!-- 담당자  -->
											<col style="width: 10%;">
											<col style="width: 8%;">
											<col style="width: 14%;">
										</colgroup>
										<thead>
											<tr class="text-center">
												<!-- <th scope="col" width="7%">번호</th> -->
												<th>업무ID</th>
												<th>긴급여부</th>
												<th><input type="checkbox" name="checkAll" class="check2" id="checkAll"></th>
												<th>진행상태</th>
												<th class="text-left">업무구분</th>
												<th class="text-left">업무제목</th>
												<th>담당자(ID)</th>
												<th>첨부파일</th>
												<th>마감일시</th>
											</tr>
										</thead>

										<tbody>
											<c:set var="total" value="${total }" />
											<c:forEach var="result" items="${resultList }" varStatus="status">
												<tr class="text-center">
													<!-- 순번 -->
													<%-- <td><c:set var="cnt" value="${status.index }" />${total - cnt}</td> --%>
													<!-- 업무ID -->
													<td>${result.taskId }</td>
													<!-- 긴급공지 -->
													<td>${result.urgent }</td>
													<!-- 체크박스 -->
													<td>
														<c:choose>
															<c:when test="${result.step eq 'STE040'}">
																<input type="checkbox" name="rowCheck" value="${result.taskId}" disabled />
															</c:when>
															<c:otherwise>
																<input type="checkbox" name="rowCheck" value="${result.taskId}" />
															</c:otherwise>
														</c:choose>
													</td>
													<!-- 진행상태 -->
													<td>${result.steNm }</td>
													<!-- 업무구분 -->
													<td class="text-left">${result.tasNm }</td>
													<!-- 업무제목 -->
													<td class="text-left" id="workTitle">
														<a href="workResultDetail.do?taskId=${result.taskId}&mode=view" onclick="loading()">${result.taskNm }</a>
													</td>
													<!-- 담당자 -->
													<td>${result.userNm }(${result.manager })</td>
													<!-- 첨부파일 여부 -->
													<td>${result.atchYn }</td>
													<!-- 마감일시 -->
													<td>${result.closeDt }&nbsp;${result.closeTm }</td>
												</tr>
											</c:forEach>
											<c:if test="${total eq 0}">
												<tr>
													<td colspan='9' class='col-auto text-center'>검색된 데이터가 없습니다</td>
												</tr>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
							<!-- END : 업무 확인 리스트 -->


							<!-- START : 페이징 처리 -->
							<div class="card-footer">
								<!-- paging navigation -->
								<div class="pagination" style="height: 4vh;">
									<ul class="pagination justify-content-center" style="width: 100%;">
										<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
									</ul>
								</div>
							</div>
							<!-- END : 페이징 처리 -->

						</div>
						<!--  END CARD -->

					</form>
				</div>
			</div>
		</div>
		<!-- Content Wrapper END-->
	</div>
	<!-- Page Wrapper END -->

	<!-- Modal & Script-->
	<%@ include file="../modal/common.jsp"%>

		<!-- 로딩 중 -->
		<div id ="loading"><!--  "../images/mapo/com/ajax-loader.gif -->
			<img id="loading-image" src="../images/mapo/com/ajax-loader4.gif" alt="Loading...">&nbsp;&nbsp;&nbsp;
			<span style="color:#ffffff;">로딩 중...&nbsp;&nbsp;&nbsp;잠시만 기다려 주세요.</span>
		</div> 
		

		
	<!-- script 호출 -->
	<script src="<c:url value="/js/mapo/checkWork.js"/>"></script>

	<script>
		$(document).ready(function() {
			/* 로딩 중 화면 페이지 */
			$("#loading").hide(); 
			
			/* $("#workTitle").click(function(){
			 	$("#loading").show(); 
			});  */ 
			
			// 왼쪽 메뉴 아이콘 활성화
			$("#menuWorkResult").addClass("active");

			// 마감일자 설정
			var startDay = getStartDay();
			var endDay = getEndDay();

			$("#startDt").val(startDay);
			$("#endDt").val(endDay);

			/* 전체 선택 */
			$("input[name = checkAll]").click(function() {
				var chk = $(this).is(":checked")
				if (chk) {
					$("input[name='rowCheck']").each(function() { //체크한 갯수만큼 for문 돈다.
						var opt = $(this).prop("disabled"); //현재 상태 체크
						if (!opt) { //prop을 통해 true,false 값을 return 받고, disabled이 아닌 박스들만 체크한다.
							$(this).attr("checked", true);
						}
					});
				} else {
					$("input[name='rowCheck']").attr("checked", false);
				}
			});
		});
		


		/* 업무완료   */
		function workComplete() {
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
				console.log("taskId value : " + taskId);
				console.log("valueArr value : " + valueArr);
				if (!confirm("업무완료 하시겠습니까?\n\n※ 업무완료 된 업무는 승인완료/수정요청을 할 수 없습니다.")) {
					return false;
				}
				$.ajax({
					url : "workComplete.do",
					type : "POST",
					traditional : true,
					data : {
						"valueArr" : valueArr
					},
					traditional : true,
					dataType : "text",
					success : function(data) {
						console.log(data);
						if (data == "OK") {
							alert("업무완료 성공");
							location.href = "workResult.do";
						} else {
							alert("업무완료 실패");

						}
					},
					error : function() {
						alert("오류발생")
					}
				});
				return false; //ajax 새로고침 방지 
			}
		}

		/* 페이징 처리 */
		function linkPage(pageNo) {
			location.href = "<c:url value='/mapo/workResult.do'/>?pageIndex="
					+ pageNo
					+ "&startDt=${startDt}&endDt=${endDt}&taskNm=${taskNm}&taskIdx=${taskIdx}&manager=${manager}&step=${step}";
		}
		
		
		/* 	로딩바 호출 */
		function loading() {
			$("#loading").show(); 
		}
		
	</script>
</body>
</html>