///! https://www.sandromaglione.com/techblog

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  group("option", () {
    test("should return 0 on null case", () {
      /// [Option]
      const int? a = null;
      final Option<int> b = none();

      /// You must manually handle missing values
      int resultI = 0;
      if (a != null) {
        resultI = a * 2;
      }

      final matcher = 0;

      /// No need to check for `null`
      final resultF = b.getOrElse(() => matcher) * 2;
      expect(resultF, matcher);
    });

    test("use 4 on null case", () {
      final Option<int> b = Option.of(4);
      final matcher = 4;

      /// No need to check for `null`
      final resultF = b.getOrElse(() => matcher);
      expect(resultF, matcher);
    });

    ///------
    /// Don't do that! ⚠
    double divideI(int x, int y) {
      if (y == 0) {
        throw Exception('Cannot divide by 0!');
      }
      return x / y;
    }

    /// Error handling using [Option] 🎉
    Option<double> divideF(int x, int y) {
      if (y == 0) {
        return none();
      }
      return some(x / y);
    }

    test("division by should return none", () {
      final result = divideF(3, 0);
      expect(result, none());
    });
    test("division by non-zero should return value", () {
      final result = divideF(3, 2);
      expect(result, some(1.5));
    });
  });

  group("Either", () {
    test("should return 0 on null case", () {
      /// [Either]
      const int? a = null;
      final Either<String, int> b = left("error");

      /// You must manually handle missing values

      final matcher = 0;

      /// No need to check for `null`
      // final resultF = b.fold((l) => l, (r) => r * 2);
      expect(b.isLeft(), true);
    });

    test("use 4 on null case", () {
      final Either<String, int> b = right(4);
      final matcher = 4;

      /// No need to check for `null`
      final resultF = b.fold((l) => matcher, (r) => r);
      expect(resultF, matcher);
    });

    ///------
    /// Don't do that! ⚠
    double divideI(int x, int y) {
      if (y == 0) {
        throw Exception('Cannot divide by 0!');
      }
      return x / y;
    }

    /// Error handling using [Either] 🎉
    Either<String, double> divideF(int x, int y) {
      if (y == 0) {
        return left("Cannot divide by 0!");
      }
      return right(x / y);
    }

    test("division by should return left", () {
      final result = divideF(3, 0);
      expect(result, left("Cannot divide by 0!"));
    });
    test("division by non-zero should return value", () {
      final result = divideF(3, 2);
      expect(result, right(1.5));
    });
  });

  group("Task", () {
    /// You must run one [Future] after the other, no way around this...
    Future<int> asyncI() {
      return Future.value(10).then((value) => value * 10);
    }

    /// No need of `async`, you decide when to run the [Future] ⚡
    Task<int> asyncF() {
      return Task(() async => 10).map((a) => a * 10);
    }

    test("should return 100", () async {
      final result = asyncI();
      expect(result, completion(100));
      expect(await result, 100);
    });

    test("Task> should return 100", () async {
      final result = asyncF();
      expect(result.run(), completion(100));
      expect(await result.run(), 100);
    });
  });

  group("TaskEither", () {
    /// What error is that? What is [dynamic]?
    Future<int> asyncI() {
      return Future<int>.error('Some error!')
          .then((value) => value * 10)
          .catchError((dynamic error) => print(error));
    }

    /// Handle all the errors easily ✨
    TaskEither<String, int> asyncF() {
      return TaskEither<String, int>(
        () async => left('Some error'),
      ).map((r) => r * 10);
    }

    test("should return left", () {
      expect(asyncF().run(), completion(left('Some error')));
    });
  });
}
