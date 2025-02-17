<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @ Class Name 	: MapoLoginUsr.jsp
  * @ Description 	: MapoLoginUsr 화면
  * @ Modification Information
  * @
  * @  수정일             	 수정자              수정내용
  * @ -----------  --------    ---------------------------
  * @ 2021.09.01 	서지혜              최초 생성
  *
  *
  *  
  */
%>
<!DOCTYPE html>
<html>
<head>
<title><spring:message code="comUatUia.title" /></title><!-- 로그인 -->
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/uat/uia/login.css' />">
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery.js'/>" ></script>

<script type="text/javaScript" language="javascript">

function actionLogin() {
	if (document.loginForm.id.value =="") {
        alert("<spring:message code="comUatUia.validate.idCheck" />"); <%-- 아이디를 입력하세요 --%>
    } else if (document.loginForm.password.value =="") {
        alert("<spring:message code="comUatUia.validate.passCheck" />"); <%-- 비밀번호를 입력하세요 --%>
    } else {
        document.loginForm.action="<c:url value='/uat/uia/actionMapoLogin.do'/>";
        document.loginForm.submit();
    }
}

function actionCrtfctLogin() {
    document.defaultForm.action="<c:url value='/uat/uia/actionCrtfctLogin.do'/>";
    document.defaultForm.submit();
}

function goFindId() {
    document.defaultForm.action="<c:url value='/uat/uia/egovIdPasswordSearch.do'/>";
    document.defaultForm.submit();
}

function goRegiUsr() {
	
	var useMemberManage = '${useMemberManage}';

	if(useMemberManage != 'true'){
		<%-- 사용자 관리 컴포넌트가 설치되어 있지 않습니다. \n관리자에게 문의하세요. --%>
		alert("<spring:message code="comUatUia.validate.userManagmentCheck" />");
		return false;
	}

    var userSe = document.loginForm.userSe.value;
 
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmMber.do'/>";
        document.loginForm.submit();
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmEntrprs.do'/>";
        document.loginForm.submit();
    // 업무사용자
    } else if (userSe == "USR") {
    	<%-- 업무사용자는 별도의 회원가입이 필요하지 않습니다. --%>
        alert("<spring:message code="comUatUia.validate.membershipCheck" />");
    }
}

function goGpkiIssu() {
    document.defaultForm.action="<c:url value='/uat/uia/egovGpkiIssu.do'/>";
    document.defaultForm.submit();
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
	form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
}

function fnInit() {    
    getid(document.loginForm);
    
    fnLoginTypeSelect("typeGnr");

    <c:if test="${not empty fn:trim(loginMessage) &&  loginMessage ne ''}">
    alert("loginMessage:<c:out value='${loginMessage}'/>");
    </c:if>
    

    if (parent.frames["_top"] == undefined)
    	console.log("'_top' frame is not exist!");
    parent.frames["_top"].location.reload();
}

function fnLoginTypeSelect(objName){

		document.getElementById("typeGnr").className = "";
		document.getElementById("typeEnt").className = "";
		document.getElementById("typeUsr").className = "";
		
		document.getElementById(objName).className = "on";
		
		if(objName == "typeGnr"){ //일반회원
			document.loginForm.userSe.value = "GNR";
		}else if(objName == "typeEnt"){	//기업회원
			 document.loginForm.userSe.value = "ENT";
		}else if(objName == "typeUsr"){	//업무사용자
			 document.loginForm.userSe.value = "USR";
		}
	
}

function fnShowLogin(stat) {
	if (stat < 1) {	//일반로그인
		$(".login_input").eq(0).show();
		$(".login_input").eq(1).hide();
	} else {		//공인인증서 로그인
		$(".login_input").eq(0).hide();
		$(".login_type").hide();
		$(".login_input").eq(1).show();
	}
}

</script>
</head>
<body onLoad="fnInit();">

<!-- javascript warning tag  -->
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>


