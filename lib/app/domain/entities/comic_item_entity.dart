import 'package:equatable/equatable.dart';

class ComicItemEntity extends Equatable {
  final String? resourceURI;
  final String? name;

  const ComicItemEntity({this.resourceURI, this.name});

  @override
  List<Object?> get props => [resourceURI, name];
}
