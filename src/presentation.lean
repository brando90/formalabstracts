import preliminaries group_theory.free_group group_theory.coset group_theory.quotient_group

/- Some definitions for specifying a finite group as a quotient of a free group -/

/-- The propositional language of the free group generated by α-/
inductive term (α : Type*)
| sym : α → term
| mul : term → term → term
| pow : term → ℕ → term
| inv : term → term
| id : term

open term

instance {α} : has_one $ term α := ⟨@term.id α⟩

local notation a `̂ `:70 k:70 := term.pow (term.sym a) k

local notation a `×'`:75 b:75 := term.mul (term.sym a) b

notation a `×'`:75 b:75 := term.mul (term.sym a) (term.sym b)

local notation a`⁻¹`:65 := term.inv (term.sym a)

/-- A relation is a formal equality of terms -/
inductive relation (α : Type*)
| eq : term α → term α → relation

notation t₁ `≃`:60 t₂ := relation.eq t₁ t₂

/-- Given a list xs of relations on α, return the normal subgroup of free_group α generated by xs -/
def normal_subgroup_mk {α : Type*} (xs : list $ relation α) : set (free_group α) := sorry

instance normal_subgroup_mk_normal {α : Type*} (xs : list $ relation α) : normal_subgroup (normal_subgroup_mk xs) := omitted

def group_of_generators_relations (gen : Type*) (relations : list $ relation gen) : Group :=
  ⟨quotient_group.quotient (normal_subgroup_mk relations), by apply_instance⟩

notation `⟨`:95 G `|`:90 R`⟩`:0 := group_of_generators_relations G R

/- Dihedral groups D_n -/
inductive dihedral_group_generators
| r : dihedral_group_generators
| s : dihedral_group_generators

open dihedral_group_generators

def G := dihedral_group_generators

def dihedral_group (n) : Group := ⟨G | [r ̂ n ≃ 1, s ̂ 2 ≃ 1, s ×' (r ×' s) ≃ r⁻¹]⟩