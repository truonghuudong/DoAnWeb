using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_QuanLyShip_QuanLyShip : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadDuLieuRepeater();
        }
    }

    void LoadDuLieuRepeater()
    {
        rpt_phiShip.DataSource = GetPhiShip();
        rpt_phiShip.DataBind();
    }

    DataTable GetPhiShip()
    {
        SqlParameter[] p = { };
        return DB.ExecuteQuery("getPhiShip", p);
    }


    protected void rpt_phiShip_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

    }

    DataRow GetPhiShipTheoId(string idphiship)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdPhiShip",SqlDbType.NVarChar,10)
        };
        p[0].Value = idphiship;
        return DB.ExecuteQuery("GetPhiShipTheoId", p).Rows[0];
    }

    protected void btn_sua_ctphiship_Click(object sender, EventArgs e)
    {
        visibleOfControlForm(true);
        btn_thue_Them_form.Visible = true;
        lb_thongbao_form.Visible = false;
        form_thue.Visible = true;
        lb_title.Text = "Sửa Thông Tin Phí Ship";


        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        string idThue = (item.FindControl("lb_IdPhiShip") as Label).Text;
        DataRow row = GetPhiShipTheoId(idThue);

        lb_IdThue.Text = idThue;
        txt_TenThue.Text = row[1].ToString();
        txt_TyLeThue.Text = row[2].ToString();


        btn_thue_Them_form.Text = "Sửa";
    }

    protected void btn_xoa_ctphiship_Click(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        string idThue = (item.FindControl("lb_IdPhiShip") as Label).Text;
        btn_thue_Them_form.Visible = true;

        lb_IdThue.Text = idThue;
        lb_thongbao_form.Visible = false;
        form_thue.Visible = true;
        lb_title.Text = "Bạn Có Chắc Muốn Xóa Không";
        visibleOfControlForm(false);
        btn_thue_Them_form.Text = "Có";
    }

    protected void ibtn_themPhiShip_Click(object sender, ImageClickEventArgs e)
    {
        visibleOfControlForm(true);
        form_thue.Visible = true;
        btn_thue_Them_form.Visible = true;

        lb_title.Text = "Thêm Phí Ship Mới";

        txt_TenThue.Text = "";
        txt_TyLeThue.Text = "";

        btn_thue_Them_form.Text = "Thêm";
        lb_thongbao_form.Visible = false;
    }
    void visibleOfControlForm(bool thuocTinh)
    {
        txt_TenThue.Visible = thuocTinh;
        txt_TyLeThue.Visible = thuocTinh;
    }

    protected void btn_xoa_ctthue_Click(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        string idThue = (item.FindControl("lb_IdThue") as Label).Text;
        btn_thue_Them_form.Visible = true;

        lb_IdThue.Text = idThue;
        lb_thongbao_form.Visible = false;
        form_thue.Visible = true;
        lb_title.Text = "Bạn Có Chắc Muốn Xóa Không";
        visibleOfControlForm(false);
        btn_thue_Them_form.Text = "Có";
    }



    protected void btn_thue_Thoat_Click(object sender, EventArgs e)
    {
        form_thue.Visible = false;
    }


    int InsertPhiShip(string khuVuc, string gia)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@khuVuc",SqlDbType.NVarChar,200),
            new SqlParameter("@gia",SqlDbType.NVarChar,10),
        };
        p[0].Value = khuVuc;
        p[1].Value = gia;
        return DB.ExecuteNonQuery("SetPhiShip", p);
    }

    void ThemPhiShip()
    {
        string tenThue = txt_TenThue.Text;
        string tyLeThue = txt_TyLeThue.Text;
        if (tenThue == "" || tyLeThue == "")
        {
            lb_thongbao_form.Visible = true;
            lb_thongbao_form.Text = "Vui lòng nhập đầy đủ thông tin";
        }
        else
        {
            try
            {
                if (InsertPhiShip(tenThue, tyLeThue) > 0)
                {
                    lb_thongbao_form.Visible = true;
                    LoadDuLieuRepeater();
                    lb_thongbao_form.Text = "Thêm Thành Công";
                }
                else
                {
                    lb_thongbao_form.Visible = true;
                    lb_thongbao_form.Text = "Thêm Thất Bại";
                }
            }
            catch
            {
                lb_thongbao_form.Visible = true;
                lb_thongbao_form.Text = "Lỗi Không Xác Định";
            }
        }
    }
    //Thêm Thuế Mới

    //Sửa Thông Tin Thuế
    int UpdatePhiShip(string idPhiShip, string khuVuc, string gia)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idPhiShip",SqlDbType.NVarChar,10),
            new SqlParameter("@khuVuc",SqlDbType.NVarChar,200),
            new SqlParameter("@gia",SqlDbType.NVarChar,10),

        };
        p[0].Value = idPhiShip;
        p[1].Value = khuVuc;
        p[2].Value = gia;

        return DB.ExecuteNonQuery("UpdatePhiShipTheoId", p);
    }

    void SuaPhiShip()
    {
        string tenThue = txt_TenThue.Text;
        string tyLeThue = txt_TyLeThue.Text;
        string idThue = lb_IdThue.Text;
        if (tenThue == "" || tyLeThue == "")
        {
            lb_thongbao_form.Visible = true;
            lb_thongbao_form.Text = "Vui lòng nhập đầy đủ thông tin";
        }
        else
        {
            try
            {
                if (UpdatePhiShip(idThue, tenThue, tyLeThue) > 0)
                {
                    lb_thongbao_form.Visible = true;
                    LoadDuLieuRepeater();
                    lb_thongbao_form.Text = "Sửa Thành Công";
                }
                else
                {
                    lb_thongbao_form.Visible = true;
                    lb_thongbao_form.Text = "Sửa Thất Bại";
                }
            }
            catch
            {
                lb_thongbao_form.Visible = true;
                lb_thongbao_form.Text = "Lỗi Không Xác Định";
            }
        }
    }
    //Sửa Thông Tin Thuế

    //Xóa Thuế
    int DeletePhiShip(string idThue)
    {
        SqlParameter[] p =
       {
            new SqlParameter("@idPhiShip",SqlDbType.NVarChar,10),
        };
        p[0].Value = idThue;
        return DB.ExecuteNonQuery("DeletePhiShip", p);
    }

    void XoaPhiShip()
    {
        string idThue = lb_IdThue.Text;
        try
        {
            if (DeletePhiShip(idThue) > 0)
            {
                lb_thongbao_form.Visible = true;
                LoadDuLieuRepeater();
                lb_thongbao_form.Text = "Xóa Thành Công";
                btn_thue_Them_form.Visible = false;
            }
            else
            {
                lb_thongbao_form.Visible = true;
                lb_thongbao_form.Text = "Xóa Thất Bại";
            }
        }
        catch
        {
            lb_thongbao_form.Visible = true;
            lb_thongbao_form.Text = "Lỗi Không Xác Định";
        }
    }



    protected void btn_thue_Them_form_Click(object sender, EventArgs e)
    {
        if (btn_thue_Them_form.Text.Equals("Thêm"))
        {
            //Thêm
            ThemPhiShip();
        }
        else
        {
            if (btn_thue_Them_form.Text.Equals("Sửa"))
            {
                //Sửa
                SuaPhiShip();
            }
            else
            {
                if (btn_thue_Them_form.Text.Equals("Có"))
                {
                    //Xóa
                    XoaPhiShip();
                }
            }
        }
    }
}