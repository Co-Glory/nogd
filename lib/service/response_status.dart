import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_status.freezed.dart';


@freezed
class ResponseStatus with _$ResponseStatus {
  const factory ResponseStatus.initial() = Initial;
  const factory ResponseStatus.noInternetC() = NoInternetC;

  const factory ResponseStatus.loading() = Loading;

  const factory ResponseStatus.success() = Success;

  const factory ResponseStatus.error([String? message]) = ErrorDetails;
}
