import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> people = [];
  bool isLoading = true;
  String? errorMessage;
  @override
  void initState() {
    super.initState();
    fetchPersons();
  }


Future<void> fetchPersons() async {
  setState(() {
    isLoading = true;
    errorMessage = null;
  });

  try {
    final response = await http
        .get(
          Uri.parse('http://localhost:8081/api/persons'),
        )
        .timeout(const Duration(seconds: 3));

    if (response.statusCode != 200) {
      throw Exception('API returned an error');
    }

    final data = jsonDecode(response.body);

    if (!mounted) return;

    setState(() {
      people = data;
      isLoading = false;
    });
  } catch (e) {
      await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    setState(() {
      isLoading = false;
      errorMessage = 'Could not connect to the API.';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Customers',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        ),
        body: Center(
          child:Container(
          child: isLoading
              ? const CircularProgressIndicator()
              : errorMessage != null
                  ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: fetchPersons,
                          child: Text('Try Again'),
                        ),
                      ],
                    ),
                  )
                  : ListView(
                      children: people.map((person) {
                        return Card(
                          color: Colors.green.shade100,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          child: ExpansionTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(
                              person['name'],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text('Age: ${person['age']}'),
                            children:
                                (person['bills'] as Map<String, dynamic>)
                                    .entries
                                    .map((bill) {
                              return ListTile(
                                title: Text(bill.key),
                                trailing: Text('€${bill.value}'),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    ),
          ),
        ),
      ),
    );
  }
}