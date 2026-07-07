import '../../domain/entities/placement_question_entity.dart';
import 'question_model.dart';

class PlacementQuestionModel extends PlacementQuestionEntity {
  const PlacementQuestionModel({required super.order, required super.question});

  factory PlacementQuestionModel.fromJson(Map<String, dynamic> json) =>
      PlacementQuestionModel(
        order: json['order'] as int,
        question: QuestionModel.fromJson(
          json['question'] as Map<String, dynamic>,
        ),
      );
}
