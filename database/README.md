# 🗄️ Database Setup Guide

## 📋 Database Schema

**Database Name**: `QuanlyHDBaoHiem`  
**Schema Version**: 11/21/2025  
**SQL Server Version**: 2016 or later

## 📂 Files trong Folder này

### `99_FULL_DATABASE_SCRIPT.sql`
- **Mô tả**: File SQL tổng hợp đầy đủ để tạo database từ đầu
- **Nội dung**:
  - CREATE DATABASE
  - CREATE USERS & ROLES
  - CREATE SEQUENCES (9 sequences)
  - CREATE TABLES (~17 tables)
  - CREATE VIEWS (9 views)
  - CREATE TRIGGERS (11 triggers)
  - CREATE STORED PROCEDURES (9 procedures)
  - CREATE INDEXES
  - DEFAULT CONSTRAINTS
  - FOREIGN KEY CONSTRAINTS

- **Kích thước**: ~90KB
- **Thời gian chạy**: 10-30 giây

### `INSERT_TEST_DATA.sql`
- **Mô tả**: Data mẫu để testing (OPTIONAL)
- **Nội dung**:
  - 5 Khách hàng
  - 6 Xe
  - 9 Hồ sơ thẩm định
  - 8 Hợp đồng
  - Các giao dịch thanh toán
  - 1 Quan hệ tái tục

- **Sử dụng**: Chỉ cho môi trường development/testing
- **KHÔNG sử dụng**: cho production

## 🚀 Quick Start

### Option 1: SQL Server Management Studio (SSMS)

1. Mở SSMS
2. Connect to SQL Server
3. File → Open → File
4. Chọn `99_FULL_DATABASE_SCRIPT.sql`
5. Nhấn **Execute** (F5)
6. Đợi script hoàn tất

### Option 2: Command Line

#### Windows
```cmd
sqlcmd -S localhost -U insurance_admin -P YourPassword -i 99_FULL_DATABASE_SCRIPT.sql
```

#### Linux
```bash
sqlcmd -S localhost -U sa -P YourPassword -i 99_FULL_DATABASE_SCRIPT.sql
```

### Option 3: Azure Data Studio

1. Mở Azure Data Studio
2. Connect to server
3. File → Open File
4. Chọn `99_FULL_DATABASE_SCRIPT.sql`
5. Run (F5)

## ✅ Verify Installation

Sau khi chạy script, verify:

```sql
-- 1. Check database exists
USE master;
GO
SELECT name FROM sys.databases WHERE name = 'QuanlyHDBaoHiem';
GO

-- 2. Check tables count
USE QuanlyHDBaoHiem;
GO
SELECT COUNT(*) AS TableCount 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';
-- Expected: ~17 tables
GO

-- 3. Check sequences
SELECT COUNT(*) AS SequenceCount 
FROM sys.sequences;
-- Expected: 9 sequences
GO

-- 4. Check stored procedures
SELECT COUNT(*) AS ProcedureCount 
FROM sys.procedures;
-- Expected: ~9 procedures
GO

-- 5. Check triggers
SELECT COUNT(*) AS TriggerCount 
FROM sys.triggers;
-- Expected: ~11 triggers
GO

-- 6. Check views
SELECT COUNT(*) AS ViewCount 
FROM INFORMATION_SCHEMA.VIEWS;
-- Expected: ~9 views
GO
```

## 📊 Database Objects Overview

### Tables (17)
1. **NhanVien** - Nhân viên
2. **TaiKhoan** - Tài khoản đăng nhập
3. **KhachHang** - Khách hàng
4. **Xe** - Thông tin xe
5. **BienSoXe** - Biển số xe
6. **KhachHangXe** - Quan hệ khách hàng - xe
7. **GoiBaoHiem** - Gói bảo hiểm
8. **MaTranThamDinh** - Tiêu chí thẩm định
9. **MaTranTinhPhi** - Ma trận tính phí
10. **HoSoThamDinh** - Hồ sơ thẩm định
11. **HoSoThamDinh_ChiTiet** - Chi tiết thẩm định
12. **HoSo_XeSnapshot** - Snapshot xe tại thời điểm thẩm định
13. **HopDong** - Hợp đồng bảo hiểm
14. **HopDongRelation** - Quan hệ hợp đồng (tái tục, chuyển quyền)
15. **ThanhToanHopDong** - Thanh toán
16. **LS_TaiNan** - Lịch sử tai nạn
17. **AuditLog** - Log audit

