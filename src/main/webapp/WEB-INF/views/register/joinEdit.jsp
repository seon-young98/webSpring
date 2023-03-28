<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	#joinEditForm ul{
		overflow:auto;
	}
	#joinEditForm li{
		float:left;
		width:20%;
		padding:10px 0;
		border-bottom:1px solid gray;
		line-height:40px;
	}
	#joinEditForm li:nth-child(2n){
		width:80%;
	}
	#joinEditForm li:last-child{
		width:100%;
	}
	#addr{width:80%;}
</style>
<script>
	$(function(){
		//우편번호 검색
		$("#zipSearch").on("click", function(){
			window.open("zipcodeSearch","zipcode","width=500, height=600");
		});
		
		//유효성 검사
		$("#joinEditForm").submit(function(){
			
			//비밀번호
			if($("#userpwd").val()==""){
				alert("비밀번호를 입력하셔야 회원정보수정이 가능합니다.");
				return false;
			}
			
			//전화번호
			var tel = $("#tel1").val() + "-" + $("#tel2").val() + "-" + $("#tel3").val();
			reg = /^(010|02|031|032|011|012)-[0-9]{3,4}-[0-9]{4}$/
			if(!reg.test(tel)){
				alert("전화번호를 잘못입력했습니다.");
				return false;
			}
			//이메일
			//아이디 6~15글자까지, @, co.kr, com, net, go.kr
			//                                  ()? -> 있어도 되고 없어도 되고            
			reg = /^\w{6,15}@[a-z]{2,8}.[a-z]{2,5}(.[a-z]{2,5})?$/
			if(!reg.test($("#email").val())){
				alert("이메일을 잘못입력했습니다.");
				return false;
			}
			
			//취미 2개 이상 반드시 선택
			var hobbyCount = 0;
			$("input[name=hobbyArr]").each(function(){
				if(this.checked==true) hobbyCount++;
			});
			if(hobbyCount<2){
				alert("취미는 2개 이상 선택해야 합니다.");
				return false;
			}
			
			//form태그의 action속성 설정
			$("#joinEditForm").attr("action","joinEditOk");
		});
	});
</script>
<div class="container">  
	<h1>회원정보수정 폼</h1>
	<form method="post" id="joinEditForm">
		<ul>
			<li>아이디</li>
			<li>
				<input type="text" name="userid" id="userid" minlength="8" maxlength="15" value="${dto.userid }" readonly/>
			</li>
			<li>비밀번호</li>
			<li><input type="password" name="userpwd" id="userpwd" minlength="8" maxlength="15"></li>
			<li>이름</li>
			<li><input type="text" name="username" id="username" minlength="2" maxlength="10" value="${dto.username }" readonly/></li>
			<li>연락처</li>
			<li>
				<select name="tel1" id="tel1">
					<option value="010"<c:if test="${dto.tel1=='010' }">selected</c:if>>010</option>
					<option value="02"<c:if test="${dto.tel1=='02' }">selected</c:if>>02</option>
					<option value="031"<c:if test="${dto.tel1=='031' }">selected</c:if>>031</option>
					<option value="032"<c:if test="${dto.tel1=='032' }">selected</c:if>>032</option>
					<option value="011"<c:if test="${dto.tel1=='011' }">selected</c:if>>011</option>
					<option value="012"<c:if test="${dto.tel1=='012' }">selected</c:if>>012</option>
				</select> -
				<input type="text" name="tel2" id="tel2" maxlength="4" value="${dto.tel2}"/> -
				<input type="text" name="tel3" id="tel3" maxlength="4" value="${dto.tel3}"/>
			</li>
			<li>이메일</li>
			<li><input type="text" name="email" id="email" value="${dto.email }"/></li>
			<li>우편번호</li>
			<li>
				<input type="text" name="zipcode" id="zipcode" value="${dto.zipcode }"/>
				<input type="button" value="우편번호찾기" id="zipSearch"/>
			</li>
			<li>주소</li>
			<li><input type="text" name="addr" id="addr" value="${dto.addr }"/></li>
			<li>상세주소</li>
			<li><input type="text" name="addrdetail" id="addrdetail" value="${dto.addrdetail }"/></li>
			<li>취미</li>
			<li>
				<input type="checkbox" name="hobbyArr" value="독서"<c:forEach var="h" items="${dto.hobbyArr}"><c:if test="${h=='독서' }">checked</c:if></c:forEach>/>독서
				<input type="checkbox" name="hobbyArr" value="영화관람"<c:forEach var="h" items="${dto.hobbyArr}"><c:if test="${h=='영화관람' }">checked</c:if></c:forEach>/>영화관람
				<input type="checkbox" name="hobbyArr" value="음악감상"<c:forEach var="h" items="${dto.hobbyArr}"><c:if test="${h=='음악감상' }">checked</c:if></c:forEach>/>음악감상
				<input type="checkbox" name="hobbyArr" value="운동"<c:forEach var="h" items="${dto.hobbyArr}"><c:if test="${h=='운동' }">checked</c:if></c:forEach>/>운동
				<input type="checkbox" name="hobbyArr" value="그림"<c:forEach var="h" items="${dto.hobbyArr}"><c:if test="${h=='그림' }">checked</c:if></c:forEach>/>그림
				<input type="checkbox" name="hobbyArr" value="쇼핑"<c:forEach var="h" items="${dto.hobbyArr}"><c:if test="${h=='쇼핑' }">checked</c:if></c:forEach>/>쇼핑
				<input type="checkbox" name="hobbyArr" value="요리"<c:forEach var="h" items="${dto.hobbyArr}"><c:if test="${h=='요리' }">checked</c:if></c:forEach>/>요리
			</li>
			<li><input type="submit" value="회원정보수정하기"/></li>
		</ul>
	</form>
</div>