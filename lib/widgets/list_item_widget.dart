import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/providers/all_providers.dart';

class ListItemWidget extends ConsumerStatefulWidget {
  const ListItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends ConsumerState<ListItemWidget> {
  late TextEditingController _textEditingController;
  late FocusNode _textFocusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final currentTodo = ref.watch(currentTodoProvider);
    return Focus(
      onFocusChange: (isFocus) {
        if (!isFocus) {
          setState(() {
            _hasFocus = false;
          });
          ref.read(todoListProvider.notifier).edit(
              id: currentTodo.id, newdescription: _textEditingController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
          });
          _textFocusNode.requestFocus();
          _textEditingController.text =currentTodo.description;
        },
        leading: Checkbox(
            value: currentTodo.completed,
            onChanged: (newvalue) {
              ref.read(todoListProvider.notifier).toggle(currentTodo.id);
            }),
        title: _hasFocus
            ? TextField(
                controller: _textEditingController,
                focusNode: _textFocusNode,
              )
            : Text(currentTodo.description),
      ),
    );
  }
}
