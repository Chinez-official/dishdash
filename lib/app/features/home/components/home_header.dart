import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;
          firstName =
              user.firstName.isNotEmpty
                  ? user.firstName
                  : user.fullName.split(' ').first;
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Greeting and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello $firstName',
                      style: textStylew600.copyWith(
                        fontSize: 24,
                        color: AppColors.textMain,
                      ),
                    ),
                    const YMargin(4),
                    Text(
                      'What are you cooking today?',
                      style: textStylew400.copyWith(
                        fontSize: 16,
                        color: AppColors.textLabel,
                      ),
                    ),
                  ],
                ),
              ),

              // Right side - User avatar
              GestureDetector(
                onTap: () {
                  // TODO: Implement avatar tap functionality
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.secondary40,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(Images.avatar, fit: BoxFit.cover),
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
