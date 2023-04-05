<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.board_header{
		padding:30px;
		background-color:#ddd;
	}
	.pHeader>div{
		width:50%;
		float:left;
		padding:10px 0;
		background-color:#888;
		color:white;
	}
	.pHeader>div:last-child{
		text-align:right;
	}
	.board_list li{
		float:left;
		width:10%;
		height:40px;
		line-height:40px;
		border-bottom:1px solid #ddd;
	}
	.board_list li:nth-child(6n+3){
		width:50%;
		/*밑줄임 표시하기*/
		white-space:nowrap; /*줄바꾸지 않음*/
		overflow:hidden; /*넘치는 문자 숨기기*/
		text-overflow:ellipsis;/*넘치는 데이터가 있을 때 밑줄임 표시하기*/
	}
	.pagingDiv li{
		float:left;
		padding:10px 20px;
	}
	.pagingDiv a:link, .pagingDiv a:hover, .pagingDiv a:visited, 
	.board_list a:link, .board_list a:hover, .board_list a:visited{
		color:#000;
	}
	.searchDiv{
		clear:left;
		padding:10px;
		text-align:center;
	}
</style>
<script>
	$(function(){
		$("#searchForm").submit(function(){
			if($("#searchWord").val()==""){
				alert("검색어를 입력하세요.");
				return false;
			}
			return true
		});
		
		//전체 선택을 클릭하면 체크박스 상태에 따라 선택 또는 해체 하는 기능 구현
		$("#allCheck").click(function(){
			$(".board_list inputp[name=noList]").prop("checked", $("#allCheck").prop("checked"))
		});
		
		//선택삭제 버튼을 클릭하면
		$("#chooseDel").click(function(){
			//최소 1개 이상 삭제를 선택했을 때
			var checkCount = 0;
			
			$(".board_list input[name=noList]").each(function(idx, obj){
				if(obj.checked){ //$(obj).prop('checked')
					checkCount++;
				}
			});
			
			if(checkCount>0){
				if(confirm(checkCount+"개의 게시글을 삭제하시겠습니까?")){
					$("#delList").submit();
				}
			}else{
				alert("삭제할 게시글이 없습니다.");
			}
		});
	});
</script>

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
	
	<!-- 검색 -->
	<div class="searchDiv">
		<form method="get" id="searchForm" action="boardList">
			<select name="searchKey">
				<option value="subject">제목</option>
				<option value="username">작성자</option>
				<option value="content">글내용</option>
			</select>
			<input type="text" name="searchWord" id="searchWord"/>
			<input type="submit" value="Search"/>
		</form>
	</div>
	
</div>