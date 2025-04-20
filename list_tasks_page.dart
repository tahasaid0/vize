import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task.dart';
import 'update_task_page.dart';

class ListTasksPage extends StatefulWidget {
  @override
  _ListTasksPageState createState() => _ListTasksPageState();
}

class _ListTasksPageState extends State<ListTasksPage> {
  List<Task> tasks = [];
  List<Task> filteredTasks = [];
  String searchQuery = '';

  // Verileri sunucudan al
  Future<void> getTasks() async {
    var response = await http.get(Uri.parse('http://localhost:8000/tasks/'));
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body) as List;
      setState(() {
        tasks = list.map((e) => Task.fromJson(e)).toList();
        filteredTasks = tasks; // Başlangıçta tüm öğrenciler gösterilecek
      });
    }
  }

  // Silme işlemi
  Future<void> deleteTask(int id) async {
    var response = await http.delete(Uri.parse('http://localhost:8000/tasks/$id'));
    if (response.statusCode == 200) {
      getTasks();
    }
  }

  // Öğrenci arama
  void _findStudent() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Öğrenci Ara", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          content: TextField(
            decoration: InputDecoration(hintText: "Öğrenci Adı"),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
                // Arama işlemi yapalım
                filteredTasks = tasks
                    .where((task) =>
                        task.ad.toLowerCase().contains(searchQuery.toLowerCase()) ||
                        task.soyad.toLowerCase().contains(searchQuery.toLowerCase()))
                    .toList();
              });
            },
          ),
          actions: [
            TextButton(
              child: Text("İptal", style: GoogleFonts.poppins()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Ara", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {
                  filteredTasks = tasks
                      .where((task) =>
                          task.ad.toLowerCase().contains(searchQuery.toLowerCase()) ||
                          task.soyad.toLowerCase().contains(searchQuery.toLowerCase()))
                      .toList();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getTasks(); // Sayfa açıldığında verileri al
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
          "Sınav Kurs Öğrenci Listesi",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white, // Başlık rengi beyaz
          ),
        ),
        backgroundColor: Color(0xFF4A70B5), // Mavi rengini 4A70B5 olarak değiştirdim
        elevation: 5,
        actions: [
          // Arama butonu
          IconButton(
            icon: Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: _findStudent,
          ),
        ],
      ),
      body: filteredTasks.isEmpty
          ? Center(
              child: Text(
                "Kayıtlı öğrenci bulunmamaktadır.",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (_, index) {
                  final task = filteredTasks[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: _getAvatarColor(task.ad),
                        child: Text(
                          task.ad[0].toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${task.ad} ${task.soyad}",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "ID: ${task.id}",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: -6,
                          children: [
                            Chip(
                              label: Text("Yaş: ${task.yas}", style: TextStyle(fontSize: 12)),
                              visualDensity: VisualDensity.compact,
                            ),
                            Chip(
                              label: Text("Sınıf: ${task.sinif}", style: TextStyle(fontSize: 12)),
                              visualDensity: VisualDensity.compact,
                            ),
                            Chip(
                              label: Text("Puan: ${task.puan}", style: TextStyle(fontSize: 12)),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 6,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Color(0xFF4A70B5), size: 22), // Mavi rengini 4A70B5 olarak değiştirdim
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UpdateTaskPage(),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_forever, color: Colors.deepOrange, size: 22),
                            onPressed: () => deleteTask(task.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  // Avatar için farklı renkler
  Color _getAvatarColor(String ad) {
    final colors = [
      Colors.teal,
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.cyan,
    ];

    int index = ad.codeUnitAt(0) % colors.length;
    return colors[index];
  }
}
