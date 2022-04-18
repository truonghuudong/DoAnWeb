<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="ThemKhuyenMai.aspx.cs" Inherits="Form_NguoiBan_QuanLyKhuyenMai_ThemKhuyenMai" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Thêm Khuyến Mãi</title>
    <style>
        .main_themkhuyenmai{
            margin:25px;
        }
        .trangthai_KM{
            display:flex;
            padding:10px;
        }
        .tieude_KM{
            text-align:center;
            font-size:25px;
            color:crimson;
            padding-bottom:5px;
        }        

        
      
        .content_KM{
            margin:auto;
            padding-bottom:30px
        }
        .ma_KM{
            font-size:15px;
            padding-top:5px;
            padding-right:40px;
        }
        .ten_KM{
            font-size:15px;
            padding-top:5px;
            padding-right:35px;
        }
        .tungay_KM{
            font-size:15px;
            padding-top:5px;
            margin-right:50px;
            padding-right:85px;
            display:flex;
        }
        .denngay_KM{
            font-size:15px;
            padding-top:5px;
            margin-right:50px;
            padding-right:78px;
            display:flex;
        }
        .textbox_KM{
            width:200px;
            height:25px
        }
        


        .button_KM{
            display:flex;
            
        }
        .btn_themKM{
            padding-left:180px;
        }
        .btn_suaKM{
            padding-left:40px;
        }
        .btn_themkhuyenmai{
            background-color:var(--primary-color);
            padding:5px;
            
        }
        .btn_themkhuyenmai:hover{
            background-color:rgba(0,0,0,0.5);
        }
        .thongbao_themcapnhat{
            font-size:1.3rem;
            color:var(--primary-color);
        }
        .chitietdanhmuc-danhsach{
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
            margin-top:30px;
        }
            .chitietdanhmuc-danhsach th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .chitietdanhmuc-danhsach td {
                border: 1px solid black;
                text-align: center;
                padding: 8px;
            }
            .chitietdanhmuc-danhsach tr:nth-child(even) {
                background-color: lightgrey;
            }
        .danhsachKM{
            font-size:20px;
            margin-top:30px;
           
            text-align:center;
            
        }
        .thongbao_themcapnhat{
            margin:15px;
        }
        .label{
            padding-left:170px
        }

        .myCalendar{
            z-index: 1;
            margin-top:10px;
            position:absolute;
            background-color: #f2f2f2;  
            width: 250px;  
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
            border:10px solid #4CCAEF !important;
            border-top:0px !important;}
        
            .myCalendar a {  
            text-decoration: none;  }
            
        .myCalendar .myCalendarTitle {  
            font-weight: bold;  
            height:35px;line-height:35px;
            background-color:#4CCAEF;
            color:#ffffff;
        }  
        .myCalendar th.myCalendarDayHeader  
        {
            height:25px;
            border-bottom: outset 2px #fbfbfb; 
            border-right: outset 2px #fbfbfb; 
        }
        .myCalendar td.myCalendarDay {  
            border: outset 2px #fbfbfb;
        }  
          .myCalendar td.myCalendarDay:nth-child(7) a{color:#c52e2e !important;}
        .myCalendar .myCalendarNextPrev {  
            text-align: center;  
        }  

        .myCalendar .myCalendarNextPrev a  {font-size:1px;}
        .myCalendar .myCalendarNextPrev:nth-child(1) a{color:#4CCAEF!important;background:url("prevMonth.png") no-repeat center center;}
        .myCalendar .myCalendarNextPrev:nth-child(1) a:hover,.myCalendar .myCalendarNextPrev:nth-child(3) a:hover{background-color:transparent;}
        .myCalendar .myCalendarNextPrev:nth-child(3) a{color:#4CCAEF!important;background:url("nextMonth.png") no-repeat center center;}
        .myCalendar td.myCalendarSelector a {  
            background-color: #25bae5;  
        }  

        .myCalendar .myCalendarDayHeader a,
        .myCalendar .myCalendarDay a,   
        .myCalendar .myCalendarSelector a,  
        .myCalendar .myCalendarNextPrev a {  
            display: block;  
            line-height: 20px;  
        }  
        .myCalendar .myCalendarToday{  background-color: #f2f2f2; -webkit-box-shadow: 0 0 7px 3px #e5e5e5;
        box-shadow: 0 0 7px 3px #e5e5e5;}
        .myCalendar .myCalendarToday a{color:#25bae5 !important;}
        .myCalendar .myCalendarDay a:hover,   
        .myCalendar .myCalendarSelector a:hover {  
            background-color: #25bae5;  
        }

         .thongke_ngay{
            margin-top:15px;
            display:flex;
        }
        .txtngay:first-child{
            display:flex;
            margin-right:50px;
        }
        .txtngay:first-child input[type=text]{
            margin-left:63px;
        }



        .txtngay:last-child{
            margin-left:50px;
        }

        .input_text{
            margin-left:10px;
            max-width:100px;
            text-align:center;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main_themkhuyenmai">
        <div class="tieude_KM">
            THÔNG TIN ĐỢT KHUYẾN MÃI
        </div>

        <div class="center">
            <div class="content_KM">
               <%-- <div class="trangthai_KM">
                    <div class="ma_KM">
                       Mã Khuyến Mãi
                    </div>
                    <div class="">
                        <asp:TextBox CssClass="textbox_KM" ID="TextBox1" runat="server"></asp:TextBox>
                    </div>                 
                 </div>
                 <div class="trangthai_KM">
                      <div class="ten_KM">
                          Tên Khuyến Mãi
                      </div>
                      <div >
                      </div>
                          <asp:TextBox CssClass="textbox_KM" ID="txt_tenKM" runat="server"></asp:TextBox>
                  </div>--%>
        
                <asp:Label ID="lb_IdKM" runat="server" Hidden="hidden" Text="Label"></asp:Label>
                <div style="display:flex;margin-top:50px;">
                    <div class="tungay_KM">
                        Từ Ngày:
                        <div class="txtngay_input">
                            <asp:TextBox CssClass="input_text input_text_tungay" ID="txt_TuNgay"  runat="server">
                            </asp:TextBox>
                            <asp:Calendar ID="cl_TuNgay"  runat="server" Visible="false" OnSelectionChanged="cl_TuNgay_SelectionChanged" DayNameFormat="FirstLetter" Font-Names="Tahoma" Font-Size="15px" NextMonthText="." PrevMonthText="." SelectMonthText="»" SelectWeekText="›" class="myCalendar" >
                                <OtherMonthDayStyle ForeColor="#b0b0b0" />
                                <DayStyle CssClass="myCalendarDay" ForeColor="#2d3338" />
                                <DayHeaderStyle CssClass="myCalendarDayHeader" ForeColor="#2d3338" />
                                <SelectedDayStyle Font-Bold="True" Font-Size="12px" CssClass="myCalendarSelector" />
                                <TodayDayStyle CssClass="myCalendarToday" />
                                <SelectorStyle CssClass="myCalendarSelector" />
                                <NextPrevStyle CssClass="myCalendarNextPrev" />
                                <TitleStyle CssClass="myCalendarTitle" />
                            </asp:Calendar>
                            <asp:ImageButton ID="ibtn_TuNgay" hidden="hidden" runat="server" OnClick="ibtn_TuNgay_Click"></asp:ImageButton>
                        </div>
                    </div>

                    <div class="denngay_KM">
                        Đến Ngày:
                        <asp:TextBox class="input_text" ID="txt_DenNgay" runat="server"></asp:TextBox>
                        <asp:Calendar ID="cl_DenNgay" runat="server" Visible="false" OnSelectionChanged="cl_DenNgay_SelectionChanged" DayNameFormat="FirstLetter" Font-Names="Tahoma" Font-Size="15px" NextMonthText="." PrevMonthText="." SelectMonthText="»" SelectWeekText="›" CssClass="myCalendar" >
                            <OtherMonthDayStyle ForeColor="#b0b0b0" />
                            <DayStyle CssClass="myCalendarDay" ForeColor="#2d3338" />
                            <DayHeaderStyle CssClass="myCalendarDayHeader" ForeColor="#2d3338" />
                            <SelectedDayStyle Font-Bold="True" Font-Size="12px" CssClass="myCalendarSelector" />
                            <TodayDayStyle CssClass="myCalendarToday" />
                            <SelectorStyle CssClass="myCalendarSelector" />
                            <NextPrevStyle CssClass="myCalendarNextPrev" />
                            <TitleStyle CssClass="myCalendarTitle" />
                        </asp:Calendar>
                        <asp:ImageButton hidden="hidden" ID="ibtn_DenNgay" runat="server" OnClick="ibtn_DenNgay_Click"></asp:ImageButton>
                    </div>
                </div>
        </div>
        
        <div class="thongbao_themcapnhat">
                <asp:Label CssClass="label" ID="lb_thongbao_capnhat" Visible="false" runat="server" text="Thay đổi thành công"></asp:Label>
            </div>
        <div class="button_KM">
            
            <div class="btn_themKM">
                <asp:Button CssClass="btn_themkhuyenmai" ID="btn_them_KM" runat="server" Text="Thêm" onclick="btn_them_KM_Click"/>
            </div>
            <div class="btn_suaKM">
                <asp:Button CssClass="btn_themkhuyenmai" ID="btn_sua_KM" runat="server" Text="Sửa" OnClick="btn_sua_KM_Click"/>
            </div>
        </div>

        <div class="danhsachKM">
            <div>
                Danh sách khuyến mãi
            </div>
            <div >
                <table class="chitietdanhmuc-danhsach">
                    <tr>
                       
                        <th>
                            ID Khuyến Mãi
                        </th>

                        <th>
                            Ngày bắt đầu
                        </th>
                        <th>
                            Ngày kết thúc
                        </th>
                        <th>
                            Trạng thái
                        </th>
                        <th>
                           Thêm SP
                        </th>
                        <th>
                           Chức năng
                        </th>
                    </tr>
                    <asp:Repeater ID="rpt_khuyenmai" runat="server" OnItemDataBound="rpt_khuyenmai_ItemDataBound">
                        <ItemTemplate>
                             <tr>
                                <td>
             
                                    <asp:Label ID="lb_IdKhuyenMai_rpt" runat="server" Text='<%#Eval("IdKhuyenMai")%>'></asp:Label>
                                </td>
                                <td>
                                    
                                    <asp:Label ID="lb_NgayBatDau_rpt" runat="server" Text='<%#Eval("NgayBatDau")%>'></asp:Label>
                                </td>
                                <td>
                                    
                                    <asp:Label ID="lb_NgayKetThuc_rpt" runat="server" Text='<%#Eval("NgayKetThuc")%>'></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox AutoPostBack="true" ID="cb_TrangThai" runat="server" OnCheckedChanged="cb_TrangThai_CheckedChanged"/>
                                </td>
                                <td>
                                    <asp:Button ID="bnt_ThemSP_KM" CommandArgument='<%#Eval("IdKhuyenMai")%>' runat="server" OnClick="bnt_ThemSP_KM_Click" Text="Thêm SP KM" />
                                    <asp:Button ID="btn_ThemSP_KM" CommandArgument='<%#Eval("IdKhuyenMai")%>' runat="server" Text="Xem" OnClick="btn_ThemSP_KM_Click" />
                                </td>
                                <td>
                                    <asp:Button CommandArgument='<%#Eval("IdKhuyenMai")%>' OnClick="btn_sua_Click" ID="btn_sua" runat="server" Text="Sửa" />
                                    <asp:Button  CommandArgument='<%#Eval("IdKhuyenMai")%>' OnClick="btn_xoa_Click" ID="btn_xoa" runat="server" Text="Xóa" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    
                </table>
            </div>
        </div>
    </div>
</div>
        <script type="text/javascript">
            function txt_TuNgayClick() {
                    document.getElementById("<%=ibtn_TuNgay.ClientID%>").click();
            }
            function txt_DenNgayClick() {
                    document.getElementById("<%=ibtn_DenNgay.ClientID%>").click();
            }
        </script>

</asp:Content>

