#!/bin/bash
SMTFILE=$1
if grep -q "unsat" $SMTFILE; then
  echo -e "SMT problem is unsat. Getting proof...\n"
  cvc4 --dump-proofs --no-lfsc-letification $SMTFILE | tail -n +2 >> proof.plf
  if [ $? -eq 0 ]; then
    echo -e "Proof in proof.plf. Checking proof...\n"
    lfscc sigs/sat.plf sigs/smt.plf sigs/th_base.plf proof.plf
  else
    echo -e "Couldn't generate proof!\n"
  fi
else
  echo "SMT problem is not unsat."
fi
