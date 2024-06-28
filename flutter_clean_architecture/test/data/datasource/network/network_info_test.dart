import 'package:flutter_clean_architecture/data/datasources/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
void main() {
  late MockInternetConnectionChecker internetConnectionChecker;
  late NetworkInfo networkInfo;

  setUp(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(internetConnectionChecker);
  });

  group("Testes para isConnected", () {
    test("Deve retornar true se tiver conexão com a internet", () async {
      //Act
      when(internetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      //Arrange
      final result = await networkInfo.isConnected;

      //Assert
      expect(result, true);
    });
    test("Deve retornar false se não tiver conexão com a internet", () async {
      //Act
      when(internetConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);

      //Arrange
      final result = await networkInfo.isConnected;

      //Assert
      expect(result, false);
    });
  });
}
