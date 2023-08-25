import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
   ToolBarWidget({super.key});
  var _currentFilter = TodoListFilter.ALL;

  Color changeTextColor(TodoListFilter filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedCount = ref.watch(onCompletedTodoCount);

    
    _currentFilter= ref.watch(todoListFilter);

    debugPrint('toolbar widegt tetiklendi');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          onCompletedCount == 0
              ? 'Tüm görevler OK'
              : "$onCompletedCount görev tamamlanmadı ",
          overflow: TextOverflow.ellipsis,
        )),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: changeTextColor(TodoListFilter.ALL)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.ALL;
              },
              child: const Text(
                'All',
              )),
        ),
        Tooltip(
          message: 'Only uncompleted Todos',
          child: TextButton(style: TextButton.styleFrom(
                  foregroundColor: changeTextColor(TodoListFilter.Active)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.Active;
              },
              child: const Text('Active')),
        ),
        Tooltip(
          message: 'only completed Todos',
          child: TextButton(style: TextButton.styleFrom(
                  foregroundColor: changeTextColor(TodoListFilter.Completed)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.Completed;
              },
              child: const Text('Completed')),
        ),
      ],
    );
  }
}
