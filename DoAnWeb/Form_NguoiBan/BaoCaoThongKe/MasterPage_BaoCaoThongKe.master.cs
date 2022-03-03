using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_BaoCaoThongKe_MasterPage_BaoCaoThongKe : System.Web.UI.MasterPage
{

    //trạng thái hóa đơn: 0:đã bị hủy, 1:đã giao - đã thanh toán, 2:đang giao, 3:hoàn trả
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AddClassActivited();
            DoDuLieuVaoLabel();
        }
    }

    void AddClassActivited()
    {
        try
        {
            string url = HttpContext.Current.Request.RawUrl.ToString();
            if (url.Contains("SanPhamBanChay"))
            {
                btn_sanPhamBanChay.Attributes.Add("class", "button-chucnang activited");
            }
            else
            {
                if (url.Contains("SoLuongHangTonKho"))
                {
                    btn_hangTon.Attributes.Add("class", "button-chucnang activited");
                }
                else
                {
                    if (url.Contains("KhachHangMuaNhieuNhat"))
                    {
                        btn_khachMuaNhieu.Attributes.Add("class", "button-chucnang activited");
                    }
                    else
                    {
                        if (url.Contains("SanPhamKhuyenMai"))
                        {
                            btn_sanPhamKhuyenMai.Attributes.Add("class", "button-chucnang activited");
                        }
                        else
                        {

                            if (url.Contains("DoanhThu"))
                            {
                                btn_doanhThu.Attributes.Add("class", "button-chucnang activited");
                            }
                        }
                    }

                }
            }
        }
        catch
        {

        }
    }

    void DoDuLieuVaoLabel()
    {
        try
        {
            UserLogin user = new UserLogin();
            user = (UserLogin)Session["User"];
            string idTaiKhoan = user.Id + "";
            lb_daThanhToan.Text = GetTongTienDaThanhToan(idTaiKhoan).Rows[0]["TongTien"].ToString();
            lb_seThanhToan.Text = GetTongTienSeThanhToan(idTaiKhoan).Rows[0]["TongTien"].ToString();
        }
        catch
        {

        }
    }


    DataTable GetTongTienDaThanhToan(string idTaiKhoan)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = idTaiKhoan;
        return DB.ExecuteQuery("GetTongSoTienDaDuocThanhToan", p);
    }

    DataTable GetTongTienSeThanhToan(string idTaiKhoan)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10)
        };
        p[0].Value = idTaiKhoan;
        return DB.ExecuteQuery("GetTongSoTienSeDuocThanhToan", p);
    }
}
