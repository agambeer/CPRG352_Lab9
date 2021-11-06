<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body {
                margin: 0;
                font-family: 'Arial', sans-serif;
            }

            h1 {
                color: darkgreen;
                text-align: center;
                margin: 0;
                padding: 10px;
            }

            form {
                display: inline-block;
                border-radius: 5px;
                border: yellowgreen solid 2px;
                text-align: center;
                padding: 10px;
                margin: 30px;
            }

            h2 {
                padding: 10px;
                color: green;
                text-align: center;
                margin: 0;
            }

            input {
                border-color: yellowgreen;
            }

            .box {
                border: yellowgreen solid 2px;
                border-radius: 3px;
                height: 20px;
                width: 200px;
            }

            .select {
                border: yellowgreen solid 2px;
                border-radius: 3px;
                height: 25px;
                width: 210px;
            }

            .button {
                margin: 20px;
                color: darkgreen;
                background-color: yellow;
                padding: 5px 10px;
                border: yellowgreen solid 2px;
                border-radius: 3px;
                font-size: large;
                font-weight: bold;
            }

            div {
                text-align: center;
            }

            table {
                border: 2px solid yellowgreen;
                border-collapse: collapse;
                width: auto;
                margin: 0 auto;
            }
            table th {
                border: 2px solid yellowgreen;
                border-collapse: collapse;
                padding: 5px 10px;
                color: darkgreen;
            }
            table td {
                border: 2px solid yellowgreen;
                border-collapse: collapse;
                padding: 5px 10px;
            }

            p {
                text-align: center;
                color: green;
            }

        </style>
        <title>Users</title>
    </head>
    <body>
        <h1>Users</h1>
        <div>
            <form class="forms" method="post" action="user">
                <h2>Add User</h2>
                <input id="add_email" class="box" type="email" name="add_email" placeholder="Email" value="${add_email}" required><br><br>
                Active:
                    <input id="add_active_yes" type="radio" name="add_active[]" value="true"><label for="add_active_yes" required>Yes</label>
                    <input id="add_active_no" type="radio" name="add_active[]" value="false"><label for="add_active_no" required>No</label><br><br>
                <input id="add_first_name" class="box" type="text" name="add_first_name" placeholder="First Name" value="${add_first_name}" required><br><br>
                <input id="add_last_name" class="box" type="text" name="add_last_name" placeholder="Last Name" value="${add_last_name}" required><br><br>
                <input id="add_password" class="box" type="password" name="add_password" placeholder="Password" value="${add_password}" required><br><br>
                <select class="select" name="add_role">
                    <option value="">--choose--</option>
                    <c:forEach var="role" items="${roles}">
                        <option ${add_role=="${role.roleName}"?"selected":""} value="${role.roleName}">${role.roleName}</option>
                    </c:forEach>
                </select><br>
                <input class="button" type="submit" value="Save">
                <input type="hidden" name="action" value="add">
            </form>

            <form class="forms" method="post" action="user">
                <h2>Edit User</h2>
                <input id="edit_email" class="box" type="email" name="edit_email" value="${edit_email}" readonly><br><br>
                Active:
                    <input id="edit_active_yes" type="radio" name="edit_active[]" value="true"><label for="edit_active_yes" required>Yes</label>
                    <input id="edit_active_no" type="radio" name="edit_active[]" value="false"><label for="edit_active_no" required>No</label><br><br>
                <input id="edit_first_name" class="box" type="text" name="edit_first_name" placeholder="First Name" value="${edit_first_name}" required><br><br>
                <input id="edit_last_name" class="box" type="text" name="edit_last_name" placeholder="Last Name" value="${edit_last_name}" required><br><br>
                <input id="edit_password" class="box" type="password" name="edit_password" placeholder="Password" value="${edit_password}" required><br><br>
                <select class="select" name="edit_role" required>
                    <option value="">--choose--</option>
                    <c:forEach var="role" items="${roles}">
                        <option ${edit_role=="${role.roleName}"?"selected":""} value="${role.roleName}">${role.roleName}</option>
                    </c:forEach>
                </select><br>
                <input class="button" type="submit" value="Update">
                <input type="hidden" name="action" value="edit">
            </form>
        </div>

        <div>
            <h2>Manage Users</h2>
            <table>
                <tr>
                    <th>Email</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.email}</td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td><a href="user?action=edit&amp;email=${user.email}">Edit</a></td>
                        <td><a href="user?action=delete&amp;email=${user.email}">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <p>${message}</p>
    </body>
</html>
