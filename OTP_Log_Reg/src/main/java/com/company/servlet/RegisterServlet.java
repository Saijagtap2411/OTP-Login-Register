package com.company.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.JSONObject;

import com.company.DAO.UserDAO;

/**
 * Servlet implementation class RegisterServlet
 */
//@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();

        try {
            String name    = request.getParameter("name");
            String address = request.getParameter("address");
            String email   = request.getParameter("email");
            String number  = request.getParameter("number");
            String gender  = request.getParameter("gender");

            // Check if already exists
            if (UserDAO.isEmailRegistered(email)) {
                json.put("status", "error");
                json.put("message", "Email already registered!");
            } else {
                UserDAO.registerUser(name, address, email, number, gender);
                json.put("status", "success");
                json.put("message", "Registration successful! You can now login.");
            }
        } catch (Exception e) {
            json.put("status", "error");
            json.put("message", "Server error: " + e.getMessage());
        }

        out.print(json.toString());
    }
	}


