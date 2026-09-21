import StructuralBertrand.ZeroForce
import StructuralBertrand.Rings
import Mathlib.Data.Nat.Prime.Basic

/-!
# Advertised statements

This is the small, trusted surface a mathematical reader should audit. It contains three
declarations, in decreasing order of what motivated this development and increasing order
of fame:

1. `Submission.prime_iff_uncovered_by_prev` — the original question this project set out to
   answer. Not "does a prime exist in `(P_k, 2·P_k]`?" (Bertrand's question) but "is every
   composite in that window already covered by a prime strictly below `P_k` (or by `2`)? —
   i.e. does the window need any prime factor from *outside* itself?" The answer is an exact
   equivalence, not an existence bound: `n` is prime iff `n` is *not* covered by the base of
   primes below `P_k`. This is proved directly from divisibility (`ZeroForce.lean`'s Zero
   Effective Force lemma plus the least-prime-factor bound), with no appeal to counting or to
   the central binomial coefficient.
2. `Submission.void_iff_prime_in_deterministic_zone` — the same equivalence, generalized from
   the window `(P_k, 2·P_k]` to the full deterministic reach of the base, the zone
   `(P_k, P_k²)`. `Rings.lean`'s `determinism_breaks_above` shows this reach is exact: the
   equivalence genuinely fails once `n ≥ P_k²`.
3. `Submission.bertrand_chebyshev` — Bertrand's postulate in its Chebyshev-strengthened form
   (for every integer `N > 1` there is a prime strictly greater than `N` and at most `2 * N`).
   This is a **corollary** of (1): given the equivalence, existence of a prime in the window
   follows once the window is shown not to be *entirely* covered, which is where the
   quantitative closure (the central binomial coefficient, the same object Erdős used for his
   own, differently-motivated proof of the same postulate) enters. Bertrand asked "is there a
   prime here?"; this project asked "where does deterministic certainty about primality end?"
   — different questions, proved by different means, that happen to agree on this object.

All three are discharged in `Solution.lean` by invoking the fully independent structural
development in this repository's `StructuralBertrand/` directory. That development does
**not** import `Mathlib.NumberTheory.Bertrand`; the quantitative core for (3) is an original
structural sieve described in the accompanying paper (`LaTex/A Structural Sieve for Bertrands
Postulate.pdf`).
-/

/-- **Original question: is every composite in the window covered by the preceding base?**
For a prime `P_k` and `n ∈ (P_k, 2·P_k]`, `n` is prime iff `n` is not covered by the base of
primes below `P_k` (`n.minFac ≤ P_k`). Proved by exact divisibility, not by counting. -/
theorem Submission.prime_iff_uncovered_by_prev
    {P_k : ℕ} (hP : Nat.Prime P_k) {n : ℕ}
    (hn_lo : P_k < n) (hn_hi : n ≤ 2 * P_k) (hn2 : 2 ≤ n) :
    n.Prime ↔ ¬ StructuralBertrand.SieveCovered P_k n := by
  sorry

/-- **Generalization: the same equivalence holds throughout the deterministic zone
`(P_k, P_k²)`**, not only in the window `(P_k, 2·P_k]`. `n` is a void with respect to the
primes below `P_k` iff `n` is prime. This reach is exact (see `Rings.lean`'s
`determinism_breaks_above`: the equivalence fails once `n ≥ P_k²`). -/
theorem Submission.void_iff_prime_in_deterministic_zone
    {Pk n : ℕ} (hPk3 : 2 < Pk) (hlo : Pk < n) (hhi : n < Pk ^ 2) :
    StructuralBertrand.isVoid ((Finset.range Pk).filter Nat.Prime) n ↔ Nat.Prime n := by
  sorry

/-- **Bertrand–Chebyshev bound** (corollary of the equivalence above). For every `N > 1`
there is a prime `p` with `N < p ≤ 2 * N`. -/
theorem Submission.bertrand_chebyshev (N : ℕ) (hN : 1 < N) :
    ∃ p : ℕ, N < p ∧ p ≤ 2 * N ∧ p.Prime := by
  sorry
