using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_User_HoSoTaiKhoan_BinhLuan : System.Web.UI.Page
{
    static PagedDataSource p = new PagedDataSource();
    public static int intSTT;
    public static int trang_thu = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string idSP = Request.QueryString.Get("IdSP").ToString();
            DataTable table = GetSanPham(idSP);
            imageSP.ImageUrl = "~/HinhAnh/Sprites_SP/" + table.Rows[0]["AnhSP"].ToString();
            lbGiaSPCu.Text = table.Rows[0]["GiaSP"].ToString();
            lbTenSP.Text = table.Rows[0]["TenSP"].ToString();
            lbGiaSPMoi.Text = table.Rows[0]["GiaKhuyenMai"].ToString();

            DoDuLieuPaged();
        }
    }

    DataTable GetSanPham(string idSanPham)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdSP",System.Data.SqlDbType.NVarChar,10)
        };
        p[0].Value = idSanPham;
        return DB.ExecuteQuery("GetSanPhamTheoId", p);
    }
    DataTable GetBinhLuan(int idSanPham)
    {

        SqlParameter[] p =
        {
            new SqlParameter("@idsp",System.Data.SqlDbType.Int)
        };
        p[0].Value = idSanPham;
        return DB.ExecuteQuery("GetDanhGiaSanPham", p);
    }


    void DoDuLieuPaged()
    {
        try
        {
            int idSP = int.Parse(Request.QueryString.Get("IdSP").ToString());
            p.DataSource = GetBinhLuan(idSP).DefaultView;

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
            if (p.IsLastPage == true && p.IsFirstPage == true)//neu la cuoi vua la trang dau

            {

                btn_TrangDau.Enabled = false;//neu la trang dau thi hai nut mo di.

                btn_Prev.Enabled = false;

                btn_Next.Enabled = false;//Hai nut sau sang len.

                btn_TrangCuoi.Enabled = false;

            }


            txt_STTPage.Text = (trang_thu + 1) + " / " + p.PageCount;


            rpt_DanhGiaSP.DataSource = p;

            rpt_DanhGiaSP.DataBind();

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

    int GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id;
    }

    void GetBinhLuan(string idTaiKhoan,string idSP,string noDung)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10),
            new SqlParameter("@idSP",SqlDbType.NVarChar,10),
            new SqlParameter("@noidung",SqlDbType.NVarChar,1000)
        };
        p[0].Value = idTaiKhoan;
        p[1].Value = idSP;
        p[2].Value = noDung;
        DB.ExecuteNonQuery("SetBinhLuan", p);
    }

    protected void btn_BinhLuan_Click(object sender, EventArgs e)
    {
        string idSP = Request.QueryString.Get("IdSP").ToString();
        GetBinhLuan(GetIdTaiKhoanTuSession().ToString(), idSP, txt_NoiDung_BinhLuan.InnerText);
        DoDuLieuPaged();
    }
}