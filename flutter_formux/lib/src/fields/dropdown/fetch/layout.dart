part of 'formux_dropdown_field_builder.dart';

class _Layout extends StatefulWidget {
  const _Layout({
    this.label,
    this.fetcher,
    required this.items,
    required this.input,
    required this.onChange,
  });

  final ValuableListFetchCallback? fetcher;
  final OnValuableEventChange onChange;
  final ValuableList items;
  final FormuxInput input;
  final String? label;

  @override
  State<_Layout> createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    if (widget.fetcher != null) {
      context.read<DropdownCubit>().load(widget.fetcher);
    }
  }

  @override
  void didUpdateWidget(covariant _Layout oldWidget) {
    super.didUpdateWidget(oldWidget);
    context.read<DropdownCubit>().load(widget.fetcher);

    // if (widget.input.valueFromItems == null) {
    // setState(() => controller = TextEditingController());
    // }
  }

  /// On change selection
  void onChange(Valuable? value) {
    if (value != null) {
      widget.onChange(ValuableInputEvent.setValue(value));
    }
  }

  @override
  Widget build(BuildContext context) => DropdownBuilder(
    builder:
        (context, state, bloc) => Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: LayoutBuilder(
            builder:
                (context, constrained) => PipenRow(
                  vertical: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownMenu<Valuable>(
                        enableFilter: true,
                        controller: controller,
                        enableSearch: true,
                        onSelected: onChange,
                        requestFocusOnTap: true,
                        width: constrained.maxWidth,
                        // initialSelection: widget.input.valueFromItems,
                        label: widget.label != null ? Text(widget.label!) : null,
                        errorText: widget.input.display ? widget.input.error : null,
                        trailingIcon: switch (state) {
                          FetchPending() => null,
                          FetchSuccess() => null,
                          FetchLoading() => FieldLoader(),
                          _ => SizedBox.shrink(),
                        },
                        dropdownMenuEntries: [
                          ...widget.items.map<DropdownMenuEntry<Valuable>>(
                            (value) =>
                                DropdownMenuEntry<Valuable>(value: value, label: value.title),
                          ),
                        ],
                      ),
                    ),
                    PipenSliceFromUp(
                      show: state is FetchFail,
                      axis: Axis.horizontal,
                      child: IconButton(
                        onPressed: bloc.refresh,
                        icon: Icon(Icons.refresh, color: context.themeColors.primary),
                      ),
                    ),
                  ],
                ),
          ),
        ),
  );
}
