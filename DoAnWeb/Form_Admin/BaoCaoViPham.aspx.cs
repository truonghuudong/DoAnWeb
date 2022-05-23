using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Admin_BaoCaoViPham : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetDuLieu();
        }
    }

    DataTable dataBaoCao()
    {
        SqlParameter[] p =
        {

        };
        return DB.ExecuteQuery("GetBaoCaoViPham", p);
    }

    void GetDuLieu()
    {
        rpt_BaoCaoViPham.DataSource = dataBaoCao();
        rpt_BaoCaoViPham.DataBind();
    }

    void UpdateTrangThaiTaiKhoan(string idTaiKhoan, string trangthai)
    {
        SqlParameter[] p =
                   {
                    new SqlParameter ("@idTaiKhoan",System.Data.SqlDbType.NVarChar,10),
                    new SqlParameter ("@trangthai",System.Data.SqlDbType.NVarChar,3)
                };
        p[0].Value = idTaiKhoan;
        p[1].Value = trangthai;
        DB.ExecuteNonQuery("UpdateTrangThaiTaiKhoan", p);
    }
    protected void cb_trangThai_CheckedChanged(object sender, EventArgs e)
    {
        RepeaterItem items = (sender as CheckBox).NamingContainer as RepeaterItem;
        Label idTaiKhoan = items.FindControl("lb_IdIdTaiKhoan") as Label;
        bool trangThai = (sender as CheckBox).Checked;
        if (trangThai == true)
        {
            UpdateTrangThaiTaiKhoan(idTaiKhoan.Text, "1");
        }
        else
        {
            UpdateTrangThaiTaiKhoan(idTaiKhoan.Text, "0");
        }
    }


    protected void rpt_BaoCaoViPham_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            CheckBox cb_trangThai = e.Item.FindControl("cb_trangThai") as CheckBox;
            if((e.Item.DataItem as DataRowView)["TrangThai"].ToString() == "0")
            {
                cb_trangThai.Checked = false;
            }
            else
            {
                cb_trangThai.Checked = true;
            }


        }
    }

    int deleteBaoCao(string idTaiKhoan)
    {
        SqlParameter[] p = {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = idTaiKhoan;
        return DB.ExecuteNonQuery("deleteBaoCao", p);
    }


    protected void btn_Xoa_Click(object sender, EventArgs e)
    {
        int ketQua = deleteBaoCao((sender as Button).CommandArgument);
        if (ketQua > 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Xóa Thành Công')", true);
            GetDuLieu();
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Xóa Thất Bại')", true);
        }
    }
}