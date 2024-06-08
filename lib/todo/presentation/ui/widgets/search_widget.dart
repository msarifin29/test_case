// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.controller,
    this.onSubmitted,
    this.onPressed,
  });
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(5),
          suffix: controller!.text.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: onPressed,
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.cancel_outlined),
                ),
        ),
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}
