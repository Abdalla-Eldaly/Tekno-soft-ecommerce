import 'package:ecommerce_c8_online/domain/model/PaginationDto.dart';

/// currentPage : 1
/// numberOfPages : 1
/// limit : 40

class PaginationEntity {
  PaginationEntity({
      this.currentPage, 
      this.numberOfPages, 
      this.limit,});

  PaginationEntity.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
  }
  int? currentPage;
  int? numberOfPages;
  int? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['numberOfPages'] = numberOfPages;
    map['limit'] = limit;
    return map;
  }
  PaginationDto toPaginationDto(){
    return PaginationDto(
      currentPage: currentPage,
      numberOfPages: numberOfPages,
      limit: limit
    );
  }
}