using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_User_TatCaSanPham : System.Web.UI.Page
{
    static PagedDataSource p = new PagedDataSource();
    public static int intSTT;
    public static int trang_thu = 0;
    static string timKiem;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            trang_thu = 0;
            timKiem = Request.QueryString.Get("TimKiem").ToString();
            DoDuLieuPaged(timKiem);
        }
    }

    DataTable GetSP(string timkiem)
    {
        SqlParameter[] p ={
            new SqlParameter("@tiemKiem",SqlDbType.NVarChar,200)
        };
        p[0].Value = timKiem;
        return DB.ExecuteQuery("GetTatCaSanPham", p);
    }

    DataTable GetSPTheoGia(int gia)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@tiemKiem",SqlDbType.Int)
        };
        p[0].Value = gia;
        return DB.ExecuteQuery("GetSanPhamTheoGia", p);
    }

    #region phantrang

    void DoDuLieuPaged(string timKiem)
    {
        try
        {
            try
            {
                int Gia = int.Parse(timKiem);
                p.DataSource = GetSPTheoGia(Gia).DefaultView;
            }
            catch
            {
                p.DataSource = GetSP(timKiem).DefaultView;
            }

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


            if(p.IsLastPage == true && p.IsFirstPage == true)
            {
                btn_TrangDau.Enabled = false;//neu la trang dau thi hai nut mo di.

                btn_Prev.Enabled = false;

                btn_Next.Enabled = false;//Hai nut sau sang len.

                btn_TrangCuoi.Enabled = false;
            }

            txt_STTPage.Text = (trang_thu + 1) + " / " + p.PageCount;


            rptListSP.DataSource = p;

            rptListSP.DataBind();

        }
        catch
        {

        }
    }

    protected void btn_TrangDau_Click(object sender, EventArgs e)
    {
        trang_thu = 0;
        DoDuLieuPaged(timKiem);
    }

    protected void btn_Prev_Click(object sender, EventArgs e)
    {
        trang_thu--;
        DoDuLieuPaged(timKiem);
    }

    protected void btn_Next_Click(object sender, EventArgs e)
    {
        trang_thu++;
        DoDuLieuPaged(timKiem);
    }

    protected void btn_TrangCuoi_Click(object sender, EventArgs e)
    {
        trang_thu = p.PageCount - 1;
        DoDuLieuPaged(timKiem);
    }
    #endregion


}