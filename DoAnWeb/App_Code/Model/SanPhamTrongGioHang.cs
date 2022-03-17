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
    string size;
    string tenShop;

    public SanPhamTrongGioHang() { }
    public SanPhamTrongGioHang(string idSP, string tenSP,string soLuong, string giaSP, 
        string anhSP, string size,  string tenShop)
    {
        this.idSP = idSP;
        this.soLuong = soLuong;
        this.giaSP = giaSP;
        this.anhSP = anhSP;
        this.size = size;
        this.tenShop = tenShop;
    }
    public string IdSP { get => idSP; set => idSP = value; }
    public string SoLuong { get => soLuong; set => soLuong = value; }
    public string GiaSP { get => giaSP; set => giaSP = value; }
    public string AnhSP { get => anhSP; set => anhSP = value; }
    public string Size { get => size; set => size = value; }
    public string TenShop { get => tenShop; set => tenShop = value; }
    public string Tensp { get => tenSP; set => tenSP = value; }
}