import 'package:products_app/ui/widgets/dialogs/category_form_dialog_widget.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app.locator.dart';
import '../core/enums/dialog_type.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.categoryForm: (context, request, completer) =>
        CategoryFormDialogWidget(
          request: request,
          completer: completer,
        ),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
