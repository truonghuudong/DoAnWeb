
alter table TaiKhoan add Email nvarchar(255)
alter table TaiKhoan add unique (Email)



CREATE TABLE [dbo].[TaiKhoan] (
    [IdTaiKhoan]  INT            IDENTITY (1, 1) NOT NULL,
    [TenTaiKhoan] NVARCHAR (255) NULL,
    [MatKhau]     NVARCHAR (255) NULL,
    [Anh]         NVARCHAR (255) NULL,
    [Email]       NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([IdTaiKhoan] ASC),
    UNIQUE NONCLUSTERED ([TenTaiKhoan] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC)
);


/*tạo table danh mục*/
create table DanhMuc(IdDanhMuc int identity primary key,
						TenDanhMuc nvarchar(255) UNique,
						AnhDanhMuc nvarchar(255)) 

/*tạo table loại sản phẩm*/
create table LoaiSP(IdLoaiSP int identity primary key,
					IdDanhMuc int,
					TenLoaiSP nvarchar(255),
					constraint fk_danhmuc_iddanhmuc foreign key (IdDanhMuc) references DanhMuc(IdDanhMuc))

create table NguoiBan (IdNguoiBan int identity primary key,
						TeNguoiBan Nvarchar(255) unique,
						SoDT Nvarchar(255),
						MatKhau nvarchar(36),
						Email nvarchar(255) unique,
						HinhANh nvarchar(255))


/*tạo table sản phẩm*/
create table SanPham(IdSP int identity primary key,
					IdLoaiSP int,
					TenSP nvarchar(255),
					SoLuong int,
					AnhSP nvarchar(255),
					GiaSP int,
					MoTa nvarchar(max),
					IdNguoiBan int,
					constraint fk_loaisp_idloaisp foreign key (IdLoaiSP) references LoaiSP(IdLoaiSP),
					constraint fk_nguoiban_idnguoiban foreign key (IdNguoiBan) references NguoiBan(IdNguoiBan))


alter table SanPham drop constraint fk_nguoiban_idnguoiban
alter table SanPham add  IdTaiKhoan int 
alter table SanPham add constraint fk_nguoiban_idtaikhoan foreign key (IdTaiKhoan) references TaiKhoan(IdTaiKhoan)



/*tạo table quảng cáo*/
create table QuangCao(IdQuangCao int identity primary key,
						IdSP int,
						MoTa nvarchar(255),
						AnhQuangCao nvarchar(255),
						constraint fk_sanpham_idsp foreign key (IdSP) references SanPham(IdSP))

/*tạo table hóa đơn*/
create table HoaDon(IdHoaDon int identity primary key,
					DiaChi nvarchar(255),
					Ngay nvarchar(15),
					IdTaiKhoan int,
					constraint fk_hoadon_taikhoan_idtaikhoan foreign key (IdTaiKhoan) references TaiKhoan(IdTaiKhoan))
alter table HoaDon add TenNguoiNhan nvarchar(255), SDTNguoiNhan nvarchar(255)
alter table HoaDon add constraint fk_hoadon_taikhoan_idtaikhoan foreign key (IdTaiKhoan) references TaiKhoan(IdTaiKhoan)


/*tạo table chi tiết hóa đơn*/
create table ChiTietHD(IdCT int identity primary key,
						IdHoaDon int,
						IdSP int,
						SoLuong int,
						TrangThai int,
						constraint fk_ct_hoadon_idhoadon foreign key(IdHoaDon) references HoaDon(IdHoaDon),
						constraint fk_ct_sanpham_idsp foreign key (IdSP) references SanPham(IdSP))


/*Get Danh Mục*/
create procedure GetDanhMuc
as
	select * from DanhMuc

/*Dang nhap*/
create function DangNhap(@tenDN nvarchar(255),@matKhau nvarchar(255))
returns int
as
	begin
		if exists (select * from TaiKhoan where TenTaiKhoan=@tenDN and MatKhau=@MatKhau)
			begin
				Declare @Id int;
				select @id =tk.IdTaiKhoan from TaiKhoan tk where TenTaiKhoan=@tenDN and MatKhau=@MatKhau
				return @id;
			end
		return -1;
	end





/*Link Anh Dai Dien*/
create proc AnhDaiDien(@Id int)
as
	select * from TaiKhoan where IdTaiKhoan = @Id;



/*Lay san pham bat ky*/
create proc GetSanPham(@offect int,@count int)
as
	begin
		SELECT * FROM 
		(
			SELECT TOP (@offect+@count-1) *, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS rnum 
			FROM SanPham
		) a
		WHERE  rnum>@offect or rnum = @offect;
	end


