<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="ThemSanPham.aspx.cs" Inherits="Form_NguoiBan_QuanLySanPham_ThemSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <title>Thêm Sản Phẩm</title>
    <style>
        .suasanpham-title {
            font-size: 1.7rem;
            background-color: var(--while-color);
            margin-left: 20px;
            font-weight: 900;
            padding: 15px 5px;
            font-weight: 500;
            border-radius: 5px;
        }
        .chitietsanpham {
            font-size: 1.2rem;
            padding: 20px;
        }
        .chitietsanpham div {
            margin-bottom: 8px;
        }
        .idSP {
            color: red;
        }
        .loaiSP {
            width: 40px;
        }
        .soLuongSP {
            width: 60px;
        }
        .tenSanPham {
            width: 450px;
            height: 30px;
        }
        .giaSP {
            width: 85px;
        }
        .moTaSP {
            width: 750px;
            height: 200px;
        }
        .btn_xacnhan {
            margin-top:5px;
            margin-left:200px;
            cursor: pointer;
            font-size: 1.6rem;
            margin-right: 5px;
        }
        .btn_xacnhan:hover {
            background-color: coral;
         }
        .upload-btn-wrapper {
            margin-top: 5px;
            position: relative;
            overflow: hidden;
            display: inline-block;
        }
        .btnFileUpload {
            border: 2px solid gray;
            color: var(--text-color);
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

        .chitietsanpham{
            border-radius:3px;
            margin-top:15px;
            margin-left:20px;
            background-color:var(--while-color);
        }
        .chitietsanpham-items{
            display:flex;
            align-items:baseline;
        }
        .chitietsanpham-items_title{
            width:200px;
            font-size:1.5rem;
            font-weight:600;
        }
        .ibtn_Anh{
            width:150px;
            height:150px;
        }

        .thongbao{
            margin-top:15px;
            font-size:1.5rem;
            color:var(--primary-color);
        }
    </style>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="phanthan">
        <div class="suasanpham" id="form_suasanpham" runat="server" visible="false">
            <div class="suasanpham-title">
                Sửa Sản phẩm
            </div>
            <%--  --%>
            <div class="chitietsanpham">
                <div class="chitietsanpham-items" style="display:none">
                    Id Sản phẩm :
                   <asp:Label class="idSP" ID="lb_IdSP" runat="server" Text="Label"></asp:Label>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Danh Mục
                    </div>
                    <asp:DropDownList AutoPostBack="true" ID="ddl_danhMuc_Sua" OnSelectedIndexChanged="ddl_DanhMuc_SelectedIndexChanged" runat="server"></asp:DropDownList>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Loại sản phẩm:
                    </div>
                    <asp:DropDownList AutoPostBack="true" ID="ddl_LoaiSP_Sua" runat="server"></asp:DropDownList>
                    <%--<asp:TextBox class="loaiSP" TextMode="Number" ID="txt_LoaiSP_Them" runat="server"></asp:TextBox>--%>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Tên sản phẩm:
                    </div>
                   <asp:TextBox class="tenSanPham" TextMode="SingleLine" ID="txt_TenSP" runat="server"></asp:TextBox>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Số lượng sản phẩm:
                    </div>
                    <asp:TextBox TextMode="Number" MaxLength="0" class="soLuongSP" ID="txt_SoLuongSP" runat="server"></asp:TextBox>
                </div>
                <div class="chitietsanpham-items">
                    <div class="danhmuc_ibtn">
                        <asp:Image ID="imgHinhAnh" runat="server" CssClass="ibtn_Anh" />
                        <div></div>
                        <%--<label runat="server" id="lbUploadHinhAnh" class="file-upload"> <span><strong>Upload Image</strong></span> <asp:FileUpload ID="fileUpload" runat="server" > </asp:FileUpload> </label>   
                        <asp:Button ID="btnUpload" runat="server" Text="Button" Style="display:none" OnClick="btnUpload_Click"/>--%>
                        <div class="upload-btn-wrapper" id="btn_upload_file" runat="server">
                            <asp:Button class="btnFileUpload" ID="btnUpload" runat="server" Text="Hình Ảnh" OnClick="btnUpload_Click" />
                            <asp:FileUpload ID="fileUpload" runat="server" />
                            <asp:Label ID="lb_thongbao_danhmuc_anhdanhmuc" runat="server" hidden="hidden"></asp:Label>
                        </div>
                    </div>
                    <%-- ok rooif ddo h css lai di con cais btn xoa , loix --%>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Giá sản phẩm:
                    </div>
                    <asp:TextBox ID="txt_GiaSP" class="giaSP" TextMode="Number" runat="server"></asp:TextBox>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Mô tả
                    </div>
                    <br />
                    <asp:TextBox ID="txt_MoTaSP" class="moTaSP" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                       
                    </div>
                    <br />
                    <asp:Label CssClass="thongbao" ID="lb_thongBao_Sua" runat="server" Text=""></asp:Label>
                </div>
                <div>
                    <asp:Button class="btn_xacnhan" runat="server" Text="Xác Nhận" OnClick="btn_SuaSP" />
                </div>
            </div>
            

        </div>
        <!--------------------THÊM SẢN PHẨM  -------------------->
        <div class="themsanpham" id="form_themsp" runat="server" visible="false">
            <div class="suasanpham-title">
                Thêm Sản phẩm
            </div>
            <div class="chitietsanpham">
                <%--<div>
                    Id Sản phẩm :
               <asp:Label class="idSP" ID="Label1" runat="server" Text="Label"></asp:Label>
                </div>--%>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Danh Mục
                    </div>
                    <asp:DropDownList AutoPostBack="true" ID="ddl_DanhMuc" OnSelectedIndexChanged="ddl_DanhMuc_SelectedIndexChanged" runat="server"></asp:DropDownList>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Loại sản phẩm:
                    </div>
                    <asp:DropDownList ID="ddl_LoaiSP" runat="server"></asp:DropDownList>
                    <%--<asp:TextBox class="loaiSP" TextMode="Number" ID="txt_LoaiSP_Them" runat="server"></asp:TextBox>--%>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Tên sản phẩm:
                    </div>
                   <asp:TextBox class="tenSanPham" TextMode="SingleLine" ID="txt_TenSP_Them" runat="server"></asp:TextBox>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Số lượng sản phẩm:
                    </div>
                    <asp:TextBox TextMode="Number" MaxLength="0" class="soLuongSP" ID="txt_SoLUongSP_Them" runat="server"></asp:TextBox>
                </div>
                <div class="chitietsanpham-items"> 
                    <div class="danhmuc_ibtn">
                        <asp:Image ID="img_HinhAnh_Them" runat="server" CssClass="ibtn_Anh" />
                        <div></div>
                        <%--<label runat="server" id="lbUploadHinhAnh" class="file-upload"> <span><strong>Upload Image</strong></span> <asp:FileUpload ID="fileUpload" runat="server" > </asp:FileUpload> </label>   
                        <asp:Button ID="btnUpload" runat="server" Text="Button" Style="display:none" OnClick="btnUpload_Click"/>--%>
                        <div class="upload-btn-wrapper" id="Div1" runat="server">
                            <asp:Button class="btnFileUpload" ID="btn_Anh_Them" runat="server" Text="Hình Ảnh" OnClick="btn_Anh_Them_Click" />
                            <asp:FileUpload ID="fileUpload_Them" runat="server" />
                            <asp:Label ID="lb_HinhAnh_Them" runat="server" hidden="hidden"></asp:Label>
                        </div>
                    </div>
                    <%-- ok rooif ddo h css lai di con cais btn xoa , loix --%>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Giá sản phẩm:
                    </div>
                <asp:TextBox ID="txt_GiaSP_Them" class="giaSP" TextMode="Number" runat="server"></asp:TextBox>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                        Mô tả
                    </div>
                    <asp:TextBox ID="txt_MoTa_Them" class="moTaSP" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="chitietsanpham-items">
                    <div class="chitietsanpham-items_title">
                       
                    </div>
                    <br />
                    <asp:Label CssClass="thongbao" ID="lb_thongBao_Them" runat="server" Text=""></asp:Label>
                </div>

                <div>
                    <asp:Button ID="btn_themsp" class="btn_xacnhan" runat="server" Text="Xác Nhận" OnClick="btnThemSP" />
                </div>
            </div>
            <%--BUTTON XAC NHAN THEM--%>
        </div>
    </div>

    <script type="text/javascript">
        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUpload.ClientID %>").click();
            }
        }
        function UploadFileThem(fileUpload_Them) {
            if (fileUpload_Them.value != '') {
                document.getElementById("<%=btn_Anh_Them.ClientID %>").click();
            }
        }

    </script>

</asp:Content>

