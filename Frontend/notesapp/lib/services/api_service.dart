import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:notesapp/models/note.dart';

class ApiService {
  static String baseUrl = "http://172.16.1.169:5000/notes";

  static Future<void> addNotes(Note note) async {
    Uri requestUri = Uri.parse('$baseUrl/add');
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse('$baseUrl/delete');
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userId) async {
    Uri requestUri = Uri.parse('$baseUrl/list');
    var response = await http.post(requestUri, body: {"userId": userId});
    var decoded = jsonDecode(response.body);

    List<Note> notes = [];
    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;
  }
}
