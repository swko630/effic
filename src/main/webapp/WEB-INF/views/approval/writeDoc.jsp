<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<%
    long currentTimeMillis = System.currentTimeMillis();
    Date currentDate = new Date(currentTimeMillis);
    request.setAttribute("currentDate", currentDate);
%>

<jsp:include page="../layout/opener.jsp"/>
<jsp:include page="../layout/sidebar.jsp" />
<link href="${contextPath}/css/writeDoc.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${contextPath}/js/writeDoc.js"></script>



</head>

<body>


 <form action="${contextPath}/approval/register.do" id="frm" method="post" enctype="multipart/form-data">
<div class="wrapper">
	<div class="mx-auto max-w-screen-2xl p-2 md:p-2 2xl:p-6">
    <div class="mb-9 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <h2 class="text-title-md2 font-bold text-black dark:text-white mt-4">문서 작성</h2>
		</div>

	<div style="font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    <div class="button-container">
    	<button id="approvalRequest" class="inline-flex rounded bg-primary px-2 py-1 text-sm font-medium text-white hover:bg-opacity-90">
            결재요청
      </button>
    	<button id="saveDraft" class="inline-flex rounded bg-primary px-2 py-1 text-sm font-medium text-white hover:bg-opacity-90">
            임시저장
      </button>
      <button id="cancelWriting" class="inline-flex rounded bg-[#DC3545] px-2 py-1 text-sm font-medium text-white hover:bg-opacity-90">
            작성취소
      </button>
    	<button id="goAppLine" class="inline-flex rounded bg-primary px-2 py-1 text-sm font-medium text-white hover:bg-opacity-90">
            결재정보
      </button>
    	<img id="urgents" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAADU0lEQVR4nO3YT0zTUBwHcE4ePXjuZGzr/jIIGy0IItAuRk9wAE4kmxLjmWBMlA2Pmo2oBzzowat68k9MBlFR/mh0W0BF0IAxxotESPjTCqLCM284snbd62zfoyTuJd+E0Db5fejb3u9HSUlxFVdx/X9LCDAdAscmBJ5ZF3kWoLLKMeBrfRVIumgQp6icDJpMYMRiFic89OVdKV7k2LNqRefLlNepiIj/TcpFPyBa/HpjjVngmN9aAQLHgOGy0ryAQYoCb/12JzGAyDNBrcVnMuGxI9/C63J6gByAYy/oBcxUupCAhIseJgYQOPaGXsCc34MEvHRYZwgCmId6AV9qKpCAcdoyTxDATuoFzNdXIQHPLOY1YgCRY7/pBSw1+ZGAR6UHN4kUD9rd+wSe3dILgEm5bUjELGvbT+QMwFF8Jh98bjBoUgZMeRx12AGrTf56nIA0osqtCJgsp08T6X8KKixQAzY6A2CzuwWAcFs68Gf4O3hNfn/SmbudiPRFAs92qxX//fghsNnTCkBfh2LgNXhP9jOLR/xgSLaVUk7bXewAkWf71f7yqOKzEfI3kZR1qq+c1gQBAHMLBYBbRK34TDY6ecmznxivBPCCtnwmARhFAdJ7PrvQa2cAGLsPwPg9AAZ6pG+hu0Xy7EKDTwIYs5qXCQDYjyjAVm+7FAALTz3eDoRkXYP3Zj+72lwtAQybD/7EDhB4Zg0foE3y7EozIwEMmUwAa/HLR2sPqH0D5WwhuG0gAhavtoUO+3LngoqKMmwAIVDrVQPg/BDHKQpMV9pbsQFEnjlWyAGG62s0TlHgjddxHh+AY7sKOYW1HGQLCgfZ9mlsv4kT0FdQG7HTSvDpfQ4/2DDbrQSv2EokFFoJmKTL9gQbQOCY6wUD/iHv8zRz6dPYYZ3eU6OkPIsNvrztNPbREscoaehoKWIYJeVZatyl0RJgHCXlGUJsIWyjJe5RMjtPy8xIAJbRcqW5uo4U4DltQQLeeelTugECx7aTAiTz/Mt9Zzb22Pt1FX+iNxo42XvpRygSA0ak69zFX8FIP68ZEIxErxpVfCiTcOyKZkAoEr1jNCAYjt3W/gbCsVGjAaFIdEQHIDpnNCAYic3qAQiGA8JRQTOguIqruEr2/PoDvwomXOvJFOsAAAAASUVORK5CYII=">
    </div>
	</div>

	<div class="btnWrapper col-9" style="margin-bottom: 10px; font-family: S-CoreDream-6Bold">
					<span class="" style="position: relative;left: 650px;">
						<label class="checkbox-inline" for="emergency" style="cursor: pointer;">
							<strong>긴급결재여부</strong>
							<input name="urgent" id="emergency" name="urgentChk" type="checkbox" style="position:relative;top: 3px; width: 17px;height: 17px;padding-top: 2px;cursor: pointer; border-radius: 3px;">
						</label>
					</span>
			</div>

<div id="divCustomWrapper" style="font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">  
<div id="titleSection" style="font-size: 19pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
	구 매 신 청 서
