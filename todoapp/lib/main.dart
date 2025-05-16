import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App List',
      theme: ThemeData(primaryColor: Colors.blueAccent, fontFamily: 'Poppins'),
      home: const ToDoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _toDoItems = [];
  final TextEditingController _controller = TextEditingController();

  void _addToDo() {
    final text = _controller.text.trim();

    if (text.isNotEmpty) {
      setState(() {
        _toDoItems.add(text);
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete To Do'),
          content: const Text('Are you sure you want to delete this To Do?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _toDoItems.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showAddToDoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add To Do'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _addToDo(),
            decoration: const InputDecoration(hintText: 'Enter To Do'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addToDo();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                _controller.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: _toDoItems.isEmpty ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 60, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text('No To Do Items', style: TextStyle(fontSize: 16)),
          ],
        ),
       )
       : ListView.builder(
          itemCount: _toDoItems.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index){
            return ToDoCard(
              title: _toDoItems[index],
              onDelete: () => _confirmDelete(index),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddToDoDialog,
        tooltip: 'Add To Do',
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

class ToDoCard extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;

  const ToDoCard({super.key, required this.title, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}


