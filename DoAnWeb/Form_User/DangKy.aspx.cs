using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DangKy : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ViewState["RefUrl"] = Request.UrlReferrer.ToString();
        }

    }

    protected void btnTroLai_Click(object sender, EventArgs e)
    {
        object refUrl = ViewState["RefUrl"];
        if (refUrl != null)
        {
            Response.Redirect((string)refUrl);
        }
    }

    int DangKyTaiKhoanThanhVien(string TenDN,string Email, string Password)
    {
        SqlParameter[] p =
                {
                    new SqlParameter ("@TenDN",System.Data.SqlDbType.NVarChar,200),
                    new SqlParameter ("@Email",System.Data.SqlDbType.NVarChar,200),
                    new SqlParameter ("@Password",System.Data.SqlDbType.NVarChar,200)
                };
        p[0].Value = TenDN;
        p[1].Value = Email;
        p[2].Value = Password;
        return DB.ExecuteNonQuery("SetTaiKhoanThanhVien", p);
    }



    protected void btnDangNhap_1_Click(object sender, EventArgs e)
    {
        if(!inputTenDN.Text.Equals("") && !inputEmail.Text.Equals("") && !inputPassword.Text.Equals("") && !inputPassword_NhapLai.Text.Equals(""))
        {
            if (inputPassword_NhapLai.Text.Equals(inputPassword.Text))
            {

                try
                {
                    int ketqua = DangKyTaiKhoanThanhVien(inputTenDN.Text, inputEmail.Text, inputPassword.Text);
                    if (ketqua >0)
                    {
                        Response.Redirect("DangNhap.aspx");
                    }
                    else
                    {
                        lbNotify_DangNhap.Text = "Đăng ký không thành công";
                    }


                }
                catch
                {
                    lbNotify_DangNhap.Text = "Lỗi";
                }

            }
            else
            {
                lbNotify_DangNhap.Text = "Mật khâu nhập lại không trùng";
            }
        }
    }
}