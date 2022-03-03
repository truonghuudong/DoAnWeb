using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_User_Default : System.Web.UI.Page
{
    static List<ListSanPhamTheoIdTaiKhoan> list;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //tenshop.Text = "";
            //idsp.Text = "";
            if (Session["GioHang"] == null)
            {

            }
            else
            {
                List<ListSanPhamTheoIdTaiKhoan> danhSachSanPham =
                    (List<ListSanPhamTheoIdTaiKhoan>)Session["GioHang"];
                list = danhSachSanPham;
                DoDuLieu(danhSachSanPham);
            }

            if (Cart() == 0)
            {
                phanthan.Visible = false;
            }
            else
            {
                phanthan.Visible = true;
            }

            TongTienCuaTatCaSanPhamDaChon();
        }

    }

    void DoDuLieu(List<ListSanPhamTheoIdTaiKhoan> listTaiKhoan)
    {
        rpt_Shop.DataSource = listTaiKhoan;
        rpt_Shop.DataBind();
    }


    protected void rpt_Shop_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpt_SanPhamTrongGioHang = (e.Item.FindControl("rpt_SanPhamTrongGioHang") as Repeater);

        foreach (ListSanPhamTheoIdTaiKhoan ls in list)
        {
            if(ls.IdNguoiBan == (e.Item.FindControl("lb_IdNguoiBan") as Label).Text)
            {
                rpt_SanPhamTrongGioHang.DataSource = ls.spTrongGioHang;
                rpt_SanPhamTrongGioHang.DataBind();
            }
        }

    }

    protected void rpt_SanPhamTrongGioHang_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Label tongtien = (e.Item.FindControl("lb_TongTien_rpt") as Label);
        int gia = int.Parse((e.Item.FindControl("lb_giasp_rpt") as Label).Text);
        int soluong = int.Parse((e.Item.FindControl("lb_soluong_rpt") as Label).Text);
        tongtien.Text = (gia * soluong).ToString();
    }

    protected void btn_Xoa_rpt_Click(object sender, EventArgs e)
    {
        string idsp = (sender as Button).CommandArgument;
        foreach (ListSanPhamTheoIdTaiKhoan listSP in list)
        {
            for(int i =0; i < listSP.SpTrongGioHang.Count; i++)
            {
                if(idsp == listSP.SpTrongGioHang[i].IdSP)
                {
                    listSP.SpTrongGioHang.Remove(listSP.SpTrongGioHang[i]);
                    Response.Redirect("~/Form_User/GioHang.aspx");
                }
            }
        }

    }


    int Cart()
    {
        List<ListSanPhamTheoIdTaiKhoan> danhSachSanPham =
                    (List<ListSanPhamTheoIdTaiKhoan>)Session["GioHang"];
        int tong = 0;
        if (danhSachSanPham != null)
        {
            foreach (ListSanPhamTheoIdTaiKhoan list in danhSachSanPham)
            {
                tong += list.spTrongGioHang.Count;
            }
        }
        return tong;
    }


    protected void btn_cong_rpt_Click(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        Label soluongSP = item.FindControl("lb_soluong_rpt") as Label;
        int soluong = int.Parse(soluongSP.Text);
        soluong++;
        soluongSP.Text = soluong + "";

        string idsp = (item.FindControl("lb_idSP_rpt") as Label).Text;

        CapNhatSoLuongTrongGioHang(idsp, soluong);

    }

    protected void btn_tru_rpt_Click(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        Label soluongSP = item.FindControl("lb_soluong_rpt") as Label;
        int soluong = int.Parse(soluongSP.Text);
        soluong--;
        soluongSP.Text = soluong + "";

        string idsp = (item.FindControl("lb_idSP_rpt") as Label).Text;
        CapNhatSoLuongTrongGioHang(idsp, soluong);
    }

    void CapNhatSoLuongTrongGioHang(string idsp,int soluong)
    {
        foreach (ListSanPhamTheoIdTaiKhoan listSP in list)
        {
            for (int i = 0; i < listSP.SpTrongGioHang.Count; i++)
            {
                if (idsp == listSP.SpTrongGioHang[i].IdSP)
                {
                    listSP.SpTrongGioHang[i].SoLuong = soluong + "";
                    Response.Redirect("~/Form_User/GioHang.aspx");
                }
            }
        }
    }


    void TongTienCuaTatCaSanPhamDaChon()
    {
        int tong = 0;
        int demSL = 0;
        foreach (RepeaterItem item in rpt_Shop.Items)
        {
            Repeater rpt_SP = item.FindControl("rpt_SanPhamTrongGioHang") as Repeater;
            foreach (RepeaterItem itemSP in rpt_SP.Items)
            {
                demSL++;
                try{
                    tong += int.Parse((itemSP.FindControl("lb_TongTien_rpt") as Label).Text);
                }
                catch
                {

                }
            }
        }
        lb_ThongTienCanThanhToan.Text = tong.ToString("#,000");
        lb_SLSanPham.Text = demSL.ToString();
    }


    #region checkbox
    //protected void cb_ChonTatCa_CheckedChanged(object sender, EventArgs e)
    //{
    //    foreach(RepeaterItem item in rpt_Shop.Items)
    //    {
    //        (item.FindControl("cb_TatCaSanPhamTrongShop") as CheckBox).Checked = cb_ChonTatCa.Checked;
    //    }

    //    foreach (RepeaterItem item in rpt_Shop.Items)
    //    {
    //        Repeater rpt_SP = item.FindControl("rpt_SanPhamTrongGioHang") as Repeater;
    //        foreach (RepeaterItem itemSP in rpt_SP.Items)
    //        {
    //            (itemSP.FindControl("cb_sp_rpt") as CheckBox).Checked =
    //                (item.FindControl("cb_TatCaSanPhamTrongShop") as CheckBox).Checked;
    //        }
    //    }
    //    TongTienCuaTatCaSanPhamDaChon();
    //}

    //protected void cb_TatCaSanPhamTrongShop_CheckedChanged(object sender, EventArgs e)
    //{
    //    foreach (RepeaterItem item in rpt_Shop.Items)
    //    {
    //        Repeater rpt_SP = item.FindControl("rpt_SanPhamTrongGioHang") as Repeater;
    //        foreach(RepeaterItem itemSP in rpt_SP.Items)
    //        {
    //            (itemSP.FindControl("cb_sp_rpt") as CheckBox).Checked =
    //                (item.FindControl("cb_TatCaSanPhamTrongShop") as CheckBox).Checked;
    //        }
    //    }
    //    TongTienCuaTatCaSanPhamDaChon();
    //}

    //protected void cb_sp_rpt_CheckedChanged(object sender, EventArgs e)
    //{
    //    CheckBox cb = (sender as CheckBox);
    //    if (cb.Checked == false)
    //    {
    //        cb_ChonTatCa.Checked = false;
    //    }
    //    TongTienCuaTatCaSanPhamDaChon();
    //}
    #endregion


    protected void btn_MuaHang_Click(object sender, EventArgs e)
    {
        form_muahang.Visible = true;
    }

    protected void btn_thoat_form_Click(object sender, EventArgs e)
    {
        form_muahang.Visible = false;
    }

    string InsertHoaDon(string idtaiKhoan,string tenNguoiNhan,string SDT,string diaChi)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10),
            new SqlParameter("@TenNguoiNhan",SqlDbType.NVarChar,200),
            new SqlParameter("@SDTnguoinhan",SqlDbType.NVarChar,10),
            new SqlParameter("@ngay",SqlDbType.DateTime),
            new SqlParameter("@diaChi",SqlDbType.NVarChar,200)
        };
        p[0].Value = idtaiKhoan;
        p[1].Value = tenNguoiNhan;
        p[2].Value = SDT;
        p[3].Value = DateTime.Now.ToString("dd/MM/yyyy");
        p[4].Value = diaChi;
        DataTable table = DB.ExecuteQuery("InsertHoaDon", p);
        return table.Rows[0]["IdHoaDon"].ToString();
    }

    void InsertChiTietHoaDon(string idHoaDonn,string idSP,int soLuong,int DonGia)
    {
        

        SqlParameter[] p =
        {
            new SqlParameter("@idHoaDon", SqlDbType.NVarChar, 10),
            new SqlParameter("@IdSP", SqlDbType.NVarChar, 10),
            new SqlParameter("@SoLuong", SqlDbType.Int),
            new SqlParameter("@DonGia", SqlDbType.Int)
        };
        p[0].Value = idHoaDonn;
        p[1].Value = idSP;
        p[2].Value = soLuong;
        p[3].Value = DonGia;
        DB.ExecuteNonQuery("InsertChiTietHoaDon", p);
    }


    void InsertHoaDOnAndChiTietHoaDon(string idtaiKhoan, string tenNguoiNhan, string SDT, string diaChi)
    {
        try
        {
            foreach (ListSanPhamTheoIdTaiKhoan listItem in list)
            {
                string idHoaDon = InsertHoaDon(idtaiKhoan, tenNguoiNhan, SDT, diaChi);
                foreach (SanPhamTrongGioHang sp in listItem.spTrongGioHang)
                {
                    InsertChiTietHoaDon(idHoaDon, sp.IdSP, int.Parse(sp.SoLuong), int.Parse(sp.GiaSP));
                }
            }
            Session.Remove("GioHang");
            Response.Redirect("~/Form_User/HoSoTaiKhoan/DonMua.aspx");
        }
        catch
        {

        }
    }
    string GetIdTaiKhoan()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id + "";
    }


    protected void btn_ThanhToan_form_Click(object sender, EventArgs e)
    {
        string tenNguoiNhan = txt_TenNguoiNhan.Text;
        string SDT = txt_SDT.Text;
        string diaChi =txt_DiaChi.Text;
        if (!tenNguoiNhan.Equals("") && !SDT.Equals("") && !diaChi.Equals(""))
        {
            InsertHoaDOnAndChiTietHoaDon(GetIdTaiKhoan(),tenNguoiNhan, SDT, diaChi);
            form_muahang.Visible = false;
        }
        else
        {
            lb_thongbao_form.Visible = true;
        }



    }

    
}