enum ResponseStatus {
  initial,
  loading,
  success,
  noInternetC,
  failure,
}

extension ResponseStatusUnion on ResponseStatus {
  T map<T>({
    required T Function() initialState,
    required T Function() loadingState,
    required T Function() failedState,
    required T Function() noInternetState,
    required T Function() successState,
  }) {
    if (this == ResponseStatus.initial) {
      return initialState();
    }
    if (this == ResponseStatus.loading) {
      return loadingState();
    }
    if (this == ResponseStatus.failure) {
      return failedState();
    }
    if (this == ResponseStatus.noInternetC) {
      return noInternetState();
    }
    if (this == ResponseStatus.success) {
      return successState();
    }
    throw AssertionError('Union does not match any possible values');
  }
}



// enum ResponseStatus {
//   initial(InitialState()),
//   loading(LoadingState()),
//   success(SuccessState()),
//   loosInternetC(LoosInternetState()),
//   failure(FailedState());

//   const ResponseStatus(this.responseDataStatus);
//   final ResponseDataStatus responseDataStatus;
// }

// abstract class ResponseDataStatus {}

// class InitialState implements ResponseDataStatus {
//   const InitialState();
// }

// class LoadingState implements ResponseDataStatus {
//   const LoadingState();
// }

// class SuccessState implements ResponseDataStatus {
//   const SuccessState();
// }

// class LoosInternetState implements ResponseDataStatus {
//   const LoosInternetState();
// }

// class FailedState implements ResponseDataStatus {
//   const FailedState();
// }

// extension ResponseStatusUnion on ResponseStatus {
//   T map<T>({
//     required T Function(InitialState?) initialState,
//     required T Function(LoadingState?) loadingState,
//     required T Function(FailedState?) failedState,
//     required T Function(LoosInternetState?) loosInternetState,
//     required T Function(SuccessState?) successState,
//   }) {
//     if (this == ResponseStatus.initial) {
//       return initialState(
//           ResponseStatus.initial.responseDataStatus as InitialState);
//     }
//     if (this == ResponseStatus.loading) {
//       return loadingState(
//           ResponseStatus.loading.responseDataStatus as LoadingState);
//     }
//     if (this == ResponseStatus.failure) {
//       return failedState(
//           ResponseStatus.failure.responseDataStatus as FailedState);
//     }
//     if (this == ResponseStatus.loosInternetC) {
//       return loosInternetState(
//           ResponseStatus.loosInternetC.responseDataStatus as LoosInternetState);
//     }
//     if (this == ResponseStatus.success) {
//       return successState(
//           ResponseStatus.success.responseDataStatus as SuccessState);
//     }
//     throw AssertionError('Union does not match any possible values');
//   }
// }
