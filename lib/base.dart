import 'package:flutter/material.dart';

abstract class BaseConnector {
  void showLoading(String message);

  void showMessage(String message);

  void hideDialog();
}

class BaseViewModel<CON extends BaseConnector> extends ChangeNotifier {
  CON? connector;
}

abstract class BaseView<VM extends BaseViewModel, T extends StatefulWidget>
    extends State<T> implements BaseConnector {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
  }

  @override
  void showLoading(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: Row(
          children: [
            Text(message),
            const CircularProgressIndicator(),
          ],
        )),
      ),
    );
  }

  @override
  void showMessage(String message) {
    hideDialog();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
      ),
    );
  }
}