/*get san pham theo danh muc*/
alter proc GetSanPhamTheoLoaiSP(@offect int,@count int,@idLoaiSP int)
as
	begin
		SELECT * FROM 
		(
			SELECT TOP (@offect+@count) *, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS rnum 
			FROM SanPham
			WHERE SanPham.IdLoaiSP = @idLoaiSP
		) a
		WHERE  rnum>@offect or rnum = @offect;
	end



--create proc GetSanPhamNotOfUser(@offect int,@count int,@iduser int)
--as
--	begin
--		SELECT * FROM 
--		(
--			SELECT TOP (@offect+@count-1) *, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS rnum 
--			FROM SanPham
--		) a
--		WHERE  rnum>@offect or rnum = @offect ;
--	end




/*Lay san pham bat ky*/
alter proc GetSanPhamBatKy
as
	select  top 42 * from dbo.SanPham order by newid()

--/*Lay san pham bat ky khong phai cua user*/
--create proc GetSanPhamBatKyNotOfUser(@IdUser int)
--as
--	select  top 40 * from dbo.SanPham where IdTaiKhoan!=@IdUser order by newid()



/*Lay danh sach cac san pham quang cao*/
create proc GetQuangCao
as
	select * from QuangCao


/*Lay danh sach loaisp theo danh muc*/
create proc GetLoaiSPTheoDanhMuc(@IdDanhMuc int)
as
	select * from LoaiSP where IdDanhMuc = @IdDanhMuc







/*Lay id danh muc*/
create function GetIdDanhMuc(@IdLoaiSP int)
returns int
as
	begin
	declare @IdDanhMuc int 
	if exists (select IdDanhMuc from LoaiSP where IdLoaiSP=@IdLoaiSP)
		begin
		select @IdDanhMuc=IdDanhMuc from LoaiSP where IdLoaiSP=@IdLoaiSP
		return @IdDanhMuc
		end
		return -1
	end

	print(dbo.GetIdDanhMuc('20'))


/*sapxepsanpham*/
create proc SapXepSanPham(@LoaiSapXep int)
as
	begin
		

	end


/*get san pham theo id*/
create proc GetSanPhamTheoId(@IdSP nvarchar(10))
as
	select * from SanPham s where s.IdSP = @IdSP 




/*ham them tai khoan thanh vien khong co thong tin kem theo*/
create proc SetTaiKhoanThanhVien(@TenDN nvarchar(200),@Email nvarchar(200),@Password nvarchar(200))
as
	begin
		insert into TaiKhoan Values(@TenDN,@Password,'',@Email,'2','','','');
	end
/*ham them tai khoan thanh vien khong co thong tin kem theo*/


alter table SanPham drop constraint fk_nguoiban_idnguoiban
drop table NguoiBan

alter table TaiKhoan add IdQuyen int 
create table PhanQuyen(IdQuyen int identity primary key, TenQuyen Nvarchar(50))
drop table PhanQuyen
alter table TaiKhoan add constraint fk_taikhoan_idquyen foreign key (IdQuyen) references PhanQuyen(IdQuyen)

create table NhomPhanLoai(IdNhomPhanLoai int identity primary key,
						IdSanPham int,
						TenNhomPhanLoai nvarchar(100),
						constraint fk_nhomphanloai_idsanpham foreign key (IdSanPham) references SanPham(IdSP))
alter table NhomPhanLoai add AnhPhanLoai nvarchar(200)

create table PhanLoai(IdPhanLoai int identity primary key,
						IdNhomPhanLoai int,
						IdSP int,
						TenPhanLoai nvarchar(100),
						GiaSP int,
						SoLuong int,
						constraint fk_phanloai_idsanpham foreign key (IdSP) references SanPham(IdSP),
						constraint fk_phanloai_idnhomphanloai foreign key (IdNhomPhanLoai) references NhomPhanLoai(IdNhomPhanLoai))
alter table PhanLoai drop constraint fk_phanloai_idsanpham


create table BinhLuan(IdBinhLuan int identity primary key,
						IdTaiKhoan int,
						IdSanPham int,
						NoiDung nvarchar(255),
						Anh nvarchar(255),
						constraint fk_binhluan_taikhoan foreign key (IdTaiKhoan) references TaiKhoan(IdTaiKHoan),
						constraint fk_binhluan_sanpham foreign key (IdSanPham) references SanPham(IdSP))

create table KhuyenMai(IdKhuyenMai int identity primary key,
						IdTaiKhoan int,
						NgayBatDau nvarchar(255),
						NgayKetThuc nvarchar(255),
						SoTienGiam int,
						SoPhanTram int,
						constraint fk_khuyenmai_taikhoan foreign key (IdTaiKhoan) references TaiKhoan(IdTaiKhoan))


