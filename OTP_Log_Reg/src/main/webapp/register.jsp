<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-pink-500 via-purple-500 to-indigo-600 flex items-center justify-center min-h-screen">

<div class="bg-white p-8 rounded-2xl shadow-xl w-96 transition transform hover:scale-[1.02]">
  <h2 class="text-3xl font-extrabold mb-6 text-center text-gray-800">Create Account</h2>
  <p class="text-center text-gray-500 mb-6 text-sm">Fill in the details to register</p>

  <!-- Full Name -->
  <input type="text" id="name" placeholder="Full Name"
         class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:outline-none transition">

  <!-- Address -->
  <input type="text" id="address" placeholder="Address"
         class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:outline-none transition">

  <!-- Email -->
  <input type="email" id="email" placeholder="Email"
         class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:outline-none transition">

  <!-- Phone Number -->
  <input type="text" id="number" placeholder="Phone Number"
         class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:outline-none transition">

  <!-- Gender -->
  <select id="gender"
          class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:outline-none transition bg-white">
    <option value="">Select Gender</option>
    <option value="Male">Male</option>
    <option value="Female">Female</option>
    <option value="Other">Other</option>
  </select>

  <!-- Feedback -->
  <p id="feedback" class="text-sm mb-3 hidden text-center"></p>

  <!-- Register Button -->
  <button id="registerBtn"
          class="w-full bg-gradient-to-r from-green-500 to-emerald-600 text-white p-3 rounded-lg font-semibold hover:from-green-600 hover:to-emerald-700 shadow-md transition">
    Register
  </button>

  <!-- Already have account -->
  <p class="text-center text-sm mt-6 text-gray-600">
    Already have an account?
    <a href="login.jsp" class="text-indigo-600 font-semibold hover:underline">
      Login here
    </a>
  </p>
</div>

<script>
const feedback = document.getElementById('feedback');
document.getElementById('registerBtn').addEventListener('click', () => {
  const data = new URLSearchParams();
  data.append("name", document.getElementById('name').value);
  data.append("address", document.getElementById('address').value);
  data.append("email", document.getElementById('email').value);
  data.append("number", document.getElementById('number').value);
  data.append("gender", document.getElementById('gender').value);

  fetch("RegisterServlet", {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: data
  })
  .then(res => res.json())
  .then(data => {
    feedback.textContent = data.message;
    feedback.className = data.status === "success"
        ? "text-green-500 mb-3 text-center"
        : "text-red-500 mb-3 text-center";
    feedback.style.display = "block";
    if (data.status === "success") {
      setTimeout(() => { window.location.href = "login.jsp"; }, 1500);
    }
  })
  .catch(() => {
    feedback.textContent = "Something went wrong.";
    feedback.className = "text-red-500 mb-3 text-center";
    feedback.style.display = "block";
  });
});
</script>

</body>
</html>
