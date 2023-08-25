import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/model/to_do_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    var eklenecekTodo = TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, eklenecekTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              completed: !todo.completed,
              description: todo.description)
        else
          todo
    ];
  }

  void edit({required String id, required String newdescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              completed: todo.completed,
              description: newdescription)
              else todo,
    ];
  }

  void remove(TodoModel silinecekDeger) {
    state = state.where((element) => element.id != silinecekDeger.id).toList();
  }
}
