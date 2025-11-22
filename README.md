# 🍜 Let Him Cook - Ứng Dụng Công Thức Nấu Ăn Việt Nam

<div align="center">
  <img src="https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=200&fit=crop&crop=center" alt="Let Him Cook Banner" width="100%"/>
  
  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)](https://firebase.google.com)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

  **Khám phá và chia sẻ những công thức nấu ăn Việt Nam tuyệt vời!**
</div>

---

## 📱 Tổng Quan

**Let Him Cook** là một ứng dụng di động được phát triển bằng Flutter, chuyên về các công thức nấu ăn Việt Nam. Ứng dụng cung cấp một nền tảng thân thiện để khám phá, lưu trữ và chia sẻ các món ăn truyền thống và hiện đại của Việt Nam.

### ✨ Tính Năng Nổi Bật

🏠 **Trang Chủ Thân Thiện**
- Hiển thị công thức nổi bật và mới nhất
- Danh mục món ăn được phân loại rõ ràng
- Giao diện đẹp mắt với hình ảnh chất lượng cao

🔍 **Tìm Kiếm Thông Minh** 
- Tìm kiếm theo tên món ăn, nguyên liệu
- Lọc theo danh mục (Món chính, Tráng miệng, Đồ uống...)
- Kết quả tìm kiếm nhanh chóng và chính xác

❤️ **Quản Lý Yêu Thích**
- Lưu các công thức yêu thích
- Truy cập nhanh đến những món ăn ưa thích
- Đồng bộ qua thiết bị (yêu cầu đăng nhập)

📖 **Chi Tiết Công Thức Đầy Đủ**
- Danh sách nguyên liệu chi tiết
- Hướng dẫn từng bước cụ thể
- Thời gian nấu, số lượng phần ăn
- Độ khó và đánh giá từ cộng đồng

➕ **Tạo Công Thức Mới**
- Form tạo công thức đơn giản, trực quan
- Thêm nguyên liệu và bước thực hiện động
- Phân loại món ăn và đánh giá độ khó

🔐 **Hệ Thống Xác Thực**
- Đăng ký/đăng nhập bảo mật
- Quản lý hồ sơ cá nhân
- Bảo vệ dữ liệu người dùng

🎨 **Giao Diện Hiện Đại**
- Material Design 3
- Chế độ sáng/tối
- Responsive design cho web và mobile
- Hoàn toàn tiếng Việt

---

## 🛠️ Công Nghệ Sử Dụng

| Công Nghệ | Mục Đích | Phiên Bản |
|-----------|----------|-----------|
| **Flutter** | Framework phát triển ứng dụng | 3.24.0+ |
| **Dart** | Ngôn ngữ lập trình | 3.5.0+ |
| **Provider** | Quản lý trạng thái | ^6.1.2 |
| **Go Router** | Navigation và routing | ^14.8.1 |
| **Firebase Auth** | Xác thực người dùng | ^5.7.0 |
| **Material Design 3** | UI/UX Design System | Built-in |
| **Cached Network Image** | Hiển thị hình ảnh tối ưu | ^3.4.1 |
| **Google Fonts** | Typography đẹp | ^6.2.1 |

---

## 🚀 Cài Đặt và Chạy Ứng Dụng

### Yêu Cầu Hệ Thống

- **Flutter SDK**: 3.24.0 trở lên
- **Dart SDK**: 3.5.0 trở lên
- **Android Studio** hoặc **VS Code** với Flutter extension
- **Chrome** (cho phát triển web)

### Bước 1: Clone Repository

```bash
git clone https://github.com/Awac8989/app_let_him_cook.git
cd app_let_him_cook
```

### Bước 2: Cài Đặt Dependencies

```bash
flutter pub get
```

### Bước 3: Chạy Ứng Dụng

**Chạy trên Web (Khuyến nghị cho demo):**
```bash
flutter run -d chrome --web-port 8080
```

**Chạy trên Android:**
```bash
flutter run -d android
```

**Build Production:**
```bash
# Web
flutter build web

# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release
```

---

## 📁 Cấu Trúc Dự Án

```
lib/
├── 📁 core/                    # Core functionality
│   ├── 📁 models/             # Data models
│   ├── 📁 providers/          # State management
│   ├── 📁 router/             # Navigation
│   ├── 📁 services/           # Business logic
│   ├── 📁 theme/              # App theming
│   └── 📁 widgets/            # Reusable widgets
├── 📁 features/               # Feature modules
│   ├── 📁 auth/               # Authentication
│   ├── 📁 home/               # Home screen
│   ├── 📁 search/             # Search functionality
│   ├── 📁 favorites/          # Favorites management
│   └── 📁 recipe/             # Recipe details & creation
├── 📁 shared/                 # Shared components
│   └── 📁 widgets/            # Common widgets
└── main.dart                  # App entry point
```

---

## 🍲 Dữ Liệu Mẫu

Ứng dụng đi kèm với bộ sưu tập công thức Việt Nam phong phú:

- **🍜 Phở Bò Hà Nội** - Món phở truyền thống với nước dùng trong vắt
- **🥪 Bánh Mì Thịt Nướng** - Bánh mì Việt Nam với thịt nướng thơm phức  
- **🍝 Bún Chả Hà Nội** - Bún chả đặc sản với thịt nướng và nước chấm
- **🍮 Chè Ba Màu** - Tráng miệng truyền thống với đậu xanh và dừa
- **🍛 Cà Ri Gà** - Cà ri gà đậm đà với nước cốt dừa

---

## 🎯 Roadmap

### Phase 1 (Hoàn thành) ✅
- [x] Giao diện cơ bản và navigation
- [x] CRUD công thức cơ bản
- [x] Hệ thống tìm kiếm
- [x] Authentication mock
- [x] Responsive design

### Phase 2 (Tiếp theo) 🔄
- [ ] Tích hợp Firebase hoàn chỉnh
- [ ] Upload hình ảnh từ thiết bị
- [ ] Hệ thống đánh giá và bình luận
- [ ] Chia sẻ công thức qua social media
- [ ] Push notifications

### Phase 3 (Tương lai) 📅
- [ ] AI gợi ý công thức
- [ ] Video hướng dẫn nấu ăn
- [ ] Tính năng mua sắm nguyên liệu
- [ ] Community features
- [ ] Offline mode

---

## 🤝 Đóng Góp

Chúng tôi hoan nghênh mọi đóng góp từ cộng đồng!

### Cách Đóng Góp

1. **Fork** repository này
2. Tạo **feature branch** (`git checkout -b feature/AmazingFeature`)
3. **Commit** thay đổi (`git commit -m 'Add some AmazingFeature'`)
4. **Push** lên branch (`git push origin feature/AmazingFeature`)
5. Mở **Pull Request**

### Guidelines

- Sử dụng tiếng Việt cho UI và comments
- Follow Flutter best practices
- Viết unit tests cho features mới
- Cập nhật documentation khi cần

---

## 📸 Screenshots

<div align="center">
  
### 🏠 Trang Chủ
<img src="https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=600&fit=crop" alt="Home Screen" width="250"/>

### 🔍 Tìm Kiếm  
<img src="https://images.unsplash.com/photo-1547592180-85f173990554?w=300&h=600&fit=crop" alt="Search Screen" width="250"/>

### 📖 Chi Tiết Công Thức
<img src="https://images.unsplash.com/photo-1559847844-d72d88e4b3f4?w=300&h=600&fit=crop" alt="Recipe Detail" width="250"/>

</div>

---

## 📞 Liên Hệ

- **GitHub**: [@Awac8989](https://github.com/Awac8989)
- **Email**: [minhquandoan66@gmail.com)
- **Project Link**: [https://github.com/Awac8989/app_let_him_cook](https://github.com/Awac8989/app_let_him_cook)

---

## 🙏 Cảm Ơn

Cảm ơn bạn đã quan tâm đến **Let Him Cook**! Nếu bạn thấy dự án này hữu ích, đừng quên ⭐ star repository này nhé!

<div align="center">
  
**Hãy để anh ấy nấu ăn! 👨‍🍳🔥**

</div>
