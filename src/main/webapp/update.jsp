<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    // Lấy id từ đường dẫn hoặc từ input ẩn trong form
    String id = request.getParameter("id");

    if (id == null || id.trim().equals("")) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Xử lý khi bấm nút Cập nhật
    if (request.getParameter("submit") != null) {

        String name = request.getParameter("sname");
        String course = request.getParameter("course");
        String fee = request.getParameter("fee");

        Connection updateCon = null;
        PreparedStatement updatePst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            updateCon = DriverManager.getConnection(
                "jdbc:mysql://localhost/schooll"
                + "?useUnicode=true"
                + "&characterEncoding=UTF-8"
                + "&serverTimezone=Asia/Ho_Chi_Minh",
                "root",
                "123456"
            );

            String sql = "UPDATE records "
                       + "SET name = ?, course = ?, fee = ? "
                       + "WHERE id = ?";

            updatePst = updateCon.prepareStatement(sql);

            updatePst.setString(1, name);
            updatePst.setString(2, course);
            updatePst.setString(3, fee);
            updatePst.setString(4, id);

            int result = updatePst.executeUpdate();

            if (result > 0) {
%>

<script>
    alert("Cập nhật thành công!");
    window.location.href = "index.jsp";
</script>

<%
                return;
            } else {
%>

<script>
    alert("Không tìm thấy dữ liệu cần cập nhật!");
</script>

<%
            }

        } catch (Exception e) {
%>

<script>
    alert("Lỗi cập nhật: <%= e.getMessage().replace("\"", "'") %>");
</script>

<%
        } finally {
            if (updatePst != null) {
                try {
                    updatePst.close();
                } catch (Exception e) {
                }
            }

            if (updateCon != null) {
                try {
                    updateCon.close();
                } catch (Exception e) {
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Cập nhật sinh viên</title>

    <link href="bootstrap/css/bootstrap.min.css"
          rel="stylesheet"
          type="text/css">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background-color: #f4f6f9;
            font-family: Arial, sans-serif;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .update-box {
            width: 100%;
            max-width: 600px;
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.18);
        }

        .update-title {
            text-align: center;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 600;
        }

        .form-control {
            height: 48px;
        }

        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
            margin-top: 25px;
        }

        .back-box {
            text-align: right;
            margin-top: 8px;
        }
    </style>
</head>

<body>

<div class="update-box">

    <h2 class="update-title">
        Cập nhật sinh viên
    </h2>

    <%
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost/schooll"
                + "?useUnicode=true"
                + "&characterEncoding=UTF-8"
                + "&serverTimezone=Asia/Ho_Chi_Minh",
                "root",
                "123456"
            );

            pst = con.prepareStatement(
                "SELECT * FROM records WHERE id = ?"
            );

            pst.setString(1, id);

            rs = pst.executeQuery();

            if (rs.next()) {
    %>

    <form method="post" action="update.jsp">

        <!-- Input ẩn dùng để gửi id khi bấm Cập nhật -->
        <input type="hidden"
               name="id"
               value="<%= id %>">

        <div class="mb-3">

            <label class="form-label">
                Tên sinh viên
            </label>

            <input type="text"
                   class="form-control"
                   name="sname"
                   id="sname"
                   value="<%= rs.getString("name") %>"
                   required>

        </div>

        <div class="mb-3">

            <label class="form-label">
                Môn học
            </label>

            <input type="text"
                   class="form-control"
                   name="course"
                   id="course"
                   value="<%= rs.getString("course") %>"
                   required>

        </div>

        <div class="mb-3">

            <label class="form-label">
                Học phí
            </label>

            <input type="number"
                   class="form-control"
                   name="fee"
                   id="fee"
                   value="<%= rs.getString("fee") %>"
                   min="0"
                   required>

        </div>

        <div class="button-group">

            <button type="submit"
                    name="submit"
                    value="submit"
                    class="btn btn-info">

                Cập nhật

            </button>

            <button type="reset"
                    class="btn btn-warning">

                Khôi phục

            </button>

            <button type="button"
                    class="btn btn-secondary"
                    onclick="clearForm()">

                Xóa trắng

            </button>

        </div>

        <div class="back-box">

            <a href="index.jsp">
                Quay lại
            </a>

        </div>

    </form>

    <%
            } else {
    %>

        <div class="alert alert-warning">
            Không tìm thấy sinh viên cần cập nhật.
        </div>

        <a href="index.jsp" class="btn btn-secondary">
            Quay lại
        </a>

    <%
            }

        } catch (Exception e) {
    %>

        <div class="alert alert-danger">
            Lỗi tải dữ liệu:
            <%= e.getMessage() %>
        </div>

    <%
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (Exception e) {
                }
            }

            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                }
            }
        }
    %>

</div>

<script>
    function clearForm() {
        document.getElementById("sname").value = "";
        document.getElementById("course").value = "";
        document.getElementById("fee").value = "";
        document.getElementById("sname").focus();
    }
</script>

</body>
</html>