### Sequences (9)
- `seq_MaNV` - Mã nhân viên
- `seq_MaTK` - Mã tài khoản
- `seq_MaKH` - Mã khách hàng
- `seq_MaXe` - Mã xe
- `seq_MaBienSo` - Mã biển số
- `seq_MaGoi` - Mã gói bảo hiểm
- `seq_MaHS` - Mã hồ sơ
- `seq_MaTT` - Mã thanh toán
- `seq_MaLS` - Mã lịch sử

### Views (9)
1. `v_DanhSachHopDong_ChiTiet`
2. `v_HopDong_SapHetHan`
3. `v_TinhTrangThanhToan_HopDong`
4. `v_HoSo_ChiTietDiemThamDinh`
5. `v_ThongKe_ThamDinh`
6. `v_BaoCao_TaiTuc`
7. `v_PhanTich_RuiRo`
8. `v_KhachHang_ChiTiet`
9. `v_BaoCao_TongHopDoanhThu`

### Stored Procedures (9)
1. `sp_TinhDiemThamDinh` - Tính điểm thẩm định
2. `sp_XacDinhRiskLevel` - Xác định mức rủi ro
3. `sp_TinhPhiBaoHiem` - Tính phí bảo hiểm
4. `sp_TaoHopDong` - Tạo hợp đồng
5. `sp_LapHopDong_TuHoSo` - Lập hợp đồng từ hồ sơ
6. `sp_TaoThanhToan` - Tạo thanh toán
7. `sp_HoanTienHopDong` - Hoàn tiền
8. `sp_RenewHopDong` - Tái tục hợp đồng
9. `sp_ChuyenQuyenHopDong` - Chuyển quyền hợp đồng
10. `sp_CreateSnapshot` - Tạo snapshot xe

### Triggers (11)
- Auto-generate primary keys (MaNV, MaTK, MaKH, MaXe, etc.)
- Auto-update contract status on payment
- Audit logging
- Business rule enforcement

## 🔐 Security

### Default Users
Script sẽ tạo 2 database users:
1. **pjico_user** - db_owner role
2. **insurance_admin** - db_owner role

⚠️ **QUAN TRỌNG**: Đổi password sau khi setup!

```sql
-- Đổi password
ALTER LOGIN pjico_user WITH PASSWORD = 'NewStrongPassword123!';
ALTER LOGIN insurance_admin WITH PASSWORD = 'NewStrongPassword123!';
```

## 🔧 Troubleshooting

### Lỗi: "Database already exists"
```sql
-- Drop database nếu muốn tạo lại
USE master;
GO
DROP DATABASE QuanlyHDBaoHiem;
GO
-- Sau đó chạy lại script
```

### Lỗi: "Cannot open database"
```sql
-- Kiểm tra kết nối
SELECT @@SERVERNAME AS ServerName, DB_NAME() AS CurrentDatabase;
```

### Lỗi: "Login failed"
- Check SQL Server Authentication được enable
- Verify username/password
- Check user permissions

## 📝 Migration & Updates

Nếu cần update database schema:
1. Backup current database
2. Test migration script trên copy
3. Apply migration script
4. Verify data integrity

## 💾 Backup & Restore

### Backup
```sql
BACKUP DATABASE QuanlyHDBaoHiem
TO DISK = 'C:\Backups\QuanlyHDBaoHiem.bak'
WITH INIT, COMPRESSION;
```

### Restore
```sql
USE master;
GO
RESTORE DATABASE QuanlyHDBaoHiem
FROM DISK = 'C:\Backups\QuanlyHDBaoHiem.bak'
WITH REPLACE;
GO
```

## 📊 Database Size

- **Initial Size**: ~75MB
- **Expected Growth**: 1-5GB/year (depending on usage)
- **Recommend**: Monitor disk space regularly

## 🔍 Maintenance

### Regular Tasks
```sql
-- 1. Update statistics (Weekly)
EXEC sp_updatestats;

-- 2. Rebuild indexes (Monthly)
ALTER INDEX ALL ON [TableName] REBUILD;

-- 3. Check database integrity (Weekly)
DBCC CHECKDB (QuanlyHDBaoHiem) WITH NO_INFOMSGS;

-- 4. Shrink log file (if needed)
DBCC SHRINKFILE (QuanlyHDBaoHiem_log, 100);
```

## 📞 Support

Nếu gặp vấn đề với database:
1. Check SQL Server error logs
2. Verify permissions
3. Check disk space
4. Review connection strings

---

**Database Version**: 11/21/2025  
**Last Updated**: 11/22/2025
