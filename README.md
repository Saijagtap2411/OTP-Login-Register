OTP Login & Registration System

A secure and user-friendly OTP-based authentication system built with Java Servlets, JSP, Tailwind CSS, and ElasticEmail API. This project facilitates user registration, OTP-based login, and session management, ensuring a seamless experience.

Features

User Registration: Collects essential user details including name, address, email, phone number, and gender.

OTP-Based Login: Sends a one-time password to the user's email for authentication.

Session Management: Protects the dashboard and ensures users cannot access it without proper login.

Responsive UI: Modern and mobile-friendly interface built with Tailwind CSS.

Dashboard: Provides a user dashboard with profile, settings, and reports sections.

Logout Functionality: Clears session and redirects users to the login page.

Technologies Used

Backend: Java Servlets, JSP

Frontend: HTML, Tailwind CSS

Database: MySQL

Email Service: ElasticEmail API

Server: Apache Tomcat 11

Project Structure
OTP_Log_Reg/
├── src/
│   ├── com/
│   │   ├── company/
│   │   │   ├── servlet/
│   │   │   │   ├── LoginServlet.java
│   │   │   │   ├── LogoutServlet.java
│   │   │   │   └── RegisterServlet.java
│   │   │   ├── dao/
│   │   │   │   ├── UserDAO.java
│   │   │   │   └── OtpDAO.java
│   │   │   └── util/
│   │   │       └── ElasticEmailUtil.java
├── WebContent/
│   ├── login.jsp
│   ├── register.jsp
│   ├── dashboard.jsp
│   └── WEB-INF/
│       └── web.xml
└── README.md

Database Setup

Create a database named pracdb.

Execute the following SQL commands to create necessary tables:

CREATE TABLE usermasterbean1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    email VARCHAR(100) UNIQUE,
    number VARCHAR(20),
    gender VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE otp_reg (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100),
    otp VARCHAR(6),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


Update database credentials in UserDAO and OtpDAO classes.

How to Run

Clone the repository:

git clone https://github.com/Saijagtap2411/OTP-Login-Register.git


Import the project into your IDE (e.g., Eclipse or IntelliJ IDEA).

Add required libraries (e.g., JSON library org.json jar).

Configure database connection in DAO classes.

Deploy the project on Apache Tomcat 11.

Access the application at:

http://localhost:8080/OTP_Log_Reg/login.jsp

Notes

Ensure you have a valid ElasticEmail API key and update it in ElasticEmailUtil.java.

OTP validity is set to 10 minutes.

For production environments, configure proper email sender and security settings.

License

This project is open-source and free to use under the MIT License.
