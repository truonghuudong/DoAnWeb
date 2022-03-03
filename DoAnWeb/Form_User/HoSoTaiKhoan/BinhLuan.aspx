<%@ Page Title="" Language="C#" MasterPageFile="~/Form_User/HoSoTaiKhoan/MasterPage_HoSoTaiKhoan.master" AutoEventWireup="true" CodeFile="BinhLuan.aspx.cs" Inherits="Form_User_HoSoTaiKhoan_BinhLuan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .anhsp{
            width:400px;
            height:400px;
        }

        .danhgiasanpham{
            background-color:var(--while-color);
            padding:5px;
            
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


        .binhluan{
            display:flex;
            margin-top:50px;
        }
        .input_BinhLuan{
            text-align:center;
        }
        .binhluan_txt{
            padding-top:5px;
            padding-left:5px;
            height:120px;
            font-size:1.5rem;
            width:400px;
        }
        .btn{
            margin-top:5px;
            background-color:var(--primary-color);
        }
        .btn:hover{
            background-color:#f05d40;
        }
    </style>
    
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="chitietsanpham">
            <div class="chitietsanpham_anhSP">
                <asp:Image ID="imageSP" runat="server" ImageUrl="~/HinhAnh/Sprites_SP/Áo Len Tăm Cổ 3 Phân.jpg" class="image-SP"/>
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

                <!--Bình Luận-->
                <div class="binhluan">
                    <div class="input_BinhLuan">
                        <div>
                            <div>
                                <textarea runat="server" class="binhluan_txt" placeholder="Nội dung bình luận" id="txt_NoiDung_BinhLuan" cols="20" rows="2"></textarea>
                            </div>
                            <asp:Button CssClass="btn" ID="btn_BinhLuan" OnClick="btn_BinhLuan_Click" runat="server" Text="Bình Luận" />
                        </div>
                    </div>
                </div>
                <!-- Bình Luận-->
            </div>
        </div>

        <div class="danhgiasanpham">

            <div class="danhgiasanpham_title">
                Đánh Giá Sản Phẩm
            </div>

            <asp:Repeater ID="rpt_DanhGiaSP" runat="server">
                <ItemTemplate>

                     <div class="danhgiasanpham_noidung">
                        <div class="noidung_taikhoan">
                            <img class="AnhDaiDien" src="../../HinhAnh/Sprites_AnhDaiDien/<%#Eval("AnhDaiDien")%>" />
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

</asp:Content>

