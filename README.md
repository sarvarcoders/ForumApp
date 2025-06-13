# 🗣️ Forum App

Bu loyiha — SwiftUI va Firebase asosida yozilgan oddiy **Savol-Javob Forum** ilovasi. Foydalanuvchilar savol qoldirishlari, boshqa foydalanuvchilarning savollarini ko‘rishlari va yoqqan savollarga "like" bosishlari mumkin.

---

## 🚀 Xususiyatlari

- 🔐 Foydalanuvchi ro‘yxatdan o‘tishi va tizimga kirishi (Firebase Auth orqali)
- 📝 Savol qoldirish (sarlavha va matn bilan)
- 📋 Barcha savollarni real vaqtda ko‘rish
- ❤️ Like bosish (har bir foydalanuvchi bir marta)
- 🧹 O‘z savollarini o‘chirish imkoniyati
- 👤 Foydalanuvchi ismi va email’ini saqlash
- 🔄 Firestore orqali real vaqtli ma’lumot almashinuvi

---

## 🛠️ Texnologiyalar

| Bo‘lim        | Texnologiya           |
|---------------|------------------------|
| Foydalanuvchi interfeysi | SwiftUI         |
| Backend       | Firebase Firestore     |
| Avtorizatsiya | Firebase Auth          |
| Arxitektura   | MVVM                   |
| Real-time     | `addSnapshotListener`  |

---


---

## ⚙️ Ishga tushirish

1. Repozitoriyani klonlang
2. Xcode 15+ bilan oching
3. Firebase’dan yuklab olingan `GoogleService-Info.plist` faylni loyihaga qo‘shing
4. iOS simulyator yoki haqiqiy qurilmada ishga tushiring (`Cmd + R`)

---

## 📸 Skreenshotlar

> 💡 

---

## ℹ️ Qo‘shimcha

- Bu ilova **Firebase Storage** ishlatmaydi
- Like faqat 1 marotaba bosilishi mumkin (userID asosida)
- Ma’lumotlar Firestore orqali **real vaqtda** yuklanadi

---

## 👨‍💻 Muallif

Loyiha muallifi: [Sarvar](https://github.com/sarvarcoders)  
Maqsad: iOS dasturchilik portfolioga loyiha tayyorlash va ishga kirishga tayyorgarlik

