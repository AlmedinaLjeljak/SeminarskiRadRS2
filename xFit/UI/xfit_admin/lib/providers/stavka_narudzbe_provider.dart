import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class StavkaNarudzbeProvider<T> extends BaseProvider<StavkaNarudzbe>{

  StavkaNarudzbeProvider():super("StavkaNarudzbe");

  @override
  StavkaNarudzbe fromJson(data){
    return StavkaNarudzbe.fromJson(data);
  }
}