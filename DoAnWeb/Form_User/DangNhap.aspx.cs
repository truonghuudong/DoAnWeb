using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPSnippets.FaceBookAPI;
public partial class DangNhap : System.Web.UI.Page
{
    //Quyền truy cập 1.Admin, 3.Người bán, 2.Người mua
    protected void Page_Load(object sender, EventArgs e)
    {
        FaceBookConnect.API_Key = "2769769016651645";//API facebook
        FaceBookConnect.API_Secret = "fca119ad29cd54696cac17e91ea80744"; // secret facebook

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


            if (Request.QueryString["error"] == "access_denied")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User has denied access.')", true);
                return;
            }

            string code = Request.QueryString["code"];
            if (!string.IsNullOrEmpty(code))
            {
                string data = FaceBookConnect.Fetch(code, "me?fields=id,name,email");
                FaceBookUser faceBookUser = new JavaScriptSerializer().Deserialize<FaceBookUser>(data);
                faceBookUser.PictureUrl = string.Format("https://graph.facebook.com/{0}/picture", faceBookUser.Id);

                if (kiemTraIdFaceBook(faceBookUser.Id) == 1)
                {
                    //Đăng nhập
                    DataTable TaiKhoan = DangNhapBangIdFaceBook(faceBookUser.Id);
                    var userSession = new UserLogin();
                    userSession.Id = int.Parse(TaiKhoan.Rows[0]["IdTaiKhoan"].ToString());
                    userSession.UserName = TaiKhoan.Rows[0]["TenTaiKhoan"].ToString();
                    userSession.PassWord = TaiKhoan.Rows[0]["MatKhau"].ToString();
                    userSession.Quyen = TaiKhoan.Rows[0]["IdQuyen"].ToString() + "";
                    Session.Add("User", userSession);

                }
                else
                {
                    //Tạo Tài Khoản Rồi Mới Đăng Nhập
                    string tenDN = RandomString(10, true);
                    taoTaiKhoanThanhVienVoiIdFaceBook(tenDN.ToString(), faceBookUser.Email.ToString(),
                        faceBookUser.Id.ToString());


                    DataTable TaiKhoan = DangNhapBangIdFaceBook(faceBookUser.Id);
                    var userSession = new UserLogin();
                    userSession.Id = int.Parse(TaiKhoan.Rows[0]["IdTaiKhoan"].ToString());
                    userSession.UserName = TaiKhoan.Rows[0]["TenTaiKhoan"].ToString();
                    userSession.PassWord = TaiKhoan.Rows[0]["MatKhau"].ToString();
                    userSession.Quyen = TaiKhoan.Rows[0]["IdQuyen"].ToString() + "";
                    Session.Add("User", userSession);

                }







                try
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
                        Response.Redirect("~/Form_User/TrangChu.aspx");
                    }
                }
                catch
                {
                    Response.Redirect("~/Form_User/TrangChu.aspx");
                }

                //pnlFaceBookUser.Visible = true;
                //lblId.Text = faceBookUser.Id;
                //lblUserName.Text = faceBookUser.PictureUrl.ToString();
                //lblName.Text = faceBookUser.Name;
                //lblEmail.Text = faceBookUser.Email;
                //ProfileImage.ImageUrl = faceBookUser.PictureUrl;
                //btnLogin.Enabled = false;
            }

        }
    }
    DataTable DangNhapBangIdFaceBook(string IdFaceBook)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdFaceBook",SqlDbType.NVarChar,20)
        };
        p[0].Value = IdFaceBook;
        return DB.ExecuteQuery("dangNhapBangIdFaceBook", p);
    }

    void taoTaiKhoanThanhVienVoiIdFaceBook(string tenDN, string email, string idFaceBook)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdFaceBook",SqlDbType.NVarChar,30),
            new SqlParameter("@Email",SqlDbType.NVarChar,200),
            new SqlParameter("@TenDN",SqlDbType.NVarChar,200)
        };
        p[0].Value = idFaceBook;
        p[1].Value = email;
        p[2].Value = tenDN;
        DB.ExecuteNonQuery("setTaiKhoanThanhVienBangFaceBook", p);
    }

    int kiemTraIdFaceBook(string IdFaceBook)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdFaceBook",SqlDbType.NVarChar,20)
        };
        p[0].Value = IdFaceBook;
        return DB.ExecuteIntCommand("kiemTraIdFaceBook", p);
    }



    void LoadCaptCha()
    {
        lbcaptcha.Text = RandomString(4, true);
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
    public int dangNhap(string tenDn, string matkhau)
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

        if (!inputTenDN.Text.Equals("") && !inputPassword.Text.Equals("") && !txtcaptcha.Text.Equals(""))
        {
            if (txtcaptcha.Text == lbcaptcha.Text)
            {
                int kqDangNhap = dangNhap(inputTenDN.Text, inputPassword.Text);
                if (kqDangNhap != -1)
                {
                    if (kqDangNhap == -2)
                    {
                        lbNotify_DangNhap.Text = "Tài Khoản Chưa Được Kích Hoạt";
                    }
                    else
                    {
                        //add session
                        var userSession = new UserLogin();
                        userSession.Id = kqDangNhap;
                        userSession.UserName = inputTenDN.Text;
                        userSession.PassWord = inputPassword.Text;
                        userSession.Quyen = quyenTaiKhoan(kqDangNhap) + "";
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

                        if (quyenTaiKhoan(kqDangNhap) == -1)
                        {
                            lbNotify_DangNhap.Text = "Đăng Nhập Không Thành Công";
                        }
                        else
                        {
                            if (quyenTaiKhoan(kqDangNhap) == 1)
                            {
                                Response.Redirect("~/Form_Admin/HoSoTaiKhoan.aspx");
                            }
                            else
                            {
                                if (quyenTaiKhoan(kqDangNhap) == 2)
                                {
                                    try
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
                                            Response.Redirect("~/Form_User/TrangChu.aspx");
                                        }
                                    }
                                    catch
                                    {

                                    }
                                }
                                else
                                {
                                    Response.Redirect("~/Form_NguoiBan/QuanLyTaiKhoan/QuangLyTaiKhoan.aspx");
                                }
                            }
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
        try
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
        catch
        {

        }
        return -1;
    }


    //protected void inputPassword_TextChanged(object sender, EventArgs e)
    //{
    //    click_DangNhap(btnDangNhap_1,e);
    //}

    protected void txtcaptcha_TextChanged(object sender, EventArgs e)
    {
        click_DangNhap(btnDangNhap_1, e);
    }

    protected void lbtn_facebook_Click(object sender, EventArgs e)
    {
        FaceBookConnect.Authorize("user_photos,email", Request.Url.AbsoluteUri.Split('?')[0]);
    }
}