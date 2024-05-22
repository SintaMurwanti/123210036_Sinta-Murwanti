import 'package:flutter/material.dart';
import '../models/job.dart';
import '../services/database_service.dart';
import 'detail_page.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Job> _bookmarkedJobs = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    List<Job> jobs = await DatabaseService.instance.getBookmarkedJobs();
    setState(() {
      _bookmarkedJobs = jobs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Jobs'),
      ),
      body: ListView.builder(
        itemCount: _bookmarkedJobs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_bookmarkedJobs[index].title),
            subtitle: Text('${_bookmarkedJobs[index].company} - ${_bookmarkedJobs[index].location}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(job: _bookmarkedJobs[index])),
              );
            },
          );
        },
      ),
    );
  }
}
