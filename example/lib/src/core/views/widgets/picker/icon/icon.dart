import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/picker/icon/icon_provider.dart';
import 'package:example/src/core/views/widgets/picker/icon/icon_tile.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/toastification.dart';

class IconPicker extends ConsumerStatefulWidget {
  const IconPicker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IconPickerState();
}

class _IconPickerState extends ConsumerState<IconPicker> {
  final GlobalKey _menuKey = GlobalKey();

  void openPopup() {
    dynamic state = _menuKey.currentState;
    state.showButtonMenu();
  }

  @override
  Widget build(BuildContext context) {
    final type = ref.watch(
      toastDetailControllerProvider.select((value) => value.type),
    );
    final style = ref.watch(
      toastDetailControllerProvider.select((value) => value.style),
    );

    final iconColor = ref.watch(toastDetailControllerProvider).primaryColor;
    final icon = ref.watch(toastDetailControllerProvider).icon;

    late final defaultStyle;

    switch (style) {
      case ToastificationStyle.minimal:
        defaultStyle = MinimalStyle(type);
        break;
      case ToastificationStyle.fillColored:
        defaultStyle = FilledStyle(type);
        break;
      case ToastificationStyle.flatColored:
        defaultStyle = FlatColoredStyle(type);
        break;
      case ToastificationStyle.flat:
        defaultStyle = FlatStyle(type);
        break;
      case ToastificationStyle.simple:
        defaultStyle = SimpleStyle(type);
        break;
      default:
        throw ArgumentError('Unknown ToastificationStyle: $style');
    }

    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
      ),
      child: PopupMenuButton(
        key: _menuKey,
        tooltip: "",
        clipBehavior: Clip.hardEdge,
        position: PopupMenuPosition.under,
        elevation: 0,
        padding: EdgeInsets.zero,
        enabled: true,
        color: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1.5,
          ),
        ),
        child: BorderedContainer(
          width: 120,
          height: 48,
          onTap: openPopup,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon?.iconData ?? Iconsax.tick_circle_copy,
                color: iconColor ?? defaultStyle.iconColor(context),
              ),
              const SizedBox(width: 8),
              const Text('Icon'),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),
            ],
          ),
        ),
        onCanceled: () => ref.read(searchedIconQuery.notifier).state = "",
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: null,
            enabled: false,
            padding: EdgeInsets.zero,
            child: Center(
              child: IconPickerWidget(
                iconColor: iconColor ?? defaultStyle.iconColor(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class IconPickerWidget extends ConsumerWidget {
  const IconPickerWidget({super.key, required this.iconColor});

  final Color iconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(filteredListProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: SizedBox(
        width: 300,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Search",
              ),
              onChanged: (value) =>
                  ref.read(searchedIconQuery.notifier).state = value,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: false,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 50,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];

                  return IconTile(
                    item: item,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
