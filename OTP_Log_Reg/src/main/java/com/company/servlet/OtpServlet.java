package com.company.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;

import com.company.DAO.OtpDAO;
import com.company.DAO.UserDAO;
import com.company.Util.ElasticEmailUtil;


/**
 * Servlet implementation class OtpServlet
 */
//@WebServlet("/OtpServlet")
public class OtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OtpServlet() {
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

		    String action = request.getParameter("action");
		    String email = request.getParameter("email");

		    JSONObject json = new JSONObject();

		    try {
		        if ("check_email".equals(action)) {
		            if (!UserDAO.isEmailRegistered(email)) {
		                json.put("status", "error");
		                json.put("message", "Email is not registered with us!");
		            } else {
		                String otp = String.valueOf((int) (Math.random() * 900000) + 100000);
		                OtpDAO.insertOtp(email, otp);
		                ElasticEmailUtil.sendOtpEmail(email, otp);

		                json.put("status", "success");
		                json.put("message", "OTP sent to your email!");
		            }

		        } else if ("verify_otp".equals(action)) {
		            String otp = request.getParameter("otp");
		            boolean valid = OtpDAO.verifyOtp(email, otp);

		            if (valid) {
		                HttpSession session = request.getSession();
		                session.setAttribute("loggedin", true);
		                session.setAttribute("email", email);

		                OtpDAO.deleteOtp(email);

		                json.put("status", "success");
		                json.put("message", "OTP verified successfully!");
		                json.put("redirect", "dashboard.jsp");
		            } else {
		                json.put("status", "error");
		                json.put("message", "Invalid or expired OTP");
		            }

		        } else {
		            // This block only runs if action is null or something else
		            json.put("status", "error");
		            json.put("message", "Invalid Request");
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		        json.put("status", "error");
		        json.put("message", "Server error: " + e.getMessage());
		    }

		    out.print(json.toString());
		}
        
	}


