/* 09/09/2020*/
use master
go
create database QL_Sach
on
(
Name=QL_Sach_DaTa,
filename= 'D:\QUANTRICSDL\QL_SACH_Data.mdf',
size=10MB,
maxsize=100MB,
FileGrowth=10%
)
Log on
(
Name=QLSach_Log,
filename= 'D:\QUANTRICSDL\QL_SACH_Log.ldf',
size=2MB,
maxsize=UNLIMITED,
FileGrowth=10%
)
use QL_Sach
/*tao bang the loai sach*/
create table TheLoai
(
   MaTL nchar(10) not null primary key,
   TenTL nchar(100)
);
create table Sach
(
  MaSach nchar(10) not null primary key,
  TenSach nchar(100),
  SoTrang int,
  NgayXb date,
  MaTL nchar(10),
  foreign key(MaTL) references TheLoai(MaTL)
  /* Khóa ngoại thm chiếu về bảng thể loại*/
)
create table NhaXB
(
   MaXB nchar(10) not null primary key,
   TenXB nchar(100),
   DiaChi nchar(100),
   SDT char(20),
   Email char(50),
   MaSach nchar(10),
);
/* them 1 cot MaXB vao bang sach*/
alter table Sach
add	MaXB nchar(10);
/*thêm mối quan hệ*/
alter table Sach
add foreign key(MaXB) references NhaXB(MaXB);
/* xóa database*/
drop database QLNS;
/*Thay đổi do rộng TenXB lên 200*/
alter table NhaXB
alter column TenXB nchar(200);
/* xóa cột email trong NhaXB*/
alter table NhaXB
drop column Email;
/* them ràng buộc sdt là duy nhất */
alter table NhaXB
add constraint SDT_duynhat unique(SDT);

/* 14/09/2020 */
/* thêm dữ liệu cho các bảng sách */

insert into TheLoai(MaTL,TenTL) values(N'TH',N'Tin Hoc');
insert into TheLoai(MaTL,TenTL) values(N'KT',N'Kế Toán');
insert into TheLoai(MaTL,TenTL) values(N'QTKD',N'Quản Trị Kinh Doanh');
insert into TheLoai(MaTL,TenTL) values(N'TNN',N'Tài Nguyên Nước');
insert into TheLoai(MaTL,TenTL) values(N'KTMT',N'Khoa Học Môi Trường');
select * from TheLoai;

/* thêm dữ liệu bảng NhaXB */
insert into NhaXB(MaXB, TenXB, DiaChi, SDT)
values(N'NXBTH',N'Nhà xuất bản tổng hợp',N'12 Hai Bà Trưng. Hà Nội','024567876');
insert into NhaXB(MaXB, TenXB, DiaChi, SDT)
values(N'NXBGD',N'Nhà xuất bản giáo dục',N'14 Đống Đa. Hà Nội','0245678567');
insert into NhaXB(MaXB, TenXB, DiaChi, SDT)
values(N'NXBTK',N'Nhà xuất bản thống kê',N'1 Bình Trị Đông. TPHCM','024567235');
insert into NhaXB(MaXB, TenXB, DiaChi, SDT)
values(N'NXBKT',N'Nhà xuất bản kỹ thuật',N'12 Võ Văn Tần. TPHCM','026567876');
-- xem lại nha xb
Select * from NhaXB
--thêm sách
SET DATEFORMAT dmy;
insert into Sach(MaSach,TenSach,SoTrang,NgayXb, MaTL,MaXB)
values(N'THKT' ,N'Tin học văn phòng cho kế toán',N'60','12/12/2020',N'TH',N'NXBGD');
insert into Sach(MaSach,TenSach,SoTrang,NgayXb, MaTL,MaXB)
values(N'THCT' ,N'Tin học văn phòng cho công trình',N'30','24/12/2020',N'TH',N'NXBGD');
insert into Sach(MaSach,TenSach,SoTrang,NgayXb, MaTL,MaXB)
values(N'KTDC' ,N'Kế toán đại cương',N'20','12/11/2020',N'KT',N'NXBGD');
insert into Sach(MaSach,TenSach,SoTrang,NgayXb, MaTL,MaXB)
values(N'QTKDNLKD' ,N'Nguyên lý kinh doanh',N'90','01/11/2020',N'QTKD',N'NXBTH');
insert into Sach(MaSach,TenSach,SoTrang,NgayXb, MaTL,MaXB)
values(N'QTKDTLKD' ,N'Triết lý kinh doanh',N'90','12/09/2020',N'QTKD',N'NXBTK');
insert into Sach(MaSach,TenSach,SoTrang,NgayXb, MaTL,MaXB)
values(N'TNCTN' ,N'Cấp thoát nước',N'40','12/08/2020',N'TNN',N'NXBTK');
insert into Sach(MaSach,TenSach,SoTrang,NgayXb, MaTL,MaXB)
values(N'KTMTCB' ,N'Kỹ thuật môi trường cơ bản',N'20','12/12/2019',N'KTMT',N'NXBKHKT');
-- Xem lại tất cả các bag vua nhap
select * from TheLoai;
select * from NhaXB;
select * from Sach;
/* Sinh Viên làm bảng tác giả bảng Sach_Tac_Gia*/
create table TacGia
(
   MaTG nchar(20) not null primary key,
   TenTG nchar(100),
   DiaChi nchar(200),
   SDT nchar(10),
   email nchar(200),
);
create table Sach_TacGia
(
   MaTG nchar(20) not null,
   MaSach nchar(10) not null,
   constraint PK_SACH_TACGIA primary key (MaTG,MaSach)
);
alter table Sach_TacGia
 add constraint FK_SACH_TAC_SACH_TACG_TACGIA foreign key (MaTG)
    references TacGia (MaTG)
