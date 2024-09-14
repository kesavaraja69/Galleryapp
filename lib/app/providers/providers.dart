import 'package:galleryapp/core/notifier/fetchimages.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => FetchimageNotifier()),
];
