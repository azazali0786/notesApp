import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  List<Note> getFilteredNotes(String searchQuery) {
    return notes.where((element) =>
        element.title!.toLowerCase().contains(searchQuery.toLowerCase())||
        element.content!.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  void sortNote() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNote();
    notifyListeners();
    ApiService.addNotes(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNote();
    notifyListeners();
    ApiService.addNotes(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNote();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes("azazali786");
    isLoading = false;
    notifyListeners();
  }
}
