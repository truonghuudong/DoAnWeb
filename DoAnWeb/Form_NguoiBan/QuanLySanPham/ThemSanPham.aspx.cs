using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_QuanLySanPham_ThemSanPham : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            fileUpload.Attributes["onchange"] = "UploadFile(this)";
            fileUpload_Them.Attributes["onchange"] = "UploadFileThem(this)";
            try
            {
                string idsp = Request.QueryString.Get("IdSP");
                lb_IdSP.Text = idsp;
                if (!idsp.Equals(""))
                {
                    form_suasanpham.Visible = true;
                    DataTable sp = ThongTinSP(int.Parse(idsp));

                    ddl_danhMuc_Sua.DataSource = GetDanhMuc();
                    ddl_danhMuc_Sua.DataTextField = "TenDanhMuc";
                    ddl_danhMuc_Sua.DataValueField = "IdDanhMuc";
                    ddl_danhMuc_Sua.DataBind();
                    ddl_danhMuc_Sua.SelectedValue = sp.Rows[0]["IdDanhMuc"].ToString();

                    ddl_LoaiSP_Sua.DataSource = GetLoaiSP(int.Parse(ddl_danhMuc_Sua.SelectedValue));
                    ddl_LoaiSP_Sua.DataTextField = "TenLoaiSP";
                    ddl_LoaiSP_Sua.DataValueField = "IdLoaiSP";
                    ddl_LoaiSP_Sua.DataBind();

                    // trang sua sp
                    lb_IdSP.Text = sp.Rows[0]["IdSP"].ToString();
                    ddl_LoaiSP_Sua.SelectedValue = sp.Rows[0]["IdLoaiSP"].ToString();
                    txt_TenSP.Text = sp.Rows[0]["TenSP"].ToString();
                    txt_SoLuongSP.Text = sp.Rows[0]["SoLuong"].ToString();
                    txt_GiaSP.Text = sp.Rows[0]["GiaSP"].ToString();
                    txt_MoTaSP.Text = sp.Rows[0]["MoTa"].ToString();
                    imgHinhAnh.ImageUrl = "~/HinhAnh/Sprites_SP/" + sp.Rows[0]["AnhSP"].ToString();

                }
                else
                {


                
                }
            }
            catch
            {
                //trang them sp
                form_themsp.Visible = true;
                ddl_DanhMuc.DataSource = GetDanhMuc();
                ddl_DanhMuc.DataTextField = "TenDanhMuc";
                ddl_DanhMuc.DataValueField = "IdDanhMuc";
                ddl_DanhMuc.DataBind();

                ddl_LoaiSP.DataSource = GetLoaiSP(int.Parse(ddl_DanhMuc.SelectedValue));
                ddl_LoaiSP.DataTextField = "TenLoaiSP";
                ddl_LoaiSP.DataValueField = "IdLoaiSP";
                ddl_LoaiSP.DataBind();

            }

            
        }

    }

    DataTable GetDanhMuc()
    {
        SqlParameter[] p = { };
        return DB.ExecuteQuery("GetDanhMuc", p);
    }

    private DataTable GetLoaiSP(int idDanhMuc)
    {
        SqlParameter[] p =
        {
            new SqlParameter ("@IdDanhMuc",SqlDbType.Int),
            new SqlParameter ("@TrangThai",SqlDbType.NVarChar,10)
        };
        p[0].Value = idDanhMuc;
        p[1].Value = "1";
        return DB.ExecuteQuery("GetLoaiSPTheoDanhMucTrangThai", p);
    }

    DataTable ThongTinSP(int idsp)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdSP",SqlDbType.NVarChar,10)
        };
        p[0].Value = idsp;
        return DB.ExecuteQuery("GetSanPhamTheoId", p);
    }
    int InsertSanPham(string idtaikhoan, string idloaisp, string tensp, string anhsp, string giasp, string soluong, string mota)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idtaiKhoan",SqlDbType.NVarChar,10),
            new SqlParameter("@idLoaiSP", SqlDbType.NVarChar,10),
            new SqlParameter("@tensp", SqlDbType.NVarChar,200),
            new SqlParameter("@anhsp", SqlDbType.NVarChar,200),
            new SqlParameter("@giasp", SqlDbType.Int),
            new SqlParameter("@soluong", SqlDbType.Int),
            new SqlParameter("@mota", SqlDbType.NVarChar,1000)
        };
        p[0].Value = idtaikhoan;
        p[1].Value = idloaisp;
        p[2].Value = tensp;
        p[3].Value = anhsp;
        p[4].Value = int.Parse(giasp);
        p[5].Value = int.Parse(soluong);
        p[6].Value = mota;
        return DB.ExecuteNonQuery("SetSanPham", p);
    }
    

    int UpdateSanPham(string idsp, string idloaisp, string tensp, string anhsp, string giasp, string soluong, string mota)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdSP",SqlDbType.Int),
            new SqlParameter("@idLoaiSP", SqlDbType.NVarChar,10),
            new SqlParameter("@tensp", SqlDbType.NVarChar,200),
            new SqlParameter("@anhsp", SqlDbType.NVarChar,200),
            new SqlParameter("@giasp", SqlDbType.Int),
            new SqlParameter("@soluong", SqlDbType.Int),
            new SqlParameter("@mota", SqlDbType.NVarChar,1000),
        };
        p[0].Value = idsp;
        p[1].Value = idloaisp;
        p[2].Value = tensp;
        p[3].Value = anhsp;
        p[4].Value = giasp;
        p[5].Value = soluong;
        p[6].Value = mota;
        return DB.ExecuteNonQuery("UpdateThongTinSPTheoId", p);
    }

    protected void btn_SuaSP(object sender, EventArgs e)
    {
        if (!lb_IdSP.Text.Equals("") &&
                !txt_TenSP.Text.Equals("") && !txt_GiaSP.Text.Equals("")
                && !txt_SoLuongSP.Text.Equals("") && !txt_MoTaSP.Text.Equals(""))
        {
            try
            {
                int ketqua = UpdateSanPham(lb_IdSP.Text, ddl_LoaiSP_Sua.SelectedValue, txt_TenSP.Text,
                            lb_thongbao_danhmuc_anhdanhmuc.Text, txt_GiaSP.Text,
                            txt_SoLuongSP.Text, txt_MoTaSP.Text);
                if (ketqua > 0)
                {
                    lb_thongBao_Sua.Text = "Sửa thành công";
                }
                else
                {
                    lb_thongBao_Sua.Text = "Sửa không thành công";
                }
            }
            catch
            {
                lb_thongBao_Sua.Text = "Lỗi không xác định";
            }
        }
        else
        {
            lb_thongBao_Sua.Text = "Vui lòng nhập đầy đủ thông tin";
        }

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        SaveHinhAnh(fileUpload);
        imgHinhAnh.ImageUrl = "~/HinhAnh/Sprites_SP/" + UploadHinhAnh(fileUpload);
        lb_thongbao_danhmuc_anhdanhmuc.Text = UploadHinhAnh(fileUpload);
    }

    public string UploadHinhAnh(FileUpload fileUpload)
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
    public void SaveHinhAnh(FileUpload fileUpload)
    {
        string tenFileHinhAnhDuocUpload = DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fileUpload.FileName;
        string thuMucHinhAnh = Server.MapPath("~/HinhAnh/Sprites_SP/");
        string duongDanHinhAnhDuocLuu = thuMucHinhAnh + tenFileHinhAnhDuocUpload;
        fileUpload.SaveAs(duongDanHinhAnhDuocLuu);
    }

    int GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id;
    }

    protected void btnThemSP(object sender, EventArgs e)
    {
        if (
                !txt_TenSP_Them.Text.Equals("") && !txt_GiaSP_Them.Text.Equals("")
                && !txt_SoLUongSP_Them.Text.Equals("") && !txt_MoTa_Them.Equals(""))
        {
            try
            {
                int ketqua = InsertSanPham(GetIdTaiKhoanTuSession().ToString(), ddl_LoaiSP.SelectedValue,
                    txt_TenSP_Them.Text, lb_HinhAnh_Them.Text, txt_GiaSP_Them.Text, txt_SoLUongSP_Them.Text, txt_MoTa_Them.Text);
                if (ketqua > 0)
                {
                    lb_thongBao_Them.Text = "Thêm thành công";
                }
                else
                {
                    lb_thongBao_Them.Text = "Thêm không thành công";
                }
            }
            catch
            {
                lb_thongBao_Them.Text = "Lỗi không xác định";

            }
        }
        else
        {
            lb_thongBao_Them.Text = "Vui lòng nhập đầy đủ thông tin";
        }
    }

    protected void btn_Anh_Them_Click(object sender, EventArgs e)
    {
        SaveHinhAnh(fileUpload_Them);
        img_HinhAnh_Them.ImageUrl = "~/HinhAnh/Sprites_SP/" + UploadHinhAnh(fileUpload_Them);
        lb_HinhAnh_Them.Text = UploadHinhAnh(fileUpload_Them);
    }

    protected void ddl_DanhMuc_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddl_LoaiSP.DataSource = GetLoaiSP(int.Parse(ddl_DanhMuc.SelectedValue));
        ddl_LoaiSP.DataTextField = "TenLoaiSP";
        ddl_LoaiSP.DataValueField = "IdLoaiSP";
        ddl_LoaiSP.DataBind();
    }
}