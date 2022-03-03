using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_QuanLyTaiKhoan_QuangLyTaiKhoan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            fileUpload.Attributes["onchange"] = "UploadFile(this)";

            string idtaikhoan = GetIdTaiKhoanTuSession() + "";
            DataTable tb = GetThongTinTaiKhoan(idtaikhoan);
            lb_hoso_tendangnhap.Text = tb.Rows[0]["TenTaiKhoan"].ToString();
            lb_hoso_email.Text = tb.Rows[0]["Email"].ToString();
            lb_hoso_sodienthoai.Text = tb.Rows[0]["SDT"].ToString();
            txt_tennguoidung.Text = tb.Rows[0]["TenNguoiDung"].ToString();
            img_hoso_hinhanh.ImageUrl = "~/HinhAnh/Sprites_AnhDaiDien/" + tb.Rows[0]["Anh"].ToString();
            txt_DiaChi.Text = tb.Rows[0]["DiaChi"].ToString();
        }
    }


    public string UploadHinhAnh()
    {
        if (fileUpload.HasFile)
        {
            string tenFileHinhAnhDuocUpload = DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fileUpload.FileName;//DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") +
            return tenFileHinhAnhDuocUpload;
        }
        else
        {
            return "";
        }
    }
    public void SaveHinhAnh()
    {
        string tenFileHinhAnhDuocUpload = DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fileUpload.FileName;
        string thuMucHinhAnh = Server.MapPath("~/HinhAnh/Sprites_AnhDaiDien/");
        string duongDanHinhAnhDuocLuu = thuMucHinhAnh + tenFileHinhAnhDuocUpload;
        fileUpload.SaveAs(duongDanHinhAnhDuocLuu);
    }
    //lay anh



    int GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id;
    }



    DataTable GetThongTinTaiKhoan(string idTaiKhoan)
    {
        SqlParameter[] p =
        {
           new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = idTaiKhoan;
        return DB.ExecuteQuery("GetThongTinTaiKhoan", p);
    }



    protected void btnUpload_Click(object sender, EventArgs e)
    {
        SaveHinhAnh();
        img_hoso_hinhanh.ImageUrl = "~/HinhAnh/Sprites_AnhDaiDien/" + UploadHinhAnh();
        lb_thongbao_hoso_anhdanhmuc.Text = UploadHinhAnh();
    }


    int UpdateHoSoTaiKhoan(string tenNguoiDung, string email, string sdt, string hinhAnh,string diaChi)
    {
        SqlParameter[] p =
        {
           new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10),
           new SqlParameter("@TenNguoiDung",SqlDbType.NVarChar,200),
           new SqlParameter("@Email",SqlDbType.NVarChar,200),
           new SqlParameter("@SDT",SqlDbType.NVarChar,200),
           new SqlParameter("@HinAnh",SqlDbType.NVarChar,200),
           new SqlParameter("@DiaChi",SqlDbType.NVarChar,200),
        };
        p[0].Value = GetIdTaiKhoanTuSession();
        p[1].Value = tenNguoiDung;
        p[2].Value = email;
        p[3].Value = sdt;
        p[4].Value = hinhAnh;
        p[5].Value = diaChi;
        return DB.ExecuteNonQuery("UpdateThongTinTaiKhoan", p);
    }

    void CapNhatThongTinTaiKhoan()
    {
        int ketqua = UpdateHoSoTaiKhoan(txt_tennguoidung.Text, lb_hoso_email.Text, lb_hoso_sodienthoai.Text, lb_thongbao_hoso_anhdanhmuc.Text,txt_DiaChi.Text);
        if (ketqua > 0)
        {
            lb_thongbao_capnhat.Text = "Cập nhật thành công";
            lb_thongbao_capnhat.Visible = true;
        }
        else
        {
            lb_thongbao_capnhat.Text = "Cập nhật thất bại";
            lb_thongbao_capnhat.Visible = true;
        }


    }



    protected void btn_luu_hoso_Click(object sender, EventArgs e)
    {
        CapNhatThongTinTaiKhoan();
        Response.Redirect("~/Form_NguoiBan/QuanLyTaiKhoan/QuangLyTaiKhoan.aspx");
    }
    protected void btn_doiMatKhau_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Form_NguoiBan/QuanLyTaiKhoan/DoiMatKhau.aspx");
    }
}