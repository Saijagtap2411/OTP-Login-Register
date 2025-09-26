<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // ✅ Check login session
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://unpkg.com/lucide-icons/dist/umd/lucide.js"></script>
</head>
<body class="bg-gradient-to-br from-indigo-700 via-purple-700 to-pink-600 min-h-screen flex flex-col">

<!-- Navbar -->
<nav class="bg-white/90 backdrop-blur-md shadow-md px-6 py-4 flex justify-between items-center">
  <h1 class="text-2xl font-extrabold text-indigo-700">Dashboard</h1>
  <div class="flex items-center space-x-6">
    <span class="text-gray-700 font-medium"><%= email %></span>
    <form action="LogoutServlet" method="get">
      <button type="submit"
              class="bg-red-600 text-white px-4 py-2 rounded-lg font-semibold hover:bg-red-700 transition">
        Logout
      </button>
    </form>
  </div>
</nav>

<!-- Main Content -->
<div class="flex-1 flex items-center justify-center px-6 py-10">
  <div class="bg-white p-8 rounded-2xl shadow-2xl w-full max-w-5xl">
    <h2 class="text-3xl font-bold text-gray-800 mb-6">Welcome 🎉</h2>
    <p class="text-gray-600 mb-10">You are logged in as <span class="font-semibold text-indigo-600"><%= email %></span></p>

    <!-- Cards Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
      <!-- Profile -->
      <!--  <a href=""
         class="group bg-gradient-to-r from-blue-500 to-indigo-600 text-white p-6 rounded-xl shadow-lg hover:shadow-2xl transition transform hover:-translate-y-1">
        <div class="flex items-center space-x-4">
          <div class="bg-white/20 p-3 rounded-full">
            <i data-lucide="user" class="w-6 h-6"></i>
          </div>
          <h3 class="text-lg font-semibold">Profile</h3>
        </div>
        <p class="mt-3 text-sm opacity-90 group-hover:opacity-100">View and update your personal information.</p>
      </a>-->

      <!-- Settings -->
      <!--<a href=""
         class="group bg-gradient-to-r from-green-500 to-emerald-600 text-white p-6 rounded-xl shadow-lg hover:shadow-2xl transition transform hover:-translate-y-1">
        <div class="flex items-center space-x-4">
          <div class="bg-white/20 p-3 rounded-full">
            <i data-lucide="settings" class="w-6 h-6"></i>
          </div>
          <h3 class="text-lg font-semibold">Settings</h3>
        </div>
        <p class="mt-3 text-sm opacity-90 group-hover:opacity-100">Customize your account preferences.</p>
      </a>-->

      <!-- Reports -->
      <!--<a href=""
         class="group bg-gradient-to-r from-purple-500 to-pink-500 text-white p-6 rounded-xl shadow-lg hover:shadow-2xl transition transform hover:-translate-y-1">
        <div class="flex items-center space-x-4">
          <div class="bg-white/20 p-3 rounded-full">
            <i data-lucide="bar-chart-3" class="w-6 h-6"></i>
          </div>
          <h3 class="text-lg font-semibold">Reports</h3>
        </div>
        <p class="mt-3 text-sm opacity-90 group-hover:opacity-100">Access your usage statistics and insights.</p>
      </a>-->
    </div>
  </div>
</div>

<script>
  lucide.createIcons();
</script>

</body>
</html>
