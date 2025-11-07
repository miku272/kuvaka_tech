import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kuvaka_tech/core/model/transaction.dart';
import 'package:kuvaka_tech/features/transaction/data/datasource/transaction_local_datasource.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for Hive Box
class MockTransactionBox extends Mock implements Box<Transaction> {}

// Mock class for Transaction
class MockTransaction extends Mock implements Transaction {}

void main() {
  late MockTransactionBox mockBox;
  late TransactionLocalDatasourceImpl datasource;

  setUp(() {
    mockBox = MockTransactionBox();
    datasource = TransactionLocalDatasourceImpl(transactionBox: mockBox);
  });

  group('getAllTransactions', () {
    test('should return list of transactions from box', () {
      // Arrange
      final transaction1 = Transaction(
        id: '1',
        category: 'Food',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Lunch',
      );
      final transaction2 = Transaction(
        id: '2',
        category: 'Salary',
        amount: 50000.0,
        type: TransactionType.income,
        date: DateTime(2025, 11, 5),
        note: 'Monthly salary',
      );
      final transactions = [transaction1, transaction2];

      when(() => mockBox.values).thenReturn(transactions);

      // Act
      final result = datasource.getAllTransactions();

      // Assert
      expect(result, equals(transactions));
      expect(result.length, 2);
      verify(() => mockBox.values).called(1);
    });

    test('should return empty list when box is empty', () {
      // Arrange
      when(() => mockBox.values).thenReturn([]);

      // Act
      final result = datasource.getAllTransactions();

      // Assert
      expect(result, isEmpty);
      verify(() => mockBox.values).called(1);
    });

    test('should rethrow exception when getting transactions fails', () {
      // Arrange
      when(() => mockBox.values).thenThrow(Exception('Box error'));

      // Act & Assert
      expect(() => datasource.getAllTransactions(), throwsA(isA<Exception>()));
    });
  });

  group('addTransaction', () {
    test('should add transaction and return it', () async {
      // Arrange
      final transaction = Transaction(
        id: '1',
        category: 'Food',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Lunch',
      );
      const key = 0;

      when(() => mockBox.add(transaction)).thenAnswer((_) async => key);
      when(() => mockBox.get(key)).thenReturn(transaction);

      // Act
      final result = await datasource.addTransaction(transaction);

      // Assert
      expect(result, equals(transaction));
      verify(() => mockBox.add(transaction)).called(1);
      verify(() => mockBox.get(key)).called(1);
    });

    test(
      'should throw exception when added transaction is not found',
      () async {
        // Arrange
        final transaction = Transaction(
          id: '1',
          category: 'Food',
          amount: 100.0,
          type: TransactionType.expense,
          date: DateTime(2025, 11, 1),
          note: 'Lunch',
        );
        const key = 0;

        when(() => mockBox.add(transaction)).thenAnswer((_) async => key);
        when(() => mockBox.get(key)).thenReturn(null);

        // Act & Assert
        expect(
          () => datasource.addTransaction(transaction),
          throwsA(isA<Exception>()),
        );
      },
    );

    test('should rethrow exception when adding transaction fails', () async {
      // Arrange
      final transaction = Transaction(
        id: '1',
        category: 'Food',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Lunch',
      );

      when(() => mockBox.add(transaction)).thenThrow(Exception('Add failed'));

      // Act & Assert
      expect(
        () => datasource.addTransaction(transaction),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('editTransaction', () {
    test('should edit transaction and return updated transaction', () {
      // Arrange
      final transaction = Transaction(
        id: '1',
        category: 'Food',
        amount: 150.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Updated lunch',
      );
      const key = 0;
      final existingTransaction = Transaction(
        id: '1',
        category: 'Food',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Lunch',
      );

      var callCount = 0;
      when(() => mockBox.keys).thenReturn([key]);
      when(() => mockBox.get(key)).thenAnswer((_) {
        callCount++;
        return callCount == 1 ? existingTransaction : transaction;
      });
      when(() => mockBox.put(key, transaction)).thenAnswer((_) async => {});

      // Act
      final result = datasource.editTransaction(transaction);

      // Assert
      expect(result, equals(transaction));
      verify(() => mockBox.keys).called(1);
      verify(() => mockBox.put(key, transaction)).called(1);
    });

    test('should throw exception when updated transaction is not found', () {
      // Arrange
      final transaction = Transaction(
        id: '1',
        category: 'Food',
        amount: 150.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Updated lunch',
      );
      const key = 0;
      final existingTransaction = Transaction(
        id: '1',
        category: 'Food',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Lunch',
      );

      var callCount = 0;
      when(() => mockBox.keys).thenReturn([key]);
      when(() => mockBox.get(key)).thenAnswer((_) {
        callCount++;
        return callCount == 1 ? existingTransaction : null;
      });
      when(() => mockBox.put(key, transaction)).thenAnswer((_) async => {});

      // Act & Assert
      expect(() => datasource.editTransaction(transaction), throwsException);
    });

    test('should rethrow exception when transaction key is not found', () {
      // Arrange
      final transaction = Transaction(
        id: '1',
        category: 'Food',
        amount: 150.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Updated lunch',
      );

      when(() => mockBox.keys).thenReturn([]);

      // Act & Assert
      expect(() => datasource.editTransaction(transaction), throwsStateError);
    });

    test('should rethrow exception when editing transaction fails', () {
      // Arrange
      final transaction = Transaction(
        id: '1',
        category: 'Food',
        amount: 150.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Updated lunch',
      );

      when(() => mockBox.keys).thenThrow(Exception('Edit failed'));

      // Act & Assert
      expect(() => datasource.editTransaction(transaction), throwsException);
    });
  });

  group('deleteTransaction', () {
    test('should delete transaction with matching id', () async {
      // Arrange
      const transactionId = '1';
      const key = 0;
      final transaction = Transaction(
        id: transactionId,
        category: 'Food',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Lunch',
      );

      when(() => mockBox.keys).thenReturn([key]);
      when(() => mockBox.get(key)).thenReturn(transaction);
      when(() => mockBox.delete(key)).thenAnswer((_) async => {});

      // Act
      await datasource.deleteTransaction(transactionId);

      // Assert
      verify(() => mockBox.keys).called(1);
      verify(() => mockBox.delete(key)).called(1);
    });

    test(
      'should rethrow exception when transaction key is not found',
      () async {
        // Arrange
        const transactionId = 'non-existent-id';

        when(() => mockBox.keys).thenReturn([]);

        // Act & Assert
        expect(
          () => datasource.deleteTransaction(transactionId),
          throwsA(isA<StateError>()),
        );
      },
    );

    test('should rethrow exception when deleting transaction fails', () async {
      // Arrange
      const transactionId = '1';
      const key = 0;
      final transaction = Transaction(
        id: transactionId,
        category: 'Food',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2025, 11, 1),
        note: 'Lunch',
      );

      when(() => mockBox.keys).thenReturn([key]);
      when(() => mockBox.get(key)).thenReturn(transaction);
      when(() => mockBox.delete(key)).thenThrow(Exception('Delete failed'));

      // Act & Assert
      expect(
        () => datasource.deleteTransaction(transactionId),
        throwsA(isA<Exception>()),
      );
    });
  });
}
