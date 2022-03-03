using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_BaoCaoThongKe_ThongKeSanPhamBanChay : System.Web.UI.Page
{

    //trạng thái hóa đơn: 0:đã bị hủy, 1:đã giao - đã thanh toán, 2:đang giao, 3:hoàn trả

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DoDuLieuVaoRepeater();
        }


    }





    //top 10 sản phẩm bán chạy nhất
    DataTable GetSanPhamBanChayNhat(string idTaiKhoan)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = idTaiKhoan;
        return DB.ExecuteQuery("GetSanPhamBanChayTheoId", p);
    }

    void DoDuLieuVaoRepeater()
    {
        try
        {
            UserLogin user = new UserLogin();
            user = (UserLogin)Session["User"];
            string idTaiKhoan = user.Id + "";
            rpt_ThongKe.DataSource = GetSanPhamBanChayNhat(idTaiKhoan);
            rpt_ThongKe.DataBind();
        }
        catch
        {

        }
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
}