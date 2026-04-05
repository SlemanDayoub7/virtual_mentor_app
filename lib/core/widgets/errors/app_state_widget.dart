import 'package:flutter/material.dart';
import '../errors/app_error_widget.dart';
import '../loading/app_loading.dart';
import '../empty/app_empty_widget.dart';

enum AppWidgetState { loading, error, empty, success }

class AppStateWidget<T> extends StatelessWidget {
  final AppWidgetState state;
  final T? data;
  final String? errorMessage;
  final Widget Function() onLoading;
  final Widget Function(String? message) onError;
  final Widget Function() onEmpty;
  final Widget Function(T data) onSuccess;

  const AppStateWidget({
    super.key,
    required this.state,
    required this.onSuccess,
    this.data,
    this.errorMessage,
    Widget Function()? onLoading,
    Widget Function(String? message)? onError,
    Widget Function()? onEmpty,
  })  : onLoading = onLoading ?? _defaultLoading,
        onError = onError ?? _defaultError,
        onEmpty = onEmpty ?? _defaultEmpty;

  static Widget _defaultLoading() => const AppShimmerList();
  static Widget _defaultError(String? msg) =>
      AppErrorWidget(message: msg);
  static Widget _defaultEmpty() => const AppEmptyWidget();

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case AppWidgetState.loading:
        return onLoading();
      case AppWidgetState.error:
        return onError(errorMessage);
      case AppWidgetState.empty:
        return onEmpty();
      case AppWidgetState.success:
        if (data == null) return onEmpty();
        return onSuccess(data as T);
    }
  }
}
