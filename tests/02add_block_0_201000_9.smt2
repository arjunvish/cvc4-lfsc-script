; add.block_0_201000.1 (0x20101c) - Value of rbp at return is preserved.
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
(define-fun a201000_rip () (_ BitVec 64) #x0000000000201000)
(declare-fun a201000_rax () (_ BitVec 64))
(define-fun a201000_rcx () (_ BitVec 64) fnstart_rcx)
(define-fun a201000_rdx () (_ BitVec 64) fnstart_rdx)
(define-fun a201000_rbx () (_ BitVec 64) fnstart_rbx)
(define-fun a201000_rsp () (_ BitVec 64) fnstart_rsp)
(define-fun a201000_rbp () (_ BitVec 64) fnstart_rbp)
(define-fun a201000_rsi () (_ BitVec 64) fnstart_rsi)
(define-fun a201000_rdi () (_ BitVec 64) fnstart_rdi)
(define-fun a201000_r8 () (_ BitVec 64) fnstart_r8)
(define-fun a201000_r9 () (_ BitVec 64) fnstart_r9)
(declare-fun a201000_r10 () (_ BitVec 64))
(declare-fun a201000_r11 () (_ BitVec 64))
(define-fun a201000_r12 () (_ BitVec 64) fnstart_r12)
(define-fun a201000_r13 () (_ BitVec 64) fnstart_r13)
(define-fun a201000_r14 () (_ BitVec 64) fnstart_r14)
(define-fun a201000_r15 () (_ BitVec 64) fnstart_r15)
(declare-fun a201000_cf () Bool)
(declare-fun a201000_pf () Bool)
(declare-fun a201000_af () Bool)
(declare-fun a201000_zf () Bool)
(declare-fun a201000_sf () Bool)
(declare-fun a201000_tf () Bool)
(declare-fun a201000_if () Bool)
(define-fun a201000_df () Bool false)
(declare-fun a201000_of () Bool)
(declare-fun a201000_ie () Bool)
(declare-fun a201000_de () Bool)
(declare-fun a201000_ze () Bool)
(declare-fun a201000_oe () Bool)
(declare-fun a201000_ue () Bool)
(declare-fun a201000_pe () Bool)
(declare-fun a201000_ef () Bool)
(declare-fun a201000_es () Bool)
(declare-fun a201000_c0 () Bool)
(declare-fun a201000_c1 () Bool)
(declare-fun a201000_c2 () Bool)
(declare-fun a201000_RESERVED_STATUS_11 () Bool)
(declare-fun a201000_RESERVED_STATUS_12 () Bool)
(declare-fun a201000_RESERVED_STATUS_13 () Bool)
(declare-fun a201000_c3 () Bool)
(declare-fun a201000_RESERVED_STATUS_15 () Bool)
(define-fun a201000_x87top () (_ BitVec 3) (_ bv7 3))
(declare-fun a201000_tag0 () (_ BitVec 2))
(declare-fun a201000_tag1 () (_ BitVec 2))
(declare-fun a201000_tag2 () (_ BitVec 2))
(declare-fun a201000_tag3 () (_ BitVec 2))
(declare-fun a201000_tag4 () (_ BitVec 2))
(declare-fun a201000_tag5 () (_ BitVec 2))
(declare-fun a201000_tag6 () (_ BitVec 2))
(declare-fun a201000_tag7 () (_ BitVec 2))
(declare-fun a201000_mm0 () (_ BitVec 80))
(declare-fun a201000_mm1 () (_ BitVec 80))
(declare-fun a201000_mm2 () (_ BitVec 80))
(declare-fun a201000_mm3 () (_ BitVec 80))
(declare-fun a201000_mm4 () (_ BitVec 80))
(declare-fun a201000_mm5 () (_ BitVec 80))
(declare-fun a201000_mm6 () (_ BitVec 80))
(declare-fun a201000_mm7 () (_ BitVec 80))
(declare-fun a201000_zmm0 () (_ BitVec 512))
(declare-fun a201000_zmm1 () (_ BitVec 512))
(declare-fun a201000_zmm2 () (_ BitVec 512))
(declare-fun a201000_zmm3 () (_ BitVec 512))
(declare-fun a201000_zmm4 () (_ BitVec 512))
(declare-fun a201000_zmm5 () (_ BitVec 512))
(declare-fun a201000_zmm6 () (_ BitVec 512))
(declare-fun a201000_zmm7 () (_ BitVec 512))
(declare-fun a201000_zmm8 () (_ BitVec 512))
(declare-fun a201000_zmm9 () (_ BitVec 512))
(declare-fun a201000_zmm10 () (_ BitVec 512))
(declare-fun a201000_zmm11 () (_ BitVec 512))
(declare-fun a201000_zmm12 () (_ BitVec 512))
(declare-fun a201000_zmm13 () (_ BitVec 512))
(declare-fun a201000_zmm14 () (_ BitVec 512))
(declare-fun a201000_zmm15 () (_ BitVec 512))
(declare-fun a201000_zmm16 () (_ BitVec 512))
(declare-fun a201000_zmm17 () (_ BitVec 512))
(declare-fun a201000_zmm18 () (_ BitVec 512))
(declare-fun a201000_zmm19 () (_ BitVec 512))
(declare-fun a201000_zmm20 () (_ BitVec 512))
(declare-fun a201000_zmm21 () (_ BitVec 512))
(declare-fun a201000_zmm22 () (_ BitVec 512))
(declare-fun a201000_zmm23 () (_ BitVec 512))
(declare-fun a201000_zmm24 () (_ BitVec 512))
(declare-fun a201000_zmm25 () (_ BitVec 512))
(declare-fun a201000_zmm26 () (_ BitVec 512))
(declare-fun a201000_zmm27 () (_ BitVec 512))
(declare-fun a201000_zmm28 () (_ BitVec 512))
(declare-fun a201000_zmm29 () (_ BitVec 512))
(declare-fun a201000_zmm30 () (_ BitVec 512))
(declare-fun a201000_zmm31 () (_ BitVec 512))
(declare-const x86mem_0 (Array (_ BitVec 64) (_ BitVec 8)))
(define-fun return_addr () (_ BitVec 64) (mem_readbv64 x86mem_0 fnstart_rsp))
(define-fun llvm_arg0 () (_ BitVec 64) fnstart_rdi)
; LLVM: %t0 = add i64 %arg0, 1
(define-fun llvm_t0 () (_ BitVec 64) (bvadd llvm_arg0 (_ bv1 64)))
; LLVM: ret i64 %t0
(define-fun x86local_0 () (_ BitVec 64) (bvsub a201000_rsp (_ bv8 64)))
(assert (mc_only_stack_range x86local_0 (_ bv8 64)))
(define-fun x86mem_1 () (Array (_ BitVec 64) (_ BitVec 8)) (mem_writebv64 x86mem_0 x86local_0 a201000_rbp))
(define-fun x86local_1 () (_ BitVec 64) (bvadd x86local_0 (_ bv18446744073709551608 64)))
(assert (mc_only_stack_range x86local_1 (_ bv8 64)))
(define-fun x86mem_2 () (Array (_ BitVec 64) (_ BitVec 8)) (mem_writebv64 x86mem_1 x86local_1 a201000_rdi))
(define-fun x86local_2 () (_ BitVec 64) (bvadd x86local_0 (_ bv18446744073709551608 64)))
(assert (on_stack x86local_2 (_ bv8 64)))
(define-fun x86local_3 () (_ BitVec 64) (mem_readbv64 x86mem_2 x86local_2))
(define-fun x86local_4 () (_ BitVec 64) (bvadd x86local_0 (_ bv18446744073709551600 64)))
(assert (mc_only_stack_range x86local_4 (_ bv8 64)))
(define-fun x86mem_3 () (Array (_ BitVec 64) (_ BitVec 8)) (mem_writebv64 x86mem_2 x86local_4 x86local_3))
(define-fun x86local_5 () (_ BitVec 64) (bvadd x86local_0 (_ bv18446744073709551600 64)))
(assert (on_stack x86local_5 (_ bv8 64)))
(define-fun x86local_6 () (_ BitVec 64) (mem_readbv64 x86mem_3 x86local_5))
(define-fun x86local_7 () Bool (distinct ((_ extract 64 64) (bvadd ((_ sign_extend 1) x86local_6) ((_ sign_extend 1) (_ bv1 64)) (ite false (_ bv1 65) (_ bv0 65)))) ((_ extract 63 63) (bvadd ((_ sign_extend 1) x86local_6) ((_ sign_extend 1) (_ bv1 64)) (ite false (_ bv1 65) (_ bv0 65))))))
(define-fun x86local_8 () (_ BitVec 4) ((_ extract 3 0) x86local_6))
(define-fun x86local_9 () Bool (= ((_ extract 4 4) (bvadd ((_ zero_extend 1) x86local_8) ((_ zero_extend 1) (_ bv1 4)) (ite false (_ bv1 5) (_ bv0 5)))) #b1))
(define-fun x86local_10 () Bool (= ((_ extract 64 64) (bvadd ((_ zero_extend 1) x86local_6) ((_ zero_extend 1) (_ bv1 64)) (ite false (_ bv1 65) (_ bv0 65)))) #b1))
(define-fun x86local_11 () (_ BitVec 64) (bvadd x86local_6 (_ bv1 64)))
(define-fun x86local_12 () Bool (bvslt x86local_11 (_ bv0 64)))
(define-fun x86local_13 () Bool (= x86local_11 (_ bv0 64)))
(define-fun x86local_14 () (_ BitVec 8) ((_ extract 7 0) x86local_11))
(define-fun x86local_15 () Bool (even_parity x86local_14))
(assert (on_stack x86local_0 (_ bv8 64)))
(define-fun x86local_16 () (_ BitVec 64) (mem_readbv64 x86mem_3 x86local_0))
(define-fun x86local_17 () (_ BitVec 64) (bvadd x86local_0 (_ bv8 64)))
(assert (on_stack x86local_17 (_ bv8 64)))
(define-fun x86local_18 () (_ BitVec 64) (mem_readbv64 x86mem_3 x86local_17))
(define-fun x86local_19 () (_ BitVec 64) (bvadd x86local_17 (_ bv8 64)))
(assert (= x86local_19 (bvadd fnstart_rsp (_ bv8 64))))
(assert (= x86local_18 return_addr))
(assert (distinct x86local_16 fnstart_rbp))
(check-sat)
;(check-sat-assuming ((distinct x86local_16 fnstart_rbp)))
(exit)
