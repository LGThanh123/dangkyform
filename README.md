công nghệ sử dụng
+ NetBeans IDE (có hỗ trợ Java EE / Jakarta EE)
+ Apache Tomcat 9.0
+ MySQL Server (đã cài riêng, không dùng XAMPP)
+ JDK 11 trở lên

Tạo database
Mở MySQL Workbench (hoặc Command Line Client), đăng nhập bằng user root, chạy file setup_schooll.sql (đính kèm trong repo) để:
Tạo database schooll
Tạo bảng users (tài khoản đăng nhập, mật khẩu đã băm SHA-256)
Tạo bảng records (dữ liệu học viên: id, strname, course, fee)

cấu hình kết nối mysql
user"root" pass"123456"

để chạy project
ở trong nextbean chỉ cần bấm Run hoặc shift+F6
tài khoản:admin     mật khẩu:123456

các chức năng
đăng nhập
xem danh sách sinh viên
thêm sửa hoặc xóa
