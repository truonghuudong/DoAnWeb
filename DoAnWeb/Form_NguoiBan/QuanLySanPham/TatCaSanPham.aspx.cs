using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_QuanLySanPham_TatCaSanPham : System.Web.UI.Page
{

    //trang thai 1:hoạt động, 0 không hoạt động


    static PagedDataSource p = new PagedDataSource();
    public static int intSTT;
    public static int trang_thu = 0;


    protected void Page_Load(object sender, EventArgs e)
    {
        string idsp = Request.QueryString.Get("IdSP");
        //lb_IdSP.Text = idsp;
        if (!IsPostBack)
        {
            //form_chinhsuasanpham.Visible = false;
            DoDuLieuPaged();
            DoDiLieuVaoGridViewNguoiBan(0);

        }
    }
    //gridview Người bán
    void DoDiLieuVaoGridViewNguoiBan(int vitri)
    {
        load_checkBox(GetIdTaiKhoanTuSession().ToString(), gv_tatcasp,vitri);
    }

    #region phantrang
    void DoDuLieuPaged()
    {
        try
        {
            p.DataSource = getSanPham(GetIdTaiKhoanTuSession().ToString()).DefaultView;

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


            gv_tatcasp.DataSource = p;

            gv_tatcasp.DataBind();

        }
        catch
        {

        }
    }

    protected void btn_TrangDau_Click(object sender, EventArgs e)
    {
        trang_thu = 0;
        DoDuLieuPaged();
        DoDiLieuVaoGridViewNguoiBan(trang_thu);
    }

    protected void btn_Prev_Click(object sender, EventArgs e)
    {
        trang_thu--;
        DoDuLieuPaged();
        DoDiLieuVaoGridViewNguoiBan(trang_thu);
    }

    protected void btn_Next_Click(object sender, EventArgs e)
    {
        trang_thu++;
        DoDuLieuPaged();
        DoDiLieuVaoGridViewNguoiBan(trang_thu);
    }

    protected void btn_TrangCuoi_Click(object sender, EventArgs e)
    {
        trang_thu = p.PageCount - 1;
        DoDuLieuPaged();
        DoDiLieuVaoGridViewNguoiBan(trang_thu);
    }
    //phan trang
    #endregion


    // trạng thái sản phẩm
    void load_checkBox(string idNguoiBan, GridView gv,int vitri)
    {
        //try
        //{
        var rows = gv.Rows;
        int count = gv.Rows.Count;
        DataTable dataTable = getSanPham(idNguoiBan);
        int j = 0;
        for (int i = vitri*10; i < vitri * 10+gv_tatcasp.Rows.Count; i++)
        {
            bool trangThai = false;
            if (dataTable.Rows[i]["TrangThai"].ToString() == "1")
            {
                trangThai = true;
            }
            ((CheckBox)rows[j].FindControl("cb_trangthai")).Checked = trangThai;
            j++;
        }

    }

    int GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id;
    }

    //danh sách sản phẩm
    DataTable getSanPham(string idTaiKhoan)
        {
            SqlParameter[] p =
                   {
                    new SqlParameter ("@idNguoiBan",System.Data.SqlDbType.NVarChar,10)
                };
            p[0].Value = idTaiKhoan;
            return DB.ExecuteQuery("GetSanPhamTheoIdNguoiBan", p);
        }
    // thay đổi trạng thái sản phẩm
    void UpdateTrangThaiSanPham(string idSP, string trangthai)
    {
        SqlParameter[] p =
                   {
                    new SqlParameter ("@idSP",System.Data.SqlDbType.NVarChar,10),
                    new SqlParameter ("@trangthai",System.Data.SqlDbType.NVarChar,3)
                };
        p[0].Value = idSP;
        p[1].Value = trangthai;
        DB.ExecuteNonQuery("UpdateTrangThaiSanPham", p);
    }


    protected void btn_Sua_Click(object sender, EventArgs e)
    {
        string idsp = (sender as Button).CommandArgument.ToString();
        //lb_Test.Text = idsp;
        Response.Redirect("~/Form_NguoiBan/QuanLySanPham/ThemSanPham.aspx?IdSP="+idsp+"");

    }
    void XoaSanPham(int idsp)
    {
        SqlParameter[] p =
       {
            new SqlParameter("@IdSP",SqlDbType.Int)
        };
        p[0].Value = idsp;
          DB.ExecuteNonQuery("DeleteSanPham", p);
    }
    protected void btn_Xoa_Click(object sender, EventArgs e)
    {
        //DeleteSanPham(lb_idSanPham.Text);
        //XoaSanPham()
        //bo cai chuc nang xoa di, xoa no no mat du lieu ben cai hoa don luon a, 
        //nen muon xoa thi xoa trong cai chi tiet hoa don nua
        // ok , cai them de t tu lamok
    }

    protected void cb_trangthai_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gv_tatcasp.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)

            {
                CheckBox chkRow = (row.Cells[0].FindControl("cb_trangthai") as CheckBox);
                string idSP = (row.Cells[0].FindControl("lb_idSanPham") as Label).Text;
                bool trangthai = chkRow.Checked;
                if (trangthai == true)
                {
                    UpdateTrangThaiSanPham(idSP, "1");
                }
                else
                {
                    UpdateTrangThaiSanPham(idSP, "0");
                }
            }
        }
    }


}
