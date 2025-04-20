import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final adController = TextEditingController();
  final soyadController = TextEditingController();
  final yasController = TextEditingController();
  final sinifController = TextEditingController();
  final puanController = TextEditingController();

  // Veri ekleme fonksiyonu
  void veriEkle() async {
    try {
      var url = Uri.parse('http://localhost:8000/tasks/');
      var response = await http.post(
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

      // Eğer API yanıtı başarılıysa
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Veri başarıyla eklendi!")),
        );
        // Alanları temizle
        adController.clear();
        soyadController.clear();
        yasController.clear();
        sinifController.clear();
        puanController.clear();
      } else {
        // API hatası durumunda kullanıcıya bildirim
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bir hata oluştu!")),
        );
      }
    } catch (e) {
      // Hata durumunda kullanıcıya bildirim
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hatalı giriş!")),
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
      width: 300, // TextField genişliğini küçülttük
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)), // Köşeleri yuvarladık
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
          "Sınav Kurs Öğrenci Kaydı",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white, // Başlık rengi beyaz
          ),
        ),
        backgroundColor: Colors.teal, // AppBar rengi
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center( // Center widget ile içeriği ortaladık
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Dikeyde ortalamak için
                crossAxisAlignment: CrossAxisAlignment.center, // Yatayda ortalama
                children: [
                  Text(
                    "Öğrenci Bilgileri",
                    style: GoogleFonts.poppins(
                      fontSize: 30, // Başlık font büyüklüğü
                      fontWeight: FontWeight.bold, // Başlık kalınlık
                      color: Colors.teal[800], // Başlık rengi
                    ),
                  ),
                  SizedBox(height: 30), // Başlık ile alanlar arasındaki boşluk

                  // Ad için textfield
                  buildTextField(label: "Ad", icon: Icons.person, controller: adController),
                  SizedBox(height: 20), // TextField'lar arasındaki boşluk

                  // Soyad için textfield
                  buildTextField(label: "Soyad", icon: Icons.person_outline, controller: soyadController),
                  SizedBox(height: 16),

                  // Yaş için textfield
                  buildTextField(
                    label: "Yaş",
                    icon: Icons.cake,
                    controller: yasController,
                    keyboardType: TextInputType.number, // Sayı girişi
                  ),
                  SizedBox(height: 16),

                  // Sınıf için textfield
                  buildTextField(
                    label: "Sınıf",
                    icon: Icons.class_ ,
                    controller: sinifController,
                    keyboardType: TextInputType.number, // Sayı girişi
                  ),
                  SizedBox(height: 16),

                  // Puan için textfield
                  buildTextField(
                    label: "Puan",
                    icon: Icons.grade,
                    controller: puanController,
                    keyboardType: TextInputType.number, // Sayı girişi
                  ),
                  SizedBox(height: 30), // Alanlar ile buton arasındaki boşluk

                  // Kaydet butonu
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Buton rengi
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Buton içindeki yazı ile kenar boşluğu arttırıldı
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Butonun köşe yuvarlaklığı
                      ),
                      elevation: 10, // Butonun gölge yüksekliği
                    ),
                    icon: Icon(
                      Icons.save,
                      color: Colors.white, // İkon rengi beyaz
                    ),
                    label: Text(
                      "Kaydet", // Buton metni
                      style: GoogleFonts.poppins(
                        fontSize: 20, // Font büyüklüğü
                        fontWeight: FontWeight.w500, // Font kalınlık
                        color: Colors.white, // Yazı rengi beyaz
                      ),
                    ),
                    onPressed: veriEkle, // Kaydet butonuna tıklanırsa veriEkle fonksiyonu çalışır
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