create table ChiTietKhuyenMai(IdKhuyenMai int,
								IdSP int,
								constraint fk_chitietkhuyenmai_taikhoan foreign key (IdSP) references SanPham(IdSP))
alter table ChiTietKhuyenMai add constraint fk_chitietkhuyenmai_khuyenmai foreign key (IdKhuyenMai) references KhuyenMai(IdKhuyenMai)


alter table NhomPhanLoai drop column IdSanPham
alter table SanPham add TrangThai nvarchar(50)
alter table KhuyenMai  drop column SoTienGiam,SoPhanTram
alter table QuangCao add TrangThai nvarchar(50), NgayBatDau nvarchar(20), NgayKetThuc nvarchar(20)
alter table HoaDon add TrangThai nvarchar(50)
alter table ChiTietKhuyenMai add TiLeKhuyenMai int
alter table TaiKhoan add SDT nvarchar(10), DiaChi nvarchar(200) 



alter table ChiTietDanhMuc add TrangThai int


create proc SetDanhMuc(@tendanhmuc nvarchar(200),@anhdanhmuc nvarchar(200))
as
begin
	insert into DanhMuc Values(@tendanhmuc,@anhdanhmuc);
end

create proc UpdateTrangThaiChiTietDanhMuc(@idLoaiSP nvarchar(3),@trangthai nvarchar(3))
as
	update ChiTietDanhMuc Set TrangThai = @trangthai WHERE IdLoaiSP = @idLoaiSP 

	
create proc UpdateDanhMucTheoId(@IdDanhMuc int,@TenDanhMuc nvarchar(200),@AnhDanhMuc nvarchar(200))
as 
	begin
		update DanhMuc set  TenDanhMuc = @TenDanhMuc, AnhDanhMuc = @AnhDanhMuc where IdDanhMuc = @IdDanhMuc
	end

create proc DeleteDanhMucTheoId(@IdDanhMuc int)
as
	begin
		DELETE FROM DanhMuc WHERE IdDanhMuc = @IdDanhMuc
	end

	create proc GetDanhMucTheoId(@IdDanhMuc int)
as 
	select * from DanhMuc where IdDanhMuc = @IdDanhMuc


	alter proc UpdateChiTietDanhMucTheoId(@idLoaiSP nvarchar(10),@tenChiTietDanhMuc nvarchar(200))
	as
		update ChiTietDanhMuc set TenLoaiSP = @tenChiTietDanhMuc where IdLoaiSP = @idLoaiSP

	alter proc InsertChiTietDanhMucTheoId(@idDanhMuc nvarchar(10),@tenChiTietDanhMuc nvarchar(200))
	as
		insert into ChiTietDanhMuc values (@idDanhMuc,@tenChiTietDanhMuc,'1')

	alter proc DeleteChiTietDanhMuc(@idLoaiSP nvarchar(10))
	as
		delete from ChiTietDanhMuc where IdLoaiSP = @idLoaiSP


--trạng thái hóa đơn: 0:đã bị hủy, 1:đã giao - đã thanh toán, 2:đang giao, 3:hoàn trả
alter procedure GetSanPhamBanChayTheoId(@idTaiKhoan nvarchar(10))
as
	select top(10) sp.IdSP,sp.TenSP,sp.AnhSP,sp.TrangThai,sum(cthd.SoLuong) as SoLuongBanDuoc from SanPham sp, ChiTietHD cthd
	where sp.IdSP = cthd.IdSP and sp.IdTaiKhoan = @idTaiKhoan and cthd.TrangThai = 1
	group by sp.IdSP,sp.TenSP,sp.AnhSP,sp.TrangThai
	order by sum(cthd.SoLuong) Desc


	GetSanPhamBanChayTheoId '1'


alter proc GetNguoiMuaNhieuNhat(@idTaiKhoan nvarchar(10))
as
	select top(10) tk.TenTaiKhoan,tk.Anh,sum(cthd.SoLuong) as SoLuong, sum(cthd.DonGia * cthd.SoLuong) as TongDonGia
	from TaiKhoan tk, HoaDon hd, ChiTietHD cthd, SanPham sp
	where tk.IdTaiKhoan = hd.IdTaiKhoan and cthd.IdHoaDon = hd.IdHoaDon and cthd.IdSP = sp.IdSP and cthd.TrangThai = 1
			and sp.IdSP in (select sp1.IdSP from SanPham sp1,TaiKhoan tk1 
			where sp1.IdTaiKhoan=tk1.IdTaiKhoan and tk1.IdTaiKhoan=@idTaiKhoan)
	group by tk.TenTaiKhoan,tk.Anh
	order by sum(cthd.SoLuong) desc

