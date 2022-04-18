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
            Label lb_DoanhThu = (e.Item.FindControl("lb_DoanhThu") as Label);
            Label lb_Thue = (e.Item.FindControl("lb_Thue") as Label);


            string doanhThu = (e.Item.DataItem as DataRowView)["DoanhThu"].ToString();
            string tongThue = (e.Item.DataItem as DataRowView)["TongThue"].ToString();

            int doanhThuConLai = int.Parse(doanhThu) - int.Parse(tongThue);

            lb_doanhThuConLai.Text =  String.Format("{0:0,0}", doanhThuConLai) +"";

            Label lb_doanhThuWebSite = (e.Item.FindControl("lb_DoanhThuWebSite") as Label);
                
            int TiLeThanhToan = int.Parse(txt_TyleThanhToan.Text);
            int doanhThuWebSite = doanhThuConLai * TiLeThanhToan / 100;


            TongDoanhThuWebSite += doanhThuWebSite;
            lb_doanhThuWebSite.Text = String.Format("{0:0,0}", doanhThuWebSite);
            lb_DoanhThu.Text = String.Format("{0:0,0}", int.Parse(doanhThu));
            lb_Thue.Text = String.Format("{0:0,0}", int.Parse(tongThue));
            

            

        }
        lb_tongDanhThuWebSite.Text = String.Format("{0:0,0}", TongDoanhThuWebSite);
    }

    protected void txt_TyleThanhToan_TextChanged(object sender, EventArgs e)
    {
        rpt_ThongKe.DataSource = GetBaoCaoThongKe(cl_TuNgay.SelectedDate, cl_DenNgay.SelectedDate);
        rpt_ThongKe.DataBind();
    }

    protected void btn_ThongKeTheoNgay_Click(object sender, EventArgs e)
    {
        formthongKeTheoNgay.Visible = true;
        form_thongKeTheoThang.Visible = false;
    }

    void KhoiTaoNam()
    {
        DataTable dataTable = new DataTable();
        dataTable.Columns.Add("IdNam", typeof(System.String));
        dataTable.Columns.Add("Nam", typeof(System.String));
        for(int i = 1950; i < 2050; i++)
        {
            dataTable.Rows.Add("Nam", i.ToString());
        }
        ddl_nam.DataSource = dataTable;
        ddl_nam.DataTextField = "Nam";
        ddl_nam.DataValueField = "Nam";
        ddl_nam.DataBind();
        string nam = DateTime.Now.Year.ToString();
        ddl_nam.SelectedValue = nam;
    }

    void KhoiTaoThang()
    {
        DataTable dataTable = new DataTable();
        dataTable.Columns.Add("IdThang", typeof(System.String));
        dataTable.Columns.Add("Thang", typeof(System.String));
        for (int i = 1; i < 13; i++)
        {
            dataTable.Rows.Add("Thang", i.ToString());
        }
        ddl_thang.DataSource = dataTable;
        ddl_thang.DataTextField = "Thang";
        ddl_thang.DataValueField = "Thang";
        ddl_thang.DataBind();
    }



    protected void btn_ThongKeTheoThang_Click(object sender, EventArgs e)
    {
        formthongKeTheoNgay.Visible = false;
        form_thongKeTheoThang.Visible = true;

        KhoiTaoNam();
        KhoiTaoThang();
    }

    void GetThongKeTheoThang()
    {

    }

}