import 'specification_interface.dart';

abstract class CompositeSpecification<T> implements ISpecification<T> {
  bool isSatisfiedBy(T candidate);
  ISpecification<T> and(ISpecification<T> other) =>
      AndSpecification<T>(this, other);
  ISpecification<T> andNot(ISpecification<T> other) =>
      AndNotSpecification<T>(this, other);
  ISpecification<T> or(ISpecification<T> other) =>
      OrSpecification<T>(this, other);
  ISpecification<T> orNot(ISpecification<T> other) =>
      OrNotSpecification<T>(this, other);
  ISpecification<T> not() => new NotSpecification<T>(this);

  operator &(o) => AndSpecification<T>(this, o);

  operator |(o) => OrSpecification<T>(this, o);

  operator [](T o) => isSatisfiedBy(o);
}

class AndSpecification<T> extends CompositeSpecification<T> {
  ISpecification<T> left;
  ISpecification<T> right;

  AndSpecification(ISpecification<T> left, ISpecification<T> right) {
    this.left = left;
    this.right = right;
  }
  @override
  bool isSatisfiedBy(T candidate) =>
      left.isSatisfiedBy(candidate) && right.isSatisfiedBy(candidate);
}

class AndNotSpecification<T> extends CompositeSpecification<T> {
  ISpecification<T> left;
  ISpecification<T> right;

  AndNotSpecification(ISpecification<T> left, ISpecification<T> right) {
    this.left = left;
    this.right = right;
  }
  @override
  bool isSatisfiedBy(T candidate) =>
      left.isSatisfiedBy(candidate) && !right.isSatisfiedBy(candidate);
}

class OrSpecification<T> extends CompositeSpecification<T> {
  ISpecification<T> left;
  ISpecification<T> right;

  OrSpecification(ISpecification<T> left, ISpecification<T> right) {
    this.left = left;
    this.right = right;
  }
  @override
  bool isSatisfiedBy(T candidate) =>
      left.isSatisfiedBy(candidate) || right.isSatisfiedBy(candidate);
}

class OrNotSpecification<T> extends CompositeSpecification<T> {
  ISpecification<T> left;
  ISpecification<T> right;

  OrNotSpecification(ISpecification<T> left, ISpecification<T> right) {
    this.left = left;
    this.right = right;
  }
  @override
  bool isSatisfiedBy(T candidate) =>
      left.isSatisfiedBy(candidate) || !right.isSatisfiedBy(candidate);
}

class NotSpecification<T> extends CompositeSpecification<T> {
  ISpecification<T> other;
  NotSpecification(ISpecification<T> other) {
    this.other = other;
  }
  @override
  bool isSatisfiedBy(T candidate) => !other.isSatisfiedBy(candidate);
}