go

alter table Sach_TacGia
 add constraint FK_SACH_TAC_SACH_TACG_SACH foreign key (MaSach)
    references SACH (MaSach)
go
insert into TacGia values(N'001',N'Phạm Hữu Độ',N'Hà Nội','0988888888','huudo@gmail.com');
insert into TacGia values(N'002',N'Phạm An Bình',N'Gia Lai','0956435654','anbinh@gmail.com');
insert into TacGia values(N'003',N'Viên An',N'Đồng Tháp','0984334566','vienan@gmail.com');
insert into TacGia values(N'004',N'Cù Huy Tiến',N'BRVT','0376209435','huytien@gmail.com');
select * from TacGia;
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'THCT');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'THKT');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'KTDC');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'TNNCTN');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'QTKDNLKD');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'THCT');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'THKT');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'TNCTN');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'QTKDNLKD');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'KTMTCB');
insert into Sach_TacGia(MaTG,MaSach) values(N'003',N'THKT');
insert into Sach_TacGia(MaTG,MaSach) values(N'004',N'THKT');
insert into Sach_TacGia(MaTG,MaSach) values(N'004',N'KTDC');
-- truy vấn sử dụng một bảng
select * from TheLoai;
select * from NhaXB;
select * from Sach;
select * from Sach_TacGia;
select * from TacGia;
-- truy vấn lấy các cột
select TheLoai.MaTL,TheLoai.TenTL from TheLoai;
select MaTL,TenTL from TheLoai;
select MaTL as ID,TenTL from TheLoai;


-- Truy vấn 2 hoặc nhiều bảng
-- Cho biết danh sách các sách của tác giả
select s.TenSach,tg.TenTG
from Sach s,TacGia tg,Sach_TacGia stg
where s.MaSach=stg.MaSach and stg.MaTG=tg.MaTG

----ngày 16-9-2020
--hiển thị ds các sách gồm các thông tin sau
-- MaSach, TênSách, sotrang, NgàyXB, MaTL, TênTL
select  s.MaSach , s.TenSach, s.SoTrang, s.MaTL, tl.TenTL
from   Sach s, TheLoai  tl
where  s.MaTL = tl.MaTL
---Hiển thị ds các sach gôm tất cả các thông tin sách và tất cả các thông tin thể loại
select    s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL
--hien thi top 3 dòng đầu tiên
--top n
select   top 3  s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL
--Sap xep sử dụng từ khóa order by
--Hiển thị ds theo só trang tăng dần
select   top 3  s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL
order by s.SoTrang asc;

--Hiển thị ds theo só trang giảm dần
select   top 3  s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL
order by s.SoTrang desc;
--Hiển thị ds theo só trang giảm dần và ngàyxb tang dần
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL
order by s.SoTrang desc  , s.NgayXb asc ;
--hiẻn thị ds mà có số trang = 50
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL and s.SoTrang = 50
order by s.SoTrang desc  , s.NgayXb asc ;
--hiẻn thị ds mà có số trang khac 50
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL and s.SoTrang != 50
order by s.SoTrang desc  , s.NgayXb asc ;
--hiển thi số trang lớn hơn 20 và nhỏ hơn 50
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL and (s.SoTrang > 20 and s.SoTrang <50)
order by s.SoTrang desc  , s.NgayXb asc ;
--hiển thi số trang >=20 và <= 50
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL and (s.SoTrang >= 20 and s.SoTrang <=50)
order by s.SoTrang desc  , s.NgayXb asc ;
--c2
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL=tl.MaTL and (s.SoTrang between 20 and 50)
order by s.SoTrang desc  , s.NgayXb asc ;
-- hiển thị ds Sach có tên sách bắt đầu là chữ T
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL = tl.MaTL and s.TenSach like 'T%'
-- hiển thị ds Sach có tên sách CÓ KÍ tư đầu ttieen là chữ T, KÍ THỰ THỨ 2 LÀ KÍ TỰ BẤT KÌ , kí tự  thứ 3 là n
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL = tl.MaTL and s.TenSach like 'T_%'
--HIỂN THỊ DANH SACH CÓ SỐ TRANG BẮT ĐẦU LÀ SỐ 2
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL = tl.MaTL and s.SoTrang like '2_'
--HIỂN THỊ ds tên là chữ đại
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL = tl.MaTL and s.TenSach like N'%đại%'
--hiển thị ds nhà xuất bản có số điện thoai 028567861[24]
select    *
from NhaXB
where SDT like '028567861[24]'
--Hiên thi sô trang theo [234]%
select     s.*,tl.*
from Sach s, TheLoai tl
where s.MaTL = tl.MaTL and s.SoTrang like '[234]%'
-- [^kytu]
--hiển thị ds nhà xuất bản có số điện thoai 028567861[^24]
select    *
from NhaXB
where SDT like '028567861[^24]'
--insert thêm 1 giá tri null
insert into Sach(MaSach, MaTL, MaXB) values (N'KTTT', N'KTMLTY', N'NXBRFCT');
select* from Sach;
-- LỌC RA DS CÁC SÁCH CÓ GIÁ TRỊ NULL
select *
from Sach
where TenSach is NULL;
--Lọc ra ds các sach có giá trị NULL
select *
from Sach
where TenSach is not NULL;
---GROUP BY
select tl.MaTL,   min(s.SoTrang) as Sotrangnhonhat, max(s.SoTrang) as sotranglonnhat, AVG(s.SoTrang) as TB, count(tl.MaTL) as tongsach 
from Sach s, TheLoai tl
where  s.MaTL = tl.MaTL
group by tl.MaTL


