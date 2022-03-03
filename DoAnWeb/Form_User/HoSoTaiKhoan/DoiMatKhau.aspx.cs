using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_User_HoSoTaiKhoan_DoiMatKhau : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    int UpdateMatKhau(string idtaikhoan, string matkhau)
    {
        SqlParameter[] p = {
            new SqlParameter("@idTaiKhoan",System.Data.SqlDbType.NVarChar,10),
            new SqlParameter("@MatKhau",System.Data.SqlDbType.NVarChar,35),
        };
        p[0].Value = idtaikhoan;
        p[1].Value = matkhau;
        return DB.ExecuteNonQuery("UpdateMatKhauTaiKhoan", p);
    }

    string GetMatKhauTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.PassWord;
    }

    string GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id + "";
    }

    void Setdieukien()
    {
        lb_thongbao_capnhat.Visible = true;
        if (!txt_matkhaucu.Text.Equals("") && !txt_matkhaumoi.Text.Equals("") && !txt_xacminhMK.Text.Equals(""))
        {
            if (txt_matkhaumoi.Text == txt_xacminhMK.Text)
            {
                if (txt_matkhaucu.Text == GetMatKhauTaiKhoanTuSession())
                {
                    string idtaikhoan = GetIdTaiKhoanTuSession();
                    if (UpdateMatKhau(idtaikhoan, txt_matkhaumoi.Text) > 0)
                    {
                        lb_thongbao_capnhat.Text = "Đổi Mật Khẩu Thành Công";
                    }
                    else
                    {
                        lb_thongbao_capnhat.Text = "Lỗi, Không Thể Thay Đổi Mật Khẩu";
                    }
                }
                else
                {
                    lb_thongbao_capnhat.Text = "Mật Khẩu Cũ Không Chính Xác";
                }

            }
            else
            {
                lb_thongbao_capnhat.Text = "Không Trùng Mật Khẩu Xác Minh";
            }
        }
    }
    protected void xacnhan_Click(object sender, EventArgs e)
    {
        Setdieukien();
    }
}