create proc GetTongSoTienDaDuocThanhToan(@idTaiKhoan nvarchar(10))
as
	select sum(cthd.DonGia*cthd.SoLuong) as TongTien
	from TaiKhoan tk, SanPham sp, ChiTietHD cthd
	where tk.IdTaiKhoan = sp.IdTaiKhoan and sp.IdSP = cthd.IdSP
			and tk.IdTaiKhoan = @idTaiKhoan and cthd.TrangThai = 1
			GetTongSoTienDaDuocThanhToan '1'

alter proc SanPhamConTrongKho(@idTaiKhoan nvarchar(10))
as
	select sp.IdSP,sp.TenSP,sp.AnhSP,sp.TrangThai,sp.SoLuong
	from SanPham sp,TaiKhoan tk
	where sp.IdTaiKhoan = tk.IdTaiKhoan and tk.IdTaiKhoan = @idTaiKhoan
	
create function TatCahangTonTrongKho(@idTaiKhoan nvarchar(10))
returns int
as
	begin
	declare @SoLuong int;
	select @SoLuong=Sum(sp.SoLuong) 
	from SanPham sp,TaiKhoan tk
	where sp.IdTaiKhoan = tk.IdTaiKhoan and tk.IdTaiKhoan = @idTaiKhoan
	return @SoLuong
	end

create proc TatCaCacSanPhamKhuyenMai(@idTaiKhoan nvarchar(10))
as
	select sp.IdSP,sp.TenSP,sp.AnhSP,km.NgayBatDau,km.NgayKetThuc,ctkm.TiLeKhuyenMai,km.TrangThai
	from SanPham sp,ChiTietKhuyenMai ctkm,KhuyenMai km,TaiKhoan tk
	where tk.IdTaiKhoan=sp.IdTaiKhoan and sp.IdSP=ctkm.IdSP and ctkm.IdKhuyenMai=km.IdKhuyenMai 
			and tk.IdTaiKhoan=@idTaiKhoan

alter proc DoanhThuTheoNgayDaChon(@idTaiKhoan nvarchar(10),@NgayBatDau DateTime,@NgayKetThuc DateTime)
as
	select hd.IdHoaDon, hd.Ngay,hd.TrangThai,sum(cthd.SoLuong*cthd.DonGia) as SoTien
	from HoaDon hd,ChiTietHD cthd,SanPham sp,TaiKhoan tk
	where hd.IdHoaDon = cthd.IdHoaDon and sp.IdSP = cthd.IdSP and sp.IdTaiKhoan = tk.IdTaiKhoan and tk.IdTaiKhoan = @idTaiKhoan
			and hd.Ngay between @NgayBatDau and @NgayKetThuc and cthd.TrangThai=1
	Group by hd.IdHoaDon, hd.Ngay,hd.TrangThai


create proc GetTongSoTienSeDuocThanhToan(@idTaiKhoan nvarchar(10))
as
	select sum(cthd.DonGia*cthd.SoLuong) as TongTien
	from TaiKhoan tk, SanPham sp, ChiTietHD cthd
	where tk.IdTaiKhoan = sp.IdTaiKhoan and sp.IdSP = cthd.IdSP
			and tk.IdTaiKhoan = @idTaiKhoan and cthd.TrangThai = 2



Create table Thue (IdThue int identity primary key, 
					TenThue nvarchar(255) unique,
					TyLeThue int,
					TuNgay DateTime,
					DenNgay DateTime)


alter table SanPham add TyLeThue int, TienThue int


create proc BaoCaoThongKeAdmin(@tungay DateTime,@denngay DateTime)
as
    select tk.IdTaiKhoan,tk.TenTaiKhoan as TenNguoiBan,sum(cthd.DonGia*cthd.SoLuong) as DoanhThu,sum(cthd.TienThue*cthd.SoLuong) as TongThue
    from ChiTietHD cthd, HoaDon hd, SanPham sp, TaiKhoan tk
    where cthd.IdHoaDon = hd.IdHoaDon and
           sp.IdSP = cthd.IdSP and 
           tk.IdTaiKhoan = sp.IdTaiKhoan and cthd.TrangThai = 1
    Group By tk.IdTaiKhoan,tk.TenTaiKhoan


