import 'package:flutter/material.dart';
import '../../models/job.dart';
import '../../services/database_service.dart';

class DetailPage extends StatelessWidget {
  final Job job;

  DetailPage({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              DatabaseService.instance.addBookmark(job);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Job bookmarked')),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('${job.company} - ${job.location}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(job.description),
          ],
        ),
      ),
    );
  }
}
