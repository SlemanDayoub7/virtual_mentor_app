import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_mentor_app/core/bloc/session_bloc/session_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/account_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(AccountFetchRequested());
  }

  void _logout() {
    context.read<SessionBloc>().add(SessionLoggedOut());
    // GoRouter redirect handles navigation back to login
  }

  void _confirmDelete(BuildContext context) {
    final passwordCtrl = TextEditingController();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Delete account'),
            content: TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(labelText: 'Current password'),
              obscureText: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  this.context.read<AccountBloc>().add(
                    AccountDeleteRequested(passwordCtrl.text),
                  );
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My account'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountDeleted) {
            context.read<SessionBloc>().add(SessionLoggedOut());
          } else if (state is AccountFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AccountUpdateSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Profile updated')));
          }
        },
        builder: (context, state) {
          if (state is AccountLoading || state is AccountInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AccountFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  TextButton(
                    onPressed:
                        () => context.read<AccountBloc>().add(
                          AccountFetchRequested(),
                        ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final user =
              state is AccountLoaded
                  ? state.user
                  : (state as AccountUpdateSuccess).user;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              ListTile(
                title: const Text('Name'),
                subtitle: Text('${user.firstName} ${user.lastName}'),
              ),
              ListTile(title: const Text('Email'), subtitle: Text(user.email)),
              if (user.profile != null) ...[
                ListTile(
                  title: const Text('Phone'),
                  subtitle: Text(user.profile!.phone ?? '—'),
                ),
                ListTile(
                  title: const Text('Address'),
                  subtitle: Text(user.profile!.address ?? '—'),
                ),
                ListTile(
                  title: const Text('Gender'),
                  subtitle: Text(user.profile!.gender ?? '—'),
                ),
              ],
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {
                  // TODO: push to an edit profile screen
                },
                child: const Text('Edit profile'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _confirmDelete(context),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete account'),
              ),
            ],
          );
        },
      ),
    );
  }
}
