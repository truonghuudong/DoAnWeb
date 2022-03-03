using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_YeuCauDanhMuc_TatCaCacYeuCauDanhMuc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            DioDuLieu();
        }
    }
    void DioDuLieu()
    {
        rpt_ChiTietDanhMuc.DataSource = GetChiTietDanhMuc();
        rpt_ChiTietDanhMuc.DataBind();
    }

    int GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id;
    }

    private DataTable GetChiTietDanhMuc()
    {
        SqlParameter[] p = { 
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = GetIdTaiKhoanTuSession();
        return DB.ExecuteQuery("LayChiTietDanhMucTheoIdTaiKhoan", p);
    }



    protected void btn_YeuCau_Huy_Click(object sender, EventArgs e)
    {

    }

    protected void ddl_trangthai_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl_trangthai = (sender as DropDownList);
        string idChiTietDanhMuc = (((sender as DropDownList).NamingContainer as RepeaterItem).FindControl("lb_idChiTietDanhMuc") as Label).Text;
        if(ddl_trangthai.SelectedValue == "1")
        {

        }
        else
        {
            updateTrangThai(idChiTietDanhMuc, ddl_trangthai.SelectedValue);
        }

        DioDuLieu();
    }
    int updateTrangThai(string IdChiTietDanhMuc, string trangThai)
    {

        SqlParameter[] p =
               {
                    new SqlParameter ("@idLoaiSP",System.Data.SqlDbType.NVarChar,10),
                    new SqlParameter ("@trangthai",System.Data.SqlDbType.NVarChar,3),
                };
        p[0].Value = IdChiTietDanhMuc;
        p[1].Value = trangThai;
        return DB.ExecuteNonQuery("UpdateTrangThaiChiTietDanhMuc", p);
    }
    DataTable dataTrangThai()
    {
        DataTable table = new DataTable();
        table.Columns.Add("Id", typeof(string));
        table.Columns.Add("TrangThai", typeof(string));
        table.Rows.Add("1", "Đã Duyệt");
        table.Rows.Add("2", "Chờ Duyệt");
        table.Rows.Add("3", "Đã Hủy");
        return table;
    }


    void AddMauDropDownList(string trangthai, DropDownList selectList)
    {
        if (trangthai == "1")
        {
            selectList.Attributes["style"] = "color:green";
        }
        else
        {
            if (trangthai == "2")
            {
                selectList.Attributes.Add("style", "color: orange");
            }
            else
            {
                selectList.Attributes["style"] = "color:red";
            }
        }

        foreach (ListItem li in selectList.Items)
        {
            if (li.Value == "1")
            {
                li.Attributes["style"] = "color:green";
            }
            else
            {
                if (li.Value == "2")
                {
                    li.Attributes.Add("style", "color: orange");
                }
                else
                {
                    li.Attributes["style"] = "color:red";
                }
            }
        }
    }

    protected void rpt_ChiTietDanhMuc_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        DropDownList ddl_trangthai = e.Item.FindControl("ddl_trangthai") as DropDownList;
        ddl_trangthai.DataSource = dataTrangThai();
        ddl_trangthai.DataValueField = "Id";
        ddl_trangthai.DataTextField = "TrangThai";
        ddl_trangthai.DataBind();

        string trangthai = (e.Item.DataItem as DataRowView)["TrangThai"].ToString();

        //chọn trạng thái hiện tại của sản phẩm
        ddl_trangthai.SelectedValue = trangthai;

        //them mau cho dropdownlist
        AddMauDropDownList(trangthai, ddl_trangthai);
        if(trangthai == "1")
        {
            ddl_trangthai.Enabled = false;
        }

    }
}