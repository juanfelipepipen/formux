import 'package:flutter_formux/flutter_formux.dart';
import 'package:formux/formux.dart';
import 'package:latlong2/latlong.dart';

class FormuxLatLngInput extends FormuxInput<LatLng?> with FormuxTranslations {
  FormuxLatLngInput() : super(value: null);

  @override
  void validator() {
    assertion(value == null, translations.locationRequired);
  }

  @override
  void clear() {
    value = null;
    errors = false;
  }
}
