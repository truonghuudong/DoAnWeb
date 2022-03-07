using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DangNhap : System.Web.UI.Page
{
    //Quyền truy cập 1.Admin, 3.Người bán, 2.Người mua
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            try
            {
                ViewState["RefUrl"] = Request.UrlReferrer.ToString();
                lbcaptcha.Style["background-image"] = "../HinhAnh/background-capcha.jpg";
                //lbcaptcha.Text += " " + "<img src='../HinhAnh/background-capcha.jpg'>";
                LoadCaptCha();
            }
            catch
            {

            }
        }
    }

    void LoadCaptCha()
    {
        lbcaptcha.Text = RandomString(4,true);
    }

    private string RandomString(int size, bool lowerCase)
    {
        StringBuilder sb = new StringBuilder();
        char c;
        Random rand = new Random();
        for (int i = 0; i < size; i++)
        {
            c = Convert.ToChar(Convert.ToInt32(rand.Next(65, 87)));
            sb.Append(c);
        }
        if (lowerCase)
            return sb.ToString().ToLower();
        return sb.ToString();
    }

    //hàm kiểm tra đăng nhập
    public int dangNhap(string tenDn,string matkhau)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@tenDN",System.Data.SqlDbType.NVarChar,255),
            new SqlParameter("@matKhau",System.Data.SqlDbType.NVarChar,255)
        };
        p[0].Value = tenDn;
        p[1].Value = matkhau;
        return DB.ExecuteIntCommand("DangNhap", p);
    }



    //khi nguoi dung click vao nut back
    protected void click_GoBack(object ob, EventArgs e)
    {
        object refUrl = ViewState["RefUrl"];
        if (refUrl != null)
        {
            Response.Redirect((string)refUrl);
        }
    }



    //khi nguoi dung click vao nut dang nhap
    protected void click_DangNhap(object ob, EventArgs e)
    {
        //if () { } ;

        if (!inputTenDN.Text.Equals("") && !inputPassword.Text.Equals("")&& !txtcaptcha.Text.Equals(""))
        {
            if (txtcaptcha.Text == lbcaptcha.Text)
            {
                int kqDangNhap = dangNhap(inputTenDN.Text, inputPassword.Text);
                if (kqDangNhap != -1)
                {


                    //add session
                    var userSession = new UserLogin();
                    userSession.Id = kqDangNhap;
                    userSession.UserName = inputTenDN.Text;
                    userSession.PassWord = inputPassword.Text;
                    userSession.Quyen = quyenTaiKhoan(kqDangNhap)+"";
                    Session.Add("User", userSession);

                    //add cookies
                    if (ckRememberUser.Checked == true)
                    {
                        HttpCookie userInfo = new HttpCookie("userInfo");
                        userInfo["userName"] = inputTenDN.Text;
                        userInfo["userPassword"] = inputPassword.Text;
                        //userInfo.Expires.Add(new TimeSpan(0, 1, 0));
                        Response.Cookies.Add(userInfo);
                    }

                    if (quyenTaiKhoan(kqDangNhap) == 1)
                    {
                        Response.Redirect("~/Form_Admin/QuanLyTaiKhoan.aspx");
                    }
                    else
                    {
                        if (quyenTaiKhoan(kqDangNhap) == 2)
                        {
                            object refUrl = ViewState["RefUrl"];
                            string link = (string)refUrl;
                            if (link != null && !link.Contains("/Form_User/DangKy.aspx") 
                                && !link.Contains("/Form_Admin/") && 
                                !link.Contains("/Form_NguoiBan/") && 
                                !link.Contains("Form_User/DangNhap.aspx"))
                            {
                                Response.Redirect((string)link);
                                //lbNotify_DangNhap.Text = (string)refUrl;
                            }
                            else
                            {
                                Response.Redirect("TrangChu.aspx");
                            }
                        }
                        else
                        {
                            Response.Redirect("~/Form_NguoiBan/BaoCaoThongKe/ThongKeSanPhamBanChay.aspx");
                        }
                    }
                }
                else
                {
                    lbNotify_DangNhap.Text = "Tên tài khoản hoặc mật khẩu không chính xác";
                }
            }
            else
            {
                lbNotify_DangNhap.Text = "Lỗi captcha ";
            }

        }
        else
        {
            lbNotify_DangNhap.Text = "Vui lòng nhập đầy đủ thông tin";
        }
    }

    public int quyenTaiKhoan(int Id)
    {
        int quyen;
        SqlParameter[] p =
        {
            new SqlParameter("@Id",System.Data.SqlDbType.Int),
        };
        p[0].Value = Id;
        DataTable table = DB.ExecuteQuery("AnhDaiDien", p);

        quyen = int.Parse(table.Rows[0][5].ToString());
        return quyen;
    }


    //protected void inputPassword_TextChanged(object sender, EventArgs e)
    //{
    //    click_DangNhap(btnDangNhap_1,e);
    //}

    protected void txtcaptcha_TextChanged(object sender, EventArgs e)
    {
        click_DangNhap(btnDangNhap_1, e);
    }

}