<!-- 일반로그인 -->
<div class="login_form">
	<form name="loginForm" id="loginForm" action="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
	<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>">
	
	<fieldset>
		<p style="text-align:center;margin-top:60px;"><img src="<c:url value='/images/mapo/com/be_logo.svg'/>" style="margin:0px 0 0px 0px;" alt="login title image"  title="login title image"></p>
		<div class="login_type">
			<ul id="ulLoginType">
		   		<li style="display:none"><a href="javascript:fnLoginTypeSelect('typeGnr');" id="typeGnr" title=""><spring:message code="comUatUia.loginForm.GNR"/></a></li> <!-- 일반 -->
				<li style="display:none"><a href="javascript:fnLoginTypeSelect('typeEnt');" id="typeEnt" title=""><spring:message code="comUatUia.loginForm.ENT"/></a></li> <!-- 기업 --> 
				<li style="display:none"><a href="javascript:fnLoginTypeSelect('typeUsr');" id="typeUsr" title=""><spring:message code="comUatUia.loginForm.USR"/></a></li> <!-- 업무 -->
			</ul>
		</div>
	
		<div class="login_input">
			<ul>
				<!-- 아이디 -->
				<c:set var="title"><spring:message code="comUatUia.loginForm.id"/></c:set>
				<li>
					<label for="id">${title}</label>
					<input type="text" name="id" id="id" maxlength="20" title="${title} ${inputTxt}" placeholder="${title} ${inputTxt}">
				</li>
				<!-- 비밀번호 -->
				<c:set var="title"><spring:message code="comUatUia.loginForm.pw"/></c:set>
				<li>
					<label for="password">${title}</label>
					<input type="password" name="password" id="password" maxlength="20" title="${title} ${inputTxt}" placeholder="${title} ${inputTxt}">
				</li>
				<!-- 아이디 저장 -->
				<c:set var="title"><spring:message code="comUatUia.loginForm.idSave"/></c:set>
				<li class="chk">
					<input type="checkbox" name="checkId" class="check2" onclick="javascript:saveid(document.loginForm);" id="checkId">${title}
				</li>
				<li>
					<input type="button" class="btn_login"  value="<spring:message code="comUatUia.loginForm.login"/>" onclick="actionLogin()"> <!-- 로그인  -->
				</li>
				<%-- <li>
					<ul class="btn_idpw" >
						<li><a href="#" onclick="goRegiUsr(); return false;"><spring:message code="comUatUia.loginForm.regist"/></a></li> <!-- 회원가입  -->
					</ul>
				</li>
				<li>
					<ul class="btn_idpw" >
						<li><a href="#" onclick="fnShowLogin(1);"><spring:message code="comUatUia.loginForm.login.gpki"/></a></li><!-- 인증서로그인 -->
						<li><a href="<c:url value='/uat/uia/egovGpkiIssu.do'/>"><spring:message code="comUatUia.loginForm.gpki.info"/></a></li><!-- 인증서안내 -->
					</ul>
				</li> --%>
				
			</ul>
		</div>
		
		<div class="login_input" style="display: none">
			<ul>
				<li>
					<label for="password"><spring:message code="comUatUia.loginForm.pw"/></label><!-- 비밀번호 -->
					<input type="password" name="pwd" id="" maxlength="20" title="${title} ${inputTxt}" placeholder="<spring:message code="comUatUia.loginForm.pw"/>"><!-- 비밀번호 -->
				</li>
				<li>
					<input type="button" class="btn_login" value="<spring:message code="comUatUia.loginForm.login.gpki"/>" onclick="actionLogin()"><!-- 인증서로그인 -->
				</li>
				<li>
					<ul class="btn_idpw" >
						<li><a href="#" onclick="fnShowLogin(0);"><spring:message code="comUatUia.loginForm.login.normal"/></a></li><!-- 일반로그인 -->
					</ul>
					<ul class="btn_idpw" >
						<li>※ <spring:message code="comUatUia.loginForm.gpki.descrption"/></li>
					</ul>
				</li>
			</ul>
			
		</div>
	</fieldset>
	
	<input name="userSe" type="hidden" value="GNR"/>
	<input name="j_username" type="hidden"/>
	</form>
</div>

<!-- 팝업 폼 -->
<form name="defaultForm" action ="" method="post" target="_blank">
<div style="visibility:hidden;display:none;">
<input name="iptSubmit3" type="submit" value="<spring:message code="comUatUia.loginForm.submit"/>" title="<spring:message code="comUatUia.loginForm.submit"/>">
</div>
</form>
<!-- login영역 //-->

<script>
window.onload = function() {
	fnLoginTypeSelect('typeUsr');
	
	// 테스트 후 삭제
	document.getElementById('id').value = "TEST1";
	document.getElementById('password').value="rhdxhd12";
	
}
</script>


</body>
</html>


