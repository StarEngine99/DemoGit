using System;
using System.Web.UI;

namespace DemoBC
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null || string.IsNullOrWhiteSpace(Session["UserName"].ToString()))
            {
                Response.Redirect("~/GiaoDien/DangNhap.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            Response.Redirect("~/GiaoDien/TrangCaNhan.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}