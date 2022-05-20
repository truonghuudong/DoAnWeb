<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="DoiMatKhau.aspx.cs" Inherits="Form_NguoiBan_QuanLyTaiKhoan_DoiMatKhau" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Đổi mật khẩu</title>
    <style>
        .title_doimatkhau{
            font-size:2rem;
            border-bottom:1px solid rgba(0,0,0,0.3);
            
        }
         .title-mota{
            margin-top:5px;
            height:2rem;
            font-size:1.5rem;
            
        }
        .content_doimatkhau{
            padding-top:20px;
        }
        .row-label{
            display:flex;
            margin:35px 0;
            align-items:center;
        }
        .label-thongtinhoso{
            text-align:right;
            width:20%;
            font-size:1.5rem;
            font-weight:400;
        }
        .input-thongtin{
            margin-left:30px;
            font-size:1.5rem;
        }
        .txt_tennguoidung{
            width:250px;
            height:30px;
            font-size:15px;
        }
        .btn_xacnhan{
            background-color:var(--primary-color);
        }
        .btn_xacnhan:hover{
            background-color:rgba(0,0,0,0.5);
        }
        .button{
            margin-top:50px;
            margin-left:30%;
         
        }
        .thongbao_capnhat{
            font-size:1.3rem;
            color:var(--primary-color);
            margin-bottom:15px;
            margin-left:-20px;
        }
        .doimatkhau{
            margin-left:15px;
            background-color:var(--while-color);
            padding: 10px 10px 10px 10px;
            border-radius:3px;
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="doimatkhau">
        <div class="title_doimatkhau">
            Đổi Mật Khẩu
            <div class="title-mota">
                Để bảo mật tài khoản, vui lòng không chia sẻ mật khẩu cho người khác
            </div>
            
        </div>

        <div class="content_doimatkhau">
            <div class="row-label">
                    <div class="label-thongtinhoso">
                        Mật khẩu cũ
                    </div>
                    <div class="input-thongtin">
                        <asp:TextBox CssClass="txt_tennguoidung" TextMode="Password"  ID="txt_matkhaucu" runat="server"></asp:TextBox>
                    </div>
                </div>

            <div class="row-label">
                    <div class="label-thongtinhoso">
                        Mật khẩu mới
                    </div>
                    <div class="input-thongtin">
                        <asp:TextBox CssClass="txt_tennguoidung" TextMode="Password"  ID="txt_matkhaumoi" runat="server"></asp:TextBox>
                    </div>
                </div>

            <div class="row-label">
                    <div class="label-thongtinhoso">
                        Xác nhận mật khẩu mới
                    </div>
                    <div class="input-thongtin">
                        <asp:TextBox CssClass="txt_tennguoidung"  TextMode="Password"  ID="txt_xacminhMK" runat="server"></asp:TextBox>
                    </div>
                </div>
        </div>
        <div class="button">
            <div class="thongbao_capnhat">
                <asp:Label ID="lb_thongbao_capnhat" runat="server"  ></asp:Label>
            </div>
            <asp:Button CssClass="btn btn_xacnhan" ID="xacnhan" runat="server" Text="Xác Nhận" OnClick="xacnhan_Click"/>
        </div>
    </div>


</asp:Content>

