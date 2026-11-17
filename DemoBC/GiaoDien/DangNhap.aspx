<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="DemoBC.GiaoDien.DangNhap" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 420px; margin: 40px auto;">
        <h2>Đăng nhập</h2>

        <p>
            Tên đăng nhập:
            <asp:TextBox ID="txtUsername" runat="server" Width="200px" />
            <asp:RequiredFieldValidator
                ControlToValidate="txtUsername"
                ErrorMessage="Vui lòng nhập tên đăng nhập."
                ForeColor="Red"
                runat="server" />
        </p>

        <p>
            Mật khẩu:
            <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" Width="200px" />
            <asp:RequiredFieldValidator
                ControlToValidate="txtPassword"
                ErrorMessage="Vui lòng nhập mật khẩu."
                ForeColor="Red"
                runat="server" />
        </p>

        <asp:Button ID="btnLogin" Text="Đăng nhập"
            OnClick="btnLogin_Click" runat="server" />

        <br /><br />

        <p>
            Chưa có tài khoản? <a href="~/GiaoDien/DangKy.aspx" runat="server">Đăng ký ngay</a>
        </p>

        <asp:Label ID="lblMessage" ForeColor="Red" runat="server" />
    </div>
</asp:Content>