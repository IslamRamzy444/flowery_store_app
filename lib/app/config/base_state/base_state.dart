import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool? isLoading;
  final T? success;
  final Exception? error;

  const BaseState({this.isLoading, this.success, this.error,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, success, error];

  BaseState<T> copyWith({
    bool? isLoading,
    T? success,
    Exception? error,
    bool clearSuccess = false,
    bool clearError = false,
  }) {
    return BaseState(
      isLoading: isLoading ?? this.isLoading,
      success: clearSuccess ? null : (success ?? this.success),
      error: clearError ? null : (error ?? this.error),
    );
  }

}