</div>
<div class="partition" id="draftSection" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

	<div class="left" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
		<table style="width:250px; height: 120px; margin-bottom: 30px;">
			<colgroup>
				<col width="80"><col width="170">
			</colgroup>
			<tbody>
				<tr>
					<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">		
						기 안 자
					</td>
					<td class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
							<span class="comp_item">${user.name}</span>
					</td>
				</tr>
				<tr>
					<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">			
						소속 부서번호
					</td>
					<td class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
							<span id="depNames" class="comp_item">
							<input type="hidden" id="hiddenTotalCurrency" name="depId">${user.depId}</span>
					</td>
				</tr>
				<tr>
					<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">				
						기 안 일
					</td>
					<td class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
							<span class="comp_item" id="currentDate"><fmt:formatDate value="${currentDate}" pattern="yyyy-MM-dd"/></span>
				</td>
			</tr>
			<tr>
				<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
					문서번호
				</td>
				<td class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
						<span class="comp_item"></span>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- 결재선 -->
	<table class="approvalLine" border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td rowspan="3" style="background-color: #DDDDDD;"><strong>결재선</strong></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td style="height: 50px">
            <img class="approveds" src="${contextPath}/image/approved.png">
						&nbsp;
        </td>
        <td>
        		<img class="approveds" src="${contextPath}/image/approved.png">
        		&nbsp;
     		</td>
    </tr>
    <tr>
        <td>${approval.submitDt}&nbsp;</td>
        <td>${approval.appDt}&nbsp;</td>
    </tr>
</table>


<div class="inaRowRight" style="width: 800px; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

</div>

</div>

<table id="dynamic_table" class="fixed-size">
	<colgroup>
		<col width="200">
		<col width="80">
		<col width="60">
		<col width="100">
		<col width="100">
		<col width="260">
	</colgroup>
 
	<tbody>
		<tr>
			<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				소속
			</td>
			<td colspan="3" class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				<span id="depId}" style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;">
						<input id="depName" class="ipt_editor" type="text">
				</span>
			</td>
			<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				작 성 자
			</td>
			<td colspan="1" class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				<p id="userName" style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;">						
					${user.name}
			</p>
		</td>
	</tr>
		<tr>
			<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				제 목
			</td>
			<td colspan="5" class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;">
						<input name="title" id="title" class="ipt_editor" type="text">
					<br>
				</p>
			</td>
		</tr>
		<tr>
			<td colspan="6" style="border:none !important;" class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;"><br></p>
			</td>
		</tr>
		<tr>
			<td colspan="6" class="viewModeHiddenPart td_button dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				<button id="plus" class="inline-flex rounded bg-[#637381] px-2 py-1 text-sm font-medium text-white hover:bg-opacity-90" type="button">
        		 추가
        </button>
				<button id="minus" class="inline-flex rounded bg-[#637381] px-2 py-1 text-sm font-medium text-white hover:bg-opacity-90" type="button">
        		 삭제
        </button>
			</td>
		</tr>
		<tr>
			<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				품 명
			</td>
			<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				규 격
			</td>
			<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				수 량
			</td>
			<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				단 가
			</td>
			<td class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				금 액
			</td>
			<td colspan="1" class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				비 고
			</td>
		</tr>
		<!-- 사용자가 입력하는 영역 -->
		<tr class="copyRow">
			<!-- 품명 -->
			<td class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;">
					<span style="width: 100%;">
						<input name="itemName" class="ipt_editor" type="text">
				</span><br></p>
			</td>
			<!-- 규격 -->
			<td class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;">
					<span style="width: 100%;">
						<input name="itemStandard" class="ipt_editor" type="text">
				</span><br></p>
			</td>
			<!-- 수량 -->
			<td class="detailColumn quan rightCol dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;">
					<span style="width: 100%;">
						<input name="itemQuan" class="ipt_editor ipt_editor_currency quan-input" id="quantity" type="text" style="width: 100%;">
				</span><br></p>
			</td>
			<!-- 단가 -->
			<td class="detailColumn price rightCol dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" style="">
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px; text-align: right;">
					<span style="width: 100%;">
						<input name="itemCost" class="ipt_editor ipt_editor_currency price-input" id="unit-price" type="text" style="width: 100%;">
					</span><br></p>
			</td>
			<!-- 금액 -->
			<td id="amount" class="amount" class="detailColumn cur rightCol dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" style="text-align: right;"> 
				<span id="amount" class="amount" style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px; text-align: right;">
				<input type="text" name="amount" class="ipt_editor_currency amount-input" readonly style="width: 100%;"></span>
			</td>
			<!-- 비고 -->
			<td colspan="1" class="detailColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" >
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;">
					<span style="width: 100%;">
						<input name="remarks" id="remarks"class="ipt_editor" type="text">
				</span><br></p>
			</td>
		</tr>
		<tr>
			<td colspan="1" style="text-align:center; font-weight:bold !important;" class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				합 계
			</td>
			<td>
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;"><br></p>
			</td>
			<td class="total-quantity" style="text-align: right;">
			  <input type="hidden" id="hiddenTotalQuantity" >
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;"><br></p>
			</td>
			<td class="total-price" style="text-align: right;">
		    <input type="hidden" id="hiddenTotalPrice" >
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;"><br></p>
			</td>
			<td class="total-cur" style="text-align: right;">
		    <input type="hidden" id="hiddenTotalCurrency" >
				<p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;"><br></p>
			</td>
			<td colspan="1"><br></p>
			</td>
		</tr>
		
		<tr>
			<td style="text-align:center; font-weight:bold !important;" class="subjectColumn dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				기 타
			</td>
			<td colspan="5">
			    <p style="font-size: 9pt; line-height: 18px; margin-top: 0px; margin-bottom: 0px;">
			        <span style="width: 100%;">
			            <textarea id="other" class="txta_editor" style="width: 100%; height: 100px;"></textarea>
			        </span><br>
			    </p>
			</td>
		</tr>
		<!-- 합계 행 End-->
	</tbody>
</table>
</div>
</div>
</div>
</form>


<jsp:include page="../layout/closer.jsp"/>