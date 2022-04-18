using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_QuanLyKhuyenMai_ThemKhuyenMai : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txt_TuNgay.Attributes.Add("onclick", "txt_TuNgayClick()");
            txt_DenNgay.Attributes.Add("onclick", "txt_DenNgayClick()");
            ThongTinKhuyenMai();
        }
    }
    
    void ThongTinKhuyenMai()
    {
        rpt_khuyenmai.DataSource = GetKhuyenMai();
        rpt_khuyenmai.DataBind();
    }

    int GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id;
    }

   DataTable GetKhuyenMai()
    {
        SqlParameter[] p =
        {
           new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = GetIdTaiKhoanTuSession();
        return DB.ExecuteQuery("GetKhuyenMai", p);
    }

    protected void rpt_khuyenmai_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            CheckBox cb_trangthai = (e.Item.FindControl("cb_TrangThai") as CheckBox);


            //lấy trậng thái hiện tại của loaisp
            string trangthai = (e.Item.DataItem as DataRowView)["TrangThai"].ToString();
            bool trangthaibool = false;
                if (trangthai == "1")
                {
                trangthaibool = true;
                }

            cb_trangthai.Checked = trangthaibool;
        }
    }

    protected void ibtn_TuNgay_Click(object sender, ImageClickEventArgs e)
    {
        cl_TuNgay.Visible = true;
    }

    protected void ibtn_DenNgay_Click(object sender, ImageClickEventArgs e)
    {
        cl_DenNgay.Visible = true;
    }

    int InsererKhuyenMai(string idtaikhoan,DateTime ngaybatdauKM,DateTime ngayketthucKM)
    {
        SqlParameter[] quara = {
            new SqlParameter("@ngaybatdau",SqlDbType.NVarChar,12),
            new SqlParameter("@ngayketthuc",SqlDbType.NVarChar,12),
            new SqlParameter("@idtaikhoan",SqlDbType.NVarChar,10),
        };
        quara[0].Value = ngaybatdauKM.ToString("dd/MM/yyyy");
        quara[1].Value = ngayketthucKM.ToString("dd/MM/yyyy");
        quara[2].Value = idtaikhoan;
        return DB.ExecuteNonQuery("InsertKhuyenMai",quara);
    }
    protected void btn_them_KM_Click(object sender, EventArgs e)
    {
        string tungay = txt_TuNgay.Text;
        string denngay = txt_DenNgay.Text;
        lb_thongbao_capnhat.Visible = true;
        if (!tungay.Equals("") && !denngay.Equals(""))
        {
            try
            {
                int ketqua = 0;
                ketqua = InsererKhuyenMai(GetIdTaiKhoanTuSession().ToString(), cl_TuNgay.SelectedDate, cl_DenNgay.SelectedDate);
                if (ketqua > 0)
                {
                    lb_thongbao_capnhat.Text = "Thêm thành công";
                    ThongTinKhuyenMai();
                }
                else
                {
                    lb_thongbao_capnhat.Text = "Thêm thất bại";
                }
            }catch{
                lb_thongbao_capnhat.Text = "Thêm thất bại";
            }
        }
    }


    int UpdateKhuyenMai(string idkhuyenmai, DateTime ngaybatdauKM, DateTime ngayketthucKM)
    {
        SqlParameter[] quara = {
            new SqlParameter("@ngaybatdau",SqlDbType.NVarChar,12),
            new SqlParameter("@ngayketthuc",SqlDbType.NVarChar,12),
            new SqlParameter("@idkhuyenmai",SqlDbType.NVarChar,10),
        };
        quara[0].Value = ngaybatdauKM.ToString("dd/MM/yyyy");
        quara[1].Value = ngayketthucKM.ToString("dd/MM/yyyy");
        quara[2].Value = idkhuyenmai;

        return DB.ExecuteNonQuery("UpdateKhuyenMai", quara);

    }
    protected void btn_sua_KM_Click(object sender, EventArgs e)
    {
        lb_thongbao_capnhat.Visible = true;
        if (!txt_TuNgay.Text.Equals("") && !txt_DenNgay.Text.Equals(""))
        {
            try
            {
                int ketqua = 0;
                ketqua = UpdateKhuyenMai(lb_IdKM.Text,cl_TuNgay.SelectedDate, cl_DenNgay.SelectedDate);
                if (ketqua > 0)
                {
                    lb_thongbao_capnhat.Text = "Sửa thành công";
                    ThongTinKhuyenMai();
                }
                else
                {
                    lb_thongbao_capnhat.Text = "Sửa thất bại";
                }
            }
            catch
            {
                lb_thongbao_capnhat.Text = "Sửa thất bại";
            }
        }
    }





    protected void btn_sua_Click(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        string idKhuyenMai = (sender as Button).CommandArgument;
        lb_IdKM.Text = idKhuyenMai;
        txt_TuNgay.Text = (item.FindControl("lb_NgayBatDau_rpt") as Label).Text;
        txt_DenNgay.Text = (item.FindControl("lb_NgayKetThuc_rpt") as Label).Text;
    }

    protected void cl_TuNgay_SelectionChanged(object sender, EventArgs e)
    {
        txt_TuNgay.Text = cl_TuNgay.SelectedDate.ToString("dd/MM/yyyy");
        cl_TuNgay.Visible = false;
    }

    protected void cl_DenNgay_SelectionChanged(object sender, EventArgs e)
    {
        try
        {
            if (cl_DenNgay.SelectedDate > cl_TuNgay.SelectedDate)
            {
                txt_DenNgay.Text = cl_DenNgay.SelectedDate.ToString("dd/MM/yyyy");
            }
            else
            {
            }
            cl_DenNgay.Visible = false;
        }
        catch
        {

        }
    }


    protected void btn_xoa_Click(object sender, EventArgs e)
    {
        string idKhuyenMai = (sender as Button).CommandArgument;
        try
        {
            if (deletekhuyenmai(idKhuyenMai) > 0)
            {
                lb_thongbao_capnhat.Text = "Xóa thành công";
                ThongTinKhuyenMai();
            }
            else
            {
                lb_thongbao_capnhat.Text = "Xóa thất bại";
            }
        }
        catch
        {
            lb_thongbao_capnhat.Text = "Xóa thất bại";
        }
    }
    int deletekhuyenmai(string idkhuyenmai)
    {
        SqlParameter[] quara = {
            
            new SqlParameter("@idkhuyenmai",SqlDbType.NVarChar,10),
        };
        quara[0].Value = idkhuyenmai;
        

        return DB.ExecuteNonQuery("deleteKhuyenMai", quara);
    }

    protected void bnt_ThemSP_KM_Click(object sender, EventArgs e)
    {
        string idKhuyenMai = (sender as Button).CommandArgument;
        Response.Redirect("ChiTietKhuyenMai.aspx?IdKM="+ idKhuyenMai);
    }




    

    void UpdateTrangThaiKM(string idKM, string trangthai)
    {
        SqlParameter[] p =
                   {
                    new SqlParameter ("@idkhuyenmai",System.Data.SqlDbType.NVarChar,10),
                    new SqlParameter ("@trangthai",System.Data.SqlDbType.NVarChar,3)
                };
        p[0].Value = idKM;
        p[1].Value = trangthai;
        DB.ExecuteNonQuery("UpdateTrangThaiKhuyenMai", p);
    }


    protected void cb_TrangThai_CheckedChanged(object sender, EventArgs e)
    {
        //txt_ngaybatdau.Text = "Hello";
        RepeaterItem item = (sender as CheckBox).NamingContainer as RepeaterItem;
        string idKhuyenMai = (item.FindControl("lb_IdKhuyenMai_rpt") as Label).Text;
        bool trangthai = (item.FindControl("cb_TrangThai") as CheckBox).Checked;
        if (trangthai == true)
        {
            UpdateTrangThaiKM(idKhuyenMai, "1");
        }
        else
        {
            UpdateTrangThaiKM(idKhuyenMai, "0");
        }
    }

    protected void btn_ThemSP_KM_Click(object sender, EventArgs e)
    {
        string idKhuyenMai = (sender as Button).CommandArgument;
        Response.Redirect("XemSanPhamKM.aspx?IdKM=" + idKhuyenMai);
    }
}