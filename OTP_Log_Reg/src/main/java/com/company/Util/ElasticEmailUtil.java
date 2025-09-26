package com.company.Util;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class ElasticEmailUtil {
    private static final String API_KEY = "Your_API_KEY_HERE";
    private static final String FROM_EMAIL = "YOUR_VERIFIED_EMAIL_HERE";

    public static void sendOtpEmail(String toEmail, String otp) throws Exception {
        String subject = "OTP_LOG_REG: Your Email Verification Code";
        String bodyHtml = "<h2>Your OTP_LOG_REG Verification Code</h2>"
                + "<p>Use this OTP: <b>" + otp + "</b></p>"
                + "<p>Valid for 10 minutes.</p>";

        URL url = new URL("https://api.elasticemail.com/v4/emails");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("X-ElasticEmail-ApiKey", API_KEY);
        conn.setDoOutput(true);

        String jsonBody = "{"
                + "\"Recipients\":[{\"Email\":\"" + toEmail + "\"}],"
                + "\"Content\":{"
                + "\"Body\":[{\"ContentType\":\"HTML\",\"Content\":\"" + bodyHtml.replace("\"","\\\"") + "\"}],"
                + "\"Subject\":\"" + subject + "\","
                + "\"From\":\"" + FROM_EMAIL + "\"}"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonBody.getBytes());
            os.flush();
        }

        if (conn.getResponseCode() != 200 && conn.getResponseCode() != 202) {
            throw new RuntimeException("ElasticEmail error, code: " + conn.getResponseCode());
        }
    }
}
