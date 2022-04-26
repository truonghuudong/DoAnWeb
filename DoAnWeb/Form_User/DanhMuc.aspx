<%@ Page Title="" Language="C#" MasterPageFile="~/Form_User/MasterPage.master" AutoEventWireup="true" CodeFile="DanhMuc.aspx.cs" Inherits="DanhMuc" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /*phan trang*/
            .phantrang{
                    background-color:var(--ưhile-color);
                    display:flex;
                    text-align:center;
                    align-items:center;
                    align-content:center;
                    justify-content:center;
                    margin-top:15px;
                }
                .btn_page{
                    margin: 0 5px;
                    text-align:center;
                    min-width:45px;
                    min-height:25px;
                    max-height:25px;
                    font-weight:bold;
                    font-size:1.7rem;
                }
                .btn_page input[type=image]{
                    color:var(--text-color);
                }
                .btn_page:hover{
                    background-color:var(--primary-color);
                }
                .btn_page_nextprev{
                    margin: 0 5px;
                    align-items:center;
                    text-align:center;
                    min-width:45px;
                    min-height:25px;
                    font-size:1.7rem;
                    font-weight:bold;
                }
                .btn_page_nextprev:hover{
                    background-color:var(--primary-color);
                }
                .btn_page_numberpage{
                    width:50px;
                    text-align:center;
                    min-width:80px;
                    min-height:30px;
                    max-height:30px;
                    font-weight:bold
                }

                /*phan trang*/
        
    </style>
    <link rel="stylesheet" href="../CSS/SanPhamCSS.css" />
    <link rel="stylesheet" href="../CSS/CSSDanhMuc.css" />
    <script src="https://code.jquery.com/jquery-2.2.4.js">

    </script>
    <title>Chi Tiết Danh Mục

    </title>
    <script>
        $(document).ready(function () {
            //console.log(IdLoaiSP);

            var qrStr = window.location.search;
            var spQrStr = qrStr.substring(1);
            var arrQrStr = new Array();
            var val;
            var key;
            var index;
            // splits each of pair
            var arr = spQrStr.split('?');
            for (var i = 0; i < arr.length; i++) {
                // splits each of field-value pair
                index = arr[i].indexOf('=');
                key = arr[i].substring(0, index);
                val = arr[i].substring(index + 1);
                // saves each of field-value pair in an array variable
                arrQrStr[key] = val;
            }
            if (key == "IdLoaiSP")
            {
                $('.category-item' + val).addClass("category-item--active");
            }

            //$('.button-page:first-child').click(function () {
            //    $('.button-page:first-child').addClass('clicked');
            //});


            
            //$('#btnMoiNhat').click(function (event) {
            //    $('#btnMoiNhat').addClass('active');
            //    $('#btnPhoBien').removeClass('active');
            //    $('#btnBanChay').removeClass('active');
            //});
            //$('#btnPhoBien').click(function (event) {
            //    $('#btnPhoBien').addClass('active');
            //    $('#btnMoiNhat').removeClass('active');
            //    $('#btnBanChay').removeClass('active');
            //});
            //$('#btnBanChay').click(function (event) {
            //    $('#btnBanChay').addClass('active');
            //    $('#btnPhoBien').removeClass('active');
            //    $('#btnMoiNhat').removeClass('active');
            //});
        });
    </script>


