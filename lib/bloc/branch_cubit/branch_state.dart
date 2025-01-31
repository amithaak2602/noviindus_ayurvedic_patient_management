part of 'branch_cubit.dart';

@immutable
abstract class BranchState {}

class BranchInitial extends BranchState {
  @override
  List<Object> get props => [];
}

class BranchLoaded extends BranchState {
  final List<Branch> branchList;
  BranchLoaded(this.branchList);
  List<Object>? get props => branchList;
}

class BranchLoadFailed extends BranchState {
  List<Object>? get props => [];
}
