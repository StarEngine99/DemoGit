IF DB_ID(N'QLThuVien') IS NULL
BEGIN
    CREATE DATABASE [QLThuVien];
END
GO

USE [QLThuVien];
GO

IF OBJECT_ID(N'dbo.ChuDe', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ChuDe
    (
        MaChuDe int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ChuDe PRIMARY KEY,
        TenChuDe nvarchar(50) NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.KhachHang', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.KhachHang
    (
        MaKH int IDENTITY(1,1) NOT NULL CONSTRAINT PK_KhachHang PRIMARY KEY,
        HoTen nvarchar(50) NULL,
        NgaySinh datetime NULL,
        GioiTinh nvarchar(3) NULL,
        DienThoai varchar(50) NULL,
        TaiKhoan varchar(50) NULL,
        MatKhau nvarchar(50) NULL,
        Email varchar(50) NULL,
        DiaChi nchar(10) NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.NguoiDung', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.NguoiDung
    (
        MaNguoiDung int IDENTITY(1,1) NOT NULL CONSTRAINT PK_NguoiDung PRIMARY KEY,
        TenDangNhap varchar(50) NOT NULL,
        MatKhau varchar(255) NOT NULL,
        HoTen nvarchar(100) NOT NULL,
        Email varchar(100) NULL,
        SoDienThoai varchar(15) NULL,
        VaiTro nvarchar(20) NULL,
        TrangThai nvarchar(20) NULL,
        NgayTao datetime NULL
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_NguoiDung_TenDangNhap'
      AND object_id = OBJECT_ID(N'dbo.NguoiDung')
)
BEGIN
    CREATE UNIQUE INDEX UX_NguoiDung_TenDangNhap
        ON dbo.NguoiDung(TenDangNhap);
END;
GO

IF OBJECT_ID(N'dbo.NhaXuatBan', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.NhaXuatBan
    (
        MaNXB int IDENTITY(1,1) NOT NULL CONSTRAINT PK_NhaXuatBan PRIMARY KEY,
        TenNXB nvarchar(50) NULL,
        DiaChi nvarchar(100) NULL,
        DienThoai decimal(18,0) NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.TacGia', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.TacGia
    (
        MaTacGia int IDENTITY(1,1) NOT NULL CONSTRAINT PK_TacGia PRIMARY KEY,
        TenTacGia nvarchar(50) NULL,
        DiaChi nvarchar(100) NULL,
        TieuSu nvarchar(max) NULL,
        DienThoai nvarchar(50) NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.TheLoai', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.TheLoai
    (
        MaTheLoai int IDENTITY(1,1) NOT NULL CONSTRAINT PK_TheLoai PRIMARY KEY,
        TenTheLoai nvarchar(100) NOT NULL,
        MoTa nvarchar(255) NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.Sach', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Sach
    (
        MaSach int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Sach PRIMARY KEY,
        TenSach nvarchar(100) NULL,
        GiaBan decimal(18,0) NULL,
        MoTa nvarchar(max) NULL,
        NgayCapNhat datetime NULL,
        AnhBia nvarchar(max) NULL,
        SoLuongTon int NULL,
        MaChuDe int NULL,
        MaNXB int NULL,
        Moi int NULL,
        NoiDung nvarchar(max) NULL,
        TacGia nvarchar(150) NULL,
        TheLoai nvarchar(100) NULL,
        CONSTRAINT FK_Sach_ChuDe FOREIGN KEY (MaChuDe) REFERENCES dbo.ChuDe(MaChuDe),
        CONSTRAINT FK_Sach_NhaXuatBan FOREIGN KEY (MaNXB) REFERENCES dbo.NhaXuatBan(MaNXB)
    );
END;
GO

IF OBJECT_ID(N'dbo.DonHang', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.DonHang
    (
        MaDonHang int IDENTITY(1,1) NOT NULL CONSTRAINT PK_DonHang PRIMARY KEY,
        NgayGiao datetime NULL,
        NgayDat datetime NULL,
        DaThanhToan nvarchar(50) NULL,
        TinhTrangGiaoHang int NULL,
        MaKH int NULL,
        CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (MaKH) REFERENCES dbo.KhachHang(MaKH)
    );
END;
GO

IF OBJECT_ID(N'dbo.PhieuMuon', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.PhieuMuon
    (
        MaPhieuMuon int IDENTITY(1,1) NOT NULL CONSTRAINT PK_PhieuMuon PRIMARY KEY,
        MaNguoiDung int NOT NULL,
        NgayTao datetime NULL,
        NgayHenLay datetime NULL,
        NgayHenTra datetime NULL,
        TrangThai int NULL,
        GhiChu nvarchar(max) NULL,
        CONSTRAINT FK_PhieuMuon_NguoiDung FOREIGN KEY (MaNguoiDung) REFERENCES dbo.NguoiDung(MaNguoiDung)
    );
END;
GO

IF OBJECT_ID(N'dbo.ChiTietDonHang', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ChiTietDonHang
    (
        MaDonHang int NOT NULL,
        MaSach int NOT NULL,
        SoLuong int NULL,
        DonGia decimal(18,0) NULL,
        CONSTRAINT PK_ChiTietDonHang PRIMARY KEY (MaDonHang, MaSach),
        CONSTRAINT FK_ChiTietDonHang_DonHang FOREIGN KEY (MaDonHang) REFERENCES dbo.DonHang(MaDonHang),
        CONSTRAINT FK_ChiTietDonHang_Sach FOREIGN KEY (MaSach) REFERENCES dbo.Sach(MaSach)
    );
END;
GO

IF OBJECT_ID(N'dbo.ChiTietPhieuMuon', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ChiTietPhieuMuon
    (
        MaPhieuMuon int NOT NULL,
        MaSach int NOT NULL,
        SoLuong int NULL,
        NgayTra date NULL,
        CONSTRAINT PK_ChiTietPhieuMuon PRIMARY KEY (MaPhieuMuon, MaSach),
        CONSTRAINT FK_ChiTietPhieuMuon_PhieuMuon FOREIGN KEY (MaPhieuMuon) REFERENCES dbo.PhieuMuon(MaPhieuMuon),
        CONSTRAINT FK_ChiTietPhieuMuon_Sach FOREIGN KEY (MaSach) REFERENCES dbo.Sach(MaSach)
    );
END;
GO

IF OBJECT_ID(N'dbo.YeuThich', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.YeuThich
    (
        MaYeuThich int IDENTITY(1,1) NOT NULL CONSTRAINT PK_YeuThich PRIMARY KEY,
        MaNguoiDung int NOT NULL,
        MaSach int NOT NULL,
        NgayThem datetime NULL,
        CONSTRAINT FK_YeuThich_Sach FOREIGN KEY (MaSach) REFERENCES dbo.Sach(MaSach)
    );
END;
GO

IF OBJECT_ID(N'dbo.ThamGia', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ThamGia
    (
        MaSach int NOT NULL,
        MaTacGia int NOT NULL,
        VaiTro nvarchar(50) NULL,
        ViTri nvarchar(50) NULL,
        CONSTRAINT PK_ThamGia PRIMARY KEY (MaSach, MaTacGia),
        CONSTRAINT FK_ThamGia_Sach FOREIGN KEY (MaSach) REFERENCES dbo.Sach(MaSach),
        CONSTRAINT FK_ThamGia_TacGia FOREIGN KEY (MaTacGia) REFERENCES dbo.TacGia(MaTacGia)
    );
END;
GO

IF OBJECT_ID(N'dbo.sysdiagrams', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.sysdiagrams
    (
        name nvarchar(128) NOT NULL,
        principal_id int NOT NULL,
        diagram_id int IDENTITY(1,1) NOT NULL CONSTRAINT PK_sysdiagrams PRIMARY KEY,
        version int NULL,
        definition varbinary(max) NULL
    );
END;
GO
