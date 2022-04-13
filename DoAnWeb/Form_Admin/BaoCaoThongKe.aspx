<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_Admin.master" AutoEventWireup="true" CodeFile="BaoCaoThongKe.aspx.cs" Inherits="Form_Admin_BaoCaoThongKe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<title>Báo cáo thống kê</title>
 <style>
        .BaoCao-title{
            font-size:1.7rem;
            background-color:var(--while-color);
            padding:15px 5px;
            font-weight:600;
            border-radius:5px;
        }
        .BaoCao-girdview{
            margin-top:5px;
        }
        .baocao-thongke{
            margin-top:10px;
            background-color:var(--while-color);
            font-size:1.5rem;
            border-radius:5px;
            padding:10px 0px 10px 5px;
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
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
        .thongbao{
            margin-left:30px;
            color:var(--primary-color);
        }

            

        .thongke{
            margin-top:10px;
        }

        .thongke-danhsach{
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }
            .thongke-danhsach th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .thongke-danhsach td {
                border: 1px solid black;
                text-align: center;
                padding: 8px;

            }
            .thongke-danhsach tr:nth-child(even) {
                background-color: lightgrey;
            }

    </style>

    <%--<script type="text/javascript">
        function TextBox(txt_TuNgay) {
            if (txt_TuNgay.value != '') {
                document.getElementById("<%=ibtn_TuNgay.ClientID %>").click();
            }
        }
    </script>--%>
    
    <script type="text/javascript">
        function txt_TuNgayClick() {
                document.getElementById("<%=ibtn_TuNgay.ClientID%>").click();
        }
        function txt_DenNgayClick() {
                document.getElementById("<%=ibtn_DenNgay.ClientID%>").click();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="BaoCaoThongKe">
            <div class="BaoCao-title"> 
                Thống Kê
            </div>
            <%--<div class="BaoCao-girdview">
                <asp:gridview runat="server" ID="gv_BaoCao" AllowSorting="True" Width="100%" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="IdTaiKhoan" HeaderText="Id Tài Khoản" />
                        <asp:BoundField DataField="TenNguoiBan" HeaderText="Tài khoản" />
                        <asp:BoundField DataField="DoanhThu" HeaderText="Doanh Thu"/>
                    </Columns>
                </asp:gridview>
            </div>--%>
            <div class="baocao-thongke">
                <div class="thongke_tylethanhtoan">
                    Tỷ lệ thanh toán:
                    <asp:TextBox AutoPostBack="true" class="input_text" ID="txt_TyleThanhToan" OnTextChanged="txt_TyleThanhToan_TextChanged" Text="10" runat="server"></asp:TextBox>

                </div>
                <div class="thongke_ngay">
                    <div class="txtngay">
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
                    <div class="txtngay">
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

                    <div class="thongbao">
                        <asp:Label ID="lb_thongbao" runat="server" Text=""></asp:Label>
                    </div>
                </div>

            </div>

            <div class="thongke">
                <table class="thongke-danhsach">
                    <tr>
                        <th style="min-width:100px;">ID</th>
                        <th style="min-width:130px;">Nhà Cung Cấp</th>
                        <th style="min-width:130px;">Tổng Doanh Thu</th>
                        <th style="min-width:130px;">Thuế</th>
                        <th>Doanh Thu Sau Thuế</th>
                        <th>Doanh Thu Của WebSite</th>
                    </tr>
                    <asp:Repeater ID="rpt_ThongKe" OnItemDataBound="rpt_ThongKe_ItemDataBound" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%#Eval("IdTaiKhoan")%>
                                </td>
                                <td>
                                    <%#Eval("TenNguoiBan")%>
                                </td>
                                <td>
                                    <%#Eval("DoanhThu")%>
                                </td>
                                <td>
                                    <%#Eval("TongThue")%>
                                </td>
                                <td>
                                    <asp:Label ID="lb_DoanhThuConLai" runat="server" ></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lb_DoanhThuWebSite" runat="server" ></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td style="text-align:right; font-weight:600" colspan="5">Tổng cộng</td>
                        <td>
                            <asp:Label Font-Bold="true" ID="lb_tongDanhThuWebSite" runat="server" Text="0"></asp:Label>
                        </td>

                    </tr>


                </table>


            </div>
                           
    </div>

</asp:Content>

