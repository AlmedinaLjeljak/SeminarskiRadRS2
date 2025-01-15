import 'package:xfit_mobile/models/grad.dart';
import 'package:xfit_mobile/providers/base_provider.dart';

class GradProvider<T> extends BaseProvider<Grad>{
  GradProvider():super("Grad");

  @override
  Grad fromJson(data){
    return Grad.fromJson(data);
  }
}