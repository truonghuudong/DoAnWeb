using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Admin_QuanLyThue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadDuLieuRepeater();

            txt_TuNgay.Attributes.Add("onclick", "txt_TuNgayClick()");
            txt_DenNgay.Attributes.Add("onclick", "txt_DenNgayClick()");
        }
    }

    void LoadDuLieuRepeater()
    {
        rpt_thue.DataSource = GetThue();
        rpt_thue.DataBind();
    }


    DataTable GetThue()
    {
        SqlParameter[] p = { };
        return DB.ExecuteQuery("GetThue", p);
    }

    DataRow GetThueTheoId(string idThue)
    {
        SqlParameter[] p = {
            new SqlParameter("@idThue",SqlDbType.NVarChar,10)
        };
        p[0].Value = idThue;
        return DB.ExecuteQuery("GetThueTheoId", p).Rows[0];
    }

    //Thêm Thuế Mới
    int  InsertThue(string tenThue,string tyLeThue,DateTime tuNgay,DateTime denNgay)
    {
        SqlParameter[] p = 
        {
            new SqlParameter("@tenThue",SqlDbType.NVarChar,200),
            new SqlParameter("@tyLeThue",SqlDbType.NVarChar,10),
            new SqlParameter("@tungay",SqlDbType.NVarChar,10),
            new SqlParameter("@denNgay",SqlDbType.NVarChar,10)
        };
        p[0].Value = tenThue;
        p[1].Value = tyLeThue;
        p[2].Value = tuNgay.ToString("MM/dd/yyyy");
        p[3].Value = denNgay.ToString("MM/dd/yyyy");
        return DB.ExecuteNonQuery("SetThue", p);
    }

    void ThemThue()
    {
        string tenThue = txt_TenThue.Text;
        string tyLeThue = txt_TyLeThue.Text;
        DateTime tuNgay = cl_TuNgay.SelectedDate;
        DateTime denNgay = cl_DenNgay.SelectedDate;
        if (tenThue==""||tyLeThue==""||tuNgay==null||denNgay==null)
        {
            lb_thongbao_form.Visible = true;
            lb_thongbao_form.Text = "Vui lòng nhập đầy đủ thông tin";
        }
        else
        {
            try
            {
                if (InsertThue(tenThue, tyLeThue, tuNgay, denNgay) > 0)
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
    int UpdateThue(string idThue,string tenThue, string tyLeThue, DateTime tuNgay, DateTime denNgay)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idThue",SqlDbType.NVarChar,10),
            new SqlParameter("@tenThue",SqlDbType.NVarChar,200),
            new SqlParameter("@tyLeThue",SqlDbType.NVarChar,10),
            new SqlParameter("@tungay",SqlDbType.NVarChar,10),
            new SqlParameter("@denNgay",SqlDbType.NVarChar,10)
        };
        p[0].Value = idThue;
        p[1].Value = tenThue;
        p[2].Value = tyLeThue;
        p[3].Value = tuNgay.ToString("MM/dd/yyyy");
        p[4].Value = denNgay.ToString("MM/dd/yyyy");
        return DB.ExecuteNonQuery("UpdateThueTheoId", p);
    }

    void SuaThue()
    {
        string tenThue = txt_TenThue.Text;
        string tyLeThue = txt_TyLeThue.Text;
        DateTime tuNgay = cl_TuNgay.SelectedDate;
        DateTime denNgay = cl_DenNgay.SelectedDate;
        string idThue = lb_IdThue.Text;
        if (tenThue == "" || tyLeThue == "" || tuNgay == null || denNgay == null)
        {
            lb_thongbao_form.Visible = true;
            lb_thongbao_form.Text = "Vui lòng nhập đầy đủ thông tin";
        }
        else
        {
            try
            {
                if (UpdateThue(idThue,tenThue, tyLeThue, tuNgay, denNgay) > 0)
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
    int DeleteThue(string idThue)
    {
        SqlParameter[] p =
       {
            new SqlParameter("@idThue",SqlDbType.NVarChar,10),
        };
        p[0].Value =idThue;
        return DB.ExecuteNonQuery("DeleteThueTheoId", p);
    }

    void XoaThue()
    {
        string idThue = lb_IdThue.Text;
            try
            {
                if (DeleteThue(idThue) > 0)
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


    //Xóa Thuế

    protected void rpt_thue_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lb_TuNgay = (e.Item.FindControl("lb_TuNgay") as Label);
            Label lb_DenNgay = (e.Item.FindControl("lb_DenNgay") as Label);

            DateTime tuNgay = DateTime.Parse((e.Item.DataItem as DataRowView)["TuNgay"].ToString());
            DateTime denNgay = DateTime.Parse((e.Item.DataItem as DataRowView)["DenNgay"].ToString());

            lb_TuNgay.Text = tuNgay.ToString("dd/MM/yyyy");
            lb_DenNgay.Text = denNgay.ToString("dd/MM/yyyy");

        }
    }

    protected void ibtn_themThue_Click(object sender, ImageClickEventArgs e)
    {
        visibleOfControlForm(true);
        form_thue.Visible = true;
        btn_thue_Them_form.Visible = true;

        lb_title.Text = "Thêm Mới Thuế";

        txt_TenThue.Text = "";
        txt_TyLeThue.Text = "";
        txt_TuNgay.Text = "";
        txt_DenNgay.Text = "";

        btn_thue_Them_form.Text = "Thêm";
        lb_thongbao_form.Visible = false;
    }

    protected void btn_sua_ctthue_Click(object sender, EventArgs e)
    {
        visibleOfControlForm(true);
        btn_thue_Them_form.Visible = true;
        lb_thongbao_form.Visible = false;
        form_thue.Visible = true;
        lb_title.Text = "Sửa Thông Tin Thuế";


        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        string idThue = (item.FindControl("lb_IdThue") as Label).Text;
        DataRow row = GetThueTheoId(idThue);



        lb_IdThue.Text = idThue;
        txt_TenThue.Text = row[1].ToString();
        txt_TyLeThue.Text = row[2].ToString();
        DateTime tuNgay = DateTime.Parse(row[3].ToString());
        DateTime denNgay = DateTime.Parse(row[4].ToString());
        txt_TuNgay.Text = tuNgay.ToString("dd/MM/yyyy");
        txt_DenNgay.Text = denNgay.ToString("dd/MM/yyyy");

        cl_TuNgay.SelectedDate = tuNgay;
        cl_DenNgay.SelectedDate = denNgay;

       
        btn_thue_Them_form.Text = "Sửa";
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

    void visibleOfControlForm(bool thuocTinh)
    {
        txt_TuNgay.Visible = thuocTinh;
        txt_DenNgay.Visible = thuocTinh;
        txt_TenThue.Visible = thuocTinh;
        txt_TyLeThue.Visible = thuocTinh;
    }




    protected void btn_thue_Thoat_Click(object sender, EventArgs e)
    {
        form_thue.Visible = false;
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
    }

    protected void cl_DenNgay_SelectionChanged(object sender, EventArgs e)
    {
        txt_DenNgay.Text = cl_DenNgay.SelectedDate.ToString("dd/MM/yyyy");
        cl_DenNgay.Visible = false;
    }

    protected void btn_thue_Them_form_Click(object sender, EventArgs e)
    {
        if (btn_thue_Them_form.Text.Equals("Thêm"))
        {
            //Thêm
            ThemThue();
        }
        else
        {
            if (btn_thue_Them_form.Text.Equals("Sửa"))
            {
                //Sửa
                SuaThue();
            }
            else
            {
                if(btn_thue_Them_form.Text.Equals("Có"))
                {
                    //Xóa
                    XoaThue();
                }
            }
        }
    }
}