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
		
		//아이디 입력란에 키보드를 입력하면 아이디중복검사 초기화
		$("#userid").keyup(function(){
			$("#idStatus").val("N");
		});
		
		//우편번호 검색
		$("#zipSearch").on("click", function(){
			window.open("zipcodeSearch","zipcode","width=500, height=600");
		})
		
		//유효성 검사
		$("#joinForm").submit(function(){
			//아이디검사
			if($("#userid").val()==""){
				alert("아이디를 입력하세요.");
				return false;
			}
			//첫번째문자 영대소문자
			//영어대소문자, 숫자, _가능
			//글자길이 8~15글자 사이
			//var reg = /^[A-Za-z]{1}[A-Za-z_]{7,14}$/
			var reg = /^[A-Za-z]{1}\w{7,14}$/

			if(!reg.test($("#userid").val()) ){
				alert("아이디의 첫번째 문자는 영어대소문자로 시작해야 하며, \n영어대소문자,숫자,_가능, 아이디 길이는 8~15글자까지 가능합니다.");
				return false;
			}
			if($("#idStatus").val()=="N"){
				alert("아이디 중복검사를 하세요.");
				return false;
			}
			//비밀번호
			if($("#userpwd").val()==""){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if($("#userpwd").val()!=$("#userpwd2").val()){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			//이름
			reg = /^[가-힣]{2,10}$/
			if(!reg.test($("#username").val())){
				alert("이름은 2~10글자까지의 한글만 가능합니다.");
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
			
			//취미는 2개 이상 반드시 선택
			var hobbyCount = 0;
			$("input[name=hobbyArr]").each(function(){
				if(this.checked==true) hobbyCount++;
			});
			if(hobbyCount<2){
				alert("취미는 2개 이상 선택해야 합니다.");
				return false;
			}
			
			//form태그에 action속성 설정
			$("#joinForm").attr("action","joinOk");
			
			return true;
			
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