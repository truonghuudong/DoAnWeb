using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //kiem tra session
            if (Session["User"] != null)
            {
                TaiKhoan.Visible = true;
                DangNhap.Visible = false;
                DangKy.Visible = false;
                UserLogin user = new UserLogin();
                user = (UserLogin)Session["User"];
                lbTenTaiKhoan.Text = user.UserName;

                string linkAnh = LinkAnhDaiDien(dangNhap(user.UserName, user.PassWord));
                if (!linkAnh.Equals(""))
                {
                    ImgDanhDaiDien.ImageUrl = "../HinhAnh/Sprites_AnhDaiDien/" + linkAnh;
                }
                else
                {
                    ImgDanhDaiDien.ImageUrl = "../HinhAnh/Sprites_AnhDaiDien/AnhDaiDien.jpg";
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
                        TaiKhoan.Visible = true;
                        DangNhap.Visible = false;
                        DangKy.Visible = false;


                        //tao mot session
                        var userSession = new UserLogin();
                        userSession.Id = kqDangNhap;
                        string linkAnh = LinkAnhDaiDien(kqDangNhap);
                        userSession.UserName = userName;
                        userSession.PassWord = userPassword;

                        Session.Add("User", userSession);

                        lbTenTaiKhoan.Text = userName;
                        if (!linkAnh.Equals(""))
                            ImgDanhDaiDien.ImageUrl = "HinhAnh/Sprites_AnhDaiDien/AnhDaiDien.jpg";
                        else
                        {
                            ImgDanhDaiDien.ImageUrl = "HinhAnh/Sprites_AnhDaiDien/" + linkAnh;
                        }
                    }
                }
                else
                {
                    TaiKhoan.Visible = false;
                    DangNhap.Visible = true;
                    DangKy.Visible = true;
                }
            }


            //lay cookies
            
        }
        //btnSearch.Attributes.Add("onclick", "click_search");
        Cart();
    }

    



    //Dang nhap
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

    //lay link anh dai dien
    public string LinkAnhDaiDien(int Id)
    {
        try
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
        }catch
        { }
        return "AnhDaiDien.jpg";
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
        Session.Remove("GioHang");
        Response.Redirect("~/Form_User/DangNhap.aspx");
    }

    void Cart()
    {
        List<ListSanPhamTheoIdTaiKhoan> danhSachSanPham =
                    (List<ListSanPhamTheoIdTaiKhoan>)Session["GioHang"];
        if (danhSachSanPham != null)
        {
            int tong= 0;
            foreach(ListSanPhamTheoIdTaiKhoan list in danhSachSanPham)
            {
                tong += list.spTrongGioHang.Count;

            }
            if (tong > 0)
            {
                lable_cart_badge.Text = tong.ToString();
            }
            else
            {
                lable_cart_badge.Visible = false;
            }
        }
        else
        {
            lable_cart_badge.Visible = false;
        }
    }

    protected void btn_Search_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Form_User/TatCaSanPham.aspx?TimKiem=" + txt_SearchBox.Text);
    }

    protected void txt_SearchBox_TextChanged(object sender, EventArgs e)
    {
        //Response.Redirect("~/Form_User/TatCaSanPham.aspx?TimKiem=" + txt_SearchBox.Text);
    }
}
