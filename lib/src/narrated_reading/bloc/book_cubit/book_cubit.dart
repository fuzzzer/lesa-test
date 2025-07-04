import 'package:bloc/bloc.dart';
import 'package:lesa/src/src.dart';

export 'book_cubit.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit({required this.bookRepository})
      : super(
          const BookState(status: StateStatus.initial),
        );

  final BookRepository bookRepository;

  Future<void> getData({
    required String languageCode,
  }) async {
    emit(state.copyWith(status: StateStatus.loading));

    final getBookDataResponse = await bookRepository.getData(
      languageCode: languageCode,
    );

    final newState = switch (getBookDataResponse) {
      GetBookDataSuccess() => state.copyWith(
          status: StateStatus.success,
          bookData: getBookDataResponse.bookData,
        ),
      GetBookDataFailure() => state.copyWith(
          status: StateStatus.failed,
          failureType: getBookDataResponse.failureType,
        ),
    };

    emit(newState);
  }

  String? getAudioPathForPage(int pageIndex) {
    final data = state.bookData;
    if (data == null || pageIndex < 0 || pageIndex >= data.pages.length) return null;
    return data.pages[pageIndex].audioFilePath;
  }
}
