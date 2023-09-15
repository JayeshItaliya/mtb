import 'package:flutter/material.dart';

class ListSection extends StatelessWidget {
  final Widget? title;

  const ListSection({
    Key? key,
     this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                child: title!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
