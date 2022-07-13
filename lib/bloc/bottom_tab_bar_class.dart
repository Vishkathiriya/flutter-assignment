import 'package:rxdart/rxdart.dart';

class UpdateValueBloc {
  final flagController = PublishSubject<bool>();
  final indexController = PublishSubject<int>();
// use for update value of paerticuler widget
  Stream<bool> get flagControllerStrme => flagController.stream;
  // use for update index value of Qutions List
  Stream<int> get indexControllerStrme => indexController.stream;

  void flagSink(bool value) {
    flagController.sink.add(value);
  }

  void indexSink(int index) {
    indexController.sink.add(index);
  }

  void dipose() {
    flagController.close();
  }
}

final updateValueBloc = UpdateValueBloc();
