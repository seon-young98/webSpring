<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
	<h1>게시판 목록</h1>
	<!--                              "/campus/board/boardWrite" -->
	<div class="board header"><a href="boardWrite">글쓰기</a></div>
	<div class="pHeader">
		<div>총 레코드 수: ${vo.totalRecord }</div>
		<div>${vo.totalPage }/${vo.nowPage }</div>
	</div>
	<form method="post" action="/campus/board/boardMultiDel" id="delList">
	<!-- 페이지번호, 검색키, 검색어 -->
	<input type="hidden" name="nowPage" value="${vo.nowPage }"/>
	<c:if test="${vo.searchWord!=null }">
		<input type="hidden" name="searchKey" value="${vo.searchKey}"/>
		<input type="hidden" name="searchWord" value="${vo.searchWord }"/>
	</c:if>
		<ul class="board_list">
			<li><input type="checkbox" id="allCheck"/>전체선택</li>
			<li>번호</li>
			<li>제목</li>
			<li>작성자</li>
			<li>조회수</li>
			<li>등록일</li>
			
			<!-- 시작번호 설정                         총레코드수       현재페이지    한페이지에 표시할 레코드 수-->
			<c:set var="recordNum" value="${vo.totalRecord - (vo.nowPage-1)*vo.onePageRecord }"/>
			
			<c:forEach var="bDTO" items="${list }">
				<li>
					<!-- 로그인한 회원이 작성한 글일 경우 -->
					<c:if test="${bDTO.userid==logId }">
						<input type="checkbox" name="noList" value="${bDTO.no }"/>
					</c:if>
					<!-- 로그인한 회원이 작성한 글이 아닐 경우 -->
					<c:if test="${bDTO.userid!=logId }">
						<input type="checkbox" disabled/>
					</c:if>
				</li>
				<li>${recordNum }</li>
				<!-- 글내용보기: 레코드번호, 현재페이지, 검색어가 있으면 검색키랑 검색어를 가지고 뷰페이지로 이동하여 다시 목록으로 올 때 해당 검색과 페이지로 이동할 수 있어야 함 -->
				<li><a href="boardView?no=${bDTO.no}&nowPage=${vo.nowPage}<c:if test="${vo.searchWord!=null }">&searchKey=${vo.searchKey }&searchWord=${vo.searchWord }</c:if>">${bDTO.subject }</a></li>
				<li>${bDTO.username }</li>
				<li>${bDTO.hit }</li>
				<li>${bDTO.writedate }</li>
				
				<c:set var="recordNum" value="${recordNum-1}"/>
			</c:forEach>
		</ul>
	</form>
	<div>
		<input type="button" value="선택삭제" id="chooseDel"/>
	</div>
	<!-- 페이징 -->
	<div class="pagingDiv">
		<ul>
			<!-- 이전페이지: nowPage를 기준으로 -->
			<c:if test="${vo.nowPage==1 }"><!-- 현재 페이지가 첫번째 페이지일 때 -->
				<li>prev</li>
			</c:if>
			<c:if test="${vo.nowPage>1 }"><!-- 현재 페이지가 첫번째 페이지가 아닐 때 -->
				<li><a href="boardList?nowPage=${vo.nowPage-1}<c:if test="${vo.searchWord!=null }">&searchKey=${vo.searchKey}&searchWord=${vo.searchWord }</c:if>">prev</a></li>
			</c:if>
			
			<!-- 페이지 번호 -->
			<c:forEach var="p" begin="${vo.startPageNum }" end="${vo.startPageNum+vo.onePageNumCount-1 }">
				<c:if test="${p<=vo.totalPage }"> <!-- 표시할 페이지 번호가 총 페이지 수보다 작거나 같을 때만 페이지 번호 출력 -->
					<!-- 현재 페이지 표시하기 -->
					<c:if test="${p==vo.nowPage }">
						<li style="background:#ddd;">
					</c:if>
					<c:if test="${p!=vo.nowPage }">
						<li>
					</c:if>
					<a href="boardList?nowPage=${p }<c:if test="${vo.searchWord!=null }">&searchKey=${vo.searchKey}&searchWord=${vo.searchWord }</c:if>">${p }</a></li>
				</c:if>
			</c:forEach>
			
			<!-- 다음 페이지 -->
			<c:if test="${vo.nowPage<vo.totalPage }"> <!-- 다음 페이지가 있을 때 -->
				<li><a href="boardList?nowPage=${vo.nowPage+1 }<c:if test="${vo.searchWord!=null }">&searchKey=${vo.searchKey}&searchWord=${vo.searchWord }</c:if>">next</a></li>	
			</c:if>	
			<c:if test="${vo.nowPage==vo.totalPage }"> <!-- 현재 페이지가 마지막 페이지일 때 -->
				<li>next</li>
			</c:if>
		</ul>
	</div>
</div>