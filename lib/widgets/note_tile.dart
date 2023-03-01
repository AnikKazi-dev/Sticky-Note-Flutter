import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sticky_notes/model/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final int index;

  const NoteTile(this.note, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title.toString(),
              maxLines: 2,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text(
              note.description,
              maxLines: 5,
              style: TextStyle(fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
