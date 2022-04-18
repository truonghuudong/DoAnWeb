using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage_MasterPage_Admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Session["User"] != null)
                {
                    UserLogin user = new UserLogin();
                    user = (UserLogin)Session["User"];
                    lbTenTaiKhoan.Text = user.UserName;

                    KiemTraQuyen(int.Parse(user.Quyen));
                    

                    string linkAnh = LinkAnhDaiDien(dangNhap(user.UserName, user.PassWord));
                    if (!linkAnh.Equals(""))
                    {
                        imgAnhDaiDien.ImageUrl = "../HinhAnh/Sprites_AnhDaiDien/" + linkAnh;
                    }
                    else
                    {
                        imgAnhDaiDien.ImageUrl = "../HinhAnh/Sprites_AnhDaiDien/AnhDaiDien.jpg";
                    }
                }
                else
                {
                    HttpCookie reqCookie = Request.Cookies["userInfo"];
                    if (reqCookie != null)
                    {
                        string userName = string.Empty;
                        string userPassword = string.Empty;
                        userName = reqCookie["userName"].ToString();
                        userPassword = reqCookie["userPassword"].ToString();
                        int kqDangNhap = dangNhap(userName, userPassword);
                        if (kqDangNhap != -1)
                        {
                            //tao mot session
                            var userSession = new UserLogin();
                            userSession.Id = kqDangNhap;
                            string linkAnh = LinkAnhDaiDien(kqDangNhap);
                            userSession.UserName = userName;
                            userSession.PassWord = userPassword;

                            Session.Add("User", userSession);
                            KiemTraQuyen(quyenTaiKhoan(kqDangNhap));

                            lbTenTaiKhoan.Text = userName;
                            if (!linkAnh.Equals(""))
                                imgAnhDaiDien.ImageUrl = "HinhAnh/Sprites_AnhDaiDien/AnhDaiDien.jpg";
                            else
                            {
                                imgAnhDaiDien.ImageUrl = "HinhAnh/Sprites_AnhDaiDien/" + linkAnh;
                            }
                        }
                    }
                    else
                    {
                        Response.Redirect("../Form_User/TrangChu.aspx");
                    }
                }
            }
            catch
            {

            }

            //kiem tra hien thi danh muc hien tai
            try
            {
                addClassDanhMuc();
            }
            catch
            {

            }

        }

    }

    void KiemTraQuyen(int quyen)
    {
        if(quyen!=1)
        {
            if (Request.Cookies["userInfo"] != null)
            {
                HttpCookie myCookie = new HttpCookie("userInfo");
                myCookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(myCookie);
            }
            Session.Remove("User");
            Response.Redirect("../Form_User/TrangChu.aspx");
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


    //Dang nhap
    int dangNhap(string tenDn, string matkhau)
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

    //lay link anh dai dien
    string LinkAnhDaiDien(int Id)
    {
        string link = null;
        SqlParameter[] p =
        {
            new SqlParameter("@Id",System.Data.SqlDbType.Int),
        };
        p[0].Value = Id;
        DataTable table = DB.ExecuteQuery("AnhDaiDien", p);

        link = table.Rows[0][3].ToString();
        return link;
    }


    void addClassDanhMuc()
    {
        string link = HttpContext.Current.Request.RawUrl.ToString();
        if (link.Contains("/Form_Admin/HoSoTaiKhoan.aspx"))
        {
            danhmuc_hosotaikhoan.Attributes.Add("class", "danhmuc-item--active danhmuc-items");
        }
        else
        {
            if (link.Contains("/Form_Admin/QuanLyDanhMuc.aspx") || link.Contains("/Form_Admin/QuanLyChiTietDanhMuc.aspx"))
            {
                danhmuc_quanlydanhmuc.Attributes.Add("class", "danhmuc-item--active danhmuc-items");
            }
            else
            {
                if (link.Contains("/Form_Admin/QuanLyTaiKhoan.aspx"))
                {
                    danhmuc_quanlytaikhoan.Attributes.Add("class", "danhmuc-item--active danhmuc-items");
                }
                else
                {
                    if (link.Contains("/Form_Admin/BaoCaoThongKe.aspx"))
                    {
                        danhmuc_baocaothongke.Attributes.Add("class", "danhmuc-item--active danhmuc-items");
                    }
                    else
                    {
                        if (link.Contains("/Form_Admin/QuanLyThue.aspx"))
                        {
                            danhmuc_quanlythue.Attributes.Add("class", "danhmuc-item--active danhmuc-items");
                        }
                    }
                }
            }
        }
    }

    protected void btnDangXuat_Click(object sender, EventArgs e)
    {
        if (Request.Cookies["userInfo"] != null)
        {
            HttpCookie myCookie = new HttpCookie("userInfo");
            myCookie.Expires = DateTime.Now.AddDays(-1d);
            Response.Cookies.Add(myCookie);
        }
        if (Session["User"] != null)
        {
            Session.Remove("User");
        }
        Response.Redirect("../Form_User/DangNhap.aspx");
    }
}
