<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="TatCaSanPham.aspx.cs" Inherits="Form_NguoiBan_QuanLySanPham_TatCaSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .sanpham-title {
            font-size: 1.7rem;
            background-color: var(--while-color);
            margin-left: 20px;
            padding: 15px 5px;
            font-weight: 500;
            border-radius: 5px;
        }

        .girdview {
            margin: 20px;
        }

        .btn_gridview {
            font-size: 1.3rem;
            margin-bottom: 10px;
            cursor: pointer;
            margin: 5px;
        }

            .btn_gridview:hover {
                background-color: var(--primary-color);
            }


        /*form*/
        .form_chinhsuasanpham {
            display: flex;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            position: fixed;
        }

        .form_overlay {
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.4);
        }

        .form_body {
            padding: 15px;
            margin: auto;
            background-color: var(--while-color);
            z-index: 1;
            border-radius: 5px;
        }

        .body-inner_title {
            font-size: 1.5rem;
            color: var(--primary-color);
            font-weight: 600;
            text-align: center;
        }

        .body-inner_ibtn {
            margin-top: 5px;
            text-align: center;
        }

        .fileUpload-button {
            /*width:120px;*/
            margin-left: 35px;
            position: relative;
            width: 120px;
            height: 120px;
            overflow: hidden;
        }

        .body-inner_ibtn input[type=image] {
            border-radius: 60px;
            width: 120px;
            height: 120px;
        }

        .fileUpload {
            font-size: 120px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }


        .body-inner_txt {
            text-align: center;
            margin-top: 5px;
        }

            .body-inner_txt input[type=text] {
                text-align: center;
                font-size: 1.5rem;
                margin: 3px 0;
            }

        .form__body-thongbao {
            margin: 5px 0;
            font-size: 1.3rem;
            color: red;
            text-align: center;
        }

        .body-inner_button {
            margin-top: 5px;
            text-align: center;
        }

            .body-inner_button input[type=submit] {
                padding: 2px 0;
                min-width: 94px;
                font-size: 1.5rem;
                border-radius: 5px;
            }

                .body-inner_button input[type=submit]:hover {
                    background-color: var(--primary-color);
                    border-radius: 5px;
                }

        .nguoiban {
            margin-top: 30px;
        }

        .padding10 {
            padding: 10px;
        }

        .checkbox_gridview {
            padding: 10px;
            cursor: pointer;
        }

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
                    min-width:80px;
                    min-height:29px;
                    max-height:29px;
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
                    min-width:80px;
                    min-height:25px;
                    font-size:2rem;
                    font-weight:bold;
                }
                .btn_page_nextprev:hover{
                    background-color:var(--primary-color);
                }
                /*phan trang*/


    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="phanthan">
        <div class="sanpham">
            <div class="sanpham-title">
                Tất cả Sản phẩm
            </div>
            <div class="girdview">
                <asp:GridView runat="server" ID="gv_tatcasp" AllowSorting="True" Width="100%" AutoGenerateColumns="False">
                    <AlternatingRowStyle BackColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                    <Columns>
                        <%--id sản phẩm--%>
                        <asp:TemplateField HeaderText="Id Sản phẩm">
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_idSanPham" runat="server" Text='<%#Eval("IdSP")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--id loại sản phẩm--%>
                        <asp:TemplateField HeaderText="ID Loại sản phẩm">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_idLoaiSP" runat="server" Text='<%#Eval("IdLoaiSP")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--tên sản phẩm--%>
                        <asp:TemplateField HeaderText="Tên sản phẩm">
                            <HeaderStyle HorizontalAlign="Center" />
                            <%--<ItemStyle HorizontalAlign="Center" />--%>
                            <ItemTemplate>
                                <div class="padding10">
                                    <asp:Label ID="lb_TenSanPham" runat="server" Text='<%#Eval("TenSP")%>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- Ảnh sản phẩm--%>
                        <asp:TemplateField HeaderText="Hình ảnh">
                            <HeaderStyle HorizontalAlign="Center" Width="80px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <div class="padding10">
                                    <img style="width: 50px; height: 50px; border-radius: 25px;" src='../../HinhAnh/Sprites_SP/<%#Eval("AnhSP")%>' />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- Giá sản phẩm--%>
                        <asp:TemplateField HeaderText="Giá sản phẩm">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label class="padding10" ID="lb_GiaSP" runat="server" Text='<%#Eval("GiaSP")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- Số lượng sản phẩm--%>
                        <asp:TemplateField HeaderText="Số lượng">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label class="padding10" ID="lb_SoLuong" runat="server" Text='<%#Eval("SoLuong")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- Mô tả sản phẩm--%>
                        <%--<asp:TemplateField HeaderText="Mô tả" >
                            <HeaderStyle HorizontalAlign="Center"/>
                            <%--<ItemStyle HorizontalAlign="Center"/>
                            <ItemTemplate>
                               <div class="padding10">
                                   <asp:Label ID="lb_MoTa" runat="server" Text='<%#Eval("MoTa")%>'></asp:Label>
                               </div> 
                            </ItemTemplate>
                          </asp:TemplateField>--%>

                        <%-- Trạng thái sản phẩm--%>
                        <asp:TemplateField HeaderText="Trạng thái">
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:CheckBox class="checkbox_gridview" AutoPostBack="true" ID="cb_trangthai" runat="server" OnCheckedChanged="cb_trangthai_CheckedChanged" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Chức năng">
                            <HeaderStyle HorizontalAlign="Center" Width="120px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <div class="hover ">
                                    <asp:Button class="btn_gridview" CommandArgument='<%#Eval("IdSP")%>' ID="btn_Sua" runat="server" Text="Sửa" OnClick="btn_Sua_Click"></asp:Button>
                                    <%--<asp:Button class="btn_gridview" CommandArgument='<%#Eval("IdSP")%>' ID="btn_Xoa" runat="server" Text="Xóa" OnClick="btn_Xoa_Click"></asp:Button>--%>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <%-- <asp:Label class="idSP" ID="lb_IdSP" runat="server" Text="Label"></asp:Label>--%>

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



    <%-- <div class="form_chinhsuasanpham" runat="server" id="form_chinhsuasanpham">
        <div class="form_overlay">
        </div>
        <div class="form_body">
            <div class="body-inner">
                <div class="body-inner_title">
                    <asp:label id="lb_form_title" cssclass="label-title" runat="server" text="sửa sản phẩm"></asp:label>
                </div>
                <div class="body-inner_ibtn">
                    <div class="fileupload-button" runat="server" id="fileupload_button">
                        <asp:imagebutton id="ibtn_anhsanpham" imageurl="~/hinhanh/sprites_sp/" onclick="ibtn_anhdaidien_click" runat="server"/>
                        <asp:fileupload cssclass="fileupload" id="fileupload" runat="server" />
                        <asp:label id="lb_linkanhtamthoi" runat="server" hidden="hidden"></asp:label>
                    </div>
                </div>
                <div class="body-inner_txt">
                    <asp:label id="lb_idsanpham_form" runat="server" hidden="hidden"></asp:label>
                    <asp:textbox id="txt_tensanpham_form" placeholder="tên sản phẩm" runat="server"></asp:textbox>
                    <div></div>
                    <asp:textbox id="txt_soluong_form" runat="server" placeholder="số lượng"></asp:textbox>
                    <div></div>
                    <asp:textbox id="txt_giasanpham_form" runat="server" placeholder="giá sản phẩm"></asp:textbox>
                    <div></div>
                    <asp:textbox id="txt_mota_form" runat="server" placeholder="mô tả"></asp:textbox>
                </div>
                <div class="form__body-thongbao">
                    <asp:label id="lb__form_thongbao" runat="server" text="label"></asp:label>
                </div>
                <div class="body-inner_button">
                    <asp:button  id="btn_xacnhan_form" runat="server" text="xác nhận" onclick="btn_xacnhan_form_click"/>
                    <asp:button  id="btn_thoat_form" runat="server" text="thoát" onclick="btn_thoat_form_click"/>
                </div>
            </div>
        </div>
    </div>--%>
    
</asp:Content>

