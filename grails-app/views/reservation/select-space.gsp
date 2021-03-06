<%--
  Created by IntelliJ IDEA.
  User: jesse
  Date: 12/31/14
  Time: 12:11 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title></title>
</head>

<body>
    <div class="panel panel-default">
        <div class="panel-heading">Select a Space and Time</div>
        <div class="panel-body">
            <table class="table table-hover" id="availability-table">
                <thead>
                    <th colspan="2">Name</th>
                    <g:each in="${availableTimes}" var="date">
                        <th><g:formatDate date="${date}" format="h:mm a"/></th>
                    </g:each>
                </thead>
                <tbody>
                    <g:each in="${locations}" var="location">
                        <tr>
                            <td colspan="2">${location.building} ${location.room}</td>
                            <g:each in="${availableTimes}" var="time" status="i">
                                <g:if test="${time < new Date()}">
                                    <td class="past"></td>
                                </g:if>
                                <g:elseif test="${reservations[location].any { it.startDate <= time && it.endDate >= time } }">
                                    <g:if test="${ reservations[location].find { it.startDate <= time && it.endDate >= time }.reserverId == (sec.loggedInUserInfo(field: 'id') as Long)}">
                                        <td class="reserved-by-user">
                                            <g:link controller="reservation" action="deleteReservation" params="[locationId: location.id, startTime: time.time]">
                                                <span class="glyphicon glyphicon-remove-circle"></span>
                                            </g:link>
                                        </td>
                                    </g:if>
                                    <g:else>
                                        <td class="unavailable"></td>
                                    </g:else>
                                </g:elseif>
                                <g:else>
                                    <td class="available">
                                        <g:link controller="reservation" action="confirmReservation" params="[locationId: location.id, startTime: time.time]">
                                            <span class="glyphicon glyphicon-thumbs-up"></span>
                                        </g:link>
                                    </td>
                                </g:else>
                            </g:each>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>