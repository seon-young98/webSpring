<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	header,footer{
		display:none;
	}
</style>
<script>
	function setUserid(id){
		//회원가입 폼에 체크한 아이디를 표시
		opener.document.getElementById("userid").value = id;
		opener.document.getElementById("idStatus").value = "Y";
		
		//현재 아이디 검색창 닫기
		window.close(); //self.close();
	}
</script>
<div class="container">
	<div>
		<!-- 사용가능한 경우 -->
		<c:if test="${result==0 }">
			<b>${userid }</b>는 사용가능한 아이디입니다.
			<input type="button" value="사용하기" onclick="setUserid('${userid}')"/>
		</c:if>
		
		<!-- 사용불가능한 경우 -->
		<c:if test="${result>0 }">
			<b>${userid }</b>는 사용불가능한 아이디입니다.
		</c:if>
	</div>
	
	<hr/>
	<div>
		<form>
			아이디 입력: <input type="text" name="userid" id="userid"/>
			<input type="submit" value="중복검사하기"/>
		</form>
	</div>
</div>