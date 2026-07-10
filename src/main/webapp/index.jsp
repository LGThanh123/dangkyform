<%-- 
    Document   : index
    Created on : Jun 26, 2026, 2:24:03 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%--khai bao ketnoi--%>
<%@page import="java.sql.*"%>
<%
    if(request.getParameter("submit")!=null){
    //doc du lieu duoc nhap vao
    String name=request.getParameter("sname");
    String course=request.getParameter("course");
    String fee=request.getParameter("fee");
    
    //khai bao ket noi va chuan bi mau syntax de add du lieu vao database
    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    
    //Tao ket noi va add du lieu vao data base
    Class.forName("com.mysql.jdbc.Driver");
    
    con=DriverManager.getConnection("jdbc:mysql://localhost/schooll","root","123456");
    pst=con.prepareStatement("insert into records(name,course,fee)values(?,?,?)");
    pst.setString(1,name);
    pst.setString(2,course);
    pst.setString(3,fee);
    
    //update database
    pst.executeUpdate();
    %>
    <%--Tao thong bao khi add thanh cong--%>
    <script>
        alert("tao thanh cong");
    </script>
    <%
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>dang ky mon</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <h1>dang ky mon</h1><br>
        <div align="right">
        hello, <%= session.getAttribute("username") %> | <a href="logout.jsp">dang xuat</a>
        </div>
        <div class="container mt-4">
    <div class="row">

        <div class="col-sm-4">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4>Đăng ký môn học</h4>
                </div>

                <div class="card-body">
                <form method="post" action="#">
                    <%
                        String defaultName = "";
                        if(request.getParameter("reset")!=null){
                            defaultName= "";
                        }
                    %>
                    <div align="left">
                        <label class="form-label">nhap ten sinh vien</label>
                        <input type="text" class="form-control" placeholder="ten sinh vien"
                               value="<%= defaultName %>"
                               name="sname" id="sname" required>
                    </div>
                    <div align="left">
                        <label class="form-label">nhap mon hoc</label>
                        <input type="text" class="form-control" placeholder="mon hoc"
                               value="<%= defaultName %>"
                               name="course" id="course" required>
                    </div>
                    
                    <div align="left">
                        <label class="form-label">nhap hoc phi</label>
                        <input type="number" class="form-control" placeholder="hoc phi"
                               value="<%= defaultName %>"
                               name="fee" id="fee" required>
                    </div>
                    </br>
                    <div align="right">
                        <input type="submit" id="submit" value="submit" name="submit" class="btn btn-info">
                        
                        <input type="reset" id="reset" value="reset" name="reset" class="btn btn-warning">
                    </div>
                
</form>
                </div>   
            </div>      
        </div>                    
            <div class="col-sm-8">

    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4>Danh sách sinh viên</h4>
        </div>

        <div class="card-body">
                <table id="tbl-student" class="table table-responsive table bordered" cellpadding="0" width="100">
                    <thread>
                        <tr>
                            <th>ten sinh vien</th>
                            <th>mon hoc</th>
                            <th>hoc phi</th>
                            <th>chinh sua</th>
                            <th>xoa</th>
                        </tr>
                    </thread>
                        <%
                        //khai bao ket noi va chuan bi mau syntax de add du lieu vao database
                            Connection con;
                            PreparedStatement pst;
                            ResultSet rs;
    
                            //Tao ket noi va add du lieu vao data base
                            Class.forName("com.mysql.jdbc.Driver");
    
                            con=DriverManager.getConnection("jdbc:mysql://localhost/schooll","root","123456");
                        
                        //syntax lay du lieu
                        String query="select * from records";
                        Statement st=con.createStatement();
                        
                        rs=st.executeQuery(query);
                        
                        //Bay gio chung ta xu dung vong lap de dien thong tin
                        //luu y dung lenh while
                        // dau dong } dat sau viec ke bang duoi
                        while(rs.next()){
                        String id=rs.getString("id"); //lay tieu de bang trong database
                        %>
                      
                        <tr>
                            <th><%=rs.getString("name")%></th>
                            <th><%=rs.getString("course")%></th>
                            <th><%=rs.getString("fee")%></th>
                            <th><a href="update.jsp?id=<%=id%>">chỉnh sửa</a></th>
                            <th><a href="delete.jsp?id=<%=id%>">xóa</a></th>
                        </tr>
                        <%
                            }
                        %>
</table>
                </div>   
            </div>       
        </div>           
    </div>              
</div>                   
</html>
