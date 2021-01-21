What is the meaning of the `<'a>` segment in the following struct declaration?

```rust
struct Nominee<'a> {
	person: &'a Person,
	award: AwardKind,
	contribution: String,
	short_bio: String,
}
```

- It means that the `Nominee` struct will live no longer than the `Person` value it borrows from.
  - Correct. The `Nominee` struct can't live longer than the `Person` value it borrows.
- It means that the `Nominee` struct will live no longer than the `AwardKind` value it borrows from.
  - Incorrect. The field `award` owns the `AwardKind` value, so no borrow occurs.
- It means that the `Nominee` struct will live no longer than the `String` value it holds.
  - Incorrect. The field `contribution` owns the `String` value, so no borrow occurs.
- It means that the `Nominee` struct can have an optional value in its `person` field.
  - Incorrect. The `person` field requires a reference to a `Person` value and it is not optional.


What type of aliasing is permitted in Rust?
- One mutable reference and multiple immutable references.
  - Incorrect. The compiler won't allow any mutable reference to exist while immutable references are present.
- One mutable reference or multiple immutable references.
  - Correct. Rust forbids the combination of aliasing and mutation on the same location.
- Many mutable references and no immutable references.
  - Incorrect. The compiler won't allow many mutable references to the same value, even if there is no immutable references.
- Many mutable and immutable references.
  - Incorrect. The compiler won't allow many mutable references to the same value, let alone combining mutable with immutable references.
