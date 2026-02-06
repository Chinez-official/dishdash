import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/providers/notifier_providers.dart';
import 'package:dishdash/app/core/services/storage/database.dart';
import 'package:dishdash/app/features/settings/components/confirmation_bottom_sheet.dart';
import 'components/empty_notes_state.dart';
import 'components/note_card.dart';
import 'components/note_options_sheet.dart';
import 'components/note_form_sheet.dart';

@RoutePage()
class NotesScreen extends HookConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesNotifierProvider);

    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: AppColors.backgroundBody,
        appBar: AppBar(
          title: Text(
            'Recipe Notes',
            style: textStylew600.copyWith(
              fontSize: 20,
              color: AppColors.textMain,
            ),
          ),
          backgroundColor: AppColors.backgroundBody,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddNoteSheet(context, ref),
          backgroundColor: AppColors.primary100,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SafeArea(
          child:
              notes.isEmpty
                  ? const EmptyNotesState()
                  : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notes.length,
                    itemBuilder:
                        (context, index) => NoteCard(
                          note: notes[index],
                          onOptionsTap:
                              () => _showNoteOptionsSheet(
                                context,
                                ref,
                                notes[index],
                              ),
                        ),
                  ),
        ),
      ),
    );
  }

  void _showAddNoteSheet(BuildContext context, WidgetRef ref) {
    NoteFormSheet.show(
      context: context,
      onSave: ({
        required String title,
        required String content,
        int? rating,
      }) async {
        await ref
            .read(notesNotifierProvider.notifier)
            .addNote(title: title, content: content, rating: rating);
      },
    );
  }

  void _showNoteOptionsSheet(
    BuildContext context,
    WidgetRef ref,
    RecipeNote note,
  ) {
    NoteOptionsSheet.show(
      context: context,
      onEdit: () => _showEditNoteSheet(context, ref, note),
      onDelete: () => _showDeleteConfirmation(context, ref, note.id),
    );
  }

  void _showEditNoteSheet(
    BuildContext context,
    WidgetRef ref,
    RecipeNote note,
  ) {
    NoteFormSheet.show(
      context: context,
      note: note,
      onSave: ({
        required String title,
        required String content,
        int? rating,
      }) async {
        // This won't be called for edit, but required by the interface
      },
      onUpdate: ({
        required int id,
        required String title,
        required String content,
        String? mealId,
        String? mealName,
        String? mealThumb,
        int? rating,
      }) async {
        await ref
            .read(notesNotifierProvider.notifier)
            .updateNote(
              id: id,
              title: title,
              content: content,
              mealId: mealId,
              mealName: mealName,
              mealThumb: mealThumb,
              rating: rating,
            );
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    int noteId,
  ) {
    ConfirmationBottomSheet.show(
      context: context,
      icon: Icons.delete_outline,
      iconBackgroundColor: AppColors.warningLight,
      iconColor: AppColors.warning,
      title: 'Delete Note',
      message:
          'Are you sure you want to delete this note? This action cannot be undone.',
      confirmText: 'Delete',
      confirmButtonColor: AppColors.warning,
      onConfirm: () async {
        await ref.read(notesNotifierProvider.notifier).deleteNote(noteId);
      },
    );
  }
}
