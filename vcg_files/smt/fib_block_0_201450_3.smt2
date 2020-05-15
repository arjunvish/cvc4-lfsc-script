; fib.block_0_201450.0 (0x201459) - Stack height at return matches init.
(set-logic ALL_SUPPORTED)
(set-option :produce-models true)
(define-fun even_parity ((v (_ BitVec 8))) Bool (= (bvxor ((_ extract 0 0) v) ((_ extract 1 1) v) ((_ extract 2 2) v) ((_ extract 3 3) v) ((_ extract 4 4) v) ((_ extract 5 5) v) ((_ extract 6 6) v) ((_ extract 7 7) v)) #b0))
(define-fun mem_readbv8 ((m (Array (_ BitVec 64) (_ BitVec 8))) (a (_ BitVec 64))) (_ BitVec 8) (select m a))
(define-fun mem_readbv16 ((m (Array (_ BitVec 64) (_ BitVec 8))) (a (_ BitVec 64))) (_ BitVec 16) (concat (select m (bvadd a (_ bv1 64))) (select m a)))
(define-fun mem_readbv32 ((m (Array (_ BitVec 64) (_ BitVec 8))) (a (_ BitVec 64))) (_ BitVec 32) (concat (select m (bvadd a (_ bv3 64))) (concat (select m (bvadd a (_ bv2 64))) (concat (select m (bvadd a (_ bv1 64))) (select m a)))))
(define-fun mem_readbv64 ((m (Array (_ BitVec 64) (_ BitVec 8))) (a (_ BitVec 64))) (_ BitVec 64) (concat (select m (bvadd a (_ bv7 64))) (concat (select m (bvadd a (_ bv6 64))) (concat (select m (bvadd a (_ bv5 64))) (concat (select m (bvadd a (_ bv4 64))) (concat (select m (bvadd a (_ bv3 64))) (concat (select m (bvadd a (_ bv2 64))) (concat (select m (bvadd a (_ bv1 64))) (select m a)))))))))
(define-fun mem_writebv8 ((m (Array (_ BitVec 64) (_ BitVec 8))) (a (_ BitVec 64)) (v (_ BitVec 8))) (Array (_ BitVec 64) (_ BitVec 8)) (store m a ((_ extract 7 0) v)))
(define-fun mem_writebv16 ((m (Array (_ BitVec 64) (_ BitVec 8))) (a (_ BitVec 64)) (v (_ BitVec 16))) (Array (_ BitVec 64) (_ BitVec 8)) (store (store m a ((_ extract 7 0) v)) (bvadd a (_ bv1 64)) ((_ extract 15 8) v)))
(define-fun mem_writebv32 ((m (Array (_ BitVec 64) (_ BitVec 8))) (a (_ BitVec 64)) (v (_ BitVec 32))) (Array (_ BitVec 64) (_ BitVec 8)) (store (store (store (store m a ((_ extract 7 0) v)) (bvadd a (_ bv1 64)) ((_ extract 15 8) v)) (bvadd a (_ bv2 64)) ((_ extract 23 16) v)) (bvadd a (_ bv3 64)) ((_ extract 31 24) v)))
(define-fun mem_writebv64 ((m (Array (_ BitVec 64) (_ BitVec 8))) (a (_ BitVec 64)) (v (_ BitVec 64))) (Array (_ BitVec 64) (_ BitVec 8)) (store (store (store (store (store (store (store (store m a ((_ extract 7 0) v)) (bvadd a (_ bv1 64)) ((_ extract 15 8) v)) (bvadd a (_ bv2 64)) ((_ extract 23 16) v)) (bvadd a (_ bv3 64)) ((_ extract 31 24) v)) (bvadd a (_ bv4 64)) ((_ extract 39 32) v)) (bvadd a (_ bv5 64)) ((_ extract 47 40) v)) (bvadd a (_ bv6 64)) ((_ extract 55 48) v)) (bvadd a (_ bv7 64)) ((_ extract 63 56) v)))
(declare-fun fnstart_rcx () (_ BitVec 64))
(declare-fun fnstart_rdx () (_ BitVec 64))
(declare-fun fnstart_rbx () (_ BitVec 64))
(declare-fun fnstart_rsp () (_ BitVec 64))
(declare-fun fnstart_rbp () (_ BitVec 64))
(declare-fun fnstart_rsi () (_ BitVec 64))
(declare-fun fnstart_rdi () (_ BitVec 64))
(declare-fun fnstart_r8 () (_ BitVec 64))
(declare-fun fnstart_r9 () (_ BitVec 64))
(declare-fun fnstart_r12 () (_ BitVec 64))
(declare-fun fnstart_r13 () (_ BitVec 64))
(declare-fun fnstart_r14 () (_ BitVec 64))
(declare-fun fnstart_r15 () (_ BitVec 64))
(declare-const stack_alloc_min (_ BitVec 64))
(assert (= (bvand stack_alloc_min #x0000000000000fff) (_ bv0 64)))
(assert (bvult (_ bv4096 64) stack_alloc_min))
(define-fun stack_guard_min () (_ BitVec 64) (bvsub stack_alloc_min (_ bv4096 64)))
(assert (bvult stack_guard_min stack_alloc_min))
(declare-const stack_max (_ BitVec 64))
(assert (= (bvand stack_max #x0000000000000fff) (_ bv0 64)))
(assert (bvult stack_alloc_min stack_max))
(assert (bvule stack_alloc_min fnstart_rsp))
(assert (bvule fnstart_rsp (bvsub stack_max (_ bv8 64))))
(define-fun on_stack ((a (_ BitVec 64)) (sz (_ BitVec 64))) Bool (let ((e (bvadd a sz))) (and (bvule stack_guard_min a) (bvule a e) (bvule e stack_max))))
(define-fun not_in_stack_range ((a (_ BitVec 64)) (sz (_ BitVec 64))) Bool (let ((e (bvadd a sz))) (and (bvule a e) (or (bvule e stack_alloc_min) (bvule stack_max a)))))
(assert (bvult fnstart_rsp (bvsub stack_max (_ bv8 64))))
(assert (= ((_ extract 3 0) fnstart_rsp) (_ bv8 4)))
(define-fun mc_only_stack_range ((a (_ BitVec 64)) (sz (_ BitVec 64))) Bool (let ((e (bvadd a sz))) (on_stack a sz)))
(define-fun a201450_rip () (_ BitVec 64) #x0000000000201450)
(declare-fun a201450_rax () (_ BitVec 64))
(declare-fun a201450_rcx () (_ BitVec 64))
(declare-fun a201450_rdx () (_ BitVec 64))
(declare-fun a201450_rbx () (_ BitVec 64))
(declare-fun a201450_rsp () (_ BitVec 64))
(declare-fun a201450_rbp () (_ BitVec 64))
(declare-fun a201450_rsi () (_ BitVec 64))
(declare-fun a201450_rdi () (_ BitVec 64))
(declare-fun a201450_r8 () (_ BitVec 64))
(declare-fun a201450_r9 () (_ BitVec 64))
(declare-fun a201450_r10 () (_ BitVec 64))
(declare-fun a201450_r11 () (_ BitVec 64))
(declare-fun a201450_r12 () (_ BitVec 64))
(declare-fun a201450_r13 () (_ BitVec 64))
(declare-fun a201450_r14 () (_ BitVec 64))
(declare-fun a201450_r15 () (_ BitVec 64))
(declare-fun a201450_cf () Bool)
(declare-fun a201450_pf () Bool)
(declare-fun a201450_af () Bool)
(declare-fun a201450_zf () Bool)
(declare-fun a201450_sf () Bool)
(declare-fun a201450_tf () Bool)
(declare-fun a201450_if () Bool)
(define-fun a201450_df () Bool false)
(declare-fun a201450_of () Bool)
(declare-fun a201450_ie () Bool)
(declare-fun a201450_de () Bool)
(declare-fun a201450_ze () Bool)
(declare-fun a201450_oe () Bool)
(declare-fun a201450_ue () Bool)
(declare-fun a201450_pe () Bool)
(declare-fun a201450_ef () Bool)
(declare-fun a201450_es () Bool)
(declare-fun a201450_c0 () Bool)
(declare-fun a201450_c1 () Bool)
(declare-fun a201450_c2 () Bool)
(declare-fun a201450_RESERVED_STATUS_11 () Bool)
(declare-fun a201450_RESERVED_STATUS_12 () Bool)
(declare-fun a201450_RESERVED_STATUS_13 () Bool)
(declare-fun a201450_c3 () Bool)
(declare-fun a201450_RESERVED_STATUS_15 () Bool)
(define-fun a201450_x87top () (_ BitVec 3) (_ bv7 3))
(declare-fun a201450_tag0 () (_ BitVec 2))
(declare-fun a201450_tag1 () (_ BitVec 2))
(declare-fun a201450_tag2 () (_ BitVec 2))
(declare-fun a201450_tag3 () (_ BitVec 2))
(declare-fun a201450_tag4 () (_ BitVec 2))
(declare-fun a201450_tag5 () (_ BitVec 2))
(declare-fun a201450_tag6 () (_ BitVec 2))
(declare-fun a201450_tag7 () (_ BitVec 2))
(declare-fun a201450_mm0 () (_ BitVec 80))
(declare-fun a201450_mm1 () (_ BitVec 80))
(declare-fun a201450_mm2 () (_ BitVec 80))
(declare-fun a201450_mm3 () (_ BitVec 80))
(declare-fun a201450_mm4 () (_ BitVec 80))
(declare-fun a201450_mm5 () (_ BitVec 80))
(declare-fun a201450_mm6 () (_ BitVec 80))
(declare-fun a201450_mm7 () (_ BitVec 80))
(declare-fun a201450_zmm0 () (_ BitVec 512))
(declare-fun a201450_zmm1 () (_ BitVec 512))
(declare-fun a201450_zmm2 () (_ BitVec 512))
(declare-fun a201450_zmm3 () (_ BitVec 512))
(declare-fun a201450_zmm4 () (_ BitVec 512))
(declare-fun a201450_zmm5 () (_ BitVec 512))
(declare-fun a201450_zmm6 () (_ BitVec 512))
(declare-fun a201450_zmm7 () (_ BitVec 512))
(declare-fun a201450_zmm8 () (_ BitVec 512))
(declare-fun a201450_zmm9 () (_ BitVec 512))
(declare-fun a201450_zmm10 () (_ BitVec 512))
(declare-fun a201450_zmm11 () (_ BitVec 512))
(declare-fun a201450_zmm12 () (_ BitVec 512))
(declare-fun a201450_zmm13 () (_ BitVec 512))
(declare-fun a201450_zmm14 () (_ BitVec 512))
(declare-fun a201450_zmm15 () (_ BitVec 512))
(declare-fun a201450_zmm16 () (_ BitVec 512))
(declare-fun a201450_zmm17 () (_ BitVec 512))
(declare-fun a201450_zmm18 () (_ BitVec 512))
(declare-fun a201450_zmm19 () (_ BitVec 512))
(declare-fun a201450_zmm20 () (_ BitVec 512))
(declare-fun a201450_zmm21 () (_ BitVec 512))
(declare-fun a201450_zmm22 () (_ BitVec 512))
(declare-fun a201450_zmm23 () (_ BitVec 512))
(declare-fun a201450_zmm24 () (_ BitVec 512))
(declare-fun a201450_zmm25 () (_ BitVec 512))
(declare-fun a201450_zmm26 () (_ BitVec 512))
(declare-fun a201450_zmm27 () (_ BitVec 512))
(declare-fun a201450_zmm28 () (_ BitVec 512))
(declare-fun a201450_zmm29 () (_ BitVec 512))
(declare-fun a201450_zmm30 () (_ BitVec 512))
(declare-fun a201450_zmm31 () (_ BitVec 512))
(declare-const x86mem_0 (Array (_ BitVec 64) (_ BitVec 8)))
(define-fun return_addr () (_ BitVec 64) (mem_readbv64 x86mem_0 fnstart_rsp))
(define-fun llvm_arg0 () (_ BitVec 64) fnstart_rdi)
(declare-const llvm_t15 (_ BitVec 64))
(assert (= a201450_rbp (bvsub fnstart_rsp (_ bv8 64))))
(assert (= a201450_rsp (bvsub fnstart_rsp (_ bv40 64))))
(assert (= (mem_readbv64 x86mem_0 (bvsub fnstart_rsp (_ bv8 64))) fnstart_rbp))
(assert (= (mem_readbv64 x86mem_0 (bvsub fnstart_rsp (_ bv16 64))) llvm_t15))
(assert (= a201450_rbx fnstart_rbx))
(assert (= a201450_r12 fnstart_r12))
(assert (= a201450_r13 fnstart_r13))
(assert (= a201450_r14 fnstart_r14))
(assert (= a201450_r15 fnstart_r15))
; LLVM: ret i64 %t15
(define-fun x86local_0 () (_ BitVec 64) (bvadd a201450_rbp (_ bv18446744073709551608 64)))
(assert (on_stack x86local_0 (_ bv8 64)))
(define-fun x86local_1 () (_ BitVec 64) (mem_readbv64 x86mem_0 x86local_0))
(define-fun x86local_2 () Bool (distinct ((_ extract 64 64) (bvadd ((_ sign_extend 1) a201450_rsp) ((_ sign_extend 1) (_ bv32 64)) (ite false (_ bv1 65) (_ bv0 65)))) ((_ extract 63 63) (bvadd ((_ sign_extend 1) a201450_rsp) ((_ sign_extend 1) (_ bv32 64)) (ite false (_ bv1 65) (_ bv0 65))))))
(define-fun x86local_3 () Bool (= ((_ extract 64 64) (bvadd ((_ zero_extend 1) a201450_rsp) ((_ zero_extend 1) (_ bv32 64)) (ite false (_ bv1 65) (_ bv0 65)))) #b1))
(define-fun x86local_4 () (_ BitVec 64) (bvadd a201450_rsp (_ bv32 64)))
(define-fun x86local_5 () Bool (bvslt x86local_4 (_ bv0 64)))
(define-fun x86local_6 () Bool (= x86local_4 (_ bv0 64)))
(define-fun x86local_7 () (_ BitVec 8) ((_ extract 7 0) x86local_4))
(define-fun x86local_8 () Bool (even_parity x86local_7))
(assert (on_stack x86local_4 (_ bv8 64)))
(define-fun x86local_9 () (_ BitVec 64) (mem_readbv64 x86mem_0 x86local_4))
(define-fun x86local_10 () (_ BitVec 64) (bvadd x86local_4 (_ bv8 64)))
(assert (on_stack x86local_10 (_ bv8 64)))
(define-fun x86local_11 () (_ BitVec 64) (mem_readbv64 x86mem_0 x86local_10))
(define-fun x86local_12 () (_ BitVec 64) (bvadd x86local_10 (_ bv8 64)))
(check-sat-assuming ((distinct x86local_12 (bvadd fnstart_rsp (_ bv8 64)))))
(exit)
