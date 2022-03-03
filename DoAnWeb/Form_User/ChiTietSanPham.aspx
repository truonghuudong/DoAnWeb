<%@ Page Title="" Language="C#" MasterPageFile="~/Form_User/MasterPage.master" AutoEventWireup="true" CodeFile="ChiTietSanPham.aspx.cs" Inherits="ChiTietSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        
    <!-- add css -->
    <%--<link rel="stylesheet" href="https://pagecdn.io/lib/normalize/8.0.1/normalize.min.css" />
    <link rel="stylesheet" href="CSS/base.css" />
    <link rel="stylesheet" href="Font/fontawesome-free-5.15.3-web/fontawesome-free-5.15.3-web/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>--%>
    <!-- add css -->
    
    <link rel="stylesheet" href="../CSS/ChitTietSanPham.css" />
    <link rel="stylesheet" href="../CSS/PhanTrang.css" />
    <style>
        .thongbao{
            padding: 0 20px;
            margin:5px 0 10px 0;
            font-size:1.5rem;
            color:var(--primary-color);
        }
        .danhgiasanpham{
            background-color:var(--while-color);
            padding-bottom:5px;
            
        }
        .danhgiasanpham_title{
            font-size:2rem;
            padding:15px;
            font-weight:600;
        }
        .danhgiasanpham_noidung{
            padding:30px;
            border-bottom:1px solid rgba(0,0,0,0.2);
        }
        .noidung_taikhoan{
            display:flex;
            align-self:center;
        }
        .taikhoan-tentaikhoan{
            font-size:1.5rem;
            font-weight:500;
        }
        .noidung_mota{
            font-size:1.5rem;
            font-weight:400;
            margin-left:15px;
        }
        .mota{
            margin-top:15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="grid">
        <div class="chitietsanpham">
            <div class="chitietsanpham_anhSP">
                <asp:Image ID="imageSP" runat="server" class="image-SP"/>
            </div>

            <!-- thông số sản phẩm(tên - giá ...) -->
            <div class="chitietsanpham_ThongSo">
                <asp:Label class="chitietsanpham_ThongSo-tenSP" ID="lbTenSP" runat="server">Áo chống nắng nam nữ 2021 dày dặn cao cấp thấm hút mồ hôi, chống tia uv Áo chống nắng nam nữ 2021 dày dặn cao cấp thấm hút mồ hôi, chống tia uv ồ hôi, chống tia uv</asp:Label>
         
                <!-- thông tin về rating, số lượt đánh giá và số lượng sản phẩm đã bán-->
                <div class="chitietsanpham_ThongSo-RatingDaBanDanhGia">
                    <div class="chitietsanpham_ThongSo-Item chitietsanpham_ThongSo-rating">
                        <asp:Label CssClass="rating" ID="lbRating" runat="server" Text="4.7"></asp:Label>
                        <i></i>
                        <i></i>
                        <i></i>
                        <i></i>
                    </div>

                    <div class="chitietsanpham_ThongSo-Item chitietsanpham_ThongSo-DanhGia">
                        <asp:Label ID="lbDanhGia" runat="server" Text="211"></asp:Label>
                        <p class="text-in-thongso">Đánh Giá</p>
                    </div>

                    <div class="chitietsanpham_ThongSo-Item chitietsanpham_ThongSo-DaMua">
                        <asp:Label ID="lbDaMua" runat="server" Text="5,5K"></asp:Label>
                        <p class="text-in-thongso">Đã Bán</p>
                    </div>

                </div>

                <!-- Giá sản phẩm-->
                <div class="chitietsanpham_ThongSo-GiaSP">
                    <div class="giaCu"> 
                        <asp:Label ID="lbGiaSPCu" runat="server" Text="30000-50000"></asp:Label>
                    </div>
                    <div class="giaMoi">
                        <asp:Label ID="lbGiaSPMoi" runat="server" Text="20000-40000"></asp:Label>
                    </div>
                </div>

                <!-- Thông tin chi tiết sản phẩm cần mua (Màu, Size, số lượng)-->
                <div class="chitietsanpham_ThongSo-info">
                    
                    <%--<!-- phân loại theo nhóm-->
                    <div class="info_nhomPhanLoai align-items" id="nhomPhanLoai" runat="server">
                        <div class="title-info">
                            <asp:Label ID="lbNhomPhanLoai" runat="server" Text="Màu"></asp:Label>
                        </div>
                        <!-- Can xoa -->
                        <asp:Button class="button button_info" ID="Button1" runat="server" Text="Button" />
                        <asp:Button class="button button_info" ID="Button2" runat="server" Text="Button" />
                    </div>

                    <!-- Phân loại-->
                    <div class="info_PhanLoai align-items" id="phanLoai" runat="server">
                        <div class="title-info">
                            <asp:Label ID="lb_PhanLoai" runat="server" Text="Size"></asp:Label>
                        </div>
                        <!-- Can Xoa -->
                        <asp:Button class="button button_info" ID="Button3" runat="server" Text="To" />
                        <asp:Button class="button button_info" ID="Button4" runat="server" Text="Nho" />
                    </div>--%>


                    <!-- Số lượng sản phẩm cần mua-->
                    <div class="chitietsanpham_ThongSo-soLuong align-items" style="margin-top:160px">
                        <div class="chitietsanpham_ThongSo-soLuong-control">
                            <div class="title-info">
                                <span class="controlText-soluong">Số lượng</span>
                            </div>
                            <asp:Button class="button" ID="btn_TruSoLuong" runat="server" Text="-" Height="32px" Width="33px" OnClick="btn_TruSoLuong_Click" />
                            <asp:TextBox AutoPostBack="true" class="txt_SoLuongSP" ID="txt_SoLuongSPMua" runat="server" Height="32px" Width="77px" TextMode="Number" OnTextChanged="txt_SoLuongSPMua_TextChanged"></asp:TextBox>
                            <asp:Button class="button" ID="btn_CongSoLuong" runat="server" Text="+" Height="32px" Width="33px" OnClick="btn_CongSoLuong_Click" />
                        </div>
                
                        <div class="chitietsanpham_ThongSo-soLuong-sanPhamHienCo">
                            <asp:Label ID="lbSanPhamHienCo" runat="server" Text="1123"></asp:Label>
                            <span> Sản phẩm hiện có</span>
                        </div>
                    </div>

                </div>

                <!-- Thông báo-->
                <div class="thongbao">
                    <asp:Label ID="lb_thongbao" Visible="false" runat="server" Text="Vui lòng chọn số lượng sản phẩm cần mua"></asp:Label>
                </div>
                <!-- Thông báo-->

                <!-- Button thêm vào giỏ hàng và mua ngay-->
                <div class="chitietsanpham_ThongSo-ThemVaoGioHangVaMuaNgay">
                    <asp:Button CssClass="button_mua button_themvaogiohang" ID="btn_ThemVaoGioHang" runat="server" Text="Thêm vào giỏ hàng" OnClick="btn_ThemVaoGioHang_Click" />
                    <asp:Button CssClass="button_mua" ID="btn_MuaNgay" runat="server" Text="Mua ngay" OnClick="btn_MuaNgay_Click" />
                </div>

            </div>



        </div>

        <div class="motasanpham">
            <div class="motasanpham_title">
                <div class="title_motasanpham">
                    Mô tả sản phẩm
                </div>
            </div>
            <div class="info-mota">
                <asp:Literal  ID="ltMota" runat="server" Text="">
                </asp:Literal>
            </div>
        </div>

        <div class="loix">
        </div>

        <%-- Đánh giá sản phẩm --%>
        <div class="danhgiasanpham">

            <div class="danhgiasanpham_title">
                Đánh Giá Sản Phẩm
            </div>

            <asp:Repeater ID="rpt_DanhGiaSP" runat="server">
                <ItemTemplate>

                     <div class="danhgiasanpham_noidung">
                        <div class="noidung_taikhoan">
                            <img class="AnhDaiDien" src="../HinhAnh/Sprites_AnhDaiDien/<%#Eval("AnhDaiDien")%>" />
                            <div class="noidung_mota">
                                <div class="taikhoan-tentaikhoan"><%#Eval("TenTaiKhoan")%></div>
                                <div class="mota">
                                    <%#Eval("NoiDung")%>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>


            <%--phan trang--%>
             <div class="phantrang">
                <div>
                    <asp:Button cssclass="btn_page" ID="btn_TrangDau" runat="server" Text="Trang Đầu" OnClick="btn_TrangDau_Click"/>
                </div>
                <div>
                    <asp:Button cssclass="btn_page_nextprev"  ID="btn_Prev" runat="server" Text="<" OnClick="btn_Prev_Click"/>
                </div>
                <div>
                    <asp:TextBox style="width:50px;text-align:center;min-width:80px;min-height:30px;max-height:30px;" ID="txt_STTPage" runat="server" Enabled="false"></asp:TextBox>
                </div>
                <div>
                    <asp:Button cssclass="btn_page_nextprev"  ID="btn_Next" runat="server" Text=">"  OnClick="btn_Next_Click"/>
                </div>
                <div>
                    <asp:Button cssclass="btn_page" ID="btn_TrangCuoi" runat="server" Text="Trang Cuối" OnClick="btn_TrangCuoi_Click"/>
                </div>
            </div>
            <%--phan trang--%>

        </div>

    </div>

</asp:Content>

