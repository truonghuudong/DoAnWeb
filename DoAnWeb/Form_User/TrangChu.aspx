<%@ Page Title="" Language="C#" MasterPageFile="~/Form_User/MasterPage.master" AutoEventWireup="true" CodeFile="TrangChu.aspx.cs" Inherits="TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <link rel="stylesheet" href="../CSS/SanPhamCSS.css" />
    <link rel="stylesheet" href="https://pagecdn.io/lib/normalize/8.0.1/normalize.min.css" />
    <link rel="stylesheet" href="../CSS/base.css" />
    <link rel="stylesheet" href="../Font/fontawesome-free-5.15.3-web/fontawesome-free-5.15.3-web/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>


    <style>
        .content{
            min-height:100%;
            min-width:100%;
        }

        .quangcao_sale{
            width:100%;
            height:340px;
            display:flex;
            align-items:center;
        }
        .quangcao{
            z-index:0;
            width:100%;
            height:340px;
            overflow:hidden;
            display:flex;
            align-items:center;
            list-style:none;
        }
        .quangcao__sale{
            overflow:hidden;
            height:235px;
        }
        

        .quangcao__slides{
            width:783px;
            display:flex;
            height:235px;
            overflow:hidden;
            position:absolute;
        }
        .slide-link{
            position:absolute;
            opacity:0;
            visibility:hidden;
        }

        .slide-link.active{
            visibility:visible;
            opacity:1;
        }


        .nut-slide{

        }

        .nut-slide span{
            padding:0px 5px;
            top:100px;
            color:var(--while-color);
            font-size:3rem;
            align-items:center;
            z-index:999;
            position:absolute;
            opacity:0.6;
            height:60px;
            margin-top:-15px;
        }

        .sale-img:first-child{
            margin-bottom:4px;
        }
        .sale-img:last-child{
            margin-top:4px;
        }
        .sale-img{
        }
        .sale-img img{
            width:412px;
            height:115px;
        }
        span#btn-prev{
            padding-top:15px;
            position:absolute;
            cursor:pointer;
            left:0px;
        }
         span#btn-prev:hover{
            opacity:1;
            background-color:rgba(0,0,0,0.12)
        }
        span#btn-next{
            padding-top:15px;
            position:absolute;
            left:755px;
            cursor:pointer;
        }
         span#btn-next:hover{
             opacity:1;
             background-color:rgba(0,0,0,0.12)
        }

        .slide-link__img{
            height:235px;
        }

        .bien-mat-ben-trai{
            animation:bien-mat-ben-trai 1s forwards;
        }

        @-webkit-keyframes bien-mat-ben-trai{
            from{
                transform:translate(0%);
            }
            to{
                transform:translate(-100%);
            }
        }


        .di-vao-ben-phai{
            animation:di-vao-ben-phai 1s forwards;
        }
        @-webkit-keyframes di-vao-ben-phai{
            from{
                transform:translate(100%);
            }
            to{
                transform:translate(0%);
            }
        }



        .bien-mat-ben-phai{
            animation:bien-mat-ben-phai 1s forwards;
        }

        @-webkit-keyframes bien-mat-ben-phai{
            from{
                transform:translate(0%);
            }
            to{
                transform:translate(100%);
            }
        }

        .di-vao-ben-trai{
            animation:di-vao-ben-trai 1s forwards;
        }
        @-webkit-keyframes di-vao-ben-trai{
            from{
                transform:translate(-100%);
            }
            to{
                transform:translate(0%);
            }
        }


        /*Danh muc*/
        .danhmuc{
            padding-top:10px;
            margin-top:20px;
        }
            /*Danh muc header*/
            .danhmuc__header{
                background:#ffffff;
                height:45px;
                border-bottom:1px solid rgba(0,0,0,0.05);
                padding:0 20px;
                align-items:center;
                display:-webkit-flex;
            }
            .danhmuc__header-title{
                font-size:1.6rem;
                font-weight:500;
                color:rgba(0,0,0,0.54);
                text-transform:uppercase;
                flex:1;
                text-overflow:ellipsis;
                white-space:nowrap;
            }

            /*Danh muc header*/


            /*Danh muc content*/
            .danhmuc__content{
                display:flex;
                width:100%;
                flex-wrap:wrap;
            }


            .link-danhmuc{
                /*margin:3px;*/
                width:10%;
                text-decoration:none;
                color:rgba(0,0,0,0.54);
                background-color:#ffffff;
                text-align:center;
                border-right:1px solid rgba(0,0,0,0.05);
                border-bottom:1px solid rgba(0,0,0,0.05);
            }
            .link-danhmuc:hover{
                /*position:relative;*/
                border-color:rgba(0,0,0,0.12);
                box-shadow:0 0 0.8rem 0 rgb(0 0 0 /5%);
            }

            .link-danhmuc__hinhanh{
                height:80px;
                margin-top:10%;
                position:center;
            }
            .link-danhmuc__hinhanh-img{
                height:100%;
                background-repeat:no-repeat;
                background-size:contain;
            }
            .link-danhmuc__tendanhmuc{
                margin:auto;
                width:90%;
            }
            .link-danhmuc__tendanhmuc-name{
                 color:rgba(0,0,0,0.8);
                 font-size:1.2rem;
                 line-height:1.3rem;
                 height:2.6rem;
                 overflow:hidden;
                 margin-bottom:10px;
                 display:block;
                 display:-webkit-box;
                 -webkit-box-orient:vertical;
                 -webkit-line-clamp:2;
                 
                 /*text-overflow:ellipsis;
                 white-space:nowrap;*/
            }
            /*Danh muc content*/

            
            /*SanPham Header*/

            .header-wapper{
                position:static;
                margin-top:40px;
            }
            .title-goiy{
                font-size:1.6rem;
                color:rgba(0,0,0,0.54);
                background-color:var(--while-color);
                padding:15px 45px;
                border-bottom: 3px solid red;
                font-weight:600;
                z-index:999;
            }

            .title-goiy.sticky{
                max-width:1200px;
                position:fixed;
                top:120px;
                width:100%;
            }



            .header-button{
                width:100%;
                text-align:center;
            }
            .header-wapper__xemthem{
                font-size:1.4rem;
                margin-top:20px;
                margin-bottom:20px;
                min-width:390px;
                height:30px;
                border:1px solid rgba(0,0,0,0.12);
                background-color:var(--while-color);
            }

            .header-wapper__xemthem:hover{
                background-color:rgba(0,0,0,0.12);
            }
        /*Danh muc */
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="content">
        <div class="grid">

            <div class="quangcao_sale">
                <div class="quangcao">
                    <div class="quangcao__slides">
                        <asp:Repeater ID="rptQuangCao" runat="server">
                            <ItemTemplate>
                                <a class="slide-link" href="">
                                    <img src="../HinhAnh/Sprites_QuangCao/<%#Eval("AnhQuangCao")%>" class="slide-link__img"/>
                                </a>
                            </ItemTemplate>
                        </asp:Repeater>
                        <div class="nut-slide">
                            <span id="btn-prev"><i class="fas fa-chevron-left"></i></span>
                            <span id="btn-next"><i class="fas fa-chevron-right"></i></span>    
                        </div>
                    </div>
                </div>


                <div class="sale">
                    <div class="sale-img">
                        <a class="sale-img__link" href="#">
                            <img src="../HinhAnh/Sprites_QuangCao/quangcaosale99.png"/>
                        </a>
                    </div>
                    <div class="sale-img">
                         <a class="sale-img__link" href="#">
                            <img src="../HinhAnh/Sprites_QuangCao/quancaosalehoanxu.png"/>
                        </a>
                    </div>
                </div>


            </div>




            <!-- danh muc -->
            <div class="danhmuc">
                <!-- header danh muc -->
                <div class="danhmuc__header">
                    <div class="danhmuc__header-title">Danh Mục</div>
                </div>
                <!-- header danh muc -->

                <!-- content danh muc -->
                <div class="danhmuc__content">
                    <asp:Repeater ID="rptDanhMuc" runat="server">
                        <ItemTemplate>
                                    <a href="DanhMuc.aspx?IdDanhMuc=<%#Eval("IdDanhMuc")%>" class="link-danhmuc">
                                        <div class="link-danhmuc__hinhanh">
                                            <img class="link-danhmuc__hinhanh-img" src="../HinhAnh/Sprites_DanhMuc/<%#Eval("AnhDanhMuc")%>" />
                                        </div>
                                        <div class="link-danhmuc__tendanhmuc">
                                            <div class="link-danhmuc__tendanhmuc-name"> <%#Eval("TenDanhMuc")%></div>
                                        </div>
                                    </a>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
                <!-- content danh muc -->
            </div>
            <!-- danh muc -->



            <div class="header-wapper">
                <div class="title-goiy">
                    <div class="header-goiy">Gợi Ý</div>
                </div>
                <!-- Danh Sach San Pham -->
                <div class="grid__row">
                    <asp:Repeater ID="rptListSP" runat="server">
                        <ItemTemplate>
                 
                            <div class="grid__column-2">
                                <a href="ChiTietSanPham.aspx?IdSP=<%#Eval("IdSP") %>" class="home-product-item">
                                        <img class="home-product-item__img" src="../HinhAnh/Sprites_SP/<%#Eval("AnhSP") %>"/>
                                        <div class="home-product-item__name">
                                            <%#Eval("TenSP") %>
                                        </div>
                                        <div class="home-product-item__price">
                                            <span class="home-product-item__price-old"><%#Eval("GiaSP")%></span>
                                            <span class="home-product-item__price-current"><%#Eval("GiaKhuyenMai")%></span>
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

                </div>
                <div class="header-button">
                    <asp:Button CssClass="header-wapper__xemthem" ID="btnXemThem" runat="server" Text="Xem Thêm" OnClick="btnXemThem_Click"/>
                </div>
            </div>



        </div>
    </div>



    <script src="https://code.jquery.com/jquery-2.2.4.js">
    </script>
    <script>
        $(document).ready(function(){
            //$(window).scroll(function () {
            //    var position_title_goiy = $(".title-goiy").position();
            //    if ($(this).scrollTop() <= (position_title_goiy.top) + 500) {
            //        $('.title-goiy').removeClass('sticky')
            //    }
            //    if ($(this).scrollTop() >= (position_title_goiy.top)) {
            //        $('.title-goiy').addClass('sticky')
            //    }
            //});
            $('.slide-link:first-child').addClass('active');
            $('#btn-next').click(function (event) {
                var slide_sau = $('.active').next();
                var slide_sau_sau = $('.active').next().next();
                if (slide_sau_sau.length !=0) {
                    $('.active').addClass('bien-mat-ben-trai').one('webkitAnimationEnd', function (event) {
                        $('.bien-mat-ben-trai').removeClass('bien-mat-ben-trai').removeClass('active');
                    });
                    slide_sau.addClass('active').addClass('di-vao-ben-phai').one('webkitAnimationEnd', function (event) {
                        $('.di-vao-ben-phai').removeClass('di-vao-ben-phai');
                    });
                } else {
                    $('.active').addClass('bien-mat-ben-trai').one('webkitAnimationEnd', function (event) {
                        $('.bien-mat-ben-trai').removeClass('bien-mat-ben-trai').removeClass('active');
                    });

                    $('.slide-link:first-child').addClass('active').addClass('di-vao-ben-phai').one('webkitAnimationEnd', function (event) {
                        $('.di-vao-ben-phai').removeClass('di-vao-ben-phai');
                    });
                }
   
            });


            $('#btn-prev').click(function (event) {
                var slide_truoc = $('.active').prev();
                console.log(slide_truoc.length);
                if (slide_truoc.length != 0) {
                    $('.active').addClass('bien-mat-ben-phai').one('webkitAnimationEnd', function (event) {
                        $('.bien-mat-ben-phai').removeClass('bien-mat-ben-phai').removeClass('active');
                    });
                    slide_truoc.addClass('active').addClass('di-vao-ben-trai').one('webkitAnimationEnd', function (event) {
                        $('.di-vao-ben-trai').removeClass('di-vao-ben-trai');
                    });
                } else {
                    var slide_last = $('.slide-link').length;
                    $('.active').addClass('bien-mat-ben-phai').one('webkitAnimationEnd', function (event) {
                        $('.bien-mat-ben-phai').removeClass('bien-mat-ben-phai').removeClass('active');
                    });
                    $('.slide-link:nth-child(' + slide_last + ')').addClass('active').addClass('di-vao-ben-trai').one('webkitAnimationEnd', function (event) {
                        $('.di-vao-ben-trai').removeClass('di-vao-ben-trai');
                    });
                }
            });

        });

    </script>

</asp:Content>