<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_Admin.master" AutoEventWireup="true" CodeFile="QuanLyThue.aspx.cs" Inherits="Form_Admin_QuanLyThue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <title>Quản Lý Thuế</title>
    <style>
        .chitietdanhmuc-danhsach{
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }
            .chitietdanhmuc-danhsach th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: left;
                padding: 8px;
            }
            .chitietdanhmuc-danhsach td {
                border: 1px solid black;
                text-align: left;
                padding: 8px;
            }
            .chitietdanhmuc-danhsach tr:nth-child(even) {
                background-color: lightgrey;
            }
            .tenchitietdanhmuc{
                font-size:1.5rem;
            }
            .DropDownList{
                border:none;
                background-color:rgba(0,0,0,0.0);
            }
        .btn_repeater{
            font-size:1.5rem;
            border:none;
            border-radius:5px;
            background-color:rgba(0,0,0,0.0);
        }
        .btn_repeater:hover{
            background-color:var(--primary-color);
        }

        /*The*/
        .themthue{
            position: fixed;
            bottom: 10%;
            right: 20%;
        }
        .themthue__button{
            width:40px;
            height:40px;
            border-radius:20px;
            background-color:green;
            padding:8px 5px;
            color:var(--while-color);
        }


        /*Form*/
        .form__modal{
            position:fixed;
            top:0;
            bottom:0;
            left:0;
            right:0;
            /*min-height:100%;
            min-width:100%;*/
            display:flex;
        }
        .modal-overlay{
            position:absolute;
            width:100%;
            height:100%;
            background-color:rgba(0,0,0,0.4);
        }
        .modal-body{
            padding:5px;
            margin:auto;
            background-color:var(--while-color);
            z-index:1;
            border-radius:5px;
        }
        .modal-inner{
            align-items:center;
            width:290px;
        }
        .themmoithue_title{
            font-size:2rem;
            padding:15px 0px 10px 0px;
            color:var(--primary-color);
            text-align:center;
        }

        .danhmuc_ibtn{
            text-align:center;
        }
        .ibtn_DanhMuc{
            width:200px;
            height:200px;
        }
        .danhmuc_txt{
            margin-top:15px;
            text-align:center;
        }
        .txt_DanhMuc{
            width:100%;
            text-align:center;
            font-size:1.5rem;
        }
        .danhmuc_btn{
            margin-top:15px;
            text-align:center;
        }
        .btn_danhmuc:hover{
            background-color:var(--primary-color);
        }
        .danhmuc_thongbao{
            margin-top:5px;
            text-align:center;
            font-size:1.5rem;
            color:red;
        }
         /*Form*/

        /*calender*/
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
        /*calender*/

    </style>

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
    <div>  
        <table class="chitietdanhmuc-danhsach">
            <tr>
                <th>Tên Thuế</th>
                <th >Tỷ Lệ</th>
                <th >Từ Ngày</th>
                <th >Đến Ngày</th>
                <th style="width:120px;text-align:center">Chức Năng</th>
            </tr>
            <asp:Repeater ID="rpt_thue" runat="server" OnItemDataBound="rpt_thue_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <asp:Label ID="lb_IdThue" runat="server" hidden="hidden" Text='<%#Eval("IdThue")%>'></asp:Label>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_TenThue" runat="server" Text='<%#Eval("TenThue")%>' ></asp:Label>
                        </td>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_TyLeThue" runat="server" Text='<%#Eval("TyLeThue")%>'></asp:Label>
                        </td>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_TuNgay" runat="server"></asp:Label>
                        </td>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_DenNgay" runat="server" ></asp:Label>
                        </td>
                        
                        <td  style="text-align:center">
                            <%-- <%#Eval("IdLoaiSP")%> --%>
                            <asp:Button class="btn_repeater" CommandArgument='<%#Eval("IdThue")%>' ID="btn_sua_ctthue" runat="server" Text="Sửa" OnClick="btn_sua_ctthue_Click" />
                            <asp:Button class="btn_repeater" CommandArgument='<%#Eval("IdThue")%>' ID="btn_xoa_ctthue" runat="server" Text="Xóa" OnClick="btn_xoa_ctthue_Click"/>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>  

    <!--button them -->
    <div class="themthue">
        <asp:ImageButton ImageUrl="~/HinhAnh/Icon/buttonAdd.png" CssClass="themthue__button" ID="ibtn_themThue" runat="server" OnClick="ibtn_themThue_Click"/>
    </div>
    <!--button them -->

    <!--form them sua -->
    <div class="form__modal" runat="server" visible="false" id="form_thue">
        <div class="modal-overlay">
        </div> 
        <div class="modal-body">
            <div class="modal-inner">
                <div class="themmoithue_title">
                    <asp:Label ID="lb_title" runat="server" Text="Thêm Mới Thuế"></asp:Label>
                    <asp:Label ID="lb_IdThue" runat="server" hidden="hidden"></asp:Label>
                </div> 
                <div class="danhmuc_txt">
                    <asp:TextBox CssClass="txt_DanhMuc" ID="txt_TenThue" placeholder="Tên Thuế" runat="server"></asp:TextBox>
                </div>
                <div class="danhmuc_txt">
                    <asp:TextBox CssClass="txt_DanhMuc" ID="txt_TyLeThue" placeholder="Tỷ Lệ" runat="server"></asp:TextBox>
                </div>
                <div class="danhmuc_txt">
                    <asp:TextBox CssClass="txt_DanhMuc" ID="txt_TuNgay" placeholder="Ngày Bắt Đầu" runat="server"></asp:TextBox>
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
                <div class="danhmuc_txt">
                    <asp:TextBox CssClass="txt_DanhMuc" ID="txt_DenNgay" placeholder="Ngày Kết Thúc" runat="server"></asp:TextBox>
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
                <div class="danhmuc_thongbao">
                    <asp:Label ID="lb_thongbao_form" Visible ="false" runat="server" Text="Thêm Thành Công"></asp:Label>
                </div>
                <div class="danhmuc_btn">
                    <asp:Button class="btn btn_danhmuc" ID="btn_thue_Them_form" runat="server" Text="Thêm" OnClick="btn_thue_Them_form_Click"/>
                    <asp:Button class="btn btn_danhmuc" ID="btn_thue_Thoat" runat="server" Text="Thoát" OnClick="btn_thue_Thoat_Click"/>
                </div>
            </div>
        </div>
    </div>
    <!--form them sua -->


</asp:Content>