create proc CapNhatThueSanPham(@TyLeThue int)
as
	begin
		Declare SP_Cursor CURSOR
			for select IdSP from SanPham
		Declare @IdSP int
		OPEN SP_Cursor;
		Fetch next from SP_Cursor INTO @IdSP;
		while @@FETCH_STATUS=0
			begin
				update SanPham Set TyLeThue = @TyLeThue,TienThue = GiaSP*@TyLeThue/100 where IdSP = @IdSP;
				Fetch next from SP_Cursor INTO @IdSP;
			end
		Close SP_Cursor;
		DEALLOCATE SP_Cursor;
	end


/*Ham getSanPhamBatKy*/
ALTER proc [dbo].[GetSanPhamBatKy]
as
	select top 42 *
	from
		(select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,(sp.GiaSP-sp.GiaSP*ctkm.TiLeKhuyenMai/100) as GiaKhuyenMai,
			ctkm.TiLeKhuyenMai
		from dbo.SanPham sp,dbo.KhuyenMai km,dbo.ChiTietKhuyenMai ctkm
		where sp.IdSP = ctkm.IdSP and ctkm.IdKhuyenMai=km.IdKhuyenMai and km.TrangThai=1
		union
		select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.GiaSP as GiaKhuyenMai,
			0 as TiLeKhuyenMai
		from dbo.SanPham sp where sp.IdSP not in (select IdSP from ChiTietKhuyenMai)
		) as SanPham
		order by newid()

/*Ham getSanPhamTheoId*/
ALTER proc [dbo].[GetSanPhamTheoId](@IdSP nvarchar(10))
as
	select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,(sp.GiaSP-sp.GiaSP*ctkm.TiLeKhuyenMai/100) as GiaKhuyenMai,
			ctkm.TiLeKhuyenMai,tk.TenTaiKhoan,tk.IdTaiKhoan
	from dbo.SanPham sp,dbo.KhuyenMai km,dbo.ChiTietKhuyenMai ctkm,TaiKhoan tk
	where sp.IdSP = ctkm.IdSP and ctkm.IdKhuyenMai=km.IdKhuyenMai and sp.IdTaiKhoan = tk.IdTaiKhoan
			and km.TrangThai=1 and sp.IdSP=@IdSP
	union
	select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,sp.GiaSP as GiaKhuyenMai,
		0 as TiLeKhuyenMai,tk.TenTaiKhoan,tk.IdTaiKhoan
	from dbo.SanPham sp,TaiKhoan tk
	where sp.IdSP=@IdSP and sp.IdSP not in (select IdSP from ChiTietKhuyenMai) and sp.IdTaiKhoan = tk.IdTaiKhoan

/*GetDanhGiaSanPham*/
ALTER proc [dbo].[GetDanhGiaSanPham](@idsp int)
as
	select bl.NoiDung,tk.Anh as AnhDaiDien,tk.TenTaiKhoan
	from BinhLuan bl,TaiKhoan tk 
	where IdSanPham = @idsp and bl.IdTaiKhoan=tk.IdTaiKhoan

/*GetThongTinTaiKhoan*/
create proc GetThongTinTaiKhoan(@idTaiKhoan nvarchar(10))
as
	select *
	from TaiKhoan
	where TaiKhoan.IdTaiKhoan = @idTaiKhoan


/*insert hóa đơn*/
ALTER proc [dbo].[InsertHoaDon](@idTaiKhoan nvarchar(10),
						@TenNguoiNhan nvarchar(200),
						@SDTnguoinhan nvarchar(10),
						@ngay Datetime,
						@diaChi nvarchar(200))
as
	begin
	insert into HoaDon 
	values(@diaChi,@ngay,@idTaiKhoan,@TenNguoiNhan,@SDTnguoinhan,4);
	select top 1 * 
	from HoaDon 
	order by HoaDon.IdHoaDon desc
	end

/*insert chi tiết hóa đơn*/
ALTER proc [dbo].[InsertChiTietHoaDon] (@idHoaDon nvarchar(10),
								@IdSP nvarchar(10),
								@SoLuong int,
								@DonGia int)
as
	declare @TienThue int
	select @TienThue = sp.TienThue
	from SanPham sp where sp.IdSP = @IdSP
	insert into ChiTietHD values(@idHoaDon,@IdSP,@SoLuong,1,@DonGia,@TienThue)


/*Lấy hóa đơn theo id người mua*/
alter proc GetHoaDonTheoIdNguoiMua (@idnguoimua nvarchar(10),@trangthai nvarchar(3))
as
	select *
	from HoaDon hd,TaiKhoan tk
	where hd.IdTaiKhoan=1 and hd.IdTaiKhoan=tk.IdTaiKhoan

