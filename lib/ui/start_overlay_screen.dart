import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_counter_app/ui/player_widget.dart';

bool _isNameValid(String name) {
  if (name.isEmpty) {
    return false;
  }

  return RegExp(r'[A-Z]{3,}\s[A-Z]{3,}').stringMatch(name.trim()) == name;
}

class StartOverlayScreen extends StatefulWidget {
  final void Function({required String user1, required String user2}) onStarted;
  const StartOverlayScreen({Key? key, required this.onStarted}) : super(key: key);

  @override
  State<StartOverlayScreen> createState() => _StartOverlayScreenState();
}

class _StartOverlayScreenState extends State<StartOverlayScreen> {
  final TextEditingController controllerPlayer1 = TextEditingController();
  final TextEditingController controllerPlayer2 = TextEditingController();
  final FocusNode focusNodePlayer1 = FocusNode();
  final FocusNode focusNodePlayer2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 20),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        PlayerInfoItem(
                          title: 'Player 1',
                          value: '',
                          customValueChild: _TextFieldItem(
                            node: focusNodePlayer1,
                            nextNode: focusNodePlayer2,
                            controller: controllerPlayer1,
                            onChanged: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        PlayerInfoItem(
                          title: 'Player 2',
                          value: '',
                          customValueChild: _TextFieldItem(
                            node: focusNodePlayer2,
                            controller: controllerPlayer2,
                            onChanged: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed:
                        _isNameValid(controllerPlayer1.text) && _isNameValid(controllerPlayer2.text)
                            ? () => widget.onStarted(
                                  user1: controllerPlayer1.text,
                                  user2: controllerPlayer2.text,
                                )
                            : null,
                    child: const Text('Start'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode? nextNode;
  final Function() onChanged;

  const _TextFieldItem({
    Key? key,
    required this.controller,
    required this.node,
    required this.onChanged,
    this.nextNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
          child: TextField(
            onSubmitted: (_) {
              nextNode?.requestFocus();
            },
            controller: controller,
            inputFormatters: [
              TextInputFormatter.withFunction(
                (oldValue, newValue) => newValue.copyWith(
                  text: newValue.text.toUpperCase(),
                ),
              )
            ],
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: node.hasFocus || controller.text.isEmpty
                  ? null
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: !_isNameValid(controller.text)
                            ? Theme.of(context).colorScheme.error
                            : Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: 'Name Surname',
              hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  ),
            ),
            onChanged: (_) => onChanged(),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
