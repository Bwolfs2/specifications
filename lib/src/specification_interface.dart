abstract class ISpecification<T> {
  bool isSatisfiedBy(T candidate);
  ISpecification<T> and(ISpecification<T> other);
  ISpecification<T> andNot(ISpecification<T> other);
  ISpecification<T> or(ISpecification<T> other);
  ISpecification<T> orNot(ISpecification<T> other);
  ISpecification<T> not();

  operator [](T o) => isSatisfiedBy(o);
}
