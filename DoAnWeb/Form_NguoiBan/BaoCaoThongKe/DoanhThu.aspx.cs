﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_BaoCaoThongKe_DoanhThu : System.Web.UI.Page
{
    static PagedDataSource p = new PagedDataSource();
    public static int intSTT;
    public static int trang_thu = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DoDuLieuPaged();
        }
    }

    protected void Calendar2_SelectionChanged(object sender, EventArgs e)
    {
        DoDuLieuPaged();
    }

    protected void rpt_ThongKe_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            //DropDownList ddlCountries = (e.Item.FindControl("ddlCountries") as DropDownList);
            CheckBox cb_tangthai = (e.Item.FindControl("cb_trangThai") as CheckBox);


            //lấy trậng thái hiện tại của loaisp
            string trangthai = (e.Item.DataItem as DataRowView)["TrangThai"].ToString();
            if (trangthai == "1")
            {
                cb_tangthai.Checked = true;
            }
            else
            {
                cb_tangthai.Checked = false;
            }

        }

    }

    DataTable GetDoanhThuTheoNgay(string IdTaiKhoan,DateTime NgayBatDau, DateTime NgayKetThuc)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10),
            new SqlParameter("@NgayBatDau",SqlDbType.DateTime),
            new SqlParameter("@NgayKetThuc",SqlDbType.DateTime),
        };
        p[0].Value = IdTaiKhoan;
        p[1].Value = NgayBatDau.ToString("dd/MM/yyyy");
        p[2].Value = NgayKetThuc.ToString("dd/MM/yyyy");
        return DB.ExecuteQuery("DoanhThuTheoNgayDaChon", p);
    }


    #region phantrang

    void DoDuLieuPaged()
    {
        try
        {
            UserLogin user = new UserLogin();
            user = (UserLogin)Session["User"];
            string idTaiKhoan = user.Id + "";
            DateTime ngayBatDau = cl_NgayBatDau.SelectedDate;
            DateTime ngayKetThuc = cl_NgayKetThuc.SelectedDate;
            p.DataSource = GetDoanhThuTheoNgay(idTaiKhoan, ngayBatDau,ngayKetThuc).DefaultView;

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


            rpt_ThongKe.DataSource = p;

            rpt_ThongKe.DataBind();

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
    #endregion
}