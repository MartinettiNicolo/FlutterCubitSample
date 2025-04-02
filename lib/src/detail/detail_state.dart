import 'package:equatable/equatable.dart';

class DetailState extends Equatable {
  final int counterValue;
  final bool isOverview;

  const DetailState({
    required this.counterValue,
    required this.isOverview
  });

  @override
  List<Object?> get props => [counterValue, isOverview];
}