import 'dart:async';
import '../visit_repository.dart';

abstract class VisitRepository {
  Future<void> addNewVisit(Visit visit);

  Future<void> deleteVisit(Visit visit);

  Future<List<Visit>> visit();

  Future<void> updateVisit(Visit visit);
}
