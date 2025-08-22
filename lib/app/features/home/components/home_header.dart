import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avatar_plus/avatar_plus.dart';
import 'package:dishdash/app/core/models/user/user.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/providers/use_case_providers.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUseCase = ref.read(authUseCaseProvider);

    return FutureBuilder<User?>(
      future: authUseCase.getCurrentUser(),
      builder: (context, snapshot) {
        String firstName = 'User';
        String avatarSeed = 'DefaultUser';

        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;
          firstName =
              user.firstName.isNotEmpty
                  ? user.firstName
                  : user.fullName.split(' ').first;

          avatarSeed = user.fullName.isNotEmpty ? user.fullName : user.email;
        }

        String displayName =
            firstName.length > 8
                ? '${firstName.substring(0, 8)}...'
                : firstName;

        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 4,
          ), // Back to original - no left/right padding

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello $displayName',
                      style: textStylew600.copyWith(
                        fontSize: 20,
                        color: AppColors.textMain,
                      ),
                    ),
                    const YMargin(4),
                    Text(
                      'What are you cooking today?',
                      style: textStylew400.copyWith(
                        fontSize: 11,
                        color: AppColors.grey3,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.secondary40,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    child: AvatarPlus(
                      avatarSeed,
                      height: 40,
                      width: 40,
                      trBackground: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