</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="grid">
        <div class="grid__row app__container">
            <div class="grid__column-2">
                <nav class="category">
                    <h3 class="category__heading">
                        <i class="category__heading-icon fas fa-list"></i>
                        Danh Muc
                    </h3>
                    <div class="category-list">
                        <asp:Repeater ID="rptLoaiSP" runat="server">
                            <ItemTemplate>
                                <div class="category-item<%#Eval("IdLoaiSP")%>">
                                    <a class="category-item_link"  href="DanhMuc.aspx?IdLoaiSP=<%#Eval("IdLoaiSP")%>"><%#Eval("TenLoaiSP")%></a>
                                    <%--<asp:LinkButton runat="server" ID="lbtnLoaiSP" OnClick="btnLoaiSP_Click" CssClass="category-item_link"><%#Eval("TenLoaiSP")%></asp:LinkButton>--%>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </nav>
            </div>
            
            <div class="grid__column-10">
                <!-- home filter -->
                <div class="home-filter">
                    <span class="home-filter__label">Sắp xếp theo</span>
                    <asp:Button ID="btnPhoBien" runat="server"  class="btn_sapxep home-filter__btn active" Text="Phổ Biến" OnClick="PhoBien_Click"/>
                    <asp:Button ID="btnMoiNhat" runat="server" class="btn_sapxep home-filter__btn" Text="Mới Nhất" OnClick="MoiNhat_Click"/>
                    <asp:Button ID="btnBanChay" runat="server" class="btn_sapxep home-filter__btn" Text="Bán Chạy" OnClick="BanChay_Click"/>
                    <asp:DropDownList ID="ddlGia" runat="server" AutoPostBack = "true" CssClass="btn"  OnSelectedIndexChanged="ddlGia_SelectedIndexChanged">
                        <asp:ListItem Id="gia" Value="1" >Giá:</asp:ListItem>
                        <asp:ListItem Value="2">Giá: Thấp đến cao</asp:ListItem>
                        <asp:ListItem Value="3">Giá: Cao điến thấp</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <!-- home filter -->

                <!-- Danh sach san pham -->
                <div class="home-product">
                    <div class="grid__row">

                        <!--Them repeat o day-->
                        <asp:Repeater ID="rptSanPham" runat="server">
                            <ItemTemplate>
                                <div class="grid__column-2-4">
                            <!--Product item-->
                                        <a class="home-product-item" href="ChiTietSanPham.aspx?IdSP=<%#Eval("IdSP")%>"">
                                            <img class="home-product-item__img" src="../HinhAnh/Sprites_SP/<%#Eval("AnhSP")%>" />
                                            <h5 class="home-product-item__name"><%#Eval("TenSP")%></h5>
                                            <div class="home-product-item__price">
                                                <span class="home-product-item__price-old"><%#Eval("GiaSP")%></span>
                                                <span class="home-product-item__price-current"><%#Eval("GiaKhuyenMai")%></span>
                                            </div>
                                            <div class="home-product-item__action">
                                                <span class="home-product-item__like home-product-item__like-liked">
                                                    <i class="home-product-item__like-icon-empty far fa-heart"></i>
                                                    <i class="home-product-item__like-icon-fill fas fa-heart"></i>
                                                </span>
                                                <div class="home-product-item__rating">
                                                    <i class="home-product-item__star-gold fas fa-star"></i>
                                                    <i class="home-product-item__star-gold fas fa-star"></i>
                                                    <i class="home-product-item__star-gold fas fa-star"></i>
                                                    <i class="home-product-item__star-gold fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                                <span class="home-product-item__sold">88 Đã Bán</span>

                                            </div>
                                            <div class="home-product-item__origin">
                                                <span class="home-product-item__brand"><%#Eval("TenTaiKhoan")%></span>
                                                <span class="home-product-item__origin-name">Nhật Bản</span>
                                            </div>
                                            <div class="home-product-item__favourite">
                                                <i class="fas fa-check"></i>
                                                <span>Yêu thích</span>
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <span class="home-product-item__sale-off-percent"><%#Eval("TiLeKhuyenMai")%>%</span>
                                                <span class="home-product-item__sale-off-label">GIẢM</span>
                                            </div>
                                        </a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <!--Them repeat o day-->

                    </div>
                </div>

                <!--Phan trang-->
                <div class="phantrang">
                    <div>
                        <asp:Button cssclass="btn_page" ID="btn_TrangDau" runat="server" Text="<<" OnClick="btn_TrangDau_Click"/>
                    </div>
                    <div>
                        <asp:Button cssclass="btn_page_nextprev"  ID="btn_Prev" runat="server" Text="<" OnClick="btn_Prev_Click"/>
                    </div>
                    <div>
                        <asp:TextBox cssclass="btn_page_numberpage" ID="txt_STTPage" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Button cssclass="btn_page_nextprev"  ID="btn_Next" runat="server" Text=">"  OnClick="btn_Next_Click"/>
                    </div>
                    <div>
                        <asp:Button cssclass="btn_page" ID="btn_TrangCuoi" runat="server" Text=">>" OnClick="btn_TrangCuoi_Click"/>
                    </div>
                </div>
                <!--Phan trang-->
            </div>

        </div>
    </div>
    

</asp:Content>

