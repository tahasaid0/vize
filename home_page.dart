import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_task_page.dart';
import 'update_task_page.dart';
import 'list_tasks_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBF4E2), // Arka plan rengini #FBF4E2 olarak ayarladık
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0), // Sol taraftan biraz boşluk ekliyoruz
          child: Row(
            children: [
              Icon(
                Icons.school, // İkonu seçtik (örneğin bir okul ikonu)
                size: 30, // İkon boyutu
                color: Colors.white, // İkon rengi
              ),
              SizedBox(width: 8), // İkon ile metin arasına boşluk ekliyoruz
              Text(
                "Sınav Kurs",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Başlık rengini beyaz yaptık
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 5,
        titleSpacing: 0, // Sağdaki boşluğu sıfırlıyoruz
        actions: [
          // Ayarlar ikonu
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Ayarlarla ilgili işlemi başlatmak için ayar ekranı göster
              _showSettingsDialog(context);
            },
          ),
          // Bildirim ikonu
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Bildirimleri gösteren dialogu aç
              _showNotificationDialog(context);
            },
          ),
          // Çıkış yap ikonu
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              // Çıkış yapma işlemi için onay ekranı açma
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🟢 Ortalanmış ve şık başlık
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sınav Kurs",
                        style: GoogleFonts.poppins(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800],
                          letterSpacing: 1.4,
                          shadows: [
                            Shadow(
                              blurRadius: 6.0,
                              color: Colors.black26,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8), // Başlıklar arasındaki boşluk
                      Text(
                        "Öğrenci Kayıt Sistemi",
                        style: GoogleFonts.poppins(
                          fontSize: 38,
                          fontWeight: FontWeight.w500,
                          color: Colors.teal[700],
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              blurRadius: 4.0,
                              color: Colors.black26,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                // Öğrenci Ekle Butonu
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    shadowColor: Colors.black.withOpacity(0.2),
                    elevation: 5,
                  ),
                  icon: Icon(Icons.person_add, color: Colors.white),
                  label: Text(
                    "Öğrenci Ekle",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddTaskPage()),
                    );
                  },
                ),
                SizedBox(height: 30),
                // Öğrenci Bilgileri Güncelleme Butonu
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE4A365),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    shadowColor: Colors.black.withOpacity(0.2),
                    elevation: 5,
                  ),
                  icon: Icon(Icons.update, color: Colors.white),
                  label: Text(
                    "Öğrenci Bilgileri Güncelleme",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UpdateTaskPage()),
                    );
                  },
                ),
                SizedBox(height: 30),
                // Öğrenci Listeleri Butonu
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4A70B5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    shadowColor: Colors.black.withOpacity(0.2),
                    elevation: 5,
                  ),
                  icon: Icon(Icons.list, color: Colors.white),
                  label: Text(
                    "Öğrenci Listeleri",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ListTasksPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Çıkış yapma onay dialogu
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Çıkış Yapmak İstediğinizden Emin Misiniz?", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text("Çıkış yaparak sistemden çıkacaksınız.", style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: Text("Hayır", style: GoogleFonts.poppins()),
            ),
            TextButton(
              onPressed: () {
                // Çıkış yapma işlemi burada yapılabilir
                Navigator.of(context).pop(); // Dialog'u kapat
                Navigator.pushReplacementNamed(context, '/login'); // Örnek yönlendirme
              },
              child: Text("Evet", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Ayarlarla ilgili dialog
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ayarlar", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog'u kapat
                  // Hesap Ayarları sayfasına yönlendirme
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UpdateTaskPage()), // Öğrenci Bilgileri Güncelleme ekranına yönlendiriyoruz
                  );
                },
                child: Text("Hesap Ayarları", style: GoogleFonts.poppins()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog'u kapat
                  // Yardım sayfasına yönlendirme
                  _showHelpDialog(context);
                },
                child: Text("Yardım", style: GoogleFonts.poppins()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: Text("Kapat", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // Yardım dialogu
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Yardım", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1. Hesap Ayarları: Kullanıcı bilgilerinizi güncelleyebilirsiniz.", style: GoogleFonts.poppins()),
              SizedBox(height: 10),
              Text("2. Sıkça Sorulan Sorular: Uygulama hakkında yardım alın.", style: GoogleFonts.poppins()),
              SizedBox(height: 10),
              Text("3. Geri bildirim göndermek için iletişime geçebilirsiniz.", style: GoogleFonts.poppins()),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: Text("Kapat", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // Bildirim dialogu
  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Bildirimler", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            "Bildirim geldiğinde burada gözükecek.",
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: Text("Kapat", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
