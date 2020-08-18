import 'package:specifications/src/specification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  group('AppController Test', () {
    test("is satisfied", () {
      var container = Containers(1, "Container yyy", 3);
      var load = Loads(1, "test", 6);

      expect(
        ContainerCanTakeColdLoadSpec(container).isSatisfiedBy(load),
        true,
      );
    });

    test("is not satisfied", () {
      var container = Containers(1, "Container yyy", 6);
      var load = Loads(1, "test", 3);

      expect(
        (ContainerCanTakeColdLoadSpec(container) &
                ContainerCanCarryLoadCapacityGreaterThan5Spec(container))
            .isSatisfiedBy(load),
        false,
      );
    });

    test("is not satisfied", () {
      var container = Containers(1, "Container yyy", 6);
      var carga = Loads(1, "test", 3);
      expect(
        ContainerCanTakeColdLoadSpec(container)
            .and(ContainerCanCarryLoadCapacityGreaterThan5Spec(container))
            .isSatisfiedBy(carga),
        false,
      );
    });

    test("is not satisfied", () {
      var container = Containers(1, "Container yyy", 6);
      var load = Loads(1, "test", 3);

      expect(
        ContainerCanTakeColdLoadSpec(container)
            .and(ContainerCanCarryLoadCapacityGreaterThan5Spec(container))
            .isSatisfiedBy(load),
        false,
      );
    });
  });
}

class ContainerCanTakeColdLoadSpec extends CompositeSpecification<Loads> {
  Containers container;

  ContainerCanTakeColdLoadSpec(Containers container) {
    this.container = container;
  }

  @override
  bool isSatisfiedBy(Loads load) {
    return container.minConservationTemperature <= load.conservationTemperature;
  }
}

class ContainerCanCarryLoadCapacityGreaterThan5Spec
    extends CompositeSpecification<Loads> {
  Containers container;

  ContainerCanCarryLoadCapacityGreaterThan5Spec(Containers container) {
    this.container = container;
  }

  @override
  bool isSatisfiedBy(Loads carga) {
    return container.minConservationTemperature > 5;
  }
}

class Loads {
  final int id;
  final String name;
  final int conservationTemperature;

  Loads(this.id, this.name, this.conservationTemperature);
}

class Containers {
  final int id;
  final String name;
  final int minConservationTemperature;

  Containers(this.id, this.name, this.minConservationTemperature);
}
