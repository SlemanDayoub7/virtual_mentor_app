// Example usage in a widget

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/category_progress_entity.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/category_progress/category_progress_bloc.dart';

class CategoryProgressScreen extends StatefulWidget {
  final int categoryId;

  const CategoryProgressScreen({required this.categoryId, super.key});

  @override
  State<CategoryProgressScreen> createState() => _CategoryProgressScreenState();
}

class _CategoryProgressScreenState extends State<CategoryProgressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProgressBloc>().add(
      GetCategoryProgress(widget.categoryId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Category Progress')),
      body: BlocBuilder<CategoryProgressBloc, CategoryProgressState>(
        builder: (context, state) {
          if (state is CategoryProgressLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryProgressLoaded) {
            return _buildProgressContent(state.progress);
          } else if (state is CategoryProgressFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProgressContent(CategoryProgressEntity progress) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Specialization Info
          Text(
            progress.specialization.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(progress.specialization.description),
          const SizedBox(height: 16),

          // Summary Cards
          Row(
            children: [
              _buildSummaryCard(
                'Progress',
                '${progress.summary.overallProgress}%',
              ),
              _buildSummaryCard('XP', '${progress.summary.totalXp}'),
            ],
          ),
          const SizedBox(height: 16),

          // Subjects List
          const Text(
            'Subjects',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...progress.subjects.map((subject) => _buildSubjectCard(subject)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(label, style: const TextStyle(color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(SubjectProgressEntity subject) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(subject.name),
        subtitle: Text(subject.description),
        trailing: Text('${subject.stats.progressPercentage}%'),
        isThreeLine: true,
      ),
    );
  }
}
