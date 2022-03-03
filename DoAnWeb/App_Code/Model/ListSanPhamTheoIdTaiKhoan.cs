using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ListSanPhamTheoIdTaiKhoan
/// </summary>
public class ListSanPhamTheoIdTaiKhoan
{
    string idNguoiBan;
    string tenNguoiBan;
    public List<SanPhamTrongGioHang> spTrongGioHang = new List<SanPhamTrongGioHang>();
    public ListSanPhamTheoIdTaiKhoan()
    {
    }
    public string IdNguoiBan { get => idNguoiBan; set => idNguoiBan = value; }
    public List<SanPhamTrongGioHang> SpTrongGioHang { get => spTrongGioHang; set => spTrongGioHang = value; }
    public string TenNguoiBan { get => tenNguoiBan; set => tenNguoiBan = value; }
}