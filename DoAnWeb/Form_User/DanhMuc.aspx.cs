using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DanhMuc : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DanhMucSanPham();
            DoDuLieuPaged(sanPham());
        }
    }


    void DanhMucSanPham()
    {
        try
        {
            //lay danh muc theo id danh muc 
            int idDanhMuc = int.Parse(Request.QueryString.Get("IdDanhMuc").ToString());
            rptLoaiSP.DataSource = GetLoaiSP(idDanhMuc);
            rptLoaiSP.DataBind();
        }
        catch
        {
            try
            {
                //lay danh muc theo id loaisp
                int idLoaiSP = int.Parse(Request.QueryString.Get("IdLoaiSP").ToString());
                rptLoaiSP.DataSource = GetLoaiSP(GetDanhMuc(idLoaiSP)); ;
                rptLoaiSP.DataBind();
            }
            catch
            {

            }
        }
    }

    DataTable sanPham()
    {
        try
        {
            //lay danh muc theo id danh muc 
            int idDanhMuc = int.Parse(Request.QueryString.Get("IdDanhMuc").ToString());
            return GetSanPhamTheoIdDanhMuc(idDanhMuc);
        }
        catch
        {
            try
            {
                //lay danh muc theo id loaisp
                int idLoaiSP = int.Parse(Request.QueryString.Get("IdLoaiSP").ToString());
                return GetSanPhamTheoIdLoaiSP(idLoaiSP);

            }
            catch
            {

            }
        }
        return null;
    }


    #region PhanTrang

    static PagedDataSource p = new PagedDataSource();
    public static int intSTT;
    public static int trang_thu = 0;

    void DoDuLieuPaged(DataTable table)
    {
        try
        {

            p.DataSource = table.DefaultView;


            p.PageSize = 30;
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

            if (p.IsLastPage == true && p.IsFirstPage == true)//neu la cuoi

            {

                btn_TrangDau.Enabled = false;//neu la trang dau thi hai nut mo di.

                btn_Prev.Enabled = false;

                btn_Next.Enabled = false;//Hai nut sau sang len.

                btn_TrangCuoi.Enabled = false;

            }


            txt_STTPage.Text = (trang_thu + 1) + " / " + p.PageCount;


            rptSanPham.DataSource = p;

            rptSanPham.DataBind();

        }
        catch
        {

        }
    }

    protected void btn_TrangDau_Click(object sender, EventArgs e)
    {
        trang_thu = 0;
        DoDuLieuPaged(sanPham());
    }

    protected void btn_Prev_Click(object sender, EventArgs e)
    {
        trang_thu--;
        DoDuLieuPaged(sanPham());
    }

    protected void btn_Next_Click(object sender, EventArgs e)
    {
        trang_thu++;
        DoDuLieuPaged(sanPham());
    }

    protected void btn_TrangCuoi_Click(object sender, EventArgs e)
    {
        trang_thu = p.PageCount - 1;
        DoDuLieuPaged(sanPham());
    }

    #endregion


    //lay san pham theo id danh muc
    private DataTable GetSanPhamTheoIdDanhMuc(int idDanhMuc)
    {
        SqlParameter[] p = {
            new SqlParameter("@iddanhmuc",SqlDbType.Int)
        };
        p[0].Value = idDanhMuc;
        return DB.ExecuteQuery("GetSanPhamTheoIdDanhMuc", p);
    }

    //lấy sản phẩm theo id loại sp

    DataTable GetSanPhamTheoIdLoaiSP(int idLoaiSP)
    {
        SqlParameter[] p = {
            new SqlParameter("@idloaisp",SqlDbType.Int)
        };
        p[0].Value = idLoaiSP;
        return DB.ExecuteQuery("GetSanPhamTheoIdLoaiSP", p);
    }


    //lay danh sach loaisp theo iddanhmuc
    private DataTable GetLoaiSP(int idDanhMuc)
    {
        SqlParameter [] p = 
        {
            new SqlParameter ("@IdDanhMuc",SqlDbType.Int),
            new SqlParameter ("@TrangThai",SqlDbType.NVarChar,10)
        };
        p[0].Value = idDanhMuc;
        p[1].Value = "1";
        return DB.ExecuteQuery("GetLoaiSPTheoDanhMucTrangThai", p);
    }



    //lay id danh muc theo idloaisp
    private int GetDanhMuc(int idLoaiSP)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdLoaiSP",SqlDbType.Int)
        };
        p[0].Value = idLoaiSP;
        return DB.ExecuteIntCommand("GetIdDanhMuc", p);
    }






    #region SapXep
    //check thay doi cua selected
    protected void ddlGia_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlGia.Items.FindByValue("1").Enabled = false;
        DataView dv = sanPham().DefaultView;
        if (ddlGia.SelectedValue=="2")
        {
            dv.Sort= "GiaKhuyenMai asc";
        }
        else
        {
            dv.Sort = "GiaKhuyenMai desc";
        }
        DataTable table = dv.ToTable();
        DoDuLieuPaged(table);
    }

    //user click in button phobien 
    protected void PhoBien_Click(object sender, EventArgs e)
    {
        btnPhoBien.Attributes.Add("class", "btn_sapxep home-filter__btn active");
        
        btnBanChay.Attributes.Remove("class");
        btnBanChay.Attributes.Add("class", "btn_sapxep home-filter__btn");
        
        
        btnMoiNhat.Attributes.Remove("class");
        btnMoiNhat.Attributes.Add("class", "btn_sapxep home-filter__btn");

    }


    //user click in button moinhat
    protected void MoiNhat_Click(object sender, EventArgs e)
    {
        btnMoiNhat.Attributes.Add("class", "btn_sapxep home-filter__btn active");
        
        btnPhoBien.Attributes.Remove("class");
        btnPhoBien.Attributes.Add("class", "btn_sapxep home-filter__btn");
        
        btnBanChay.Attributes.Remove("class");
        btnBanChay.Attributes.Add("class", "btn_sapxep home-filter__btn");

    }


    //user click in button banchay
    protected void BanChay_Click(object sender, EventArgs e)
    {
        btnBanChay.Attributes.Add("class", "btn_sapxep home-filter__btn active");


        btnPhoBien.Attributes.Remove("class");
        btnPhoBien.Attributes.Add("class", "btn_sapxep home-filter__btn");
        
        btnMoiNhat.Attributes.Remove("class");
        btnMoiNhat.Attributes.Add("class", "btn_sapxep home-filter__btn");
    }
    #endregion


}