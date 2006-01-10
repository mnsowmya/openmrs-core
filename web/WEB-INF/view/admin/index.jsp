<%@ include file="/WEB-INF/template/include.jsp" %>

<%@ include file="/WEB-INF/template/header.jsp" %>

<openmrs:require privilege="" otherwise="/login.htm" redirect="/admin/index.htm" />

<style>
	ul#menu, #springnote {
		background-color: whitesmoke;
		border: 1px solid lightgrey;
	}
	#menu li {
		display: list-item;
		border-left-width: 0px;
	}
	#menu li.first {
		display: none;
	}
</style>

<h2><spring:message code="admin.title"/></h2>

<div id="springnote">Marked sections have been springified</div>

<h4>Users</h4>
	<%@ include file="users/localHeader.jsp" %>

<h4>Patients</h4>
	<%@ include file="patients/localHeader.jsp" %>

<h4>Encounters</h4>
	<%@ include file="encounters/localHeader.jsp" %>
	
<h4>Observations</h4>
	<%@ include file="observations/localHeader.jsp" %>

<h4>Orders</h4>
	<%@ include file="orders/localHeader.jsp" %>

<h4>Concepts</h4>
	<%@ include file="concepts/localHeader.jsp" %>

<h4>Forms</h4> 
<ul>
	<li><a href="forms/forms.jsp">Manage forms</a></li>
	<li><a href="forms/fields.jsp">Manage fields</a></li>
	<li><a href="forms/fieldsAnswers.jsp">Manage field answers</a></li>
	<li><a href="forms/fieldTypes.jsp">Manage field types</a></li>
</ul>

<h4>Reports</h4>
	<%@ include file="reports/localHeader.jsp" %>

<%@ include file="/WEB-INF/template/footer.jsp" %>