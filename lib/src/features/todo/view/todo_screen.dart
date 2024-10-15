import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/features/auth/service/auth_repository.dart';
import 'package:todo_app/src/features/auth/view/login_screen.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //rgb(64, 80, 175)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _dialogBuilder(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Things to do',
          style: TextStyle(fontSize: 17.sp),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // context.read<AuthBloc>().add(LogoutRequested());
              BlocProvider.of<AuthBloc>(context).add(LogoutRequested());
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
        bottom: TabBar(
          dividerColor: Colors.black,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.blue,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Text('Incomplete'),
            ),
            Tab(
              icon: Text('Complete'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.sp,
          ),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: 'Search',
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Column(
                children: [
                  ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text('Incomplete Item $index'),
                          value: null,
                          groupValue: null,
                          onChanged: (Null? value) {},
                        );
                      })
                ],
              ),
              Column(
                children: [
                  ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text('Incomplete Item $index'),
                          value: null,
                          groupValue: null,
                          onChanged: (Null? value) {},
                        );
                      })
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add new To Do',
            style: TextStyle(color: Colors.black),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                SizedBox(
                  height: 25.sp,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
