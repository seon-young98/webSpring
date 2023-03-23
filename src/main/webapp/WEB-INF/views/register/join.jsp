<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	#joinForm ul{
		overflow:auto;
	}
	#joinForm li{
		float:left;
		width:20%;
		padding:10px 0;
		border-bottom:1px solid gray;
		line-height:40px;
	}
	#joinForm li:nth-child(2n){
		width:80%;
	}
	#joinForm li:last-child{
		width:100%;
	}
	#addr{width:80%;}
</style>
<script>
	$(function(){
		//아이디중복검사
		$("input[value=아이디중복검사]").click(function(){
			if($('#userid').val()!=""){
				//                  주소                          창이름         옵션
				window.open("idCheck?userid="+$("#userid").val(),"chk","width=400,height=300");
			}else{
				alert("아이디를 입력해주세요.");
			}
		});
	});
</script>
<div class="container">
	<h1>회원가입 폼</h1>
	<form method="post" action="joinOk" id="joinForm">
		<ul>
			<li>아이디</li>
			<li>
				<input type="text" name="userid" id="userid" minlength="8" maxlength="15"/>
				<input type="button" value="아이디중복검사"/>
				<input type="hidden" id="idStatus" value="N"/>
			</li>
			<li>비밀번호</li>
			<li><input type="password" name="userpwd" id="userpwd" minlength="8" maxlength="15"/></li>
			<li>비밀번호확인</li>
			<li><input type="password" name="userpwd2" id="userpwd2"/></li>
			<li>이름</li>
			<li><input type="text" name="username" id="username" minlength="2" maxlength="10"/></li>
			<li>연락처</li>
			<li>
				<select name="tel1" id="tel1">
					<option value="010">010</option>
					<option value="02">02</option>
					<option value="031">031</option>
					<option value="032">032</option>
					<option value="011">011</option>
					<option value="012">012</option>
				</select> -
				<input type="text" name="tel2" id="tel2" maxlength="4"/> -
				<input type="text" name="tel3" id="tel3" maxlength="4"/>
			</li>
			<li>이매일</li>
			<li><input type="text" name="email" id="email"/></li>
			<li>우편번호</li>
			<li>
				<input type="text" name="zipcode" id="zipcode"/>
				<input type="button" value="우편번호찾기" id="zipSearch"/>
			</li>
			<li>주소</li>
			<li><input type="text" name="addr" id="addr"/></li>
			<li>상세주소</li>
			<li><input type="text" name="addrdetail" id="addrdetail"></li>
			<li>취미</li>
			<li>
				<input type="checkbox" name="hobbyArr" value="독서"/>독서
				<input type="checkbox" name="hobbyArr" value="영화관람"/>영화관람
				<input type="checkbox" name="hobbyArr" value="음악감상"/>음악감상
				<input type="checkbox" name="hobbyArr" value="운동"/>운동
				<input type="checkbox" name="hobbyArr" value="그림"/>그림
				<input type="checkbox" name="hobbyArr" value="쇼핑"/>쇼핑
				<input type="checkbox" name="hobbyArr" value="요리"/>요리
			</li>
			<li><input type="submit" value="회원가입"/></li>
		</ul>
	</form>
</div>