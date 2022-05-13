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
            countSizeSua = 0;
            countSize = 3;
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


                    ddl_thue_sua.DataSource = GetThue();
                    ddl_thue_sua.DataTextField = "TenThue";
                    ddl_thue_sua.DataValueField = "TyLeThue";
                    ddl_thue_sua.DataBind();


                    KhoiTaoSize(idsp);
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


                ddl_thue_them.DataSource = GetThue();
                ddl_thue_them.DataTextField = "TenThue";
                ddl_thue_them.DataValueField = "TyLeThue";
                ddl_thue_them.DataBind();

            }


            

        }

    }

    DataTable GetDanhMuc()
    {
        SqlParameter[] p = { };
        return DB.ExecuteQuery("GetDanhMuc", p);
    }

    DataTable GetThue() {
        SqlParameter[] p = { };
        return DB.ExecuteQuery("GetThue", p);
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
    int InsertSanPham(string idtaikhoan, string idloaisp, string tensp, string anhsp, string giasp, string soluong, string mota,string thue)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idtaiKhoan",SqlDbType.NVarChar,10),
            new SqlParameter("@idLoaiSP", SqlDbType.NVarChar,10),
            new SqlParameter("@tensp", SqlDbType.NVarChar,200),
            new SqlParameter("@anhsp", SqlDbType.NVarChar,200),
            new SqlParameter("@giasp", SqlDbType.Int),
            new SqlParameter("@soluong", SqlDbType.Int),
            new SqlParameter("@mota", SqlDbType.NVarChar,1000),
            new SqlParameter("@thue", SqlDbType.NVarChar,10)
        };
        p[0].Value = idtaikhoan;
        p[1].Value = idloaisp;
        p[2].Value = tensp;
        p[3].Value = anhsp;
        p[4].Value = int.Parse(giasp);
        p[5].Value = int.Parse(soluong);
        p[6].Value = mota;
        p[7].Value = thue;
        return DB.ExecuteNonQuery("SetSanPham", p);
    }
    

    int UpdateSanPham(string idsp, string idloaisp, string tensp, string anhsp, string giasp, string soluong, string mota,string thue)
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
            new SqlParameter("@thue", SqlDbType.NVarChar,10)
        };
        p[0].Value = idsp;
        p[1].Value = idloaisp;
        p[2].Value = tensp;
        p[3].Value = anhsp;
        p[4].Value = giasp;
        p[5].Value = soluong;
        p[6].Value = mota;
        p[7].Value = thue;
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
                string idsp = Request.QueryString.Get("IdSP");
                int ketqua = UpdateSanPham(lb_IdSP.Text, ddl_LoaiSP_Sua.SelectedValue, txt_TenSP.Text,
                            lb_thongbao_danhmuc_anhdanhmuc.Text, txt_GiaSP.Text,
                            txt_SoLuongSP.Text, txt_MoTaSP.Text,ddl_thue_sua.SelectedValue);
                ThemSizeSanPham(idsp);
                if (ketqua > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Sửa Thành Công')", true);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Sửa Thất Bại')", true);
                }
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Lỗi Không Xác Định')", true);
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


    string GetIdSanPhamVuaThem()
    {
        SqlParameter[] p = { };
        DataTable table = DB.ExecuteQuery("getIdSanPhamVuaThem", p);
        return table.Rows[0]["IdSP"].ToString();
    }

    void ThemSizeSanPham(string idSP,string tenSize)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idsp",SqlDbType.NVarChar,10),
            new SqlParameter("@tensize",SqlDbType.NVarChar,10)
        };
        p[0].Value = idSP;
        p[1].Value = tenSize;
        DB.ExecuteNonQuery("SetSizeSanPham", p);
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
                    txt_TenSP_Them.Text, lb_HinhAnh_Them.Text, txt_GiaSP_Them.Text, txt_SoLUongSP_Them.Text, txt_MoTa_Them.Text,ddl_thue_them.SelectedValue);
                string idSanPhamVuaThem = GetIdSanPhamVuaThem();

                for(int i = 1; i <= countSize; i++)
                {
                    string idTenTextBox = "txt_Size" + i;
                    TextBox txtSize = themsanpham_size.FindControl(idTenTextBox) as TextBox;
                    ThemSizeSanPham(idSanPhamVuaThem, txtSize.Text);
                }

                if (ketqua > 0)
                {
                    XoaThongTinThem();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Thêm Thành Công')", true);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Thêm Thất Bại')", true);
                }
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Lỗi không xác định')", true);

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


    static int countSize = 3;
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        
        countSize++;
        for(int i = 4; i <= countSize; i++)
        {
            TextBox txtSize = new TextBox();
            txtSize.ID = "txt_Size" + i;
            txtSize.Visible = true;
            txtSize.Attributes.Add("placeholder","size");
            txtSize.Attributes.Add("class", "txt_size");
            themsanpham_size.Controls.Add(txtSize);
        }
    }



    DataTable GetSizeTheoId(string idSP)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdSP",System.Data.SqlDbType.NVarChar,10)
        };
        p[0].Value = idSP;
        return DB.ExecuteQuery("GetSizeSanPhamTheoId", p);
    }

    void KhoiTaoSize(string idSP)
    {
        DataTable table = GetSizeTheoId(idSP);
        countSizeSuaCu = table.Rows.Count;
        for (int i = 1; i <= countSizeSuaCu; i++)
        {
            string tenSize = table.Rows[i-1]["TenSize"].ToString();
            TextBox txtSize = new TextBox();
            txtSize.ID = "txt_Size" + i;
            txtSize.Visible = true;
            txtSize.Attributes.Add("placeholder", "size");
            txtSize.Text = tenSize;
            txtSize.Attributes.Add("class", "txt_size");
            suasanpham_size.Controls.Add(txtSize);
        }
    }

    static int countSizeSua=0;
    static int countSizeSuaCu;
    protected void ibtn_SuaSanPham_Click(object sender, ImageClickEventArgs e)
    {

        countSizeSua++;

        string idsp = Request.QueryString.Get("IdSP");

        KhoiTaoSize(idsp);
        for (int i = countSizeSuaCu+1; i <= countSizeSua+countSizeSuaCu; i++)
        {
            TextBox txtSize = new TextBox();
            txtSize.ID = "txt_Size" + i;
            txtSize.Visible = true;
            txtSize.Attributes.Add("placeholder", "size");
            txtSize.Attributes.Add("class", "txt_size");
            suasanpham_size.Controls.Add(txtSize);
        }
    }

    void DeleteSizeCu(string idsp)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idsp",SqlDbType.NVarChar,10)
        };
        p[0].Value = idsp;
        DB.ExecuteNonQuery("DeleteSizeSanPham", p);
    }
    void UpdateSizeSanPham(string idsp,string tensize)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idsp",SqlDbType.NVarChar,10),
            new SqlParameter("@tenSize",SqlDbType.NVarChar,10)
        };
        p[0].Value = idsp;
        p[1].Value = tensize;
        DB.ExecuteNonQuery("InsertSizeSanPham", p);
    }



    void ThemSizeSanPham(string idSP)
    {
        DeleteSizeCu(idSP);
        for (int i = 1; i <= countSizeSua + countSizeSuaCu; i++)
        {
            string idTxt = "txt_Size" + i;
            TextBox txtSizeSua = suasanpham_size.FindControl(idTxt) as TextBox;
            UpdateSizeSanPham(idSP, txtSizeSua.Text);
        }

    }

    void XoaThongTinThem()
    {
        txt_TenSP_Them.Text = "";
        txt_SoLUongSP_Them.Text = "";
        img_HinhAnh_Them.ImageUrl = "";
        txt_GiaSP_Them.Text = "";
        txt_MoTa_Them.Text = "";

        for (int i = 4; i <= countSize; i++)
        {
            string idTextBox = "txt_Size" + i;
            TextBox txtSize = themsanpham_size.FindControl(idTextBox) as TextBox;
            txtSize.Text = "";
        }

    }


    protected void txt_GiaSP_Them_TextChanged(object sender, EventArgs e)
    {
        if (int.Parse(txt_GiaSP_Them.Text) < 0)
        {
            txt_GiaSP_Them.Text = 0+"";
        }
    }

    protected void txt_GiaSP_TextChanged(object sender, EventArgs e)
    {
        if (int.Parse(txt_GiaSP.Text) < 0)
        {
            txt_GiaSP.Text = 0 + "";
        }
    }

    protected void txt_SoLuongSP_TextChanged(object sender, EventArgs e)
    {
        if (int.Parse(txt_SoLuongSP.Text) < 0)
        {
            txt_SoLuongSP.Text = "0";
        }
    }

    protected void txt_SoLUongSP_Them_TextChanged(object sender, EventArgs e)
    {
        if (int.Parse(txt_SoLUongSP_Them.Text) < 0)
        {
            txt_SoLUongSP_Them.Text = "0";
        }
    }
}