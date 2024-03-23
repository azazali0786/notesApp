import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/pages/add_new_note.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading == false)
          ? SafeArea(
              child: notesProvider.notes.isNotEmpty
                  ? ListView(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              searchQuery = val;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                            ),
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search)
                          ),
                        ),
                      ),
                     (notesProvider.getFilteredNotes(searchQuery).isNotEmpty)?GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: notesProvider.getFilteredNotes(searchQuery).length,
                          itemBuilder: (context, index) {
                            Note currentNote = notesProvider.getFilteredNotes(searchQuery)[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => AddNewNotePage(
                                              isUpdate: true,
                                              note: currentNote,
                                            )));
                              },
                              onLongPress: () {
                                notesProvider.deleteNote(currentNote);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentNote.title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      currentNote.content!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 108, 104, 104)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 6,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }): const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text("No notes yet",textAlign: TextAlign.center,),
                          ),
                    ])
                  : const Center(
                      child: Text("No notes yet"),
                    ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddNewNotePage(
                        isUpdate: false,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
