using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_QuanLyKhuyenMai_ChiTietKhuyenMai : System.Web.UI.Page
{

    static PagedDataSource p = new PagedDataSource();
    public static int intSTT;
    public static int trang_thu = 0;
    static DataTable  SPCuaKhuyenMai =new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            trang_thu = 0;
            DoDuLieuPaged();
        }
    }

    int GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id;
    }


    //lay sp cua nguoi ban
    DataTable GetSPCuaNguoiBan()
    {
        SPCuaKhuyenMai = GetSPCuaKhuyenMai();
        SqlParameter[] p =
        {
            new SqlParameter("@idNguoiBan",SqlDbType.NVarChar,10)
        };
        p[0].Value = GetIdTaiKhoanTuSession().ToString();
        return DB.ExecuteQuery("GetSanPhamTheoIdNguoiBan",p);
    }


    DataTable GetSPCuaKhuyenMai()
    {
        string idkhuyenmai = Request.QueryString.Get("IdKM").ToString();
        SqlParameter[] p =
        {
            new SqlParameter("@IdKhuyenMai",SqlDbType.NVarChar,10)
        };
        p[0].Value = idkhuyenmai;
        return DB.ExecuteQuery("GetSanPhamTrongChiTietKhuyenMai", p);
    }



    #region phantrang
    void DoDuLieuPaged()
    {
        try
        {
            p.DataSource = GetSPCuaNguoiBan().DefaultView;

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


            rpt_ChiTietKhuyenMai.DataSource = p;

            rpt_ChiTietKhuyenMai.DataBind();

            KiemTraChecked();
        }
        catch
        {

        }
    }

    protected void btn_TrangDau_Click(object sender, EventArgs e)
    {
        cb_TatCa_Chung.Checked = false;
        trang_thu = 0;
        DoDuLieuPaged();
    }

    protected void btn_Prev_Click(object sender, EventArgs e)
    {
        cb_TatCa_Chung.Checked = false;
        trang_thu--;
        DoDuLieuPaged();
    }

    protected void btn_Next_Click(object sender, EventArgs e)
    {
        cb_TatCa_Chung.Checked = false;
        trang_thu++;
        DoDuLieuPaged();
    }

    protected void btn_TrangCuoi_Click(object sender, EventArgs e)
    {
        cb_TatCa_Chung.Checked = false;
        trang_thu = p.PageCount - 1;
        DoDuLieuPaged();
    }
    //phan trang
    #endregion


    protected void rpt_ChiTietKhuyenMai_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            CheckBox cb_trangthai = (e.Item.FindControl("cb_TrangThai") as CheckBox);
            TextBox txt_TyLe = (e.Item.FindControl("txt_TyLeKhuyenMai") as TextBox);

            //lấy trậng thái hiện tại của loaisp
            string idSP = (e.Item.DataItem as DataRowView)["IdSP"].ToString();
            for (int i = 0; i < SPCuaKhuyenMai.Rows.Count; i++)
            {
                if(idSP.Equals(SPCuaKhuyenMai.Rows[i]["IdSP"].ToString()))
                {
                    txt_TyLe.Enabled = true;
                    txt_TyLe.Text = SPCuaKhuyenMai.Rows[i]["TiLeKhuyenMai"].ToString();
                    cb_trangthai.Checked = true;
                }
            }

        
        }
    }

    void KiemTraChecked()
    {
        int dem = 0;
        foreach(RepeaterItem item in rpt_ChiTietKhuyenMai.Items)
        {
            CheckBox cb_trangthai = item.FindControl("cb_trangthai") as CheckBox;
            if(cb_trangthai.Checked == true)
            {
                dem++;
            }
        }
        if (dem == 10)
        {
            cb_TatCa_Chung.Checked = true;
        }
        else
        {
            cb_TatCa_Chung.Checked = false;
        }
    }

    void CB_ChungBangTrue()
    {
        for (int i = 0; i < rpt_ChiTietKhuyenMai.Items.Count; i++)
        {
            CheckBox cb = (rpt_ChiTietKhuyenMai.Items[i].FindControl("cb_TrangThai") as CheckBox);
            string idSP = (rpt_ChiTietKhuyenMai.Items[i].FindControl("lb_idSp") as Label).Text;
            if (cb_TatCa_Chung.Checked == true)
            {
                    cb.Checked = true;
            }
        }
    }


    void addTatCaKhuyenMai()
    {
        string idKm = Request.QueryString.Get("IdKM").ToString();

        for (int i = 0; i < rpt_ChiTietKhuyenMai.Items.Count; i++)
        {
            CheckBox cb = (rpt_ChiTietKhuyenMai.Items[i].FindControl("cb_TrangThai") as CheckBox);
            string idSP = (rpt_ChiTietKhuyenMai.Items[i].FindControl("lb_idSp") as Label).Text;


            if (cb_TatCa_Chung.Checked == true)
            { 
                    cb.Checked = cb_TatCa_Chung.Checked;
                    TextBox txt = (rpt_ChiTietKhuyenMai.Items[i].FindControl("txt_TyLeKhuyenMai") as TextBox);
                    txt.Enabled = true;
                    txt.Text = txt_tyleKM_chung.Text;
                    int tylechung = int.Parse(txt_tyleKM_chung.Text);
                    //try
                    //{
                        InsertChiTietKhuyenMai(idKm, idSP, tylechung);
                    //}
                    //catch
                    //{

                    //}
            }
        }
    }

    void CB_ChungBangFalse()
    {
        string idKm = Request.QueryString.Get("IdKM").ToString();

        for (int i = 0; i < rpt_ChiTietKhuyenMai.Items.Count; i++)
        {
            CheckBox cb = (rpt_ChiTietKhuyenMai.Items[i].FindControl("cb_TrangThai") as CheckBox);
            string idSP = (rpt_ChiTietKhuyenMai.Items[i].FindControl("lb_idSp") as Label).Text;
            if (cb_TatCa_Chung.Checked == false)
            {
                TextBox txt = (rpt_ChiTietKhuyenMai.Items[i].FindControl("txt_TyLeKhuyenMai") as TextBox);
                txt.Enabled = false;
                txt.Text = "";
                //try
                //{
                    DeleteChiTietKhuyenMai(idKm, idSP);
                    cb.Checked = false;
                //}
                //catch
                //{

                //}
            }
        }
    }


    void InsertChiTietKhuyenMai(string idKhuyenMai,string idSP, int tyle)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdKhuyenMai",SqlDbType.NVarChar,10),
            new SqlParameter("@IdSP",SqlDbType.NVarChar,10),
             new SqlParameter("@TyLeKhuyenMai",SqlDbType.Int)
        };
        p[0].Value = idKhuyenMai;
        p[1].Value = idSP;
        p[2].Value = tyle;
        DB.ExecuteNonQuery("InsertChiTietKhuyenMai", p);
    }

    void DeleteChiTietKhuyenMai(string idKhuyenMai, string idSP)
    {
        SqlParameter[] p =
       {
            new SqlParameter("@IdKhuyenMai",SqlDbType.NVarChar,10),
            new SqlParameter("@IdSP",SqlDbType.NVarChar,10),
        };
        p[0].Value = idKhuyenMai;
        p[1].Value = idSP;
        DB.ExecuteNonQuery("DeleteChiTietKhuyenMai", p);
    }




    protected void cb_TatCa_Chung_CheckedChanged(object sender, EventArgs e)
    {
        if (cb_TatCa_Chung.Checked == true)
        {
            CB_ChungBangTrue();
        }
        else
        {
            if( cb_TatCa_Chung.Checked == false)
            {
                CB_ChungBangFalse();
            }
            else
            {
                cb_TatCa_Chung.Checked = false;
            }
        }


    }

    protected void cb_TrangThai_CheckedChanged(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as CheckBox).NamingContainer as RepeaterItem;
        string idKM = Request.QueryString.Get("IdKM").ToString();
        string idSP = (item.FindControl("lb_idSp") as Label).Text;

        if ((sender as CheckBox).Checked == true)
        {
            (item.FindControl("txt_TyLeKhuyenMai") as TextBox).Enabled = true;
        }
        else
        {
            (item.FindControl("txt_TyLeKhuyenMai") as TextBox).Enabled =false;
            (item.FindControl("txt_TyLeKhuyenMai") as TextBox).Text = "";
            //try
            //{
                DeleteChiTietKhuyenMai(idKM, idSP);
            //}
            //catch
            //{

            //}
        }
        KiemTraChecked();
    }

    protected void txt_TyLeKhuyenMai_TextChanged(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as TextBox).NamingContainer as RepeaterItem;
        string idKM = Request.QueryString.Get("IdKM").ToString();
        string idSP = (item.FindControl("lb_idSp") as Label).Text;
        //try
        //{
            int tyle = int.Parse((sender as TextBox).Text);
            InsertChiTietKhuyenMai(idKM,idSP,tyle);
            DoDuLieuPaged();
        //}
        //catch
        //{

        //}
    }

    protected void btn_Them_Click(object sender, EventArgs e)
    {
        addTatCaKhuyenMai();
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Thêm Thành Công')", true);
    }
}