/*lấy hóa đơn theo id hóa đơn*/
alter proc GetHoaDonTheoIdHoaDon (@idhoadon nvarchar(10))
as
	select *
	from ChiTietHD cthd,HoaDon hd,SanPham sp
	where cthd.IdHoaDon = hd.IdHoaDon and hd.IdHoaDon = @idhoadon and cthd.IdSP = sp.IdSP

/*update trạng thái hóa đơn*/
create proc UpdateTrangThaiDonHang(@idhoadon nvarchar(10),@trangthai nvarchar(3))
as
	update HoaDon Set TrangThai = @trangthai where IdHoaDon = @idhoadon


/*get sản phẩm theo id danh muc*/
create proc GetSanPhamTheoIdDanhMuc(@iddanhmuc nvarchar(10))
as
	select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,(sp.GiaSP-sp.GiaSP*ctkm.TiLeKhuyenMai/100) as GiaKhuyenMai,
			ctkm.TiLeKhuyenMai
	from SanPham sp,ChiTietDanhMuc ctdm,DanhMuc dm,ChiTietKhuyenMai ctkm,KhuyenMai km
	where sp.IdLoaiSP=ctdm.IdLoaiSP 
			and ctdm.IdDanhMuc = dm.IdDanhMuc
			and ctkm.IdSP = sp.IdSP 
			and km.IdKhuyenMai = ctkm.IdKhuyenMai
			and dm.IdDanhMuc = @iddanhmuc
	union 
	select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,sp.GiaSP as GiaKhuyenMai,
		0 as TiLeKhuyenMai
	from SanPham sp,ChiTietDanhMuc ctdm,DanhMuc dm
	where sp.IdLoaiSP=ctdm.IdLoaiSP 
			and ctdm.IdDanhMuc = dm.IdDanhMuc
			and dm.IdDanhMuc = @iddanhmuc
			and sp.IdSP not in (select IdSP from ChiTietKhuyenMai)

/*get loại sp theo danh mục và trạng thái*/
alter proc GetLoaiSPTheoDanhMucTrangThai(@IdDanhMuc int,@TrangThai nvarchar(10))
as
	select * 
	from DanhMuc dm,ChiTietDanhMuc ctdm
	where dm.IdDanhMuc = ctdm.IdDanhMuc
			and dm.IdDanhMuc = @IdDanhMuc
			and ctdm.TrangThai = @TrangThai

/*get getSanPhamTheoIdLoaiSP*/

create proc GetSanPhamTheoIdLoaiSP(@idLoaiSP int)
as
	select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,(sp.GiaSP-sp.GiaSP*ctkm.TiLeKhuyenMai/100) as GiaKhuyenMai,
			ctkm.TiLeKhuyenMai,tk.TenTaiKhoan
	from SanPham sp,ChiTietDanhMuc ctdm,ChiTietKhuyenMai ctkm,KhuyenMai km,TaiKhoan tk
	where sp.IdLoaiSP=ctdm.IdLoaiSP 
			and ctkm.IdSP = sp.IdSP 
			and sp.IdTaiKhoan = tk.IdTaiKhoan
			and km.IdKhuyenMai = ctkm.IdKhuyenMai
			and @idLoaiSP = sp.IdLoaiSP
	union 
	select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,sp.GiaSP as GiaKhuyenMai,
		0 as TiLeKhuyenMai,tk.TenTaiKhoan
	from SanPham sp,ChiTietDanhMuc ctdm,TaiKhoan tk
	where sp.IdLoaiSP=ctdm.IdLoaiSP 
			and sp.IdTaiKhoan = tk.IdTaiKhoan
			and sp.IdSP not in (select IdSP from ChiTietKhuyenMai)
			and @idLoaiSP = sp.IdLoaiSP

