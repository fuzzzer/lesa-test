part of 'book_cubit.dart';

class BookState {
  final StateStatus status;
  final BookData? bookData;
  final GetBookDataFailureType? failureType;

  const BookState({
    required this.status,
    this.bookData,
    this.failureType,
  });

  BookState copyWith({
    StateStatus? status,
    BookData? bookData,
    GetBookDataFailureType? failureType,
  }) {
    return BookState(
      status: status ?? this.status,
      bookData: bookData ?? this.bookData,
      failureType: failureType ?? this.failureType,
    );
  }

  @override
  String toString() => 'BookState(status: $status, bookData: $bookData, failureType: $failureType)';
}
