# Specifications

 Na programação de computadores, o padrão de Specifications é um padrão de design de software específico, por meio do qual as regras de negócios podem ser recombinadas encadeando as regras de negócios usando a lógica booleana.
 O padrão é freqüentemente usado no contexto de design orientado a domínio. (DDD)

## Getting Started

import 'package:specifications/src/specification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  group('AppController Test', () {
    test("is satisfied", () {
      expect(
          ContainerPodeLevarCargaResfriadaSpec(
                  Containers(1, "Container yyy", 3))
              .isSatisfiedBy(Cargas(1, "teste", 6)),
          true);
    });

    test("is not satisfied", () {
      expect(
          (ContainerPodeLevarCargaResfriadaSpec(
                      Containers(1, "Container yyy", 6)) &
                  ContainerPodeLevarCargaCapacidadeMaiorQue5Spec(
                      Containers(1, "casa", 6)))
              .isSatisfiedBy(Cargas(1, "teste", 3)),
          false);
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

Link de Apoio: https://martinfowler.com/apsupp/spec.pdf