import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateTaskPage extends StatefulWidget {
  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final idController = TextEditingController();
  final adController = TextEditingController();
  final soyadController = TextEditingController();
  final yasController = TextEditingController();
  final sinifController = TextEditingController();
  final puanController = TextEditingController();

  // Veri güncelleme işlemi
  void guncelleTask(BuildContext context) async {
    final id = idController.text.trim();
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lütfen ID giriniz")));
      return;
    }

    final url = Uri.parse('http://localhost:8000/tasks/$id');
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "ad": adController.text,
        "soyad": soyadController.text,
        "yas": int.parse(yasController.text),
        "sinif": int.parse(sinifController.text),
        "puan": int.parse(puanController.text),
      }),
    );

    // Yanıtın durumu
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Güncelleme başarılı")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Güncelleme başarısız")),
      );
    }
  }

  // Genel metin alanı widget'ı
  Widget buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: 300, // TextField genişliği
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon), // İkon ekleniyor
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)), // Yuvarlak köşeler
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBF4E2), // Arka plan rengini #FBF4E2 olarak ayarladık
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Geri gitme butonu
          color: Colors.white, // Geri gitme butonunun rengi beyaz
          onPressed: () {
            Navigator.pop(context); // Geri gitmek için Navigator.pop
          },
        ),
        title: Text(
          "Öğrenci Bilgilerini Güncelleme",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600, // Başlık font kalınlığı
            color: Colors.white, // Başlık rengi beyaz
          ),
        ),
        backgroundColor: Color(0xFFE4A365), // Yeni turuncu renk
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center( // Burada Center widget'ı ile tüm sayfayı ortaladık
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Dikeyde ortalama
                crossAxisAlignment: CrossAxisAlignment.center, // Yatayda ortalama
                children: [
                  // Sayfa Başlığı
                  Text(
                    "Öğrenci Bilgilerini Güncelle",
                    style: GoogleFonts.poppins(
                      fontSize: 24, // Başlık font büyüklüğü
                      fontWeight: FontWeight.bold, // Başlık kalınlık
                      color: Color(0xFFE4A365), // Yeni turuncu renk
                    ),
                  ),
                  SizedBox(height: 30),

                  // ID metin alanı
                  buildTextField(label: "Güncellenecek Kayıt ID", icon: Icons.assignment, controller: idController),
                  SizedBox(height: 16),

                  // Ad metin alanı
                  buildTextField(label: "Ad", icon: Icons.person, controller: adController),
                  SizedBox(height: 16),

                  // Soyad metin alanı
                  buildTextField(label: "Soyad", icon: Icons.person_outline, controller: soyadController),
                  SizedBox(height: 16),

                  // Yaş metin alanı
                  buildTextField(
                    label: "Yaş",
                    icon: Icons.cake,
                    controller: yasController,
                    keyboardType: TextInputType.number, // Sayı girişi
                  ),
                  SizedBox(height: 16),

                  // Sınıf metin alanı
                  buildTextField(
                    label: "Sınıf",
                    icon: Icons.class_,
                    controller: sinifController,
                    keyboardType: TextInputType.number, // Sayı girişi
                  ),
                  SizedBox(height: 16),

                  // Puan metin alanı
                  buildTextField(
                    label: "Puan",
                    icon: Icons.grade,
                    controller: puanController,
                    keyboardType: TextInputType.number, // Sayı girişi
                  ),
                  SizedBox(height: 30),

                  // Güncelle Butonu
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE4A365), // Yeni turuncu renk buton için
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Buton içindeki metinle kenar arasındaki boşluk
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Yuvarlatılmış köşeler
                      ),
                      elevation: 5, // Butonun gölge yüksekliği
                    ),
                    icon: Icon(
                      Icons.update,
                      color: Colors.white, // İkon rengi beyaz
                    ),
                    label: Text(
                      "Güncelle", // Buton metni
                      style: GoogleFonts.poppins(
                        fontSize: 18, // Font büyüklüğü
                        fontWeight: FontWeight.w500, // Font kalınlık
                        color: Colors.white, // Yazı rengi beyaz
                      ),
                    ),
                    onPressed: () => guncelleTask(context), // Butona tıklanınca guncelleTask fonksiyonu çalışır
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
