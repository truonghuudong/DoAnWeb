using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_User_DangKyNguoiBan : System.Web.UI.Page
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

    DataTable DangKyTaiKhoanThanhVien(string TenDN, string Email, string Password)
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
        return DB.ExecuteQuery("SetTaiKhoanNguoiBan", p);
    }



    protected void btnDangNhap_1_Click(object sender, EventArgs e)
    {
        if (inputEmail.Text.Equals("") ||
                inputPassword.Text.Equals("") ||
                inputPassword_NhapLai.Text.Equals("") ||
                inputTenDN.Text.Equals(""))
        {
            lbNotify_DangNhap.Text = "Vui lòng nhập thông tin đầy đủ!";
        }
        else
        {
            if (!inputTenDN.Text.Equals("") && !inputEmail.Text.Equals("") && !inputPassword.Text.Equals("") && !inputPassword_NhapLai.Text.Equals(""))
        {
            if (inputPassword_NhapLai.Text.Equals(inputPassword.Text))
            {

                try
                {
                    string strKetQua = DangKyTaiKhoanThanhVien(inputTenDN.Text, inputEmail.Text, inputPassword.Text).Rows[0]["IdTaiKhoan"].ToString();
                    int ketQua = int.Parse(strKetQua);
                    if (ketQua > 0)
                    {
                        SendActivationEmail(ketQua);
                        lbNotify_DangNhap.Text = "Mời Bạn Xác Thực Email";
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


    private void SendActivationEmail(int ketQua)
    {
        //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        //string activationCode = Guid.NewGuid().ToString();
        //using (SqlConnection con = new SqlConnection(constr))
        //{
        //    using (SqlCommand cmd = new SqlCommand("INSERT INTO UserActivation VALUES(@UserId, @ActivationCode)"))
        //    {
        //        using (SqlDataAdapter sda = new SqlDataAdapter())
        //        {
        //            cmd.CommandType = CommandType.Text;
        //            cmd.Parameters.AddWithValue("@UserId", userId);
        //            cmd.Parameters.AddWithValue("@ActivationCode", activationCode);
        //            cmd.Connection = con;
        //            con.Open();
        //            cmd.ExecuteNonQuery();
        //            con.Close();
        //        }
        //    }
        //}
        using (MailMessage mm = new MailMessage("dfashionk24@gmail.com", inputEmail.Text))
        {
            mm.Subject = "Account Activation";
            string body = "Hello " + inputTenDN.Text.Trim() + ",";
            body += "<br /><br />Please click the following link to activate your account";
            body += "<br /><a href = '" + Request.Url.AbsoluteUri.Replace("DangKyNguoiBan.aspx", "ActivationEmail.aspx?IdTaiKhoan=" + ketQua) + "'>Click here to activate your account.</a>";
            body += "<br /><br />Thanks";
            mm.Body = body;
            mm.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            NetworkCredential NetworkCred = new NetworkCredential("dfashionk24@gmail.com", "Dong0967842119");
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
        }
    }
}