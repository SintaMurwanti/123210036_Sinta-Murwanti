import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> _jobs;

  @override
  void initState() {
    super.initState();
    _fetchJobs();
  }

  Future<void> _fetchJobs() async {
    final response = await http.get(Uri.parse('https://jobicy.com/api/v2/remote-jobs'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _jobs = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Jobs'),
      ),
      body: _jobs != null
          ? ListView.builder(
        itemCount: _jobs.length,
        itemBuilder: (context, jobTitle) {
          final job = _jobs[jobTitle];
          return ListTile(
            title: Text(job['title']),
            subtitle: Text('${job['companyName']} - ${job['companyLogo']}'),
            onTap: () {
              // Tambahkan logika untuk menampilkan detail pekerjaan
            },
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
