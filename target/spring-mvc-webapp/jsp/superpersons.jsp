<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Super People!</title>
        <!-- Bootstrap core CSS -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1>Super People!!!</h1>
            <hr/>
            <c:if test="${pageContext.request.userPrincipal == null}">
                <button type="submit"
                        id="login-button"
                        class="btn btn-default"
                        style="margin-right: 150px;">
                    <a href="${pageContext.request.contextPath}/login"> 
                        Login</a>
                </button>
            </c:if>
            <div class="navbar">
                <ul class="nav nav-tabs">
                    <li role="presentation">
                        <a href="${pageContext.request.contextPath}">
                            Home
                        </a>
                    </li>
                    <li role="presentation" class="active">
                        <a href="${pageContext.request.contextPath}/superpersons">
                            Super Heroes and Villains
                        </a>
                    </li>
                    <li role="presentation">
                        <a href="${pageContext.request.contextPath}/locations">
                            Locations
                        </a>
                    </li>
                    <li role="presentation">
                        <a href="${pageContext.request.contextPath}/organizations">
                            Organizations
                        </a>
                    </li>
                    <li role="presentation">
                        <a href="${pageContext.request.contextPath}/sightings">
                            Sightings
                        </a>
                    </li>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <li role="presentation">
                            <a href="${pageContext.request.contextPath}/displayUserList">
                                User Admin
                            </a>
                        </li>                        
                    </sec:authorize>

                </ul>    
            </div>

            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <h4>Hello : ${pageContext.request.userPrincipal.name}
                    | <a href="<c:url value="/j_spring_security_logout" />" > Logout</a>
                </h4>
            </c:if>

            <div class="row">
                <div class="col-md-6">
                    <h2>Super Heroes and Villains </h2>

                    <table id="contactTable" class="table table-hover">
                        <tr>
                            <th width="40%">Name</th>
                            <th width="30%">Power</th>
                            <th width="15%"></th>
                            <th width="15%"></th>
                        </tr>
                        <tr>
                            <c:forEach var="currentPerson" items="${spList}">
                            <tr>
                                <td>
                                    <a href="displayPersonDetails?superpersonId=${currentPerson.superpersonId}">
                                        <c:out value="${currentPerson.name}"/>
                                    </a>
                                </td>
                                <td>
                                    <c:out value="${currentPerson.power}"/>
                                </td>
                                <td>
                                    <sec:authorize access="isAuthenticated()">
                                        <a href="editPersonForm?superpersonId=${currentPerson.superpersonId}">
                                            Edit
                                        </a>
                                    </sec:authorize>
                                </td>
                                <td>
                                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                                        <a href="deletePerson?superpersonId=${currentPerson.superpersonId}">
                                            Delete
                                        </a>
                                    </sec:authorize>
                                </td>
                            </tr>
                        </c:forEach>
                        </tr>
                    </table> 
                </div>
                <div class="col-md-6">
                    <sec:authorize access="isAuthenticated()">
                        <h2>Add New</h2>
                        <form class="form-horizontal"
                              role="form" method="POST"
                              action="addNewPerson">
                            <div class="form-group">
                                <label for="add-name" class="col-md-4 control-label">
                                    Name:
                                </label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" name="name" placeholder="Name" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add-power" class="col-md-4 control-label">
                                    Power:
                                </label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" name="power" placeholder="Power" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add-description" class="col-md-4 control-label">
                                    Description:
                                </label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" name="description" placeholder="Description" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add-organization" class="col-md-4 control-label">
                                    Organization:
                                </label>
                                <div class="col-md-8">                                                             
                                    <c:forEach var="currentO" items="${oList}">
                                        <input type="checkbox" value="${currentO.organizationId}" name="orgsList"> 
                                        ${currentO.name}
                                    </c:forEach>                            
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-4 col-md-8">
                                    <input type="submit" value="Add"/>
                                </div>
                            </div>
                        </form>
                    </sec:authorize>
                </div>
            </div>
        </div>
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

    </body>
</html>

