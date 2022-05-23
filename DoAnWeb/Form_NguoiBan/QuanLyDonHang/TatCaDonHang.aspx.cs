using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_QuanLyDonHang_TatCaDonHang : System.Web.UI.Page
{
    //trạng thái hóa đơn: 0:đã bị hủy, 1:đã giao - đã thanh toán, 2:đang giao, 3:hoàn trả, 4:Đang Chờ Duyệt
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            doDuLieu("");
        }
    }


    //tạo data trạng thái
    DataTable dataTrangThai()
    {
        DataTable table = new DataTable();
        table.Columns.Add("Id", typeof(string));
        table.Columns.Add("TrangThai", typeof(string));
        table.Rows.Add("0", "Đã hủy");
        table.Rows.Add("1", "Đã giao");
        table.Rows.Add("2", "Đang giao");
        table.Rows.Add("4", "Đang Chờ Duyệt");
        return table;
    }

    void doDuLieu(string trangthai)
    {
        rpt_HoaDon.DataSource = GetTatCaHoaDonTheoIdNguoiBan(trangthai);
        rpt_HoaDon.DataBind();
    }


    string GetIdTaiKhoan()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id + "";
    }

    DataTable GetTatCaHoaDonTheoIdNguoiBan(string trangThai)
    {
        SqlParameter[] p ={
            new SqlParameter("@idnguoiban",SqlDbType.NVarChar,10),
            new SqlParameter("@trangthai",SqlDbType.NVarChar,3)
        };
        p[0].Value = GetIdTaiKhoan().ToString();
        p[1].Value = trangThai;
        return DB.ExecuteQuery("GetHoaDonTheoIdNguoiBan", p);
    }
    DataTable GetChiTietHDTheoIdHoaDon(string idhoadon)
    {
        SqlParameter[] p ={
            new SqlParameter("@idhoadon",SqlDbType.NVarChar,10)

        };
        p[0].Value = idhoadon;

        return DB.ExecuteQuery("GetChiTietHoaDonTheoIdHoaDon", p);
    }

    DataTable  dataphiShip()
    {
        SqlParameter[] p = {};
        return DB.ExecuteQuery("getPhiShip", p);
    }
    DataTable TaoDataPhiShip()
    {
        DataTable table = new DataTable();
        DataColumn idPhiShip = new DataColumn("IdPhiShip");
        DataColumn tenPhiShip = new DataColumn("TenPhiShip");
        table.Columns.Add(idPhiShip);
        table.Columns.Add(tenPhiShip);
        table.Rows.Add(0, "");

        foreach(DataRow row in dataphiShip().Rows)
        {
            table.Rows.Add(row["IdPhiShip"].ToString(),row["KhuVuc"].ToString() + ":" + row["Gia"].ToString());
        }


        return table;
    }



    protected void rpt_HoaDon_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater rpt_CTHD = e.Item.FindControl("rpt_ChiTietHoaDon") as Repeater;

            string idhoadon = (e.Item.FindControl("lb_IdHoaDon") as Label).Text;
            DateTime ngay = DateTime.Parse((e.Item.DataItem as DataRowView)["Ngay"].ToString());


            DropDownList ddl_TrangThai = e.Item.FindControl("ddl_TrangThai") as DropDownList;
            DropDownList ddl_phiShip = e.Item.FindControl("ddl_phiShip") as DropDownList;

            Label lb_ngay = e.Item.FindControl("lb_Ngay") as Label;

            lb_ngay.Text = ngay.ToString("dd/MM/yyyy");
            ddl_TrangThai.DataSource = dataTrangThai();
            ddl_TrangThai.DataTextField = "TrangThai";
            ddl_TrangThai.DataValueField = "Id";
            ddl_TrangThai.DataBind();

            ddl_phiShip.DataSource = TaoDataPhiShip();
            ddl_phiShip.DataTextField = "TenPhiShip";
            ddl_phiShip.DataValueField = "IdPhiShip";
            ddl_phiShip.DataBind();
            ddl_phiShip.Items[0].Attributes.Add("hidden","hidden");
            ddl_phiShip.SelectedValue = (e.Item.DataItem as DataRowView)["IdPhiShip"].ToString();

            string trangthai = (e.Item.DataItem as DataRowView)["TrangThai"].ToString();
            ddl_TrangThai.SelectedValue = trangthai;
            if (trangthai == "0")
            {
                ddl_TrangThai.Enabled = false;
                ddl_phiShip.Enabled = false;
            }
            if (trangthai == "1")
            {
                ddl_TrangThai.Enabled = false;
                ddl_phiShip.Enabled = false;
            }

            if (trangthai == "2")
            {
                ddl_TrangThai.Items[0].Attributes.Add("hidden", "hidden");
                ddl_TrangThai.Items[2].Attributes.Add("hidden", "hidden");
                ddl_TrangThai.Items[3].Attributes.Add("hidden", "hidden");
                ddl_phiShip.Enabled = false;
            }
            if (trangthai == "4")
            {
                ddl_TrangThai.Items[1].Attributes.Add("hidden", "hidden");
                ddl_TrangThai.Items[3].Attributes.Add("hidden", "hidden");
            }

            if (ddl_phiShip.SelectedIndex == 0)
            {
                ddl_TrangThai.Enabled = false;
            }


            AddMauDropDownList(trangthai, ddl_TrangThai);


            rpt_CTHD.DataSource = GetChiTietHDTheoIdHoaDon(idhoadon);
            rpt_CTHD.DataBind();
        }

    }

    void AddMauDropDownList(string trangthai, DropDownList selectList)
    {
        if (trangthai == "0")
        {
            selectList.Attributes["style"] = "color:red";
        }
        else
        {
            if (trangthai == "1")
            {
                selectList.Attributes.Add("style", "color:green");
            }
            else
            {
                if (trangthai == "2")
                {
                    selectList.Attributes["style"] = "color:#9999FF";
                }
                else
                {
                    selectList.Attributes["style"] = "color:orange";
                }
            }
        }


        foreach (ListItem li in selectList.Items)
        {
            if (li.Value == "0")
            {
                li.Attributes["style"] = "color:red";
            }
            else
            {
                if (li.Value == "1")
                {
                    li.Attributes.Add("style", "color: green");
                }
                else
                {
                    if (li.Value == "2")
                    {
                        li.Attributes["style"] = "color:#9999FF";
                    }
                    else
                    {
                        li.Attributes["style"] = "color:orange";
                    }
                }
            }
        }
    }

    protected void btn_hienThi_Click(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        bool kiemtra = item.FindControl("td_ChiTietHD").Visible;
        if (kiemtra){
            item.FindControl("td_ChiTietHD").Visible = false;
        }
        else
        {
            item.FindControl("td_ChiTietHD").Visible = true;
        }
    }

    void UpdateTrangThai(string idHoaDon,string trangThai)
    {
        SqlParameter[] p ={
            new SqlParameter("@idhoadon",SqlDbType.NVarChar,10),
            new SqlParameter("@trangthai",SqlDbType.NVarChar,3)

        };
        p[0].Value = idHoaDon;
        p[1].Value = trangThai;
        DB.ExecuteNonQuery("UpdateTrangThaiDonHang", p);
    }

    protected void ddl_TrangThai_SelectedIndexChanged(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as DropDownList).NamingContainer as RepeaterItem;
        string idHoaDon = (item.FindControl("lb_IdHoaDon") as Label).Text;

        string trangThai = (sender as DropDownList).SelectedValue;
        UpdateTrangThai(idHoaDon, trangThai);
        doDuLieu("");
    }

    protected void btn_DonHangMoi_Click(object sender, EventArgs e)
    {
        doDuLieu("4");
    }

    protected void btn_DangGiao_Click(object sender, EventArgs e)
    {
        doDuLieu("2");
    }

    protected void btn_DaGiao_Click(object sender, EventArgs e)
    {
        doDuLieu("1");
    }

    protected void btn_DaHuy_Click(object sender, EventArgs e)
    {
        doDuLieu("0");
    }

    void UpdatePhiShip(string idHoaDon,string idPhiShip)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdHoaDon",SqlDbType.NVarChar,10),
            new SqlParameter("@IdPhiShip",SqlDbType.NVarChar,10)
        };
        p[0].Value = idHoaDon;
        p[1].Value = idPhiShip;
        DB.ExecuteNonQuery("updatePhiShip", p);
    }


    protected void ddl_phiShip_SelectedIndexChanged(object sender, EventArgs e)
    {

        RepeaterItem item = (sender as DropDownList).NamingContainer as RepeaterItem;
        DropDownList ddl_trangThai = item.FindControl("ddl_TrangThai") as DropDownList;
        string idHoaDon = (item.FindControl("lb_IdHoaDon") as Label).Text;

        string idPhiShip = (sender as DropDownList).SelectedValue;
        UpdatePhiShip(idHoaDon, idPhiShip);
        ddl_trangThai.Enabled = true;
        doDuLieu("");

        

    }

    int BaoCaoTaiKHoan(string idTaiKhoan)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = idTaiKhoan;
        return DB.ExecuteNonQuery("ToCaoTaiKhoan", p);
    }


    protected void btnBaoCao_Click(object sender, EventArgs e)
    {
        string idTaiKhoan = (sender as Button).CommandArgument;
        try
        {
            int ketqua = BaoCaoTaiKHoan(idTaiKhoan);
            if (ketqua > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Báo Cáo Thành Công')", true);
            }
        }
        catch
        {

        }
    }
    int deleteHoaDon(string idHoaDon)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idHD",SqlDbType.NVarChar,10)
        };
        p[0].Value = idHoaDon;

        return DB.ExecuteNonQuery("DeleteHoaDon", p);
    }


    protected void btn_Xoa_HD_Click(object sender, EventArgs e)
    {
        try
        {
            int ketQua = deleteHoaDon((sender as Button).CommandArgument);
            if (ketQua > 0)
            {
                doDuLieu("");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Xóa Thành Công')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Xóa Thất Bại')", true);
            }
        }
        catch
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Lỗi Không Xác Định')", true);
        }


    }
}