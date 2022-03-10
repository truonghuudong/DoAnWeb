using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_User_ActivetionEmail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try{
                string IdTaiKhoan = "";
                IdTaiKhoan = Request.QueryString.Get("IdTaiKhoan").ToString();
                UpdateActiveEmail(IdTaiKhoan);
                lb_ThongBao.Text = "Xác Thực Thành Công, Click Vào";
                lb_ThongBao.Text += " <a href='"+ "DangNhap.aspx" + "'> Đây<a>";
                lb_ThongBao.Text += " Để Đến Trang Đăng Nhập";
            }
            catch
            {
                lb_ThongBao.Text = "Xác thực thất bại";
            }
        }
    }

    void UpdateActiveEmail(string idTaiKhoan)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = idTaiKhoan;
        DB.ExecuteNonQuery("UpdateActiveEmail", p);
    }

}