/*Get Tất cả sản phẩm*/
alter proc GetTatCaSanPham(@tiemKiem nvarchar(200))
as
	if(@tiemKiem='TatCaSanPham')
		begin
			select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,(sp.GiaSP-sp.GiaSP*ctkm.TiLeKhuyenMai/100) as GiaKhuyenMai,
			ctkm.TiLeKhuyenMai,tk.TenTaiKhoan,tk.IdTaiKhoan
			from dbo.SanPham sp,dbo.KhuyenMai km,dbo.ChiTietKhuyenMai ctkm,TaiKhoan tk
			where sp.IdSP = ctkm.IdSP and ctkm.IdKhuyenMai=km.IdKhuyenMai and sp.IdTaiKhoan = tk.IdTaiKhoan
					and km.TrangThai=1
			union
			select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,sp.GiaSP as GiaKhuyenMai,
				0 as TiLeKhuyenMai,tk.TenTaiKhoan,tk.IdTaiKhoan
			from dbo.SanPham sp,TaiKhoan tk
			where  sp.IdSP not in (select IdSP from ChiTietKhuyenMai) and sp.IdTaiKhoan = tk.IdTaiKhoan
		end
	else
		begin
			select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,(sp.GiaSP-sp.GiaSP*ctkm.TiLeKhuyenMai/100) as GiaKhuyenMai,
			ctkm.TiLeKhuyenMai,tk.TenTaiKhoan,tk.IdTaiKhoan
			from dbo.SanPham sp,dbo.KhuyenMai km,dbo.ChiTietKhuyenMai ctkm,TaiKhoan tk
			where sp.IdSP = ctkm.IdSP and ctkm.IdKhuyenMai=km.IdKhuyenMai and sp.IdTaiKhoan = tk.IdTaiKhoan
					and km.TrangThai=1 and sp.TenSP like N'%'+@tiemKiem+'%'
			union
			select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,sp.GiaSP as GiaKhuyenMai,
				0 as TiLeKhuyenMai,tk.TenTaiKhoan,tk.IdTaiKhoan
			from dbo.SanPham sp,TaiKhoan tk
			where sp.TenSP like N'%'+@tiemKiem+'%' and sp.IdSP not in (select IdSP from ChiTietKhuyenMai) and sp.IdTaiKhoan = tk.IdTaiKhoan
		end

/*update trang thái tài khoản*/
create proc UpdateTrangThaiTaiKhoan(@idTaiKhoan nvarchar(10),@trangthai nvarchar(3))
as
	update TaiKhoan set TrangThai = @trangthai  where @idTaiKhoan= IdTaiKhoan

/*GetTaiKhoanTheoQuyen*/
alter proc GetDanhSachTaiKhoanTheoQuyen(@IdQuyen nvarchar(3))
as
	select * 
	from TaiKhoan tk, PhanQuyen pq	
	where tk.IdQuyen = pq.IdQuyen and pq.IdQuyen=@IdQuyen

/*Update trang thai tai khoan*/
create proc UpdateTrangThaiTaiKhoan(@idTaiKhoan nvarchar(10),@trangthai nvarchar(3))
as
	update TaiKhoan set TrangThai = @trangthai  where @idTaiKhoan= IdTaiKhoan

/*trigger cập nhật thuế sản phẩm*/
alter trigger updateTyLeThueCuaSanPham on SanPham for update
as
	begin
	declare @tylethue int
	declare @idsp int
	select @tylethue = TyLeThue,@idsp = IdSP from inserted
	update SanPham Set TienThue = (GiaSP*@tylethue)/100 where IdSP = @idsp
	end

/*trigger cập nhật tỷ lệ thuế sản phẩm*/
alter trigger BatSuKienThayDoiThue on Thue for update
as
	begin
	declare @tylethue int
	select @tylethue = TyLeThue from inserted
	Declare cursor_sanpham cursor
		for select IdSP from SanPham
	declare @idsp int
	open cursor_sanpham
	Fetch next from cursor_sanpham into @idsp
	while @@FETCH_STATUS =0
		begin
			update SanPham set TyLeThue=@tylethue where IdSP = @idsp
			Fetch next from cursor_sanpham into @idsp
		end
	close cursor_sanpham
	deallocate cursor_sanpham
	end


/*sua san pham*/
create proc UpdateThongTinSPTheoId(@IdSP int,
									@idLoaiSP nvarchar(10),
									@tensp nvarchar(200),
									@anhsp nvarchar(200),
									@giasp int,
									@soluong int,
									@mota nvarchar(1000))
as
	begin
		if(@anhsp='')
			update SanPham set TenSP = @tensp, GiaSP=@giasp, SoLuong=@soluong, MoTa=@mota,IdLoaiSP=@idLoaiSP where IdSP=@IdSP
		else update SanPham set TenSP = @tensp,AnhSP = @anhsp, GiaSP=@giasp, SoLuong=@soluong, MoTa=@mota,IdLoaiSP=@idLoaiSP where IdSP=@IdSP
	end

/*them san pham*/
create proc SetSanPham				(@idtaiKhoan nvarchar(10),
									@idLoaiSP nvarchar(10),
									@tensp nvarchar(200),
									@anhsp nvarchar(200),
									@giasp int,
									@soluong int,
									@mota nvarchar(1000))
as
	begin
		insert into SanPham Values(@idLoaiSP,@tensp,@soluong,@anhsp,@giasp,@mota
									,@idtaiKhoan,'1','','')
	end

