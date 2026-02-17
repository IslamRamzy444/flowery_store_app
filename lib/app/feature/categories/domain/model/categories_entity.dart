import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
  final List<CategoryEntity>? categoriesEntity;

  const CategoriesEntity({this.categoriesEntity});

  @override
  List<Object?> get props => [categoriesEntity];
}

class CategoryEntity extends Equatable {
  final String? id;
  final String? title;

  const CategoryEntity({this.id, this.title});

  @override
  List<Object?> get props => [id, title];
}
