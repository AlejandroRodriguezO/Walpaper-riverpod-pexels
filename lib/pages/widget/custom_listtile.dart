import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.onClick,
  });

  final String title;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onClick,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
