import 'package:flutter/material.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final _controller = TextEditingController();
  final List<_Entry> _entries = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addEntry() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _entries.insert(0, _Entry(text: text, createdAt: DateTime.now()));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24), // breathe above bottom bar
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: 3,
                      minLines: 1,
                      decoration: const InputDecoration(
                        hintText: "Write today’s note…",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _addEntry,
                    icon: const Icon(Icons.save_alt),
                    label: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _entries.isEmpty
                ? const Center(
                    child: Text("No diary entries yet.\nWrite something above!",
                        textAlign: TextAlign.center))
                : ListView.separated(
                    itemCount: _entries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final e = _entries[i];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        child: ListTile(
                          title: Text(e.text),
                          subtitle: Text(
                            _formatDateTime(e.createdAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          leading: const Icon(Icons.book_rounded),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    // simple local format: YYYY-MM-DD HH:MM
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return "$y-$m-$d  $hh:$mm";
  }
}

class _Entry {
  final String text;
  final DateTime createdAt;
  _Entry({required this.text, required this.createdAt});
}
