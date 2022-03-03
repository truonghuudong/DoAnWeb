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

}