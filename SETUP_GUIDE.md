# 📘 PJICO Insurance Management System - Hướng dẫn Cài đặt Chi tiết

## 📑 Mục lục
1. [Yêu cầu Hệ thống](#yêu-cầu-hệ-thống)
2. [Cài đặt SQL Server](#cài-đặt-sql-server)
3. [Cài đặt Node.js & npm](#cài-đặt-nodejs--npm)
4. [Setup Database](#setup-database)
5. [Setup Backend](#setup-backend)
6. [Setup Frontend](#setup-frontend)
7. [Chạy Ứng dụng](#chạy-ứng-dụng)
8. [Troubleshooting](#troubleshooting)
9. [Production Deployment](#production-deployment)

---

## Yêu cầu Hệ thống

### Phần cứng Tối thiểu
- **CPU**: 2 cores
- **RAM**: 4GB
- **Disk**: 10GB free space

### Phần cứng Khuyến nghị
- **CPU**: 4+ cores
- **RAM**: 8GB+
- **Disk**: 20GB+ SSD

### Phần mềm
- **OS**: Windows 10/11, Ubuntu 20.04+, macOS 10.15+
- **SQL Server**: 2016 Express or later
- **Node.js**: v14.0.0 or later
- **npm**: v6.0.0 or later

---

## Cài đặt SQL Server

### Windows

1. **Download SQL Server Express**
   ```
   https://www.microsoft.com/en-us/sql-server/sql-server-downloads
   ```

2. **Cài đặt**
   - Chọn "Basic" installation
   - Chấp nhận license terms
   - Chờ cài đặt hoàn tất
   - Ghi chú lại Connection String

3. **Cài đặt SQL Server Management Studio (SSMS)** (Optional)
   ```
   https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms
   ```

4. **Enable SQL Server Authentication**
   - Mở SSMS
   - Connect to server
   - Right-click server → Properties → Security
   - Chọn "SQL Server and Windows Authentication mode"
   - Restart SQL Server service

5. **Tạo Login mới**
   ```sql
   CREATE LOGIN insurance_admin WITH PASSWORD = 'Your_Strong_Password_123!';
   ALTER SERVER ROLE sysadmin ADD MEMBER insurance_admin;
   ```

### Linux (Ubuntu)

```bash
# Install SQL Server
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)"
sudo apt-get update
sudo apt-get install -y mssql-server

# Configure SQL Server
sudo /opt/mssql/bin/mssql-conf setup

# Install SQL Server tools
sudo apt-get install -y mssql-tools unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
```

---

## Cài đặt Node.js & npm

### Windows

1. **Download Node.js**
   ```
   https://nodejs.org/en/download/
   ```
   - Tải bản LTS (Long Term Support)
   - Chạy installer
   - Chọn "Automatically install necessary tools"

2. **Verify Installation**
   ```cmd
   node --version
   npm --version
   ```

### Linux

```bash
# Using NodeSource
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify
node --version
npm --version
```

### macOS

```bash
# Using Homebrew
brew install node

# Verify
node --version
npm --version
```

---

## Setup Database

### Bước 1: Kết nối SQL Server

#### Windows (Command Line)
```cmd
sqlcmd -S localhost -U insurance_admin -P Your_Password
```

#### Linux
```bash
sqlcmd -S localhost -U sa -P Your_Password
```

### Bước 2: Restore Database

#### Option A: Sử dụng SSMS (Windows)
1. Mở SQL Server Management Studio
2. Connect to server
3. File → Open → File
4. Chọn file `database/99_FULL_DATABASE_SCRIPT.sql`
5. Nhấn Execute (F5)

#### Option B: Sử dụng Command Line
```bash
# Windows
sqlcmd -S localhost -U insurance_admin -P Your_Password -i database/99_FULL_DATABASE_SCRIPT.sql

# Linux
sqlcmd -S localhost -U sa -P Your_Password -i database/99_FULL_DATABASE_SCRIPT.sql
```

### Bước 3: Insert Test Data (Optional)
```bash
sqlcmd -S localhost -U insurance_admin -P Your_Password -d QuanlyHDBaoHiem -i database/INSERT_TEST_DATA.sql
```

### Bước 4: Verify Database
```sql
USE QuanlyHDBaoHiem;
GO
SELECT COUNT(*) AS TableCount FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
GO
```
Kết quả: Nên có ~15-20 tables

---

## Setup Backend

### Bước 1: Navigate to Backend Folder
```bash
cd insurance-deployment/backend
```

### Bước 2: Install Dependencies
```bash
npm install
```
⏱️ Thời gian: 2-5 phút

### Bước 3: Configure Environment
```bash
# Windows
copy .env.example .env

# Linux/Mac
cp .env.example .env
```

### Bước 4: Edit .env File
```env
# Chỉnh sửa các giá trị sau:
DB_SERVER=localhost
DB_PORT=1433
DB_NAME=QuanlyHDBaoHiem
DB_USER=insurance_admin
DB_PASSWORD=Your_Password

PORT=5000
NODE_ENV=development

JWT_SECRET=your_super_secret_key_change_this_123456789
JWT_EXPIRE=24h

CORS_ORIGIN=http://localhost:3000
```

⚠️ **QUAN TRỌNG**: 
- Đổi `JWT_SECRET` thành chuỗi random dài
- Sử dụng strong password cho database
- KHÔNG commit file `.env` vào git

### Bước 5: Test Backend
```bash
npm start
```

Kết quả mong đợi:
```
✓ Connected to SQL Server successfully
✓ Server is running on port 5000
```

---

## Setup Frontend

### Bước 1: Navigate to Frontend Folder
```bash
cd insurance-deployment/frontend
```

### Bước 2: Install Dependencies
```bash
npm install
```
⏱️ Thời gian: 3-7 phút

### Bước 3: Configure Environment
```bash
# Windows
copy .env.example .env

# Linux/Mac
cp .env.example .env
```

### Bước 4: Edit .env File (Optional)
```env
REACT_APP_API_URL=http://localhost:5000/api
REACT_APP_NAME=PJICO Insurance Management System
```

### Bước 5: Test Frontend
```bash
npm start
```

Browser sẽ tự động mở: `http://localhost:3000`

---

## Chạy Ứng dụng

### Option 1: Manual Start

#### Terminal 1 (Backend)
```bash
cd insurance-deployment/backend
npm start
```

#### Terminal 2 (Frontend)
```bash
cd insurance-deployment/frontend
npm start
```

### Option 2: Using Start Scripts

#### Windows
```cmd
cd insurance-deployment
start.bat
```

#### Linux/Mac
```bash
cd insurance-deployment
chmod +x start.sh
./start.sh
```

### Default Ports
- **Frontend**: http://localhost:3000
- **Backend**: http://localhost:5000
- **Database**: localhost:1433

### Default Login
```
Username: admin
Password: admin123
```

⚠️ **QUAN TRỌNG**: Đổi mật khẩu admin sau khi login lần đầu!

---

## Troubleshooting

### 1. Database Connection Failed

**Lỗi**: `Connection to SQL Server failed`

**Giải pháp**:
```bash
# Kiểm tra SQL Server đang chạy
# Windows
services.msc → tìm "SQL Server" → Start

# Linux
sudo systemctl status mssql-server
sudo systemctl start mssql-server

# Test connection
sqlcmd -S localhost -U your_user -P your_password
```

### 2. Port Already in Use

**Lỗi**: `Port 5000 is already in use`

**Giải pháp**:
```bash
# Tìm process đang sử dụng port
# Windows
netstat -ano | findstr :5000

# Linux/Mac
lsof -i :5000

# Kill process hoặc đổi port trong .env
```

### 3. npm install Failed

**Lỗi**: `npm ERR! code EACCES`

**Giải pháp**:
```bash
# Clear npm cache
npm cache clean --force

# Remove node_modules và package-lock.json
rm -rf node_modules package-lock.json

# Install lại
npm install
```

### 4. CORS Error

**Lỗi**: `Access-Control-Allow-Origin`

**Giải pháp**:
- Kiểm tra `CORS_ORIGIN` trong backend/.env
- Đảm bảo frontend URL khớp với CORS_ORIGIN

### 5. JWT Token Invalid

**Lỗi**: `JsonWebTokenError: invalid token`

**Giải pháp**:
- Logout và login lại
- Clear browser cache/cookies
- Kiểm tra `JWT_SECRET` trong .env

---

## Production Deployment

### 1. Build Frontend
```bash
cd frontend
npm run build
```
Output: `frontend/build/` folder

### 2. Setup Production Environment

#### Backend .env
```env
NODE_ENV=production
PORT=5000
DB_SERVER=your_production_server
DB_USER=your_production_user
DB_PASSWORD=strong_password_here
JWT_SECRET=very_long_random_secret_key_for_production
CORS_ORIGIN=https://yourdomain.com
```

#### Frontend .env
```env
REACT_APP_API_URL=https://api.yourdomain.com/api
```

### 3. Use PM2 for Backend (Recommended)
```bash
# Install PM2
npm install -g pm2

# Start backend
cd backend
pm2 start server.js --name insurance-api

# Auto-restart on system reboot
pm2 startup
pm2 save
```

### 4. Serve Frontend với Nginx

#### Install Nginx (Ubuntu)
```bash
sudo apt install nginx
```

#### Configure Nginx
```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /path/to/insurance-deployment/frontend/build;
    index index.html;

    location / {
        try_files $uri /index.html;
    }

    location /api {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### 5. Setup SSL với Let's Encrypt
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com
```

### 6. Database Backup Strategy
```sql
-- Daily backup script
BACKUP DATABASE QuanlyHDBaoHiem 
TO DISK = 'C:\Backups\QuanlyHDBaoHiem_backup.bak' 
WITH INIT, COMPRESSION;
```

### 7. Monitoring
- Setup log rotation
- Monitor với PM2: `pm2 monit`
- Setup alerts cho database disk space
- Monitor application logs

---

## Security Best Practices

1. ✅ **Đổi tất cả default passwords**
2. ✅ **Sử dụng HTTPS trong production**
3. ✅ **Enable firewall rules**
4. ✅ **Regular database backups**
5. ✅ **Keep dependencies updated**: `npm audit fix`
6. ✅ **Use environment variables cho sensitive data**
7. ✅ **Implement rate limiting**
8. ✅ **Enable SQL Server encryption**

---

## Performance Optimization

### Database
- Index các foreign keys
- Regular DBCC CHECKDB
- Update statistics

### Backend
- Enable compression
- Use connection pooling
- Cache frequently accessed data

### Frontend
- Use production build
- Enable gzip compression
- CDN cho static assets
- Lazy loading components

---

## 📞 Support

Nếu gặp vấn đề:
1. Check logs: `backend/*.log`, `pm2 logs`
2. Verify environment variables
3. Check database connection
4. Restart services

---

**Good luck với việc deployment! 🚀**
