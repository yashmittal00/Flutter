abstract class ResponseState {}

class ResponseInitialState extends ResponseState {
  ResponseInitialState();
}

class LoadingState extends ResponseState {}

class FetchDataState extends ResponseState {}
