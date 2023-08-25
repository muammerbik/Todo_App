import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/providers/all_providers.dart';

class TextfielddWidgets extends ConsumerWidget {
  TextfielddWidgets({super.key});
  final TextEditingController _controller =  TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
        controller: _controller,
        autofocus: true,
        onSubmitted: (value) {
          ref.read(todoListProvider.notifier).addTodo(value);
        },
        decoration: const InputDecoration(
          labelText: 'Bugün ne yapacaksın ? ',
        ),
        style: const TextStyle(fontSize: 20));
  }
}
