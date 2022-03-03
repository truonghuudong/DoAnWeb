using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Admin_TrangChuAdmin : System.Web.UI.Page
{

    //trang thai 1:hoạt động, 0 không hoạt động
    //quyền: 1:admin, 2:người mua, 3:người bán

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            form_chinhsuataikhoan.Visible = false;
            DoDiLieuVaoGridViewNguoiMua();
            DoDiLieuVaoGridViewNguoiBan();
            fileUpload.Attributes["onchange"] = "UploadFile(this)";
        }


    }

    //gridview Người mua
    void DoDiLieuVaoGridViewNguoiMua()
    {
        gv_nguoinhan.DataSource = getTaiKhoan("2");
        gv_nguoinhan.DataBind();
        load_checkBox("2",gv_nguoinhan);
    }

    void DoDiLieuVaoGridViewNguoiBan()
    {
        gv_nguoiban.DataSource = getTaiKhoan("3");
        gv_nguoiban.DataBind();
        load_checkBox("3", gv_nguoiban);
    }

    //load trạng thái checkbox
    void load_checkBox(string idQuyen,GridView gv)
    {
        //try
        //{
        var rows = gv.Rows;
        int count = gv.Rows.Count;
        DataTable dataTable = getTaiKhoan(idQuyen);
        for (int i = 0; i < count; i++)
        {
                bool trangThai = false;
            if (dataTable.Rows[i]["TrangThai"].ToString()=="1")
            {
                trangThai = true;
            }
            ((CheckBox)rows[i].FindControl("cb_trangthai")).Checked = trangThai;
        }
        
    }


    //danh sách tài khoản
    DataTable getTaiKhoan(string idQuyen)
        {
            SqlParameter[] p =
                   {
                    new SqlParameter ("@IdQuyen",System.Data.SqlDbType.NVarChar,3)
                };
            p[0].Value = idQuyen;
            return DB.ExecuteQuery("GetDanhSachTaiKhoanTheoQuyen", p);
        }


    //thay đổi trạng thái tài khoản
    void UpdateTrangThaiTaiKhoan(string idTaiKhoan,string trangthai)
    {
        SqlParameter[] p =
                   {
                    new SqlParameter ("@idTaiKhoan",System.Data.SqlDbType.NVarChar,10),
                    new SqlParameter ("@trangthai",System.Data.SqlDbType.NVarChar,3)
                };
        p[0].Value = idTaiKhoan;
        p[1].Value = trangthai;
        DB.ExecuteNonQuery("UpdateTrangThaiTaiKhoan", p);
    }


    //checkbox thay đổi
    protected void cb_trangthai_CheckedChanged(object sender, EventArgs e)
    {

        foreach (GridViewRow row in gv_nguoinhan.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
      
                  {
                CheckBox chkRow = (row.Cells[0].FindControl("cb_trangthai") as CheckBox);
                string idTaiKhoan = (row.Cells[0].FindControl("lb_idTaiKhoan") as Label).Text;
                bool trangthai = chkRow.Checked;
                if (trangthai == true)
                {
                    UpdateTrangThaiTaiKhoan(idTaiKhoan, "1");
                }
                else
                {
                    UpdateTrangThaiTaiKhoan(idTaiKhoan, "0");
                }}
        }
        foreach (GridViewRow row in gv_nguoiban.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)

            {
                CheckBox chkRow = (row.Cells[0].FindControl("cb_trangthai") as CheckBox);
                string idTaiKhoan = (row.Cells[0].FindControl("lb_idTaiKhoan") as Label).Text;
                bool trangthai = chkRow.Checked;
                if (trangthai == true)
                {
                    UpdateTrangThaiTaiKhoan(idTaiKhoan, "1");
                }
                else
                {
                    UpdateTrangThaiTaiKhoan(idTaiKhoan, "0");
                }
            }
        }

    }


    //lấy link hình ảnh
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

    //lưu hình ảnh
    public void SaveHinhAnh()
    {
        string tenFileHinhAnhDuocUpload = DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fileUpload.FileName;
        string thuMucHinhAnh = Server.MapPath("~/HinhAnh/Sprites_AnhDaiDien/");
        string duongDanHinhAnhDuocLuu = thuMucHinhAnh + tenFileHinhAnhDuocUpload;
        fileUpload.SaveAs(duongDanHinhAnhDuocLuu);
    }


    //ibtn_AnhDaiDien click
    protected void ibtn_AnhDaiDien_Click(object sender, ImageClickEventArgs e)
    {
        SaveHinhAnh();
        lb_linkanhtamthoi.Text = UploadHinhAnh();
        ibtn_AnhDaiDien.ImageUrl = "~/HinhAnh/Sprites_AnhDaiDien/"+ UploadHinhAnh();
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

    protected void btn_Sua_Click(object sender, EventArgs e)
    {
        lb_form_title.Text = "Sửa Thông Tin";
        btn_xacnhan_form.Text = "Xác Nhận";
        btn_thoat_form.Text = "Thoát";


        btn_xacnhan_form.Visible = true;
        form_chinhsuataikhoan.Visible = true;

        fileUpload_button.Visible = true;
        txt_TenTaiKhoan_form.Visible = true;
        txt_DiaChi_form.Visible = true;
        txt_SDT_form.Visible = true;
        txt_Email_form.Visible = true;
        lb__form_thongbao.Visible = false;

        string idTaiKhoan = (sender as Button).CommandArgument;
        DataTable table = GetThongTinTaiKhoan(idTaiKhoan);
        ibtn_AnhDaiDien.ImageUrl = "/HinhAnh/Sprites_AnhDaiDien/" + table.Rows[0]["Anh"].ToString();
        txt_TenTaiKhoan_form.Text = table.Rows[0]["TenTaiKhoan"].ToString();
        txt_DiaChi_form.Text = table.Rows[0]["DiaChi"].ToString();
        txt_SDT_form.Text = table.Rows[0]["SDT"].ToString();
        txt_Email_form.Text = table.Rows[0]["Email"].ToString();
        lb_idTaiKhoan_form.Text = idTaiKhoan;
    }

    protected void btn_Xoa_Click(object sender, EventArgs e)
    {
        btn_xacnhan_form.Visible = true;
        lb_form_title.Text = "Bạn có thực sự muốn xóa tài khoản này không";
        form_chinhsuataikhoan.Visible = true;
        btn_xacnhan_form.Text = "Có";
        btn_thoat_form.Text = "Không";

        lb_idTaiKhoan_form.Text = (sender as Button).CommandArgument;
        fileUpload_button.Visible = false;
        txt_TenTaiKhoan_form.Visible = false;
        txt_DiaChi_form.Visible = false;
        txt_SDT_form.Visible = false;
        txt_Email_form.Visible = false;
        lb__form_thongbao.Visible = false;
    }


    int UpdateHoSoTaiKhoan(string idTaiKhoan,string tenNguoiDung, string email, string diachi,string sdt, string hinhAnh)
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
        p[0].Value = idTaiKhoan;
        p[1].Value = tenNguoiDung;
        p[2].Value = email;
        p[3].Value = sdt;
        p[4].Value = hinhAnh;
        p[5].Value = diachi;
        return DB.ExecuteNonQuery("UpdateThongTinTaiKhoan", p);
    }

    int XoaTaiKhoan(string idTaiKhoan)
    {
        SqlParameter[] p =
        {
           new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10),
        };
        p[0].Value = idTaiKhoan;
        return DB.ExecuteNonQuery("DeleteTaiKhoan", p);
    }

    //click button thoát trong form
    protected void btn_thoat_form_Click(object sender, EventArgs e)
    {
        form_chinhsuataikhoan.Visible = false;
    }

    protected void btn_xacnhan_form_Click(object sender, EventArgs e)
    {
        if (lb_form_title.Text == "Sửa Thông Tin")
        {
            string idTaikhoan = lb_idTaiKhoan_form.Text;
            string tenTaiKhoan = txt_TenTaiKhoan_form.Text;
            string diaChi = txt_DiaChi_form.Text;
            string sdt = txt_SDT_form.Text;
            string email = txt_Email_form.Text;
            string linkAnh = lb_linkanhtamthoi.Text;
            if (!idTaikhoan.Equals("") && !tenTaiKhoan.Equals("") &&
                !diaChi.Equals("") && !sdt.Equals("") && !email.Equals(""))
            {
                int ketqua = UpdateHoSoTaiKhoan(idTaikhoan, tenTaiKhoan, email, diaChi, sdt, linkAnh);
                KiemTraKetQua(ketqua,"Sửa");
            }

        }
        else
        {
            int ketqua = XoaTaiKhoan(lb_idTaiKhoan_form.Text);
            KiemTraKetQua(ketqua,"Xóa");
        }

        btn_xacnhan_form.Visible = false;
        btn_thoat_form.Text = "Thoát";
    }

    void KiemTraKetQua(int ketqua,string ThongBao)
    {
        if (ketqua > 0)
        {
            lb__form_thongbao.Visible = true;
            lb__form_thongbao.Text = ThongBao+" thành công";
            DoDiLieuVaoGridViewNguoiMua();
            DoDiLieuVaoGridViewNguoiBan();
        }
        else
        {
            lb__form_thongbao.Visible = true;
            lb__form_thongbao.Text = ThongBao+" thất bại";
        }
    }

}