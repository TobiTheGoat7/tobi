import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectInterestLocalSourceProvider = Provider<SelectInterestLocalSource>(
    (ref) => SelectInterestLocalSourceI(ref));

abstract class SelectInterestLocalSource {}

class SelectInterestLocalSourceI implements SelectInterestLocalSource {
  SelectInterestLocalSourceI(Ref ref);
}
