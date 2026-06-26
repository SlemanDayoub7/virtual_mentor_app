import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/router/app_router.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/password_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _codeCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _codeCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_newPasswordCtrl.text != _confirmPasswordCtrl.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }
    context.read<PasswordBloc>().add(
      ResetPasswordSubmitted(
        email: widget.email,
        code: _codeCtrl.text.trim(),
        newPassword: _newPasswordCtrl.text,
        confirmPassword: _confirmPasswordCtrl.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: BlocConsumer<PasswordBloc, PasswordState>(
        listener: (context, state) {
          if (state is PasswordSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            context.go(AppRoutes.login);
          } else if (state is PasswordFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is PasswordLoading;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                Text('Enter the code sent to ${widget.email}'),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _codeCtrl,
                  decoration: const InputDecoration(labelText: 'Reset code'),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _newPasswordCtrl,
                  decoration: const InputDecoration(labelText: 'New password'),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirmPasswordCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Confirm new password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: isLoading ? null : _submit,
                  child:
                      isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text('Reset password'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
