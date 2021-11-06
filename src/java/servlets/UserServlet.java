package servlets;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import services.UserService;
import services.RoleService;
import models.User;
import models.Role;

public class UserServlet extends HttpServlet { 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserService us = new UserService();
        RoleService rs = new RoleService();
        try {
            if (request.getParameter("action") != null) {
                if (request.getParameter("action").equals("edit")) {
                    String email = request.getParameter("email");
                    request.setAttribute("edit_email", email);
                }
                if (request.getParameter("action").equals("delete")) {
                    String email = request.getParameter("email");
                    us.delete(email);
                    request.setAttribute("message", "User " + email + " deleted!");
                }
            }
            List<User> users = us.getAll();
            request.setAttribute("users", users);
            List<Role> roles = rs.getAll();
            request.setAttribute("roles", roles);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("action", null);
        getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserService us = new UserService();
        RoleService rs = new RoleService();
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String stringRole = "";
        int intRole = 0;
        try {
            switch(action) {
                case "add":
                    stringRole = request.getParameter("add_role");
                    switch(stringRole) {
                        case "system admin": intRole = 1; break;
                        case "regular user": intRole = 2; break;
                        case "company admin": intRole = 3; break;
                        default: break;
                    }
                    email = request.getParameter("add_email");
                    us.insert( email, 
                            Boolean.parseBoolean(request.getParameter("add_active[]")), 
                            request.getParameter("add_first_name"), 
                            request.getParameter("add_last_name"), 
                            request.getParameter("add_password"), 
                            intRole
                        );
                    request.setAttribute("message", "User " + email + " added!");
                    break;

                case "edit":
                    stringRole = request.getParameter("edit_role");
                    switch(stringRole) {
                        case "system admin": intRole = 1; break;
                        case "regular user": intRole = 2; break;
                        case "company admin": intRole = 3; break;
                        default: break;
                    }
                    email = request.getParameter("edit_email");
                    us.update(email, 
                            Boolean.parseBoolean(request.getParameter("edit_active[]")), 
                            request.getParameter("edit_first_name"), 
                            request.getParameter("edit_last_name"), 
                            request.getParameter("edit_password"), 
                            intRole
                        );
                    request.setAttribute("message", "User " + email + " edited!");
                    break;
                
                default:
                    break;
            }
            List<User> users = us.getAll();
            request.setAttribute("users", users);
            List<Role> roles = rs.getAll();
            request.setAttribute("roles", roles);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("action", null);
        getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
        return;
    }
}
