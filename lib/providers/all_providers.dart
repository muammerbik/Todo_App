import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/model/to_do_model.dart';
import 'package:to_do_app/providers/todo_list_manager.dart';

enum TodoListFilter {
  ALL,
  Active,
  Completed;
}

final todoListFilter = StateProvider<TodoListFilter>(
  (ref) => TodoListFilter.ALL,
);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>(
  (ref) => TodoListManager([
 
  ]),
);

final filterListProvider = Provider(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final todoList = ref.watch(todoListProvider);

    switch (filter) {
      case TodoListFilter.ALL:
        return todoList;
      case TodoListFilter.Completed:
        return todoList.where((element) => element.completed).toList();
      case TodoListFilter.Active:
        return todoList.where((element) => !element.completed).toList();
    }
  },
);

final onCompletedTodoCount = Provider<int>(
  (ref) {
    final allTodo = ref.watch(todoListProvider);
    final count = allTodo.where((element) => !element.completed).length;
    return count;
  },
);

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
