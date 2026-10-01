import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Finset.Basic

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
   `(P_k, P_k²)` — this direction holds for every `P_k > 2`, prime or composite.
   `Rings.lean`'s `determinism_breaks_above` shows this reach is exact for a **prime**
   `P_k`: the equivalence genuinely fails once `n ≥ P_k²`. Tightness for a composite `P_k`
   is not established here.
3. `Submission.bertrand_chebyshev` — Bertrand's postulate in its Chebyshev-strengthened form
   (for every integer `N > 1` there is a prime strictly greater than `N` and at most `2 * N`).
   This is a **corollary** of (1): given the equivalence, existence of a prime in the window
   follows once the window is shown not to be *entirely* covered, which is where the
   quantitative closure (the central binomial coefficient, the same object Erdős used for his
   own, differently-motivated proof of the same postulate) enters. Bertrand asked "is there a
   prime here?"; this project asked "where does deterministic certainty about primality end?"
   — different questions, proved by different means, that happen to agree on this object.

**Relationship to trial division.** (1) and (2) restate, for `n` in their respective ranges,
the classical trial-division fact that a composite has a prime factor at most `√n` — the
bound `P_k`/`P_k²` here is exactly that `√n` bound, not a new one. What is not classical is
that the divisor set is fixed *before* `n` is chosen: only the frozen base `{primes < P_k}`
is ever consulted, as if no prime `≥ P_k` existed yet, instead of searching every prime up to
`√n` as `n` varies. "Covered" (not void) means *has a prime divisor in the base* — not that
`n` factors entirely into base elements (that stronger, separate claim is self-containment,
proved only on the narrower window `(P_k, 2·P_k]`; e.g. for `P_k = 10`, `n = 22 = 2 · 11` is
covered by `2` alone, though `11` sits outside the base). A single base divisor already
forces compositeness via the least-prime-factor bound. A void `n` has no base divisor at
all, which forces `n` itself to be the new prime the fixed base cannot see — not "a composite
the base failed to build". So (1)/(2) are trial division viewed from the base's side: how far
one fixed, finite set of primes can certify primality unaided.

All three are discharged in `Solution.lean` by invoking the fully independent structural
development in this repository's `StructuralBertrand/` directory. That development does
**not** import `Mathlib.NumberTheory.Bertrand`; the quantitative core for (3) is an original
structural sieve described in the accompanying paper (`LaTex/A Structural Sieve for Bertrands
Postulate.pdf`).

This file itself deliberately imports nothing from `StructuralBertrand/` — only Mathlib. A
canonical challenge file must be checkable in isolation, independent of the submitter's own
library, so (1) and (2) below state their project-specific predicates unfolded to what they
literally mean rather than by name: `StructuralBertrand.SieveCovered P n` is `n.minFac ≤ P`
(`Defs.lean`), and `StructuralBertrand.isVoid S n` is `∀ p ∈ S, ¬ p ∣ n` (`Rings.lean`, via
`aligned p n := p ∣ n`). The unfolded and named forms are definitionally equal, so a proof
term from the named version still checks against this unfolded statement — but Palomar's
comparator does a literal statement match rather than a `defeq` check, so `Solution.lean`
restates (1) and (2) here verbatim, unfolded, and only calls the named versions inside the
proof term.
-/

/-- **Original question: is every composite in the window covered by the preceding base?**
For a prime `P_k` and `n ∈ (P_k, 2·P_k]`, `n` is prime iff `n` is not covered by the base of
primes below `P_k` (`n.minFac ≤ P_k`). Proved by exact divisibility, not by counting. -/
theorem Submission.prime_iff_uncovered_by_prev
    {P_k : ℕ} (hP : Nat.Prime P_k) {n : ℕ}
    (hn_lo : P_k < n) (hn_hi : n ≤ 2 * P_k) (hn2 : 2 ≤ n) :
    n.Prime ↔ ¬ (n.minFac ≤ P_k) := by
  sorry

/-- **Generalization: the same equivalence holds throughout the deterministic zone
`(P_k, P_k²)`**, not only in the window `(P_k, 2·P_k]`, for every `P_k > 2` whether prime
or composite. `n` is a void with respect to the primes below `P_k` iff `n` is prime. For a
**prime** `P_k` this reach is exact (see `Rings.lean`'s `determinism_breaks_above`: the
equivalence fails once `n ≥ P_k²`); tightness for a composite `P_k` is open. -/
theorem Submission.void_iff_prime_in_deterministic_zone
    {Pk n : ℕ} (hPk3 : 2 < Pk) (hlo : Pk < n) (hhi : n < Pk ^ 2) :
    (∀ p ∈ (Finset.range Pk).filter Nat.Prime, ¬ p ∣ n) ↔ Nat.Prime n := by
  sorry

/-- **Bertrand–Chebyshev bound** (corollary of the equivalence above). For every `N > 1`
there is a prime `p` with `N < p ≤ 2 * N`. -/
theorem Submission.bertrand_chebyshev (N : ℕ) (hN : 1 < N) :
    ∃ p : ℕ, N < p ∧ p ≤ 2 * N ∧ p.Prime := by
  sorry
