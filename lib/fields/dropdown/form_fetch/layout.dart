part of 'formux_dropdown_field_form_fetch.dart';

class PipenDropdownFormLayout extends StatefulWidget {
  const PipenDropdownFormLayout({
    super.key,
    this.label,
    required this.input,
    required this.onChange,
  });

  final Function(Valuable?)? onChange;
  final FormuxValuableType input;
  final String? label;

  @override
  State<PipenDropdownFormLayout> createState() => _PipenDropdownFormLayoutState();
}

class _PipenDropdownFormLayoutState extends State<PipenDropdownFormLayout> {
  Valuable? value;

  @override
  void initState() {
    super.initState();
    if (widget.input.fetch != null) {
      context.read<DropdownFetchCubit>().load(widget.input.fetch);
    } else {
      context.read<DropdownFetchCubit>().empty();
    }
  }

  @override
  void didUpdateWidget(covariant PipenDropdownFormLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    context.read<DropdownFetchCubit>().load(widget.input.fetch);
  }

  @override
  Widget build(BuildContext context) => BlocBuilderFetch<DropdownFetchCubit, DropdownState>(
        builder: (context, state, bloc) => PipenRow(
          vertical: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constrained) => DropdownMenu<Valuable>(
                  onSelected: widget.onChange,
                  width: constrained.maxWidth,
                  initialSelection: bloc.value,
                  label: widget.label != null ? Text(widget.label!) : null,
                  errorText: widget.input.display ? widget.input.error : null,
                  dropdownMenuEntries: bloc.items
                      .map<DropdownMenuEntry<Valuable>>(
                        (Valuable value) => DropdownMenuEntry<Valuable>(
                          value: value,
                          label: value.title,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            When<LoadingState>(
              value: state,
              child: (_) => const Padding(
                padding: EdgeInsets.only(left: 20),
                child: SizedBox.square(
                  dimension: 25,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      );
}
