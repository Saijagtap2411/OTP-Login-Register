<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // ✅ Redirect to dashboard if already logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedin");
    if (loggedIn != null && loggedIn) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 flex items-center justify-center min-h-screen">

<!-- Card -->
<div class="bg-white p-8 rounded-2xl shadow-xl w-96 transition transform hover:scale-[1.02]">
    <h2 class="text-3xl font-extrabold mb-6 text-center text-gray-800">Login</h2>
    <p class="text-center text-gray-500 mb-6 text-sm">Enter your email to receive OTP</p>

    <!-- Email Field -->
    <input type="email" id="email" placeholder="Enter your email"
           class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:outline-none transition">

    <!-- OTP Field (hidden initially) -->
    <div id="otpSection" style="display:none;">
        <input type="text" id="otp" placeholder="Enter OTP"
               class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-400 focus:outline-none transition">
    </div>

    <!-- Feedback -->
    <p id="feedback" class="text-sm mb-3 hidden text-center"></p>

    <!-- Buttons -->
    <button id="requestOtp"
            class="w-full bg-gradient-to-r from-blue-500 to-indigo-600 text-white p-3 rounded-lg font-semibold hover:from-blue-600 hover:to-indigo-700 shadow-md transition mb-3">
        Request OTP
    </button>

    <button id="verifyOtp" style="display:none;"
            class="w-full bg-gradient-to-r from-green-500 to-emerald-600 text-white p-3 rounded-lg font-semibold hover:from-green-600 hover:to-emerald-700 shadow-md transition">
        Verify OTP
    </button>

    <!-- Register link -->
    <p class="text-center text-sm mt-6 text-gray-600">
        Don’t have an account?
        <a href="register.jsp" class="text-indigo-600 font-semibold hover:underline">
            Register here
        </a>
    </p>
</div>

<script>
const feedback = document.getElementById('feedback');
const emailInput = document.getElementById('email');
const otpInput = document.getElementById('otp');
const otpSection = document.getElementById('otpSection');
const requestBtn = document.getElementById('requestOtp');
const verifyBtn = document.getElementById('verifyOtp');

// Request OTP
requestBtn.addEventListener('click', () => {
    const email = emailInput.value.trim();
    if(!email){
        feedback.textContent = 'Please enter your email.';
        feedback.className = 'text-red-500 text-sm mb-3 text-center';
        feedback.style.display = 'block';
        return;
    }

    feedback.textContent = 'Sending OTP...';
    feedback.className = 'text-blue-500 text-sm mb-3 text-center';
    feedback.style.display = 'block';

    fetch('OtpServlet', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=check_email&email=' + encodeURIComponent(email)
    })
    .then(res => res.json())
    .then(data => {
        feedback.textContent = data.message;
        feedback.className = data.status === 'success'
                             ? 'text-green-500 text-sm mb-3 text-center'
                             : 'text-red-500 text-sm mb-3 text-center';
        if(data.status === 'success'){
            otpSection.style.display = 'block';
            requestBtn.style.display = 'none';
            verifyBtn.style.display = 'block';
        }
    })
    .catch(err => {
        feedback.textContent = 'Something went wrong.';
        feedback.className = 'text-red-500 text-sm mb-3 text-center';
    });
});

// Verify OTP
verifyBtn.addEventListener('click', () => {
    const email = emailInput.value.trim();
    const otp = otpInput.value.trim();
    if(!otp){
        feedback.textContent = 'Please enter OTP.';
        feedback.className = 'text-red-500 text-sm mb-3 text-center';
        feedback.style.display = 'block';
        return;
    }

    fetch('OtpServlet', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=verify_otp&email=' + encodeURIComponent(email) + '&otp=' + encodeURIComponent(otp)
    })
    .then(res => res.json())
    .then(data => {
        feedback.textContent = data.message;
        feedback.className = data.status === 'success'
                             ? 'text-green-500 text-sm mb-3 text-center'
                             : 'text-red-500 text-sm mb-3 text-center';
        if(data.status === 'success'){
            window.location.href = 'dashboard.jsp'; // redirect after success
        }
    })
    .catch(err => {
        feedback.textContent = 'Something went wrong.';
        feedback.className = 'text-red-500 text-sm mb-3 text-center';
    });
});
</script>

</body>
</html>
