using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_User_HoSoTaiKhoan_DonMua : System.Web.UI.Page
{
    //trạng thái hóa đơn: 0:đã bị hủy, 1:đã giao - đã thanh toán, 2:đang giao, 3:hoàn trả, 4:Đang Chờ Duyệt
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            doDuLieu("");
            form_muahang.Attributes.Add("onclick", "form_Click()");
        }
    }


    //tạo data trạng thái
    DataTable dataTrangThai()
    {
        DataTable table = new DataTable();
        table.Columns.Add("Id", typeof(string));
        table.Columns.Add("TrangThai", typeof(string));
        table.Rows.Add("0", "Hủy");
        table.Rows.Add("1", "Đã nhận");
        table.Rows.Add("2", "Đang giao");
        table.Rows.Add("4", "Chờ Duyệt");
        return table;
    }

    void doDuLieu(string trangthai)
    {
        rpt_HoaDon.DataSource = GetTatCaHoaDonTheoIdNguoiMua(trangthai);
        rpt_HoaDon.DataBind();
    }


    string GetIdTaiKhoan()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id + "";
    }

    DataTable GetTatCaHoaDonTheoIdNguoiMua(string trangThai)
    {
        SqlParameter[] p ={
            new SqlParameter("@idnguoimua",SqlDbType.NVarChar,10),
            new SqlParameter("@trangthai",SqlDbType.NVarChar,3)
        };
        p[0].Value = GetIdTaiKhoan();
        p[1].Value = trangThai;
        return DB.ExecuteQuery("GetHoaDonTheoIdNguoiMua", p);
    }
    DataTable GetChiTietHDTheoIdHoaDon(string idhoadon)
    {
        SqlParameter[] p ={
            new SqlParameter("@idhoadon",SqlDbType.NVarChar,10)

        };
        p[0].Value = idhoadon;
        return DB.ExecuteQuery("GetHoaDonTheoIdHoaDon", p);
    }

    DataTable dataphiShip()
    {
        SqlParameter[] p = { };
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

        foreach (DataRow row in dataphiShip().Rows)
        {
            table.Rows.Add(row["IdPhiShip"].ToString(), row["KhuVuc"].ToString() + ":" + row["Gia"].ToString());
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
            DropDownList ddl_phiShip = e.Item.FindControl("ddl_PhiShip") as DropDownList;
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
            ddl_phiShip.SelectedValue = (e.Item.DataItem as DataRowView)["IdPhiShip"].ToString();

            string trangthai = (e.Item.DataItem as DataRowView)["TrangThai"].ToString();
            ddl_TrangThai.SelectedValue = trangthai;
            if (trangthai == "2" || trangthai == "1" ||trangthai=="0")
            {
                ddl_TrangThai.Enabled = false;
            }
            if (trangthai=="4")
            {
                ddl_TrangThai.Items[1].Attributes.Add("hidden", "hidden");
                ddl_TrangThai.Items[2].Attributes.Add("hidden", "hidden");
                ddl_TrangThai.Items[3].Attributes.Add("hidden", "hidden");
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
        if (kiemtra)
        {
            item.FindControl("td_ChiTietHD").Visible = false;
        }
        else
        {
            item.FindControl("td_ChiTietHD").Visible = true;
        }
    }

    void UpdateTrangThai(string idHoaDon, string trangThai)
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
        if(trangThai!="1" && trangThai != "2")
        {
            UpdateTrangThai(idHoaDon, trangThai);
            doDuLieu("");
        }
        else
        {
            form_muahang.Visible = true;
            
        }
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


    protected void btn_thoat_form_Click1(object sender, EventArgs e)
    {
        form_muahang.Visible = false;
        doDuLieu("");
    }

    protected void lbtn_sp_Click(object sender, EventArgs e)
    {
        RepeaterItem item = ((sender as LinkButton).NamingContainer as RepeaterItem);
        string idsp = (item.FindControl("lb_IdSP") as Label).Text;

        Response.Redirect("BinhLuan.aspx?IdSP="+idsp);
    }

    protected void rpt_ChiTietHoaDon_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            RepeaterItem item = e.Item.NamingContainer.NamingContainer as RepeaterItem;
            DropDownList ddl = item.FindControl("ddl_TrangThai") as DropDownList;
            if (ddl.SelectedValue == "1")
            {
                (e.Item.FindControl("lbtn_sp") as LinkButton).Enabled = true;
            }
        }
    }
}