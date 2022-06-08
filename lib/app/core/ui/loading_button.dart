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
    return ElevatedButton(
      onPressed: onPressed,
      child: BlocSelector<B, S, bool>(
        bloc: bloc,
        selector: selector,
        builder: (_, showLoading) => !showLoading
            ? Text(label)
            : Stack(
                alignment: Alignment.center,
                children: [
                  Text(label),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
