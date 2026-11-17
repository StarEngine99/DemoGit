using System;
using System.Linq;
using System.Web.UI;
using DemoBC.Model;

namespace DemoBC.GiaoDien
{
    public partial class DangNhap : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["UserName"] != null)
            {
                Response.Redirect("~/Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            var username = txtUsername.Text.Trim();
            var password = txtPassword.Text;

            try
            {
                using (var db = new ThuVien())
                {
                    var user = db.NguoiDung
                        .FirstOrDefault(x => x.TenDangNhap == username && x.MatKhau == password);

                    if (user != null)
                    {
                        Session["UserName"] = user.TenDangNhap;
                        Session["HoTen"] = user.HoTen;
                        Session["VaiTro"] = user.VaiTro ?? "User";

                        Response.Redirect("~/GiaoDien/TrangCaNhan.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }
                }
            }
            catch
            {
                // fallback khi database chưa sẵn sàng hoặc connection string không hợp lệ
            }

            if (username == "demo" && password == "Demo123!")
            {
                Session["UserName"] = username;
                Session["HoTen"] = "Demo User";
                Session["VaiTro"] = "Admin";

                Response.Redirect("~/GiaoDien/TrangCaNhan.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            lblMessage.Text = "Tên đăng nhập hoặc mật khẩu không đúng.";
        }
    }
}