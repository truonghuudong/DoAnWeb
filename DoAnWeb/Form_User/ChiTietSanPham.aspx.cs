using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class ChiTietSanPham : System.Web.UI.Page
{

    static PagedDataSource p = new PagedDataSource();
    public static int intSTT;
    public static int trang_thu = 0;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string idSP = Request.QueryString.Get("IdSP").ToString();
            DataTable table = GetSanPham(idSP);
            imageSP.ImageUrl = "~/HinhAnh/Sprites_SP/" + table.Rows[0]["AnhSP"].ToString();
            lbGiaSPCu.Text = table.Rows[0]["GiaSP"].ToString();
            lbTenSP.Text = table.Rows[0]["TenSP"].ToString();
            lbGiaSPMoi.Text = table.Rows[0]["GiaKhuyenMai"].ToString();
            lbSanPhamHienCo.Text = table.Rows[0]["SoLuong"].ToString();
            ltMota.Text = table.Rows[0]["Mota"].ToString();
            DoDuLieuPaged();

            rpt_size.DataSource = GetSizeSanPham(idSP);
            rpt_size.DataBind();
        }
    }


    DataTable GetSizeSanPham(string idSanPham)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdSP",System.Data.SqlDbType.NVarChar,10)
        };
        p[0].Value = idSanPham;
        return DB.ExecuteQuery("GetSizeSanPhamTheoId", p);
    }


    DataTable GetSanPham(string idSanPham)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@IdSP",System.Data.SqlDbType.NVarChar,10)
        };
        p[0].Value = idSanPham;
        return DB.ExecuteQuery("GetSanPhamTheoId", p);
    }


    protected void btn_TruSoLuong_Click(object sender, EventArgs e)
    {
        try
        {
            if (int.Parse(txt_SoLuongSPMua.Text) > 1)
            {
                int i = int.Parse(txt_SoLuongSPMua.Text);
                i--;
                txt_SoLuongSPMua.Text = "" + i;
            }
        }
        catch
        {

        }
    }

    protected void btn_CongSoLuong_Click(object sender, EventArgs e)
    {
        int i;
        try
        {
            i = int.Parse(txt_SoLuongSPMua.Text);
            i++;
            if (i > int.Parse(lbSanPhamHienCo.Text))
            {
                i = int.Parse(lbSanPhamHienCo.Text);
            }
        }
        catch
        {
            i= 0;
            i++;
        }
        txt_SoLuongSPMua.Text = "" + i;
    }

    protected void txt_SoLuongSPMua_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (int.Parse(txt_SoLuongSPMua.Text) < 0)
            {
                int i = int.Parse(txt_SoLuongSPMua.Text);
                i = 0;
                txt_SoLuongSPMua.Text = "" + i;
            }
            else
            {
                if (int.Parse(txt_SoLuongSPMua.Text) > int.Parse(lbSanPhamHienCo.Text))
                {
                    txt_SoLuongSPMua.Text = lbSanPhamHienCo.Text;
                }
            }
        }
        catch
        {

        }
    }


    protected void btn_ThemVaoGioHang_Click(object sender, EventArgs e)
    {
        try
        {
            int ketQuaKiemTra = int.Parse(txt_SoLuongSPMua.Text);
            if(lb_Size.Text != "")
            {
                if (ketQuaKiemTra > 0)
                {
                    if (Session["user"] == null)
                    {
                        Response.Redirect("../Form_User/DangNhap.aspx");
                    }
                    else
                    {
                        string idSP = Request.QueryString.Get("IdSP").ToString();
                        DataTable table = GetSanPham(idSP);
                        if (Session["GioHang"] == null)
                        {
                            ThemSanPhamVaoGioHangRong(table);
                        }
                        else
                        {
                            ThemSanPhamVaoGioHangDaCo(table);
                        }
                        Response.Redirect("../Form_User/GioHang.aspx");
                    }

                }
                else
                {
                    lb_thongbao.Text = "Vui lòng chọn số lượng sản phẩm";
                    lb_thongbao.Visible = true;
                }

            }
            else
            {
                lb_thongbao.Text = "Vui lòng chọn size sản phẩm";
                lb_thongbao.Visible = true;
            }
        }
        catch
        {
            lb_thongbao.Visible = true;
        }
    }

    void ThemSanPhamVaoGioHangRong(DataTable table)
    {
        List<ListSanPhamTheoIdTaiKhoan> danhSachSanPham =
                    new List<ListSanPhamTheoIdTaiKhoan>();

        ListSanPhamTheoIdTaiKhoan listSP = new ListSanPhamTheoIdTaiKhoan();
        SanPhamTrongGioHang sp = new SanPhamTrongGioHang();

        sp.IdSP = table.Rows[0]["IdSP"].ToString();
        sp.GiaSP = table.Rows[0]["GiaKhuyenMai"].ToString();
        sp.Tensp = table.Rows[0]["TenSP"].ToString();
        sp.SoLuong = txt_SoLuongSPMua.Text;
        sp.TenShop = table.Rows[0]["TenTaiKhoan"].ToString();
        sp.AnhSP = table.Rows[0]["AnhSP"].ToString();

        listSP.TenNguoiBan = sp.TenShop;
        listSP.IdNguoiBan = table.Rows[0]["IdTaiKhoan"].ToString();
        listSP.SpTrongGioHang.Add(sp);

        danhSachSanPham.Add(listSP);
        Session.Add("GioHang", danhSachSanPham);
    }


    void ThemSanPhamVaoGioHangDaCo(DataTable table)
    {
        List<ListSanPhamTheoIdTaiKhoan> danhSachSanPham =
                    (List<ListSanPhamTheoIdTaiKhoan>)Session["GioHang"];

        SanPhamTrongGioHang sp = new SanPhamTrongGioHang();
        sp.IdSP = table.Rows[0]["IdSP"].ToString();
        sp.GiaSP = table.Rows[0]["GiaKhuyenMai"].ToString();
        sp.SoLuong = txt_SoLuongSPMua.Text;
        sp.AnhSP = table.Rows[0]["AnhSP"].ToString();
        sp.Tensp = table.Rows[0]["TenSP"].ToString();
        sp.TenShop = table.Rows[0]["TenTaiKhoan"].ToString();
        sp.Size = lb_Size.Text;
        int dem = 0;
        foreach (ListSanPhamTheoIdTaiKhoan listSP in danhSachSanPham)
        {
            if (listSP.IdNguoiBan == table.Rows[0]["IdTaiKhoan"].ToString())
            {
                listSP.SpTrongGioHang.Add(sp);
                break;
            }
            dem++;
        }

        if (dem == danhSachSanPham.Count)
        {
            ListSanPhamTheoIdTaiKhoan listSP = new ListSanPhamTheoIdTaiKhoan();
            listSP.TenNguoiBan = sp.TenShop;
            listSP.IdNguoiBan = table.Rows[0]["IdTaiKhoan"].ToString();
            listSP.SpTrongGioHang.Add(sp);
            danhSachSanPham.Add(listSP);
        }
        Session.Add("GioHang", danhSachSanPham);
    }

    protected void btn_MuaNgay_Click(object sender, EventArgs e)
    {

    }




    DataTable GetBinhLuan(int idSanPham)
    {

        SqlParameter[] p =
        {
            new SqlParameter("@idsp",System.Data.SqlDbType.Int)
        };
        p[0].Value = idSanPham;
        return DB.ExecuteQuery("GetDanhGiaSanPham", p);
    }



    void DoDuLieuPaged()
    {
        try
        {
            int idSP = int.Parse(Request.QueryString.Get("IdSP").ToString());
            p.DataSource = GetBinhLuan(idSP).DefaultView;

            p.PageSize = 10;

            p.CurrentPageIndex = trang_thu;

            p.AllowPaging = true;


            btn_TrangDau.Enabled = true; btn_Prev.Enabled = true; btn_Next.Enabled = true; btn_TrangCuoi.Enabled = true;


            if (p.IsFirstPage == true)//neu la dau.

            {

                btn_TrangDau.Enabled = false;//neu la trang dau thi hai nut mo di.

                btn_Prev.Enabled = false;

                btn_Next.Enabled = true;//Hai nut sau sang len.

                btn_TrangCuoi.Enabled = true;

            }


            if (p.IsLastPage == true)//neu la cuoi

            {

                btn_TrangDau.Enabled = true;//neu la trang dau thi hai nut mo di.

                btn_Prev.Enabled = true;

                btn_Next.Enabled = false;//Hai nut sau sang len.

                btn_TrangCuoi.Enabled = false;

            }

            if (p.IsLastPage == true && p.IsFirstPage == true)//neu la cuoi

            {

                btn_TrangDau.Enabled = false;//neu la trang dau thi hai nut mo di.

                btn_Prev.Enabled = false;

                btn_Next.Enabled = false;//Hai nut sau sang len.

                btn_TrangCuoi.Enabled = false;

            }


            txt_STTPage.Text = (trang_thu + 1) + " / " + p.PageCount;


            rpt_DanhGiaSP.DataSource = p;

            rpt_DanhGiaSP.DataBind();

        }
        catch
        {

        }
    }

    protected void btn_TrangDau_Click(object sender, EventArgs e)
    {
        trang_thu = 0;
        DoDuLieuPaged();
    }

    protected void btn_Prev_Click(object sender, EventArgs e)
    {
        trang_thu--;
        DoDuLieuPaged();
    }

    protected void btn_Next_Click(object sender, EventArgs e)
    {
        trang_thu++;
        DoDuLieuPaged();
    }

    protected void btn_TrangCuoi_Click(object sender, EventArgs e)
    {
        trang_thu = p.PageCount - 1;
        DoDuLieuPaged();
    }




    protected void btnSize_Click(object sender, EventArgs e)
    {
        lb_Size.Text = (sender as Button).Text;

        for(int i = 0; i < rpt_size.Items.Count; i++)
        {
            (rpt_size.Items[i].FindControl("btnSize") as Button).CssClass= "button button_info button_size";
        }
        (sender as Button).CssClass = "button button_info button_size button_active";
    }
}