using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Admin_QuanLyDanhMuc : System.Web.UI.Page
{
    //trạng thái hóa đơn: 0:đã bị hủy, 1:đã giao - đã thanh toán, 2:đang giao, 3:hoàn trả, 4:chờ xác nhận 

    static PagedDataSource p = new PagedDataSource();
    public static int intSTT;
    public static int trang_thu = 0;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //fileUpload.Attributes["onchange"] = "UploadFile(this)";
            DoDuLieuPaged();
            form_chinhsuadanhmuc.Visible = false;
        }
    }

    //phan trang

    #region phantrang
    void DoDuLieuPaged()
    {
        try
        {
            UserLogin user = new UserLogin();
            user = (UserLogin)Session["User"];
            string idTaiKhoan = user.Id + "";
            p.DataSource = GetDanhMuc().DefaultView;

            p.PageSize = 10;

            p.CurrentPageIndex = trang_thu;

            p.AllowPaging = true;


            btn_TrangDau.Enabled = true; btn_Prev.Enabled = true; btn_Next.Enabled = true; btn_TrangCuoi.Enabled = true;


            if (p.IsFirstPage == true)//neu la dau.

            {

                btn_TrangDau.Enabled = false;//neu la trang dau thi hai nut mo di.

                btn_Prev.Enabled = false;

                btn_Next.Enabled = true;//Hai nut sau sang len.

                btn_TrangCuoi.Enabled = true;

            }


            if (p.IsLastPage == true)//neu la cuoi

            {

                btn_TrangDau.Enabled = true;//neu la trang dau thi hai nut mo di.

                btn_Prev.Enabled = true;

                btn_Next.Enabled = false;//Hai nut sau sang len.

                btn_TrangCuoi.Enabled = false;

            }


            txt_STTPage.Text = (trang_thu + 1) + " / " + p.PageCount;


            gridView_DanhMuc.DataSource = p;

            gridView_DanhMuc.DataBind();

        }
        catch
        {

        }
    }

    protected void btn_TrangDau_Click(object sender, EventArgs e)
    {
        trang_thu = 0;
        DoDuLieuPaged();
    }

    protected void btn_Prev_Click(object sender, EventArgs e)
    {
        trang_thu--;
        DoDuLieuPaged();
    }

    protected void btn_Next_Click(object sender, EventArgs e)
    {
        trang_thu++;
        DoDuLieuPaged();
    }

    protected void btn_TrangCuoi_Click(object sender, EventArgs e)
    {
        trang_thu = p.PageCount - 1;
        DoDuLieuPaged();
    }
    //phan trang
    #endregion




    private DataTable GetDanhMuc()
    {
        SqlParameter[] p = { };
        return DB.ExecuteQuery("GetDanhMuc", p);
    }

    //public string UploadHinhAnh()
    //{
    //    if (fileUpload.HasFile)
    //    {
    //        string tenFileHinhAnhDuocUpload = DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fileUpload.FileName;//DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") +
    //        return tenFileHinhAnhDuocUpload;
    //    }
    //    else
    //    {
    //        return "";
    //    }
    //}
    //public void SaveHinhAnh()
    //{
    //    string tenFileHinhAnhDuocUpload = DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fileUpload.FileName;
    //    string thuMucHinhAnh = Server.MapPath("~/HinhAnh/Sprites_DanhMuc/");
    //    string duongDanHinhAnhDuocLuu = thuMucHinhAnh + tenFileHinhAnhDuocUpload;
    //    fileUpload.SaveAs(duongDanHinhAnhDuocLuu);
    //}

    void SuaDanhMuc(string idDanhMuc, string anhDanhMuc)
    {
        if (!txt_TenDanhMuc.Text.Equals(""))
        {
            if (UpdateDanhMuc(idDanhMuc, txt_TenDanhMuc.Text, anhDanhMuc) > 0)
            {
                lb_thongbao_danhmuc.Text = "Sửa thành công";
                btn_danhmuc_Them.Visible = false;
                DoDuLieuPaged();
            }
            else
            {
                lb_thongbao_danhmuc.Text = "Sửa thất bại";
            }
        }
        else
        {
            lb_thongbao_danhmuc.Visible = true;
            lb_thongbao_danhmuc.Text = "Vui lòng nhập đầy đủ thông tin";
        }
    }
    void ThemDanhMuc(string tenDanhMuc, string anhDanhMuc)
    {
        if (!txt_TenDanhMuc.Text.Equals(""))
        {
            if (SetDanhMuc(txt_TenDanhMuc.Text, anhDanhMuc) > 0)
            {
                lb_thongbao_danhmuc.Text = "Thêm thành công";
                btn_danhmuc_Them.Visible = false;
                DoDuLieuPaged();
            }
            else
            {
                lb_thongbao_danhmuc.Text = "Thêm thất bại";
            }
        }
        else
        {
            lb_thongbao_danhmuc.Visible = true;
            lb_thongbao_danhmuc.Text = "Vui lòng nhập đầy đủ thông tin";
        }
    }
    void XoaDanhMuc(string idDanhMuc)
    {
        try
        {
            if (DeleteDanhMuc(idDanhMuc) > 0)
            {
                lb_thongbao_danhmuc.Text = "Xóa thành công";
                btn_danhmuc_Them.Visible = false;
                btn_danhmuc_Thoat.Text = "Thoát";
                DoDuLieuPaged();
            }
            else
            {
                lb_thongbao_danhmuc.Text = "Xóa thất bại";
            }
        }
        catch
        {

        }

    }

    protected void btn_DanhMuc_Them_Click(object sender, EventArgs e)
    {
        lb_thongbao_danhmuc.Visible = true;
        string idDanhMuc = lb_thongbao_danhmuc_id.Text;
        string anhDanhMuc = lb_thongbao_danhmuc_anhdanhmuc.Text;
        string tenDanhMuc = txt_TenDanhMuc.Text;


        if (lb_title.Text.Equals("Sửa Danh Mục"))
        {
            SuaDanhMuc(idDanhMuc, anhDanhMuc);
        }
        else
        {
            if (lb_title.Text == "Thêm Danh Mục")
            {
                ThemDanhMuc(tenDanhMuc, anhDanhMuc);
            }
            else
            {
                XoaDanhMuc(idDanhMuc);
            }
        }
    }

    int DeleteDanhMuc(string idDanhMuc)
    {
        SqlParameter[] p =
               {
                    new SqlParameter ("@IdDanhMuc",System.Data.SqlDbType.Int)
                };
        p[0].Value = int.Parse(idDanhMuc);
        return DB.ExecuteNonQuery("DeleteDanhMucTheoId", p);
    }
    int UpdateDanhMuc(string IdDanhMuc, string TenDanhMuc, string AnhDanhMuc)
    {
        try
        {
            SqlParameter[] p =
               {
                    new SqlParameter("@IdDanhMuc", System.Data.SqlDbType.Int),
                    new SqlParameter("@TenDanhMuc", System.Data.SqlDbType.NVarChar, 200),
                    new SqlParameter("@AnhDanhMuc", System.Data.SqlDbType.NVarChar, 200),
                };
            p[0].Value = int.Parse(IdDanhMuc);
            p[1].Value = TenDanhMuc;
            p[2].Value = "";
            int rowsaffected = DB.ExecuteNonQuery("UpdateDanhMucTheoId", p);
            return rowsaffected;
        }
        catch
        {
            lb_thongbao_danhmuc.Text = "Lỗi, Vui lòng thử lại sau";
            return 0;
        }


    }
    int SetDanhMuc(string tenDanhMuc, string anhDanhMuc)
    {
        SqlParameter[] p =
               {
                    new SqlParameter ("@tendanhmuc",System.Data.SqlDbType.NVarChar,200),
                    new SqlParameter ("@anhdanhmuc",System.Data.SqlDbType.NVarChar,200),
                };
        p[0].Value = tenDanhMuc;
        p[1].Value = "";
        return DB.ExecuteNonQuery("SetDanhMuc", p);
    }

    protected void btn_DanhMuc_Thoat_Click(object sender, EventArgs e)
    {
        form_chinhsuadanhmuc.Visible = false;
    }

    protected void Btn_Sua_Click(object sender, EventArgs e)
    {
        //imgHinhAnh.Visible = true;
        //fileUpload.Visible = true;
        //lbUploadHinhAnh.Visible = true;
        //btn_upload_file.Visible = true;


        lb_thongbao_danhmuc.Visible = false;
        form_chinhsuadanhmuc.Visible = true;
        txt_TenDanhMuc.Visible = true;


        lb_title.Text = "Sửa Danh Mục";
        btn_danhmuc_Them.Visible = true;
        btn_danhmuc_Them.Text = "Sửa";
        btn_danhmuc_Thoat.Text = "Thoát";

        string idDanhMuc = (sender as Button).CommandArgument;

        DataTable tb = GetDanhMucTheoId(idDanhMuc);
        txt_TenDanhMuc.Text = tb.Rows[0]["TenDanhMuc"].ToString();
        lb_thongbao_danhmuc_id.Text = idDanhMuc;
        string anhDanhMuc = tb.Rows[0]["AnhDanhMuc"].ToString();

        //imgHinhAnh.ImageUrl = "~/HinhAnh/Sprites_DanhMuc/" + tb.Rows[0]["AnhDanhMuc"].ToString();
        lb_thongbao_danhmuc_anhdanhmuc.Text = tb.Rows[0]["AnhDanhMuc"].ToString();
    }
    protected void btn_Xoa_Click(object sender, EventArgs e)
    {
        form_chinhsuadanhmuc.Visible = true;
        //lbUploadHinhAnh.Visible = false;
        //btn_upload_file.Visible = false;
        //imgHinhAnh.Visible = false;
        txt_TenDanhMuc.Visible = false;
        //fileUpload.Visible = false;
        lb_thongbao_danhmuc.Visible = false;

        lb_title.Text = "Bạn có muốn xóa danh mục này không.";
        btn_danhmuc_Them.Visible = true;
        btn_danhmuc_Them.Text = "Có";
        btn_danhmuc_Thoat.Text = "Không";
        lb_thongbao_danhmuc_id.Text = (sender as Button).CommandArgument;
    }
    DataTable GetDanhMucTheoId(string id)
    {
        SqlParameter[] p =
               {
                    new SqlParameter ("@IdDanhMuc",System.Data.SqlDbType.Int),
                };
        p[0].Value = id;
        return DB.ExecuteQuery("GetDanhMucTheoId", p);
    }
    //protected void btnUpload_Click(object sender, EventArgs e)
    //{
    //    SaveHinhAnh();
    //    imgHinhAnh.ImageUrl = "~/HinhAnh/Sprites_DanhMuc/" + UploadHinhAnh();
    //    lb_thongbao_danhmuc_anhdanhmuc.Text = UploadHinhAnh();
    //}

    protected void ibtn_themdanhmuc_Click(object sender, ImageClickEventArgs e)
    {
        //imgHinhAnh.Visible = true;
        //fileUpload.Visible = true;
        //lbUploadHinhAnh.Visible = true;
        //btn_upload_file.Visible = true;
        lb_thongbao_danhmuc.Visible = false;
        form_chinhsuadanhmuc.Visible = true;
        txt_TenDanhMuc.Visible = true;

        btn_danhmuc_Them.Text = "Thêm";
        btn_danhmuc_Thoat.Text = "Thoát";
        btn_danhmuc_Them.Visible = true;
        lb_title.Text = "Thêm Danh Mục";

        txt_TenDanhMuc.Text = "";
        //imgHinhAnh.ImageUrl = "";
        lb_thongbao_danhmuc_anhdanhmuc.Text = "";
        lb_thongbao_danhmuc_id.Text = "";

    }
}