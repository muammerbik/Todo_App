import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/providers/all_providers.dart';
import 'package:to_do_app/widgets/list_item_widget.dart';
import 'package:to_do_app/widgets/text_field.dart';
import 'package:to_do_app/widgets/title_widget.dart';
import 'package:to_do_app/widgets/toolbar_widget.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filterListProvider);
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          children: [
            const TitleWidget(),
            TextfielddWidgets(),
            const SizedBox(
              height: 10,
            ),
            ToolBarWidget(),
           
            allTodos.isEmpty
                ? Center(
                    child: Container(height: 150,alignment: Alignment.bottomCenter,
                      child: const Text(
                        'Herhangi bir görev yok !',
                        style: TextStyle(color: Colors.purple,fontSize: 20),
                      ),
                    ),
                  )
                : const SizedBox(),
            for (var i = 0; i < allTodos.length; i++)
              Dismissible(
                  key: ValueKey(allTodos[i].id),
                  onDismissed: (direction) {
                    ref.read(todoListProvider.notifier).remove(allTodos[i]);
                  },
                  child: ProviderScope(
                    overrides: [
                      currentTodoProvider.overrideWithValue(allTodos[i]),
                    ],
                    child: const ListItemWidget(),
                  )),
          ]),
    );
  }
}
