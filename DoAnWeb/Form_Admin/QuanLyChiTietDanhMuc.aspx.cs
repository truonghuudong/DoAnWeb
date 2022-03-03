using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Admin_QuanLyChiTietDanhMuc : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                form_chitietdanhmuc_capnhat.Visible = false;
                HienThi();
            }
            catch
            {

            }
        }
    }


    //đỗ dữ liệu vào repeater
    private void HienThi()
    {
        int idDanhMuc = int.Parse(Request.QueryString.Get("IdDanhMuc").ToString());
        rpt_chitietdanhmuc.DataSource = GetLoaiSP(idDanhMuc);
        rpt_chitietdanhmuc.DataBind();
    }


    //lấy danh sách loaisp
    private DataTable GetLoaiSP(int idDanhMuc)
    {
        SqlParameter[] p =
        {
            new SqlParameter ("@IdDanhMuc",SqlDbType.Int)
        };
        p[0].Value = idDanhMuc;
        return DB.ExecuteQuery("GetLoaiSPTheoDanhMuc",p);
    }

    //tạo data trạng thái
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


    protected void rpt_chitietdanhmuc_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            //DropDownList ddlCountries = (e.Item.FindControl("ddlCountries") as DropDownList);
            DropDownList selectList = (e.Item.FindControl("ddl_trangthai_ctdm") as DropDownList);

            //đô dữ liệu vào dropdownlist
            selectList.DataSource = dataTrangThai();
            selectList.DataTextField = "TrangThai";
            selectList.DataValueField = "Id";
            selectList.DataBind();

            //lấy trậng thái hiện tại của loaisp
            string trangthai = (e.Item.DataItem as DataRowView)["TrangThai"].ToString();

            //chọn trạng thái hiện tại của sản phẩm
            selectList.SelectedValue = trangthai;

            //them mau cho dropdownlist
            AddMauDropDownList(trangthai, selectList);

        }
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

    //dropdownlist thay đổi
    protected void ddl_trangthai_ctdm_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Reference the Repeater Item using Button.
        RepeaterItem item = (sender as DropDownList).NamingContainer as RepeaterItem;

        string idloaisp = (item.FindControl("lb_IdLoaiSP") as Label).Text;
        string trangthai = (item.FindControl("ddl_trangthai_ctdm") as DropDownList).SelectedValue.ToString();
        try
        {
            updateTrangThai(idloaisp, trangthai);
        }
        catch
        {
        }
        HienThi();
    }


    protected void btn_sua_ctdm_Click(object sender, EventArgs e)
    {

        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        string idloaisp = (item.FindControl("lb_IdLoaiSP") as Label).Text;
        string tenloaisp = (item.FindControl("lb_tenLoaiSP") as Label).Text;

        btn_form_them.Visible = true;
        form_chitietdanhmuc_capnhat.Visible = true;
        lb__form_thongbao.Visible = false;
        lb_title_form.Text = "Sửa Chi Tiết Danh Mục";
        btn_form_them.Text = "Sửa";
        btn_form_thoat.Text = "Thoát";
        lb__form_idchitietdanhmuc.Text = idloaisp;
        txt_TenChiTietDanhMuc.Text = tenloaisp;
    }

    //sự kiện button xóa trong repeater được click
    protected void btn_xoa_ctdm_Click(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        string idloaisp = (item.FindControl("lb_IdLoaiSP") as Label).Text;
        string tenloaisp = (item.FindControl("lb_tenLoaiSP") as Label).Text;

        form_chitietdanhmuc_capnhat.Visible = true;
        lb__form_thongbao.Visible = false;
        lb_title_form.Text = "Bạn có muốn xóa không";
        btn_form_them.Text = "Có";
        btn_form_thoat.Text = "Không";
        btn_form_them.Visible = true;
        lb__form_idchitietdanhmuc.Text = idloaisp;
        txt_TenChiTietDanhMuc.Text = tenloaisp;
    }

    //sự kiện button Add được click
    protected void ibtn_themdanhmuc_Click(object sender, ImageClickEventArgs e)
    {
        lb_title_form.Text = "Thêm Chi Tiết Danh Mục"; // thay đổi tile form
        form_chitietdanhmuc_capnhat.Visible = true; //hiên thị
        lb__form_thongbao.Visible = false; //tắt label thông báo

        btn_form_them.Text = "Thêm";
        btn_form_thoat.Text = "Thoát";
        txt_TenChiTietDanhMuc.Text = "";
        btn_form_them.Visible = true;
    }



    //button thoát trong form cập nhật chi tiết danh mục
    protected void btn_form_thoat_Click(object sender, EventArgs e)
    {
        form_chitietdanhmuc_capnhat.Visible = false;
        HienThi();
    }

    //button thêm trong form
    protected void btn_form_them_Click(object sender, EventArgs e)
    {
        try
        {
            if (!txt_TenChiTietDanhMuc.Text.Equals(""))
            {
                string title_form = lb_title_form.Text;
                if (title_form.Equals("Thêm Chi Tiết Danh Mục"))
                {
                    // thêm chi tiết danh mục
                    ThemChiTietDanhMuc(txt_TenChiTietDanhMuc.Text);
                }
                else
                {
                    if (title_form.Equals("Sửa Chi Tiết Danh Mục"))
                    {
                        //sửa chi tiết danh mục
                        ChinhSuaTenChiTietDanhMuc(lb__form_idchitietdanhmuc.Text,txt_TenChiTietDanhMuc.Text);
                    
                    }
                    else
                    {
                        //xóa chi tiết danh mục
                        XoaChiTietDanhMuc(lb__form_idchitietdanhmuc.Text);
                    }

                }
            }
            else
            {
                lb__form_thongbao.Text = "Vui lòng nhập đầy đủ thông tin";
            }

        }
        catch
        {

        }
        //hiển thị lại repeater
        HienThi();
    }

    //update tên chi tiết danh mục
    int UpdateTenChiTietDanhMuc(string idChiTietDanhMuc,string tenDanhMuc)
    {
        SqlParameter[] p =
               {
                    new SqlParameter ("@idLoaiSP",System.Data.SqlDbType.NVarChar,10),
                    new SqlParameter ("@tenChiTietDanhMuc",System.Data.SqlDbType.NVarChar,200),
                };
        p[0].Value = idChiTietDanhMuc;
        p[1].Value = tenDanhMuc;
        return DB.ExecuteNonQuery("UpdateChiTietDanhMucTheoId", p);
    }

    void ChinhSuaTenChiTietDanhMuc(string idChiTietDanhMuc, string tenChiTietDanhMuc)
    {
        lb__form_thongbao.Visible = true;
        btn_form_them.Visible = false;
        int ketqua = UpdateTenChiTietDanhMuc(idChiTietDanhMuc, tenChiTietDanhMuc);
        if (ketqua > 0)
        {
            lb__form_thongbao.Text = "Sửa thành công";
        }
        else
        {
            lb__form_thongbao.Text = "Sửa thất bại";
        }


    }
    //update tên chi tiết danh mục


    //insert chi tiết danh mục
    int InsertChiTietDanhMuc(string tenDanhMuc)
    {
        string idDanhMuc = Request.QueryString.Get("IdDanhMuc").ToString();

        SqlParameter[] p =
               {
                    new SqlParameter ("@idDanhMuc",System.Data.SqlDbType.NVarChar,10),
                    new SqlParameter ("@tenChiTietDanhMuc",System.Data.SqlDbType.NVarChar,200),
                };
        p[0].Value = idDanhMuc;
        p[1].Value = tenDanhMuc;
        return DB.ExecuteNonQuery("InsertChiTietDanhMucTheoId", p);
    }

    void ThemChiTietDanhMuc(string tenChiTietDanhMuc)
    {
        lb__form_thongbao.Visible = true;
        btn_form_them.Visible = false;
        int ketqua = InsertChiTietDanhMuc(tenChiTietDanhMuc);
        if (ketqua > 0)
        {
            lb__form_thongbao.Text = "Thêm thành công";
        }
        else
        {
            lb__form_thongbao.Text = "Thêm thất bại";
        }
    }
    //insert chi tiết danh mục

    //delete chi tiết danh mục
    int DeleteChiTietDanhMuc(string idChiTietDanhMuc)
    {
        SqlParameter[] p =
               {
                    new SqlParameter ("@idLoaiSP",System.Data.SqlDbType.NVarChar,10),
                };
        p[0].Value = idChiTietDanhMuc;
        return DB.ExecuteNonQuery("DeleteChiTietDanhMuc", p);
    }

    void XoaChiTietDanhMuc(string idChiTietDanhMuc)
    {
        lb__form_thongbao.Visible = true;
        btn_form_them.Visible = false;
        btn_form_thoat.Text = "Thoát";
        int ketqua = DeleteChiTietDanhMuc(idChiTietDanhMuc);
        if (ketqua > 0)
        {
            lb__form_thongbao.Text = "Xóa thành công";
        }
        else
        {
            lb__form_thongbao.Text = "Xóa thất bại";
        }
    }
    //delete chi tiết danh mục
}