import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/services/storage/database.dart';

/// Bottom sheet form for adding or editing a note.
class NoteFormSheet extends StatefulWidget {
  final RecipeNote? note;
  final Future<void> Function({
    required String title,
    required String content,
    int? rating,
  })
  onSave;
  final Future<void> Function({
    required int id,
    required String title,
    required String content,
    String? mealId,
    String? mealName,
    String? mealThumb,
    int? rating,
  })?
  onUpdate;

  const NoteFormSheet({
    super.key,
    this.note,
    required this.onSave,
    this.onUpdate,
  });

  static void show({
    required BuildContext context,
    RecipeNote? note,
    required Future<void> Function({
      required String title,
      required String content,
      int? rating,
    })
    onSave,
    Future<void> Function({
      required int id,
      required String title,
      required String content,
      String? mealId,
      String? mealName,
      String? mealThumb,
      int? rating,
    })?
    onUpdate,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) =>
              NoteFormSheet(note: note, onSave: onSave, onUpdate: onUpdate),
    );
  }

  @override
  State<NoteFormSheet> createState() => _NoteFormSheetState();
}

class _NoteFormSheetState extends State<NoteFormSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  int? _selectedRating;

  bool get _isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
    _selectedRating = widget.note?.rating;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.backgroundBody,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey4,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const YMargin(24),
            Text(
              _isEditing ? 'Edit Note' : 'Add Note',
              style: textStylew600.copyWith(
                fontSize: 20,
                color: AppColors.textMain,
              ),
            ),
            const YMargin(20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: textStylew400.copyWith(color: AppColors.grey2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary100),
                ),
              ),
            ),
            const YMargin(16),
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Your experience...',
                alignLabelWithHint: true,
                labelStyle: textStylew400.copyWith(color: AppColors.grey2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary100),
                ),
              ),
            ),
            const YMargin(16),
            Text(
              'Rating (optional)',
              style: textStylew500.copyWith(
                fontSize: 14,
                color: AppColors.textLabel,
              ),
            ),
            const YMargin(8),
            Row(
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap:
                      () => setState(() {
                        _selectedRating =
                            _selectedRating == index + 1 ? null : index + 1;
                      }),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      _selectedRating != null && index < _selectedRating!
                          ? Icons.star
                          : Icons.star_border,
                      size: 32,
                      color: AppColors.rating,
                    ),
                  ),
                ),
              ),
            ),
            const YMargin(24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.primary100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: textStylew600.copyWith(
                        fontSize: 14,
                        color: AppColors.primary100,
                      ),
                    ),
                  ),
                ),
                const XMargin(16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary100,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _isEditing ? 'Update' : 'Save',
                      style: textStylew600.copyWith(
                        fontSize: 14,
                        color: AppColors.backgroundBody,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const YMargin(16),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      return;
    }

    Navigator.pop(context);

    if (_isEditing && widget.onUpdate != null) {
      await widget.onUpdate!(
        id: widget.note!.id,
        title: _titleController.text,
        content: _contentController.text,
        mealId: widget.note!.mealId,
        mealName: widget.note!.mealName,
        mealThumb: widget.note!.mealThumb,
        rating: _selectedRating,
      );
    } else {
      await widget.onSave(
        title: _titleController.text,
        content: _contentController.text,
        rating: _selectedRating,
      );
    }
  }
}
