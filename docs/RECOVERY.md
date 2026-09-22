# RECOVERY GUIDE (HƯỚNG DẪN KHÔI PHỤC DỰ ÁN)

Nếu trong quá trình làm bài hoặc cấu hình gặp lỗi nghiêm trọng, hãy dùng các lệnh Git dưới đây để đưa project về trạng thái sạch ngay lập tức.

---

## 1. MỐC KHÔI PHỤC (TAG & BRANCH)
- **Tag ban đầu trước khi tạo template:** `before-exam-template` (`4b35f32`)
- **Branch chuẩn bị thi:** `exam-preparation`
- **Tag hoàn chỉnh sẵn sàng thi (sau khi chuẩn bị xong):** `exam-ready` (`7d39f7a23ddaac6d0991f56b023b4220ee115796`)

---

## 2. CÁC LỆNH KIỂM TRA TRẠNG THÁI
```powershell
# Xem trạng thái thay đổi hiện tại
git status

# Xem 5 commit gần nhất
git log --oneline -5
```

---

## 3. CÁCH HỦY BỎ THAY ĐỔI CHƯA COMMIT
```powershell
# Hủy toàn bộ thay đổi trong các file đang sửa (chưa git add)
git restore .

# Bỏ staged các file đã lỡ 'git add'
git restore --staged .

# Xóa toàn bộ file rác / file mới chưa được Git theo dõi
git clean -fd
```

---

## 4. QUAY LẠI MỐC BAN ĐẦU SẠCH (TAG: before-exam-template)
Nếu code bị lỗi nặng không sửa được và muốn quay lại bản gốc:
```powershell
# Hủy toàn bộ thay đổi hiện tại và reset cứng về tag ban đầu
git reset --hard before-exam-template
git clean -fd
```

---

## 5. QUAY LẠI MỐC SẴN SÀNG THI (TAG: exam-ready)
Nếu trong phòng thi code thử bị hỏng và muốn quay lại bộ Starter Kit chuẩn:
```powershell
git reset --hard exam-ready
git clean -fd
```

---

## 6. CHUYỂN BRANCH
```powershell
# Chuyển về branch chính
git switch main

# Chuyển sang branch làm bài thi
git switch exam-preparation
```
