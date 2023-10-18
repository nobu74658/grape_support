import 'package:flutter/material.dart';

enum WhenType {
  loading,
  loadingWidget,
  error,
  errorWidget,
}

class PrimaryWhenWidget extends StatelessWidget {
  const PrimaryWhenWidget({
    required this.whenType,
    this.errorMessage,
    super.key,
  });

  final WhenType whenType;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    switch (whenType) {
      case WhenType.loading:
        return Scaffold(body: _loading());
      case WhenType.loadingWidget:
        return _loading();
      case WhenType.error:
        return Scaffold(
          appBar: AppBar(
            title: const Text('エラーが発生'),
          ),
          body: _error(),
        );
      case WhenType.errorWidget:
        return _error();
    }
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _error() {
    const String normalErrorMessage = 'エラーが発生しました。'
        '\n'
        'ネットワーク環境をご確認の上、もう一度実行してみて下さい。';

    return Center(
      child: Text(
        errorMessage ?? normalErrorMessage,
        textAlign: TextAlign.center,
      ),
    );
  }
}
