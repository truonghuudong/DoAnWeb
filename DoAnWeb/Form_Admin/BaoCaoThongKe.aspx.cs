using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Admin_BaoCaoThongKe : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            lb_thongbao.Visible = false;
            txt_TuNgay.Attributes.Add("onclick", "txt_TuNgayClick()");
            txt_DenNgay.Attributes.Add("onclick", "txt_DenNgayClick()");
        }
    }

    DataTable GetBaoCaoThongKe(DateTime tuNgay,DateTime denNgay)
    {
        SqlParameter[] p ={
            new SqlParameter("@tungay",SqlDbType.DateTime),
            new SqlParameter("@denngay",SqlDbType.DateTime)

        };
        p[0].Value = tuNgay;
        p[1].Value = denNgay;

        return DB.ExecuteQuery("BaoCaoThongKeAdmin", p);
    }



    protected void ibtn_TuNgay_Click(object sender, ImageClickEventArgs e)
    {
        cl_TuNgay.Visible = true;
    }

    protected void ibtn_DenNgay_Click(object sender, ImageClickEventArgs e)
    {
        cl_DenNgay.Visible = true;
    }

    protected void cl_TuNgay_SelectionChanged(object sender, EventArgs e)
    {
        txt_TuNgay.Text = cl_TuNgay.SelectedDate.ToString("dd/MM/yyyy");
        cl_TuNgay.Visible = false;
        lb_thongbao.Visible = false;
    }

    protected void cl_DenNgay_SelectionChanged(object sender, EventArgs e)
    {
        //try
        //{
            if (cl_DenNgay.SelectedDate > cl_TuNgay.SelectedDate)
            {
                txt_DenNgay.Text = cl_DenNgay.SelectedDate.ToString("dd/MM/yyyy");

                
                rpt_ThongKe.DataSource = GetBaoCaoThongKe(cl_TuNgay.SelectedDate, cl_DenNgay.SelectedDate);
                
                rpt_ThongKe.DataBind();
            }
            else
            {
                txt_DenNgay.Text = "";
                lb_thongbao.Text = "Chọn sai, vui lòng chọn lại";
            }
            cl_DenNgay.Visible = false;
        //}
        //catch
        //{

        //}
    }

    protected void rpt_ThongKe_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        int TongDoanhThuWebSite = 0;

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            //DropDownList ddlCountries = (e.Item.FindControl("ddlCountries") as DropDownList);
            Label lb_doanhThuConLai = (e.Item.FindControl("lb_DoanhThuConLai") as Label);

            string doanhThu = (e.Item.DataItem as DataRowView)["DoanhThu"].ToString();
            string tongThue = (e.Item.DataItem as DataRowView)["TongThue"].ToString();

            int doanhThuConLai = int.Parse(doanhThu) - int.Parse(tongThue);

            lb_doanhThuConLai.Text = doanhThuConLai +"";

            Label lb_doanhThuWebSite = (e.Item.FindControl("lb_DoanhThuWebSite") as Label);

            int TiLeThanhToan = int.Parse(txt_TyleThanhToan.Text);
            int doanhThuWebSite = doanhThuConLai * TiLeThanhToan / 100;


            TongDoanhThuWebSite += doanhThuWebSite;
            lb_doanhThuWebSite.Text = doanhThuWebSite.ToString();
        }
        lb_tongDanhThuWebSite.Text = TongDoanhThuWebSite.ToString();
    }

    protected void txt_TyleThanhToan_TextChanged(object sender, EventArgs e)
    {
        rpt_ThongKe.DataSource = GetBaoCaoThongKe(cl_TuNgay.SelectedDate, cl_DenNgay.SelectedDate);
        rpt_ThongKe.DataBind();
    }
}