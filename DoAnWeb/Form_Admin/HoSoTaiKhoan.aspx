<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_Admin.master" AutoEventWireup="true" CodeFile="HoSoTaiKhoan.aspx.cs" Inherits="Form_Admin_HoSoTaiKhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Hồ sơ tài khoản</title>
    <style>
        .title-hosotaikhoan{
            font-size:2rem;
            border-bottom:1px solid rgba(0,0,0,0.3);
            display:flex;
            align-items:center;
        }
        
        .title-mota{
            margin-top:5px;
            height:2rem;
            font-size:1.5rem
        }
        .hoso-content{
            display:flex;
        }
        .content-label{
            width:65%;
            text-align:right;
            padding:0px 15px 0 0;
        }
        .content-hinhanh{
            width:35%;
        }
        .label-thongtinhoso{
            text-align:right;
            width:20%;
            font-size:1.5rem;
            font-weight:600;
        }
        .row-label{
            margin:35px 0;
            display:flex;
            align-items:center;
        }
        .input-thongtin{
            margin-left:30px;
            font-size:1.5rem;
        }
        .txt_tennguoidung{
           margin-left:-3px;
           width:250px;
           height:35px;
           font-size:1.7rem;
        }

        .img_hoso-hinhanh{
            width:100px;
            height:100px;
            border-radius:50px;
        }

        .content-hinhanh_thongtin{
            margin-top:30px;
            text-align:center;
            border-left:1px solid rgba(0,0,0,0.3);
        }
        .upload-btn-wrapper {
            margin-top:15px;
            position: relative;
            overflow: hidden;
            display: inline-block;
        }

        .btnFileUpload {
            border: 2px solid gray;
            color:var(--text-color);
            background-color: white;
            padding: 4px 15px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
        }

        .upload-btn-wrapper input[type=file] {
            font-size: 50px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }
        .button{
            margin-top:30px;
            margin-left:15%;
         
        }

        .btnLuu{
            background-color:var(--primary-color);
            margin-top:15px;


        }
        .btnLuu:hover{
            background-color:#f05d40;
        }
        .btn_doimatkhau{
            background-color:var(--primary-color);
            margin-left:50px;
            padding:5px;
            border:none;
            box-shadow:rgba(0,0,0,0.2) 2px 2px;
        }
        .btn_doimatkhau:hover{
            cursor:pointer;
            background-color:#f05d40;
        }
        .thongbao_capnhat{
            font-size:1.3rem;
            color:var(--primary-color);
        }
        .btn_doimatkhauhoso{
            
        }
        .hosotaikhoan{
            background-color:var(--while-color);
            padding: 10px 10px 10px 10px;
            border-radius:3px;
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
        }
    </style>
    <script type="text/javascript">
        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUpload.ClientID%>").click();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="hosotaikhoan">
        <div class="title-hosotaikhoan">
            <div>
                 Hồ Sơ Của Tôi
                 <div class="title-mota">Quản lý thông tin hồ sơ để bảo mật tài khoản</div>
            </div>
           <div class="btn_doimatkhauhoso">
               <asp:Button class="btn_doimatkhau" ID="btn_DoiMatKhau" runat="server" Text="Đổi Mật Khẩu" onclick="btn_DoiMatKhau_Click"/>
           </div>
            
        </div> 
        <div class="hoso-content">
           
            <%-- Thong tin --%>
            <div  class="content-label">
                <div class="row-label">
                    <div class="label-thongtinhoso">
                        Tên Đăng Nhập
                    </div>
                    <div class="input-thongtin">
                        <asp:Label ID="lb_hoso_tendangnhap" runat="server" Text="huudong1105"></asp:Label>
                    </div>
                </div>
                <div class="row-label">
                    <div class="label-thongtinhoso">
                        Tên
                    </div>
                    <div class="input-thongtin">
                        <asp:TextBox CssClass="txt_tennguoidung" ID="txt_tennguoidung" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row-label">
                    <div class="label-thongtinhoso">
                        Email
                    </div>
                    <div class="input-thongtin">
                        <asp:Label ID="lb_hoso_email" runat="server" Text="dongtruong1105200@gmail.com"></asp:Label>
                    </div>
                </div>
                <div class="row-label">
                    <div class="label-thongtinhoso">
                        Số Điện Thoại
                    </div>
                    <div class="input-thongtin">
                        <%--<asp:Label ID="lb_hoso_sodienthoai" runat="server" Text="08125436259"></asp:Label>--%>
                        <asp:TextBox CssClass="txt_tennguoidung" ID="txt_SoDienThoai" runat="server"></asp:TextBox>
                    </div>
                </div>




            </div>
            <%-- Hinh Anh --%>
            <div class="content-hinhanh">
                <div class="content-hinhanh_thongtin">
                    <div>
                        <asp:Image CssClass="img_hoso-hinhanh" ImageUrl="~/HinhAnh/AnhDaiDien.jpg" ID="img_hoso_hinhanh" runat="server" />
                    </div>
                    
                    <div class="upload-btn-wrapper" id="btn_upload_file" runat="server">
                        <asp:Button class="btnFileUpload" ID="btnUpload" runat="server" Text="Chọn Ảnh" OnClick="btnUpload_Click"/>
                        <asp:FileUpload ID="fileUpload" runat="server" />
                        <asp:Label ID="lb_thongbao_hoso_anhdanhmuc" runat="server" Hidden="hidden"></asp:Label>
                    </div>
                </div>

            </div>
        </div>
        
        <div class="button">
            <div class="thongbao_capnhat">
                <asp:Label ID="lb_thongbao_capnhat" runat="server" ></asp:Label>
            </div>
            <asp:Button CssClass="btn btnLuu" ID="btn_luu_hoso" runat="server" Text="Lưu" OnClick="btn_luu_hoso_Click"/>

        </div>
    </div>

</asp:Content>

