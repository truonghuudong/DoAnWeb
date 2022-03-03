using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TrangChu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetDanhMuc();
            
            GetSanPhamBatKy();

            GetQuangCao();
        }
    }


    private void GetDanhMuc()
    {
        SqlParameter[] p = { };
        DataTable table = DB.ExecuteQuery("GetDanhMuc", p);
        rptDanhMuc.DataSource = table;
        rptDanhMuc.DataBind();
    }


    private void GetSanPhamBatKy()
    {
        SqlParameter[] p = { };
        DataTable table = DB.ExecuteQuery("GetSanPhamBatKy", p);
        rptListSP.DataSource = table;
        rptListSP.DataBind();
    }


    private void GetQuangCao()
    {
        SqlParameter[] p = { };
        DataTable table = DB.ExecuteQuery("GetQuangCao", p);
        rptQuangCao.DataSource = table;
        rptQuangCao.DataBind();
    }



    protected void btnXemThem_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Form_User/TatCaSanPham.aspx?TimKiem=TatCaSanPham");
    }
}