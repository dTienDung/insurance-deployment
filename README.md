# 🚀 PJICO Insurance Management System - Deployment Package

Đây là package deployment tối ưu hóa cho hệ thống quản lý bảo hiểm PJICO, chỉ bao gồm các file cần thiết để triển khai trên máy mới.

## 📦 Nội dung Package

```
insurance-deployment/
├── backend/              # Backend API (Node.js + Express)
│   ├── config/          # Cấu hình database, constants
│   ├── controllers/     # API controllers
│   ├── middleware/      # Authentication, error handler
│   ├── routes/          # API routes
│   ├── services/        # Business logic services
│   ├── utils/           # Utility functions
│   ├── fonts/           # Fonts cho PDF export
│   ├── scripts/         # Utility scripts
│   ├── package.json     # Dependencies
│   ├── server.js        # Entry point
│   ├── businessRules.js # Business rules
│   └── .env.example     # Environment template
│
├── frontend/            # Frontend (React)
│   ├── public/          # Static files
│   ├── src/             # Source code
│   ├── package.json     # Dependencies
│   └── .env.example     # Environment template
│
├── database/            # Database scripts
│   ├── 99_FULL_DATABASE_SCRIPT.sql  # Full database schema
│   ├── INSERT_TEST_DATA.sql         # Sample data (optional)
│   └── README.md        # Database setup guide
│
├── start.bat            # Windows startup script
├── start.sh             # Linux/Mac startup script
├── README.md            # This file
└── SETUP_GUIDE.md       # Detailed setup instructions
```

## 📋 Yêu cầu Hệ thống

### ✅ Backend Requirements
- **Node.js**: >= 14.0.0
- **npm**: >= 6.0.0
- **SQL Server**: 2016 or later

### ✅ Frontend Requirements
- **Node.js**: >= 14.0.0
- **npm**: >= 6.0.0
- **Modern Browser**: Chrome, Firefox, Edge (latest versions)

## 🎯 Kích thước Package

- **Deployment package**: ~5-10 MB (không có node_modules)
- **Sau khi npm install**: ~500 MB
- **Tiết kiệm**: ~98% so với project đầy đủ

## 🚀 Quick Start

### 1. Setup Database
```bash
# Kết nối SQL Server và chạy script
sqlcmd -S localhost -d master -i database/99_FULL_DATABASE_SCRIPT.sql

# (Optional) Insert test data
sqlcmd -S localhost -d QuanlyHDBaoHiem -i database/INSERT_TEST_DATA.sql
```

### 2. Setup Backend
```bash
cd backend
cp .env.example .env
# Chỉnh sửa .env với thông tin database của bạn
npm install
npm start
```

### 3. Setup Fron tend
```bash
cd frontend
cp .env.example .env
# Chỉnh sửa .env nếu cần
npm install
npm start
```

### 4. Hoặc sử dụng Start Scripts
```bash
# Windows
start.bat

# Linux/Mac
chmod +x start.sh
./start.sh
```

## 📚 Tài liệu Chi tiết

Xem file **SETUP_GUIDE.md** để có hướng dẫn chi tiết về:
- Cài đặt và cấu hình từng bước
- Troubleshooting
- Production deployment
- Security best practices

## 🔧 Configuration

### Backend (.env)
Các biến quan trọng cần cấu hình:
- `DB_SERVER`: SQL Server hostname
- `DB_NAME`: Database name (QuanlyHDBaoHiem)
- `DB_USER`: Database username
- `DB_PASSWORD`: Database password
- `JWT_SECRET`: Secret key cho JWT (QUAN TRỌNG: Đổi trong production)

### Frontend (.env)
- `REACT_APP_API_URL`: Backend API URL (mặc định: http://localhost:5000/api)

## ⚠️ Lưu ý Quan trọng

1. **Database**: File `99_FULL_DATABASE_SCRIPT.sql` là phiên bản mới nhất (11/21/2025)
2. **Security**: 
   - ĐỔI `JWT_SECRET` trong production
   - Sử dụng HTTPS cho production
   - Không commit file `.env` vào git
3. **Node Modules**: Cần chạy `npm install` ở cả backend và frontend
4. **Ports**: 
   - Backend: 5000
   - Frontend: 3000
   - SQL Server: 1433

## 📞 Hỗ trợ

- **Technical Documentation**: Xem SETUP_GUIDE.md
- **Database Schema**: Xem database/README.md
- **API Documentation**: Xem backend/README.md (nếu có)

## 📝 Version

- **Package Version**: 1.0.0
- **Database Schema**: 11/21/2025
- **Last Updated**: 11/22/2025

---

**Lưu ý**: Package này KHÔNG bao gồm `node_modules`, test files, và documentation files để tối ưu kích thước.
