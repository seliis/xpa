import "package:flutter/material.dart";

class CommonAsyncError extends StatelessWidget {
  const CommonAsyncError({
    super.key,
    required this.error,
    required this.stackTrace,
  });

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            error.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            stackTrace.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