/*trigger them thue vao san pham moi*/
create trigger insert_sanpham on SanPham for insert
as
	begin
		declare @tylethue int
		select @tylethue = TyLeThue from Thue
		declare @idsp int
		select @idsp= IdSP from inserted
		update SanPham set TyLeThue=@tylethue where IdSP=@idsp
	end

/*trigger chinh sua so luong sp*/
create trigger updateTrangThaiHoaDon on HoaDon for update
as
	begin
		declare @idhoadon int
		declare @trangthai int
		select @idhoadon =IdHoaDon,@trangthai=TrangThai from inserted
		if(@trangthai = '1' or @trangthai = '2')
			begin
				declare cursor_chitiethoadon cursor
					for select IdSP,SoLuong from ChiTietHD
				declare @idsp int
				declare @soluong int
				open  cursor_chitiethoadon
					fetch next from cursor_chitiethoadon into @idsp,@soluong
				while  @@FETCH_STATUS=0
					begin
						update SanPham set SoLuong=SoLuong-@soluong where IdSP=@idsp
						fetch next from cursor_chitiethoadon into @idsp,@soluong
					end
				close cursor_chitiethoadon
				deallocate cursor_chitiethoadon
			end

	end

/*Lay hoa don theo id nguoi ban*/

alter proc GetHoaDonTheoIdNguoiBan(@idnguoiban nvarchar(10),@trangthai nvarchar(3))
as
	if(@trangthai='')
		select hd.IdHoaDon,hd.TenNguoiNhan,hd.SDTNguoiNhan,hd.Ngay,hd.TrangThai
		from HoaDon hd,ChiTietHD cthd,SanPham sp
		where hd.IdHoaDon=cthd.IdHoaDon and cthd.IdSP = sp.IdSP AND sp.IdTaiKhoan=@idnguoiban
		group by hd.IdHoaDon,hd.TenNguoiNhan,hd.SDTNguoiNhan,hd.Ngay,hd.TrangThai
	else
		select hd.IdHoaDon,hd.TenNguoiNhan,hd.SDTNguoiNhan,hd.Ngay,hd.TrangThai
		from HoaDon hd,ChiTietHD cthd,SanPham sp
		where hd.IdHoaDon=cthd.IdHoaDon and cthd.IdSP = sp.IdSP 
				AND sp.IdTaiKhoan=@idnguoiban and hd.TrangThai= @trangthai
		group by hd.IdHoaDon,hd.TenNguoiNhan,hd.SDTNguoiNhan,hd.Ngay,hd.TrangThai

/*get san pham trong chi tiet khuyen mai*/
create proc GetSanPhamTrongChiTietKhuyenMai(@IdKhuyenMai nvarchar(10))
as
	select * from ChiTietKhuyenMai ctkm, SanPham sp
	where ctkm.IdSP=sp.IdSP and ctkm.IdKhuyenMai=@IdKhuyenMai

/*insert chi tiet khuyen mai*/
create proc InsertChiTietKhuyenMai(@IdKhuyenMai nvarchar(10),@IdSP nvarchar(10),@TyLeKhuyenMai int)
as
	insert into ChiTietKhuyenMai values (@IdKhuyenMai,@IdSP,@TyLeKhuyenMai)

/*delete chi tiet khuyen mai*/
create proc DeleteChiTietKhuyenMai(@IdKhuyenMai nvarchar(10),@IdSP nvarchar(10))
as	
	delete from ChiTietKhuyenMai where IdSP=@IdSP and IdKhuyenMai=@IdKhuyenMai 


/*lay chi tiet danh muc*/
create proc LayChiTietDanhMucTheoIdTaiKhoan(@idTaiKhoan nvarchar(10))

as
	select * from ChiTietDanhMuc where IdTaiKhoan = @idTaiKhoan

/*insert yeu cau them chi tiet danh muc*/
create proc SetChiTietDanhMuc(@idTaiKhoan nvarchar(10),
							@iddanhmuc nvarchar(10),
							@tenctd nvarchar(100))
as
	insert into ChiTietDanhMuc values (@iddanhmuc,@tenctd,'2',@idTaiKhoan)

/*sản phẩm bán chạy theo id*/
alter proc GetSanPhamBanChayTheoId(@idTaiKhoan nvarchar(10))
as
	select top 10 sp.IdSP,sp.AnhSP,sp.TenSP,sp.GiaSP,sp.TrangThai,sum(cthd.SoLuong) as SoLuongBanDuoc
	from SanPham sp,ChiTietHD cthd
	where sp.IdSP = cthd.IdSP
	group by sp.IdSP,sp.AnhSP,sp.TenSP,sp.GiaSP,sp.TrangThai
	order by sum(cthd.SoLuong) desc




