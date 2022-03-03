using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class SanPhamTrongGioHang
{
    string idSP;
    string tenSP;
    string soLuong;
    string giaSP;
    string anhSP;
    string phanLoai;
    string nhomPhanLoai;
    string tenShop;

    public SanPhamTrongGioHang() { }
    public SanPhamTrongGioHang(string idSP, string tenSP,string soLuong, string giaSP, 
        string anhSP, string phanLoai, string nhomPhanLoai, string tenShop)
    {
        this.idSP = idSP;
        this.soLuong = soLuong;
        this.giaSP = giaSP;
        this.anhSP = anhSP;
        this.phanLoai = phanLoai;
        this.nhomPhanLoai = nhomPhanLoai;
        this.tenShop = tenShop;
    }
    public string IdSP { get => idSP; set => idSP = value; }
    public string SoLuong { get => soLuong; set => soLuong = value; }
    public string GiaSP { get => giaSP; set => giaSP = value; }
    public string AnhSP { get => anhSP; set => anhSP = value; }
    public string PhanLoai { get => phanLoai; set => phanLoai = value; }
    public string NhomPhanLoai { get => nhomPhanLoai; set => nhomPhanLoai = value; }
    public string TenShop { get => tenShop; set => tenShop = value; }
    public string Tensp { get => tenSP; set => tenSP = value; }
}