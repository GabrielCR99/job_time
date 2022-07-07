import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingButton<B extends StateStreamable<S>, S> extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final BlocWidgetSelector<S, bool> selector;
  final B bloc;

  const LoadingButton({
    required this.onPressed,
    required this.label,
    required this.selector,
    required this.bloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, bool>(
      bloc: bloc,
      selector: selector,
      builder: (_, showLoading) => ElevatedButton(
        onPressed: showLoading
            ? null
            : () {
                FocusScope.of(context).unfocus();
                onPressed();
              },
        style: !showLoading
            ? ElevatedButton.styleFrom()
            : ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                onSurface: Colors.blue,
              ),
        child: Visibility(
          visible: showLoading,
          replacement: Text(label),
          child: const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
