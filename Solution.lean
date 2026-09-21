import StructuralBertrand.Main
import StructuralBertrand.Rings

/-!
# Proved solutions

This module imports the full structural proof development. Comparator checks that each
declaration below has exactly the same statement as its counterpart in `Challenge.lean` and
uses only the permitted axioms.

Each proof is a one-line restatement: the real work happens in `StructuralBertrand/`, which
is derived entirely from the structural sieve described in the accompanying paper without
depending on `Mathlib.NumberTheory.Bertrand`. That development contains zero `sorry`s and
(per `#print axioms`) depends only on `propext`, `Classical.choice`, and `Quot.sound` — no
`native_decide`/`Lean.ofReduceBool`.
-/

theorem Submission.prime_iff_uncovered_by_prev
    {P_k : ℕ} (hP : Nat.Prime P_k) {n : ℕ}
    (hn_lo : P_k < n) (hn_hi : n ≤ 2 * P_k) (hn2 : 2 ≤ n) :
    n.Prime ↔ ¬ StructuralBertrand.SieveCovered P_k n :=
  StructuralBertrand.prime_iff_uncovered_by_prev hP hn_lo hn_hi hn2

theorem Submission.void_iff_prime_in_deterministic_zone
    {Pk n : ℕ} (hPk3 : 2 < Pk) (hlo : Pk < n) (hhi : n < Pk ^ 2) :
    StructuralBertrand.isVoid ((Finset.range Pk).filter Nat.Prime) n ↔ Nat.Prime n :=
  StructuralBertrand.void_iff_prime_in_deterministic_zone hPk3 hlo hhi

theorem Submission.bertrand_chebyshev (N : ℕ) (hN : 1 < N) :
    ∃ p : ℕ, N < p ∧ p ≤ 2 * N ∧ p.Prime :=
  StructuralBertrand.bertrand_chebyshev N hN
