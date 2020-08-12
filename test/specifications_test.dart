import 'package:specifications/src/specification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  group('AppController Test', () {
    test("is satisfied", () {
      var container = Containers(1, "Container yyy", 6);
      var carga = Cargas(1, "teste", 3);

      expect(
        ContainerPodeLevarCargaResfriadaSpec(container).isSatisfiedBy(carga),
        true,
      );
    });

    test("is not satisfied", () {
      var container = Containers(1, "Container yyy", 6);
      var carga = Cargas(1, "teste", 3);

      expect(
        (ContainerPodeLevarCargaResfriadaSpec(container) &
                ContainerPodeLevarCargaCapacidadeMaiorQue5Spec(container))
            .isSatisfiedBy(carga),
        false,
      );
    });

    test("is not satisfied", () {
      var container = Containers(1, "Container yyy", 6);
      var carga = Cargas(1, "teste", 3);
      expect(
        ContainerPodeLevarCargaResfriadaSpec(container)
            .and(ContainerPodeLevarCargaCapacidadeMaiorQue5Spec(container))
            .isSatisfiedBy(carga),
        false,
      );
    });

    test("is not satisfied", () {
      var container = Containers(1, "Container yyy", 6);
      var carga = Cargas(1, "teste", 3);

      expect(
        ContainerPodeLevarCargaResfriadaSpec(container)
            .and(ContainerPodeLevarCargaCapacidadeMaiorQue5Spec(container))
            .isSatisfiedBy(carga),
        false,
      );
    });
  });
}

class ContainerPodeLevarCargaResfriadaSpec
    extends CompositeSpecification<Cargas> {
  Containers container;

  ContainerPodeLevarCargaResfriadaSpec(Containers container) {
    this.container = container;
  }

  @override
  bool isSatisfiedBy(Cargas carga) {
    return container.capacidadeTemperaturaMinima <=
        carga.temperaturaDeConservacao;
  }
}

class ContainerPodeLevarCargaCapacidadeMaiorQue5Spec
    extends CompositeSpecification<Cargas> {
  Containers container;

  ContainerPodeLevarCargaCapacidadeMaiorQue5Spec(Containers container) {
    this.container = container;
  }

  @override
  bool isSatisfiedBy(Cargas carga) {
    return container.capacidadeTemperaturaMinima > 5;
  }
}

class Cargas {
  final int id;
  final String name;
  final int temperaturaDeConservacao;

  Cargas(this.id, this.name, this.temperaturaDeConservacao);
}

class Containers {
  final int id;
  final String name;
  final int capacidadeTemperaturaMinima;

  Containers(this.id, this.name, this.capacidadeTemperaturaMinima);
}
