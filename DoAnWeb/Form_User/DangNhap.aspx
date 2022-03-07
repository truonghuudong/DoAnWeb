<%@ Page Title="" Language="C#" MasterPageFile="~/Form_User/MasterPage.master" AutoEventWireup="true" CodeFile="DangNhap.aspx.cs" Inherits="DangNhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <!-- add css -->
    <link rel="stylesheet" href="https://pagecdn.io/lib/normalize/8.0.1/normalize.min.css" />
    <link rel="stylesheet" href="../CSS/base.css" />
    <link rel="stylesheet" href="../Font/fontawesome-free-5.15.3-web/fontawesome-free-5.15.3-web/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <!-- add css -->


    <style>
        /*form dang nhap*/
        .content{
            width:100%;
            height:calc(100% - 100px);
            background-color:#f0f0f0;
            display:flex;
        }
        .formDangNhap{
            background-color:var(--while-color);
            width:450px;
            height:455px;
            margin:auto;
            box-shadow:1px 1px 3px #999;
            border-radius:5px;
        }



        /*css container*/
        .formDangNhap__container{
            padding:0 32px;
        }
        

        /*css Dang Nhap Header*/
        .formDangNhap__header{
            display:flex;
            align-items:center;
        }

        .formDangNhap__header-btnDN{
            margin: 22px auto;
            font-size:1.6rem;
            color:var(--primary-color)
        }
        /*css Dang Nhap Header*/

        /*Dang Nhap input*/
        .formDangNhap__form{
            font-size:1.6rem;
        }
        .formDangNhap__input{
            width:100%;
            height:40px;
            margin-top:16px;
            padding:0 12px;
            font-size:1.6rem;
            border:1px solid var(--border-color);
            border-radius:2px;
            outline:none;    
        }

        .formDangNhap__input:focus{
            border-color:#777;
        }
        /*Dang Nhap input*/


        /*Check Remember*/
        .formDangNhap__remember{
            align-items:center;
            margin-top:10px;
            display:flex;
            margin-left:80%;
            font-size:1.6rem;
        }
        .formDangNhap__remember-checkbox{
            margin-right:5px;
            font-size:1.6rem;
        }

        .formDangNhap__remember-name{
            color:var(--text-color);
        }
        /*Check Remember*/
        
        
        /*captcha*/
        .formDangNhap_captcha{
            margin-top:15px;
            display:flex;
            align-items:center;
        }
        .captcha_text{
            padding:10px;
            margin-left:45%;
            font-size:2.4rem;
            border: solid 1px red;
            border-radius:5px;
            color:silver;
        }
        .formDangNhap__input-captcha{
            width:50%;
            height:40px;
            padding:0 12px;
            font-size:1.6rem;
            border:1px solid var(--border-color);
            border-radius:2px;
            outline:none;   

        }
        /*captcha*/


        /*notify*/
        .formDangNhap__notify{
            margin-top:20px;
            text-align:center;
            height:1.4rem;
        }
        .notify-label{
            font-size:1.4rem;
            color:red;
        }
        /*notify*/



        /* formDangNhap controls */
        .formDangNhap__controls{
            display:flex;
            margin-top:65px;
            justify-content:flex-end;
        }

        .formDangNhap__btn{
            min-width:142px;
            height:36px;
        }


        .formDangNhap__controls-back{
            margin-right:8px;
        }

        /* formDangNhap controls */
        
        
        
        /* Mang xa hoi */
        .formDanhNhap__socials{
            background-color:#f5f5f5;
            padding:16px 36px;
            display:flex;
            margin-top:5px;
            justify-content:space-between;
            border-bottom-left-radius:5px;
            border-bottom-right-radius:5px;
        }

        .formDanhNhap__socials-icon{
            font-size:1.8rem;
        }

        /*button facebook*/
        .formDanhNhap__socials--facebook{
            background-color:#3A5A98;
            color:var(--while-color);
        }
        

        /*icon facebook in button*/
        .formDanhNhap__socials--facebook
        .formDanhNhap__socials-icon{
            color:var(--while-color);
        }

        /*button google*/
        .formDanhNhap__socials--google{
            background-color:var(--while-color);
            color:#666;
        }

        /*icon google in button*/
        .formDanhNhap__socials--google
        .formDanhNhap__socials-icon{
            color:#666;
        }

        .formDanhNhap__socials-label{
            margin:0 20px;
        }
        /* Mang xa hoi */
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <!-- Content -->
    <div class="content">


         <!-- formDangNhap -->
        <div class="formDangNhap">

            <!-- container -->
            <div class="formDangNhap__container">


                <!-- Dang Nhap Header -->
                <div class="formDangNhap__header">
                    <h3 class="formDangNhap__header-btnDN">Đăng Nhập</h3>
                </div>
                <!-- Dang Nhap Header -->


                <!-- Dang Nhap input -->
                <div class="formDangNhap__form">
                    <div class="formDangNhap__group">
                        <asp:TextBox ID="inputTenDN" runat="server"  class="formDangNhap__input" type="text" placeholder="Tên đăng nhập" ></asp:TextBox>
                    </div>
                    <div class="formDangNhap__group">
                        <asp:TextBox ID="inputPassword" runat="server" class="formDangNhap__input" TextMode="Password" placeholder="Mật khẩu của bạn" ></asp:TextBox>
                    </div>
                </div>
                <!-- Dang Nhap input -->

                <!--Captcha-->
                <div class="formDangNhap_captcha">
                    <asp:TextBox AutoPostBack="true" OnTextChanged="txtcaptcha_TextChanged"  class="formDangNhap__input-captcha" ID="txtcaptcha" runat="server" placeholder="Captcha"></asp:TextBox>
                    <asp:Label CssClass="captcha_text" ID="lbcaptcha" runat="server"></asp:Label>
                </div>
                <!--Captcha-->

                <!--Remember-->
                <div class="formDangNhap__remember">
                    <asp:CheckBox ID="ckRememberUser" runat="server" CssClass="formDangNhap__remember-checkbox"/>
                    <span class="formDangNhap__remember-name">Ghi Nhớ</span>
                </div>
                <!--Remember-->



                <div class="formDangNhap__notify">
                    <asp:Label ID="lbNotify_DangNhap" runat="server" CssClass="notify-label"></asp:Label>
                </div>


                


                <!-- formDangNhap controls -->
                <div class="formDangNhap__controls">
                    <asp:Button class="btn btn--normal formDangNhap__controls-back" runat="server" OnClick="click_GoBack" ID="btnTroLai" text="TRỞ LẠI"/>
                    <asp:Button class="btn btn--primary" runat="server" ID="btnDangNhap_1" OnClick="click_DangNhap" text="ĐĂNG NHẬP"/>      
                </div>
                <!-- formDangNhap controls -->

            </div>
             <!-- container -->
            
            <!-- Mang xa hoi -->
            <div class="formDanhNhap__socials">
                <!-- facebook -->
                <a href="" class="formDanhNhap__socials--facebook btn btn-size-s btn-with-icon " >
                    <i class="formDanhNhap__socials-icon fab fa-facebook-square"></i>
                    <span class="formDanhNhap__socials-label">Kết nối với facebook</span>
                </a>
                <!-- facebook -->

                <!-- google -->
                <a href="" class="formDanhNhap__socials--google btn btn-size-s btn-with-icon">
                    <i class="formDanhNhap__socials-icon fab fa-google"></i>
                    <span class="formDanhNhap__socials-label">Kết nối với google</span>
                </a>
                <!-- google -->
            
            </div>
            <!-- Mang xa hoi -->

        </div>
         <!-- formDangNhap -->

    </div>
     <!-- Content -->
</asp:Content>

