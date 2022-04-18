using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_BaoCaoThongKe_KhachHangMuaNhieuNhat : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DoDuLieuVaoRepeater();
        }
    }

    DataTable GetNguoiMuaNhieuNhat(string idTaiKhoan)
    {
        SqlParameter[] p =
        {
            new SqlParameter ("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = idTaiKhoan;
        return DB.ExecuteQuery("GetNguoiMuaNhieuNhat",p);
    }

    void DoDuLieuVaoRepeater()
    {
        try
        {
            UserLogin user = new UserLogin();
            user = (UserLogin)Session["User"];
            string idTaiKhoan = user.Id + "";
            rpt_ThongKe.DataSource = GetNguoiMuaNhieuNhat(idTaiKhoan);
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
            int tongHoaDon = int.Parse((e.Item.DataItem as DataRowView)["TongDonGia"].ToString());

            Label lb_TongHoaDon = (e.Item.FindControl("lb_TongHoaDon") as Label);
            lb_TongHoaDon.Text = String.Format("{0:0,0}", tongHoaDon);

        }
    }
}