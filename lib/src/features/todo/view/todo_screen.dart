import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/features/auth/service/auth_repository.dart';
import 'package:todo_app/src/features/auth/view/login_screen.dart';
import 'package:todo_app/src/features/todo/bloc/todo_bloc.dart';
import 'package:todo_app/src/features/todo/bloc/todo_event.dart';
import 'package:todo_app/src/features/todo/bloc/todo_state.dart';
import 'package:todo_app/src/features/todo/models/todo_model.dart';
import 'package:todo_app/src/features/todo/models/todo_request_model.dart';
import 'package:todo_app/src/features/todo/service/todo_repository.dart';

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
  GetStorage box = GetStorage();
  int? userId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    setState(() {
      userId = box.read('userId');
    });
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
    return BlocProvider(
      create: (BuildContext context) => ToDoBloc(
        ToDoRepository(),
      )..add(GetInComplateToDos(userId!)),
      child: Scaffold(
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
                BlocProvider.of<AuthBloc>(context).add(const LogoutRequested());
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.sp),
                  ),
                ),
                labelText: 'Search',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(controller: _tabController, children: [
                  buildToDoListInComplate(
                    isComplete: false,
                  ),
                  buildToDoListComplate(
                    isComplete: true,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  BlocBuilder<ToDoBloc, ToDoState> buildToDoListInComplate(
      {required bool isComplete}) {
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (context, state) {
        if (state is ToDoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ToDoSuccess) {
          final completeToDos = state.toDo
              .where((todo) => todo.isComplated == isComplete)
              .toList();
          if (completeToDos == null || completeToDos.isEmpty) {
            return const Center(child: Text('No incomplete todos available'));
          }
          return incomploteList(completeToDos);
        } else if (state is ToDoFailure) {
          return Center(child: Text('Failed to load data: ${state.error}'));
        }
        return const Center(child: Text('No data available'));
      },
    );
  }

  ListView incomploteList(List<ToDoData> completeToDos) {
    return ListView.builder(
      itemCount: completeToDos.length,
      itemBuilder: (context, index) {
        final todo = completeToDos[index];
        DateTime dateTime = DateTime.parse(todo.createdAt!);
        String formattedDate = DateFormat("dd-MM-yyyy HH:mm").format(dateTime);
        return toDoCard(todo, formattedDate, context);
      },
    );
  }

  Card toDoCard(ToDoData todo, String formattedDate, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(todo.title ?? 'No Title'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.description ?? 'No Description'),
            Text('${formattedDate}'),
          ],
        ),
        leading: Checkbox(
          onChanged: (value) {
            BlocProvider.of<ToDoBloc>(context).add(
              UpdateToDo(userId!, todo.id!, value!),
            );
          },
          value: todo.isComplated,
        ),
        trailing: IconButton(
          onPressed: () {
            BlocProvider.of<ToDoBloc>(context).add(
              DeleteToDo(
                userId!,
                todo.id!,
              ),
            );
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  BlocBuilder<ToDoBloc, ToDoState> buildToDoListComplate(
      {required bool isComplete}) {
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (context, state) {
        if (state is ToDoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ToDoSuccess) {
          final incompleteToDos = state.toDo
              .where((todo) => todo.isComplated == isComplete)
              .toList();
          if (incompleteToDos == null || incompleteToDos.isEmpty) {
            return const Center(child: Text('No incomplete todos available'));
          }
          return complateToDosList(incompleteToDos);
        } else if (state is ToDoFailure) {
          return Center(child: Text('Failed to load data: ${state.error}'));
        }
        return const Center(child: Text('No data available'));
      },
    );
  }

  ListView complateToDosList(List<ToDoData> incompleteToDos) {
    return ListView.builder(
      itemCount: incompleteToDos.length,
      itemBuilder: (context, index) {
        final todo = incompleteToDos[index];
        DateTime dateTime = DateTime.parse(todo.createdAt!);
        String formattedDate = DateFormat("dd-MM-yyyy HH:mm").format(dateTime);
        return Card(
          child: ListTile(
            title: Text(todo.title ?? 'No Title'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.description ?? 'No Description'),
                Text('${formattedDate}'),
              ],
            ),
            leading: Checkbox(
              onChanged: (value) {
                BlocProvider.of<ToDoBloc>(context).add(
                  UpdateToDo(userId!, todo.id!, value!),
                );
              },
              value: todo.isComplated,
            ),
            trailing: IconButton(
              onPressed: () {
                BlocProvider.of<ToDoBloc>(context).add(
                  DeleteToDo(
                    userId!,
                    todo.id!,
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
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
                  style: const TextStyle(color: Colors.black),
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                SizedBox(
                  height: 25.sp,
                ),
                TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: descriptionController,
                  decoration: const InputDecoration(
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
                ToDoModel newToDo = ToDoModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  userId: userId,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Yeni ToDo əlavə edildi!'),
                    duration: Duration(seconds: 2),
                  ),
                );
                context.read<ToDoBloc>().add(AddToDo(newToDo));

                // BlocProvider.of<ToDoBloc>(context).add(AddToDo(newToDo));
                titleController.clear();
                descriptionController.clear();
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
