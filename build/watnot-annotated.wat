(module
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i32) (result i32)))
  (type (;2;) (func (param i32 i32) (result i32)))
  (type (;3;) (func (param i32 i32 i32) (result i32)))
  (type (;4;) (func (param i64 i64) (result i32)))
  (type (;5;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;6;) (func (param i32)))
  (type (;7;) (func (param i32 i32 i32)))
  (type (;8;) (func))
  (type (;9;) (func (param i32 i64) (result i32)))
  (type (;10;) (func (param i32 i64 i32) (result i32)))
  (type (;11;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;12;) (func (param i32) (result i64)))
  (type (;13;) (func (param i32 i64)))
  (type (;14;) (func (param i32 i32 i32 i32 i32)))
  (type (;15;) (func (param i32 i32 i32 i32 i32 i32)))
  (type (;16;) (func (param i32 i32) (result i64)))
  (type (;17;) (func (param i32 i32 i32 i32)))
  (type (;18;) (func (param i32 i32 i64) (result i32)))
  (type (;19;) (func (result i32)))
  (type (;20;) (func (param i32 i32 i32 i32 i32 i64 i64 i32 i32) (result i32)))
  (type (;21;) (func (param i64) (result i32)))
  (type (;22;) (func (param i32 i32 i64)))
  (import "wasi_snapshot_preview1" "fd_write" (func $~lib/bindings/wasi_snapshot_preview1/fd_write (type 5)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $~lib/bindings/wasi_snapshot_preview1/proc_exit (type 6)))
  (import "wasi_snapshot_preview1" "args_sizes_get" (func $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/args_sizes_get (type 2)))
  (import "wasi_snapshot_preview1" "args_get" (func $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/args_get (type 2)))
  (import "wasi_snapshot_preview1" "fd_write" (func $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/fd_write (type 5)))
  (import "wasi_snapshot_preview1" "path_open" (func $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/path_open (type 20)))
  (import "wasi_snapshot_preview1" "fd_read" (func $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/fd_read (type 5)))
  (func $start:~lib/as-wasi/assembly/as-wasi (type 8)
    (global.set $~lib/as-wasi/assembly/as-wasi/Time.MILLISECOND
      (i32.mul
        (global.get $~lib/as-wasi/assembly/as-wasi/Time.NANOSECOND)
        (i32.const 1000000)))
    (global.set $~lib/as-wasi/assembly/as-wasi/Time.SECOND
      (i32.mul
        (global.get $~lib/as-wasi/assembly/as-wasi/Time.MILLISECOND)
        (i32.const 1000))))
  (func $start:~lib/as-wasi/assembly/index (type 8)
    (call $start:~lib/as-wasi/assembly/as-wasi))
  (func $~lib/bindings/wasi_snapshot_preview1/iovec#set:buf (type 0) (param $this i32) (param $buf i32)
    (i32.store
      (local.get $this)
      (local.get $buf)))
  (func $~lib/rt/common/OBJECT#get:rtSize (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/string/String#get:length (type 1) (param $this i32) (result i32)
    (return
      (i32.shr_u
        (call $~lib/rt/common/OBJECT#get:rtSize
          (i32.sub
            (local.get $this)
            (i32.const 20)))
        (i32.const 1))))
  (func $~lib/util/string/compareImpl (type 11) (param $str1 i32) (param $index1 i32) (param $str2 i32) (param $index2 i32) (param $len i32) (result i32)
    (local $ptr1 i32) (local $ptr2 i32) (local $7 i32) (local $a i32) (local $b i32)
    (local.set $ptr1
      (i32.add
        (local.get $str1)
        (i32.shl
          (local.get $index1)
          (i32.const 1))))
    (local.set $ptr2
      (i32.add
        (local.get $str2)
        (i32.shl
          (local.get $index2)
          (i32.const 1))))
    (drop
      (i32.lt_s
        (i32.const 0)
        (i32.const 2)))
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.ge_u
          (local.get $len)
          (i32.const 4))
        (then
          (i32.eqz
            (i32.or
              (i32.and
                (local.get $ptr1)
                (i32.const 7))
              (i32.and
                (local.get $ptr2)
                (i32.const 7)))))
        (else
          (i32.const 0)))
      (then
        (block  ;; label = @2
          (loop  ;; label = @3
            (if  ;; label = @4
              (i64.ne
                (i64.load
                  (local.get $ptr1))
                (i64.load
                  (local.get $ptr2)))
              (then
                (br 2 (;@2;))))
            (local.set $ptr1
              (i32.add
                (local.get $ptr1)
                (i32.const 8)))
            (local.set $ptr2
              (i32.add
                (local.get $ptr2)
                (i32.const 8)))
            (local.set $len
              (i32.sub
                (local.get $len)
                (i32.const 4)))
            (br_if 0 (;@3;)
              (i32.ge_u
                (local.get $len)
                (i32.const 4)))))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.set $len
          (i32.sub
            (local.tee $7
              (local.get $len))
            (i32.const 1)))
        (if  ;; label = @3
          (local.get $7)
          (then
            (local.set $a
              (i32.load16_u
                (local.get $ptr1)))
            (local.set $b
              (i32.load16_u
                (local.get $ptr2)))
            (if  ;; label = @4
              (i32.ne
                (local.get $a)
                (local.get $b))
              (then
                (return
                  (i32.sub
                    (local.get $a)
                    (local.get $b)))))
            (local.set $ptr1
              (i32.add
                (local.get $ptr1)
                (i32.const 2)))
            (local.set $ptr2
              (i32.add
                (local.get $ptr2)
                (i32.const 2)))
            (br 1 (;@2;))))))
    (return
      (i32.const 0)))
  (func $~lib/string/String.UTF8.encodeUnsafe (type 11) (param $str i32) (param $len i32) (param $buf i32) (param $nullTerminated i32) (param $errorMode i32) (result i32)
    (local $strEnd i32) (local $bufOff i32) (local $c1 i32) (local $b0 i32) (local $b1 i32) (local $c2 i32) (local $b0|11 i32) (local $b1|12 i32) (local $b2 i32) (local $b3 i32) (local $b0|15 i32) (local $b1|16 i32) (local $b2|17 i32) (local $18 i32)
    (local.set $strEnd
      (i32.add
        (local.get $str)
        (i32.shl
          (local.get $len)
          (i32.const 1))))
    (local.set $bufOff
      (local.get $buf))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $str)
            (local.get $strEnd))
          (then
            (local.set $c1
              (i32.load16_u
                (local.get $str)))
            (if  ;; label = @4
              (i32.lt_u
                (local.get $c1)
                (i32.const 128))
              (then
                (i32.store8
                  (local.get $bufOff)
                  (local.get $c1))
                (local.set $bufOff
                  (i32.add
                    (local.get $bufOff)
                    (i32.const 1)))
                (if  ;; label = @5
                  (i32.and
                    (local.get $nullTerminated)
                    (i32.eqz
                      (local.get $c1)))
                  (then
                    (return
                      (i32.sub
                        (local.get $bufOff)
                        (local.get $buf))))))
              (else
                (if  ;; label = @5
                  (i32.lt_u
                    (local.get $c1)
                    (i32.const 2048))
                  (then
                    (local.set $b0
                      (i32.or
                        (i32.shr_u
                          (local.get $c1)
                          (i32.const 6))
                        (i32.const 192)))
                    (local.set $b1
                      (i32.or
                        (i32.and
                          (local.get $c1)
                          (i32.const 63))
                        (i32.const 128)))
                    (i32.store16
                      (local.get $bufOff)
                      (i32.or
                        (i32.shl
                          (local.get $b1)
                          (i32.const 8))
                        (local.get $b0)))
                    (local.set $bufOff
                      (i32.add
                        (local.get $bufOff)
                        (i32.const 2))))
                  (else
                    (if  ;; label = @6
                      (i32.eq
                        (i32.and
                          (local.get $c1)
                          (i32.const 63488))
                        (i32.const 55296))
                      (then
                        (if  ;; label = @7
                          (if (result i32)  ;; label = @8
                            (i32.lt_u
                              (local.get $c1)
                              (i32.const 56320))
                            (then
                              (i32.lt_u
                                (i32.add
                                  (local.get $str)
                                  (i32.const 2))
                                (local.get $strEnd)))
                            (else
                              (i32.const 0)))
                          (then
                            (local.set $c2
                              (i32.load16_u offset=2
                                (local.get $str)))
                            (if  ;; label = @8
                              (i32.eq
                                (i32.and
                                  (local.get $c2)
                                  (i32.const 64512))
                                (i32.const 56320))
                              (then
                                (local.set $c1
                                  (i32.or
                                    (i32.add
                                      (i32.const 65536)
                                      (i32.shl
                                        (i32.and
                                          (local.get $c1)
                                          (i32.const 1023))
                                        (i32.const 10)))
                                    (i32.and
                                      (local.get $c2)
                                      (i32.const 1023))))
                                (local.set $b0|11
                                  (i32.or
                                    (i32.shr_u
                                      (local.get $c1)
                                      (i32.const 18))
                                    (i32.const 240)))
                                (local.set $b1|12
                                  (i32.or
                                    (i32.and
                                      (i32.shr_u
                                        (local.get $c1)
                                        (i32.const 12))
                                      (i32.const 63))
                                    (i32.const 128)))
                                (local.set $b2
                                  (i32.or
                                    (i32.and
                                      (i32.shr_u
                                        (local.get $c1)
                                        (i32.const 6))
                                      (i32.const 63))
                                    (i32.const 128)))
                                (local.set $b3
                                  (i32.or
                                    (i32.and
                                      (local.get $c1)
                                      (i32.const 63))
                                    (i32.const 128)))
                                (i32.store
                                  (local.get $bufOff)
                                  (i32.or
                                    (i32.or
                                      (i32.or
                                        (i32.shl
                                          (local.get $b3)
                                          (i32.const 24))
                                        (i32.shl
                                          (local.get $b2)
                                          (i32.const 16)))
                                      (i32.shl
                                        (local.get $b1|12)
                                        (i32.const 8)))
                                    (local.get $b0|11)))
                                (local.set $bufOff
                                  (i32.add
                                    (local.get $bufOff)
                                    (i32.const 4)))
                                (local.set $str
                                  (i32.add
                                    (local.get $str)
                                    (i32.const 4)))
                                (br 6 (;@2;))))))
                        (if  ;; label = @7
                          (i32.ne
                            (local.get $errorMode)
                            (i32.const 0))
                          (then
                            (if  ;; label = @8
                              (i32.eq
                                (local.get $errorMode)
                                (i32.const 2))
                              (then
                                (call $~lib/wasi_internal/wasi_abort
                                  (i32.const 224)
                                  (i32.const 288)
                                  (i32.const 742)
                                  (i32.const 49))
                                (unreachable)))
                            (local.set $c1
                              (i32.const 65533))))))
                    (local.set $b0|15
                      (i32.or
                        (i32.shr_u
                          (local.get $c1)
                          (i32.const 12))
                        (i32.const 224)))
                    (local.set $b1|16
                      (i32.or
                        (i32.and
                          (i32.shr_u
                            (local.get $c1)
                            (i32.const 6))
                          (i32.const 63))
                        (i32.const 128)))
                    (local.set $b2|17
                      (i32.or
                        (i32.and
                          (local.get $c1)
                          (i32.const 63))
                        (i32.const 128)))
                    (i32.store16
                      (local.get $bufOff)
                      (i32.or
                        (i32.shl
                          (local.get $b1|16)
                          (i32.const 8))
                        (local.get $b0|15)))
                    (i32.store8 offset=2
                      (local.get $bufOff)
                      (local.get $b2|17))
                    (local.set $bufOff
                      (i32.add
                        (local.get $bufOff)
                        (i32.const 3)))))))
            (local.set $str
              (i32.add
                (local.get $str)
                (i32.const 2)))
            (br 1 (;@2;))))))
    (if  ;; label = @1
      (local.get $nullTerminated)
      (then
        (local.set $bufOff
          (i32.add
            (local.tee $18
              (local.get $bufOff))
            (i32.const 1)))
        (i32.store8
          (local.get $18)
          (i32.const 0))))
    (return
      (i32.sub
        (local.get $bufOff)
        (local.get $buf))))
  (func $~lib/string/String.UTF8.encodeUnsafe@varargs (type 11) (param $str i32) (param $len i32) (param $buf i32) (param $nullTerminated i32) (param $errorMode i32) (result i32)
    (block  ;; label = @1
      (block  ;; label = @2
        (block  ;; label = @3
          (block  ;; label = @4
            (br_table 1 (;@3;) 2 (;@2;) 3 (;@1;) 0 (;@4;)
              (i32.sub
                (global.get $~argumentsLength)
                (i32.const 3))))
          (unreachable))
        (local.set $nullTerminated
          (i32.const 0)))
      (local.set $errorMode
        (i32.const 0)))
    (call $~lib/string/String.UTF8.encodeUnsafe
      (local.get $str)
      (local.get $len)
      (local.get $buf)
      (local.get $nullTerminated)
      (local.get $errorMode)))
  (func $~lib/util/number/decimalCount32 (type 1) (param $value i32) (result i32)
    (if  ;; label = @1
      (i32.lt_u
        (local.get $value)
        (i32.const 100000))
      (then
        (if  ;; label = @2
          (i32.lt_u
            (local.get $value)
            (i32.const 100))
          (then
            (return
              (i32.add
                (i32.const 1)
                (i32.ge_u
                  (local.get $value)
                  (i32.const 10)))))
          (else
            (return
              (i32.add
                (i32.add
                  (i32.const 3)
                  (i32.ge_u
                    (local.get $value)
                    (i32.const 10000)))
                (i32.ge_u
                  (local.get $value)
                  (i32.const 1000))))))
        (unreachable))
      (else
        (if  ;; label = @2
          (i32.lt_u
            (local.get $value)
            (i32.const 10000000))
          (then
            (return
              (i32.add
                (i32.const 6)
                (i32.ge_u
                  (local.get $value)
                  (i32.const 1000000)))))
          (else
            (return
              (i32.add
                (i32.add
                  (i32.const 8)
                  (i32.ge_u
                    (local.get $value)
                    (i32.const 1000000000)))
                (i32.ge_u
                  (local.get $value)
                  (i32.const 100000000))))))
        (unreachable)))
    (unreachable))
  (func $~lib/bindings/wasi_snapshot_preview1/iovec#set:buf_len (type 0) (param $this i32) (param $buf_len i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $buf_len)))
  (func $~lib/rt/itcms/Object#set:nextWithColor (type 0) (param $this i32) (param $nextWithColor i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $nextWithColor)))
  (func $~lib/rt/itcms/Object#set:prev (type 0) (param $this i32) (param $prev i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $prev)))
  (func $~lib/rt/itcms/initLazy (type 1) (param $space i32) (result i32)
    (call $~lib/rt/itcms/Object#set:nextWithColor
      (local.get $space)
      (local.get $space))
    (call $~lib/rt/itcms/Object#set:prev
      (local.get $space)
      (local.get $space))
    (return
      (local.get $space)))
  (func $~lib/rt/itcms/Object#get:nextWithColor (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/rt/itcms/Object#get:next (type 1) (param $this i32) (result i32)
    (return
      (i32.and
        (call $~lib/rt/itcms/Object#get:nextWithColor
          (local.get $this))
        (i32.xor
          (i32.const 3)
          (i32.const -1)))))
  (func $~lib/rt/itcms/Object#get:color (type 1) (param $this i32) (result i32)
    (return
      (i32.and
        (call $~lib/rt/itcms/Object#get:nextWithColor
          (local.get $this))
        (i32.const 3))))
  (func $~lib/rt/itcms/visitRoots (type 6) (param $cookie i32)
    (local $pn i32) (local $iter i32)
    (call $~lib/rt/__visit_globals
      (local.get $cookie))
    (local.set $pn
      (global.get $~lib/rt/itcms/pinSpace))
    (local.set $iter
      (call $~lib/rt/itcms/Object#get:next
        (local.get $pn)))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $iter)
            (local.get $pn))
          (then
            (drop
              (i32.const 1))
            (if  ;; label = @4
              (i32.eqz
                (i32.eq
                  (call $~lib/rt/itcms/Object#get:color
                    (local.get $iter))
                  (i32.const 3)))
              (then
                (call $~lib/wasi_internal/wasi_abort
                  (i32.const 0)
                  (i32.const 400)
                  (i32.const 160)
                  (i32.const 16))
                (unreachable)))
            (call $~lib/rt/__visit_members
              (i32.add
                (local.get $iter)
                (i32.const 20))
              (local.get $cookie))
            (local.set $iter
              (call $~lib/rt/itcms/Object#get:next
                (local.get $iter)))
            (br 1 (;@2;)))))))
  (func $~lib/rt/itcms/Object#set:color (type 0) (param $this i32) (param $color i32)
    (call $~lib/rt/itcms/Object#set:nextWithColor
      (local.get $this)
      (i32.or
        (i32.and
          (call $~lib/rt/itcms/Object#get:nextWithColor
            (local.get $this))
          (i32.xor
            (i32.const 3)
            (i32.const -1)))
        (local.get $color))))
  (func $~lib/rt/itcms/Object#get:prev (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/rt/itcms/Object#set:next (type 0) (param $this i32) (param $obj i32)
    (call $~lib/rt/itcms/Object#set:nextWithColor
      (local.get $this)
      (i32.or
        (local.get $obj)
        (i32.and
          (call $~lib/rt/itcms/Object#get:nextWithColor
            (local.get $this))
          (i32.const 3)))))
  (func $~lib/rt/itcms/Object#unlink (type 6) (param $this i32)
    (local $next i32) (local $prev i32)
    (local.set $next
      (call $~lib/rt/itcms/Object#get:next
        (local.get $this)))
    (if  ;; label = @1
      (i32.eq
        (local.get $next)
        (i32.const 0))
      (then
        (drop
          (i32.const 1))
        (if  ;; label = @2
          (i32.eqz
            (if (result i32)  ;; label = @3
              (i32.eq
                (call $~lib/rt/itcms/Object#get:prev
                  (local.get $this))
                (i32.const 0))
              (then
                (i32.lt_u
                  (local.get $this)
                  (global.get $~lib/memory/__heap_base)))
              (else
                (i32.const 0))))
          (then
            (call $~lib/wasi_internal/wasi_abort
              (i32.const 0)
              (i32.const 400)
              (i32.const 128)
              (i32.const 18))
            (unreachable)))
        (return)))
    (local.set $prev
      (call $~lib/rt/itcms/Object#get:prev
        (local.get $this)))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (local.get $prev))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 400)
          (i32.const 132)
          (i32.const 16))
        (unreachable)))
    (call $~lib/rt/itcms/Object#set:prev
      (local.get $next)
      (local.get $prev))
    (call $~lib/rt/itcms/Object#set:next
      (local.get $prev)
      (local.get $next)))
  (func $~lib/rt/itcms/Object#get:rtId (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/shared/typeinfo/Typeinfo#get:flags (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/rt/__typeinfo (type 1) (param $id i32) (result i32)
    (local $ptr i32)
    (local.set $ptr
      (global.get $~lib/rt/__rtti_base))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $id)
        (i32.load
          (local.get $ptr)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 528)
          (i32.const 592)
          (i32.const 21)
          (i32.const 28))
        (unreachable)))
    (return
      (call $~lib/shared/typeinfo/Typeinfo#get:flags
        (i32.add
          (i32.add
            (local.get $ptr)
            (i32.const 4))
          (i32.mul
            (local.get $id)
            (i32.const 4))))))
  (func $~lib/rt/itcms/Object#get:isPointerfree (type 1) (param $this i32) (result i32)
    (local $rtId i32)
    (local.set $rtId
      (call $~lib/rt/itcms/Object#get:rtId
        (local.get $this)))
    (return
      (if (result i32)  ;; label = @1
        (i32.le_u
          (local.get $rtId)
          (i32.const 2))
        (then
          (i32.const 1))
        (else
          (i32.ne
            (i32.and
              (call $~lib/rt/__typeinfo
                (local.get $rtId))
              (i32.const 32))
            (i32.const 0))))))
  (func $~lib/rt/itcms/Object#linkTo (type 7) (param $this i32) (param $list i32) (param $withColor i32)
    (local $prev i32)
    (local.set $prev
      (call $~lib/rt/itcms/Object#get:prev
        (local.get $list)))
    (call $~lib/rt/itcms/Object#set:nextWithColor
      (local.get $this)
      (i32.or
        (local.get $list)
        (local.get $withColor)))
    (call $~lib/rt/itcms/Object#set:prev
      (local.get $this)
      (local.get $prev))
    (call $~lib/rt/itcms/Object#set:next
      (local.get $prev)
      (local.get $this))
    (call $~lib/rt/itcms/Object#set:prev
      (local.get $list)
      (local.get $this)))
  (func $~lib/rt/itcms/Object#makeGray (type 6) (param $this i32)
    (local $1 i32)
    (if  ;; label = @1
      (i32.eq
        (local.get $this)
        (global.get $~lib/rt/itcms/iter))
      (then
        (global.set $~lib/rt/itcms/iter
          (if (result i32)  ;; label = @2
            (i32.eqz
              (local.tee $1
                (call $~lib/rt/itcms/Object#get:prev
                  (local.get $this))))
            (then
              (call $~lib/wasi_internal/wasi_abort
                (i32.const 0)
                (i32.const 400)
                (i32.const 148)
                (i32.const 30))
              (unreachable))
            (else
              (local.get $1))))))
    (call $~lib/rt/itcms/Object#unlink
      (local.get $this))
    (call $~lib/rt/itcms/Object#linkTo
      (local.get $this)
      (global.get $~lib/rt/itcms/toSpace)
      (if (result i32)  ;; label = @1
        (call $~lib/rt/itcms/Object#get:isPointerfree
          (local.get $this))
        (then
          (i32.eqz
            (global.get $~lib/rt/itcms/white)))
        (else
          (i32.const 2)))))
  (func $~lib/rt/itcms/__visit (type 0) (param $ptr i32) (param $cookie i32)
    (local $obj i32)
    (if  ;; label = @1
      (i32.eqz
        (local.get $ptr))
      (then
        (return)))
    (local.set $obj
      (i32.sub
        (local.get $ptr)
        (i32.const 20)))
    (drop
      (i32.const 0))
    (if  ;; label = @1
      (i32.eq
        (call $~lib/rt/itcms/Object#get:color
          (local.get $obj))
        (global.get $~lib/rt/itcms/white))
      (then
        (call $~lib/rt/itcms/Object#makeGray
          (local.get $obj))
        (global.set $~lib/rt/itcms/visitCount
          (i32.add
            (global.get $~lib/rt/itcms/visitCount)
            (i32.const 1))))))
  (func $~lib/rt/itcms/visitStack (type 6) (param $cookie i32)
    (local $ptr i32)
    (local.set $ptr
      (global.get $~lib/memory/__stack_pointer))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $ptr)
            (global.get $~lib/memory/__heap_base))
          (then
            (call $~lib/rt/itcms/__visit
              (i32.load
                (local.get $ptr))
              (local.get $cookie))
            (local.set $ptr
              (i32.add
                (local.get $ptr)
                (i32.const 4)))
            (br 1 (;@2;)))))))
  (func $~lib/rt/common/BLOCK#get:mmInfo (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/rt/itcms/Object#get:size (type 1) (param $this i32) (result i32)
    (return
      (i32.add
        (i32.const 4)
        (i32.and
          (call $~lib/rt/common/BLOCK#get:mmInfo
            (local.get $this))
          (i32.xor
            (i32.const 3)
            (i32.const -1))))))
  (func $~lib/rt/tlsf/Root#set:flMap (type 0) (param $this i32) (param $flMap i32)
    (i32.store
      (local.get $this)
      (local.get $flMap)))
  (func $~lib/rt/common/BLOCK#set:mmInfo (type 0) (param $this i32) (param $mmInfo i32)
    (i32.store
      (local.get $this)
      (local.get $mmInfo)))
  (func $~lib/rt/tlsf/Block#set:prev (type 0) (param $this i32) (param $prev i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $prev)))
  (func $~lib/rt/tlsf/Block#set:next (type 0) (param $this i32) (param $next i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $next)))
  (func $~lib/rt/tlsf/Block#get:prev (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/rt/tlsf/Block#get:next (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/rt/tlsf/Root#get:flMap (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/rt/tlsf/removeBlock (type 0) (param $root i32) (param $block i32)
    (local $blockInfo i32) (local $size i32) (local $fl i32) (local $sl i32) (local $6 i32) (local $7 i32) (local $boundedSize i32) (local $prev i32) (local $next i32) (local $root|11 i32) (local $fl|12 i32) (local $sl|13 i32) (local $root|14 i32) (local $fl|15 i32) (local $sl|16 i32) (local $head i32) (local $root|18 i32) (local $fl|19 i32) (local $slMap i32) (local $root|21 i32) (local $fl|22 i32) (local $slMap|23 i32)
    (local.set $blockInfo
      (call $~lib/rt/common/BLOCK#get:mmInfo
        (local.get $block)))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (i32.and
          (local.get $blockInfo)
          (i32.const 1)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 268)
          (i32.const 14))
        (unreachable)))
    (local.set $size
      (i32.and
        (local.get $blockInfo)
        (i32.xor
          (i32.const 3)
          (i32.const -1))))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (i32.ge_u
          (local.get $size)
          (i32.const 12)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 270)
          (i32.const 14))
        (unreachable)))
    (if  ;; label = @1
      (i32.lt_u
        (local.get $size)
        (i32.const 256))
      (then
        (local.set $fl
          (i32.const 0))
        (local.set $sl
          (i32.shr_u
            (local.get $size)
            (i32.const 4))))
      (else
        (local.set $boundedSize
          (select
            (local.tee $6
              (local.get $size))
            (local.tee $7
              (i32.const 1073741820))
            (i32.lt_u
              (local.get $6)
              (local.get $7))))
        (local.set $fl
          (i32.sub
            (i32.const 31)
            (i32.clz
              (local.get $boundedSize))))
        (local.set $sl
          (i32.xor
            (i32.shr_u
              (local.get $boundedSize)
              (i32.sub
                (local.get $fl)
                (i32.const 4)))
            (i32.shl
              (i32.const 1)
              (i32.const 4))))
        (local.set $fl
          (i32.sub
            (local.get $fl)
            (i32.sub
              (i32.const 8)
              (i32.const 1))))))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (if (result i32)  ;; label = @2
          (i32.lt_u
            (local.get $fl)
            (i32.const 23))
          (then
            (i32.lt_u
              (local.get $sl)
              (i32.const 16)))
          (else
            (i32.const 0))))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 284)
          (i32.const 14))
        (unreachable)))
    (local.set $prev
      (call $~lib/rt/tlsf/Block#get:prev
        (local.get $block)))
    (local.set $next
      (call $~lib/rt/tlsf/Block#get:next
        (local.get $block)))
    (if  ;; label = @1
      (local.get $prev)
      (then
        (call $~lib/rt/tlsf/Block#set:next
          (local.get $prev)
          (local.get $next))))
    (if  ;; label = @1
      (local.get $next)
      (then
        (call $~lib/rt/tlsf/Block#set:prev
          (local.get $next)
          (local.get $prev))))
    (if  ;; label = @1
      (i32.eq
        (local.get $block)
        (block (result i32)  ;; label = @2
          (local.set $root|11
            (local.get $root))
          (local.set $fl|12
            (local.get $fl))
          (local.set $sl|13
            (local.get $sl))
          (br 0 (;@2;)
            (i32.load offset=96
              (i32.add
                (local.get $root|11)
                (i32.shl
                  (i32.add
                    (i32.shl
                      (local.get $fl|12)
                      (i32.const 4))
                    (local.get $sl|13))
                  (i32.const 2)))))))
      (then
        (block  ;; label = @2
          (local.set $root|14
            (local.get $root))
          (local.set $fl|15
            (local.get $fl))
          (local.set $sl|16
            (local.get $sl))
          (local.set $head
            (local.get $next))
          (i32.store offset=96
            (i32.add
              (local.get $root|14)
              (i32.shl
                (i32.add
                  (i32.shl
                    (local.get $fl|15)
                    (i32.const 4))
                  (local.get $sl|16))
                (i32.const 2)))
            (local.get $head)))
        (if  ;; label = @2
          (i32.eqz
            (local.get $next))
          (then
            (local.set $slMap
              (block (result i32)  ;; label = @3
                (local.set $root|18
                  (local.get $root))
                (local.set $fl|19
                  (local.get $fl))
                (br 0 (;@3;)
                  (i32.load offset=4
                    (i32.add
                      (local.get $root|18)
                      (i32.shl
                        (local.get $fl|19)
                        (i32.const 2)))))))
            (block  ;; label = @3
              (local.set $root|21
                (local.get $root))
              (local.set $fl|22
                (local.get $fl))
              (local.set $slMap|23
                (local.tee $slMap
                  (i32.and
                    (local.get $slMap)
                    (i32.xor
                      (i32.shl
                        (i32.const 1)
                        (local.get $sl))
                      (i32.const -1)))))
              (i32.store offset=4
                (i32.add
                  (local.get $root|21)
                  (i32.shl
                    (local.get $fl|22)
                    (i32.const 2)))
                (local.get $slMap|23)))
            (if  ;; label = @3
              (i32.eqz
                (local.get $slMap))
              (then
                (call $~lib/rt/tlsf/Root#set:flMap
                  (local.get $root)
                  (i32.and
                    (call $~lib/rt/tlsf/Root#get:flMap
                      (local.get $root))
                    (i32.xor
                      (i32.shl
                        (i32.const 1)
                        (local.get $fl))
                      (i32.const -1)))))))))))
  (func $~lib/rt/tlsf/insertBlock (type 0) (param $root i32) (param $block i32)
    (local $blockInfo i32) (local $block|3 i32) (local $right i32) (local $rightInfo i32) (local $block|6 i32) (local $block|7 i32) (local $left i32) (local $leftInfo i32) (local $size i32) (local $fl i32) (local $sl i32) (local $13 i32) (local $14 i32) (local $boundedSize i32) (local $root|16 i32) (local $fl|17 i32) (local $sl|18 i32) (local $head i32) (local $root|20 i32) (local $fl|21 i32) (local $sl|22 i32) (local $head|23 i32) (local $root|24 i32) (local $fl|25 i32) (local $root|26 i32) (local $fl|27 i32) (local $slMap i32)
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (local.get $block))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 201)
          (i32.const 14))
        (unreachable)))
    (local.set $blockInfo
      (call $~lib/rt/common/BLOCK#get:mmInfo
        (local.get $block)))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (i32.and
          (local.get $blockInfo)
          (i32.const 1)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 203)
          (i32.const 14))
        (unreachable)))
    (local.set $right
      (block (result i32)  ;; label = @1
        (local.set $block|3
          (local.get $block))
        (br 0 (;@1;)
          (i32.add
            (i32.add
              (local.get $block|3)
              (i32.const 4))
            (i32.and
              (call $~lib/rt/common/BLOCK#get:mmInfo
                (local.get $block|3))
              (i32.xor
                (i32.const 3)
                (i32.const -1)))))))
    (local.set $rightInfo
      (call $~lib/rt/common/BLOCK#get:mmInfo
        (local.get $right)))
    (if  ;; label = @1
      (i32.and
        (local.get $rightInfo)
        (i32.const 1))
      (then
        (call $~lib/rt/tlsf/removeBlock
          (local.get $root)
          (local.get $right))
        (call $~lib/rt/common/BLOCK#set:mmInfo
          (local.get $block)
          (local.tee $blockInfo
            (i32.add
              (i32.add
                (local.get $blockInfo)
                (i32.const 4))
              (i32.and
                (local.get $rightInfo)
                (i32.xor
                  (i32.const 3)
                  (i32.const -1))))))
        (local.set $right
          (block (result i32)  ;; label = @2
            (local.set $block|6
              (local.get $block))
            (br 0 (;@2;)
              (i32.add
                (i32.add
                  (local.get $block|6)
                  (i32.const 4))
                (i32.and
                  (call $~lib/rt/common/BLOCK#get:mmInfo
                    (local.get $block|6))
                  (i32.xor
                    (i32.const 3)
                    (i32.const -1)))))))
        (local.set $rightInfo
          (call $~lib/rt/common/BLOCK#get:mmInfo
            (local.get $right)))))
    (if  ;; label = @1
      (i32.and
        (local.get $blockInfo)
        (i32.const 2))
      (then
        (local.set $left
          (block (result i32)  ;; label = @2
            (local.set $block|7
              (local.get $block))
            (br 0 (;@2;)
              (i32.load
                (i32.sub
                  (local.get $block|7)
                  (i32.const 4))))))
        (local.set $leftInfo
          (call $~lib/rt/common/BLOCK#get:mmInfo
            (local.get $left)))
        (drop
          (i32.const 1))
        (if  ;; label = @2
          (i32.eqz
            (i32.and
              (local.get $leftInfo)
              (i32.const 1)))
          (then
            (call $~lib/wasi_internal/wasi_abort
              (i32.const 0)
              (i32.const 672)
              (i32.const 221)
              (i32.const 16))
            (unreachable)))
        (call $~lib/rt/tlsf/removeBlock
          (local.get $root)
          (local.get $left))
        (local.set $block
          (local.get $left))
        (call $~lib/rt/common/BLOCK#set:mmInfo
          (local.get $block)
          (local.tee $blockInfo
            (i32.add
              (i32.add
                (local.get $leftInfo)
                (i32.const 4))
              (i32.and
                (local.get $blockInfo)
                (i32.xor
                  (i32.const 3)
                  (i32.const -1))))))))
    (call $~lib/rt/common/BLOCK#set:mmInfo
      (local.get $right)
      (i32.or
        (local.get $rightInfo)
        (i32.const 2)))
    (local.set $size
      (i32.and
        (local.get $blockInfo)
        (i32.xor
          (i32.const 3)
          (i32.const -1))))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (i32.ge_u
          (local.get $size)
          (i32.const 12)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 233)
          (i32.const 14))
        (unreachable)))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (i32.eq
          (i32.add
            (i32.add
              (local.get $block)
              (i32.const 4))
            (local.get $size))
          (local.get $right)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 234)
          (i32.const 14))
        (unreachable)))
    (i32.store
      (i32.sub
        (local.get $right)
        (i32.const 4))
      (local.get $block))
    (if  ;; label = @1
      (i32.lt_u
        (local.get $size)
        (i32.const 256))
      (then
        (local.set $fl
          (i32.const 0))
        (local.set $sl
          (i32.shr_u
            (local.get $size)
            (i32.const 4))))
      (else
        (local.set $boundedSize
          (select
            (local.tee $13
              (local.get $size))
            (local.tee $14
              (i32.const 1073741820))
            (i32.lt_u
              (local.get $13)
              (local.get $14))))
        (local.set $fl
          (i32.sub
            (i32.const 31)
            (i32.clz
              (local.get $boundedSize))))
        (local.set $sl
          (i32.xor
            (i32.shr_u
              (local.get $boundedSize)
              (i32.sub
                (local.get $fl)
                (i32.const 4)))
            (i32.shl
              (i32.const 1)
              (i32.const 4))))
        (local.set $fl
          (i32.sub
            (local.get $fl)
            (i32.sub
              (i32.const 8)
              (i32.const 1))))))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (if (result i32)  ;; label = @2
          (i32.lt_u
            (local.get $fl)
            (i32.const 23))
          (then
            (i32.lt_u
              (local.get $sl)
              (i32.const 16)))
          (else
            (i32.const 0))))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 251)
          (i32.const 14))
        (unreachable)))
    (local.set $head
      (block (result i32)  ;; label = @1
        (local.set $root|16
          (local.get $root))
        (local.set $fl|17
          (local.get $fl))
        (local.set $sl|18
          (local.get $sl))
        (br 0 (;@1;)
          (i32.load offset=96
            (i32.add
              (local.get $root|16)
              (i32.shl
                (i32.add
                  (i32.shl
                    (local.get $fl|17)
                    (i32.const 4))
                  (local.get $sl|18))
                (i32.const 2)))))))
    (call $~lib/rt/tlsf/Block#set:prev
      (local.get $block)
      (i32.const 0))
    (call $~lib/rt/tlsf/Block#set:next
      (local.get $block)
      (local.get $head))
    (if  ;; label = @1
      (local.get $head)
      (then
        (call $~lib/rt/tlsf/Block#set:prev
          (local.get $head)
          (local.get $block))))
    (block  ;; label = @1
      (local.set $root|20
        (local.get $root))
      (local.set $fl|21
        (local.get $fl))
      (local.set $sl|22
        (local.get $sl))
      (local.set $head|23
        (local.get $block))
      (i32.store offset=96
        (i32.add
          (local.get $root|20)
          (i32.shl
            (i32.add
              (i32.shl
                (local.get $fl|21)
                (i32.const 4))
              (local.get $sl|22))
            (i32.const 2)))
        (local.get $head|23)))
    (call $~lib/rt/tlsf/Root#set:flMap
      (local.get $root)
      (i32.or
        (call $~lib/rt/tlsf/Root#get:flMap
          (local.get $root))
        (i32.shl
          (i32.const 1)
          (local.get $fl))))
    (block  ;; label = @1
      (local.set $root|26
        (local.get $root))
      (local.set $fl|27
        (local.get $fl))
      (local.set $slMap
        (i32.or
          (block (result i32)  ;; label = @2
            (local.set $root|24
              (local.get $root))
            (local.set $fl|25
              (local.get $fl))
            (br 0 (;@2;)
              (i32.load offset=4
                (i32.add
                  (local.get $root|24)
                  (i32.shl
                    (local.get $fl|25)
                    (i32.const 2))))))
          (i32.shl
            (i32.const 1)
            (local.get $sl))))
      (i32.store offset=4
        (i32.add
          (local.get $root|26)
          (i32.shl
            (local.get $fl|27)
            (i32.const 2)))
        (local.get $slMap))))
  (func $~lib/rt/tlsf/addMemory (type 18) (param $root i32) (param $start i32) (param $endU64 i64) (result i32)
    (local $end i32) (local $root|4 i32) (local $tail i32) (local $tailInfo i32) (local $size i32) (local $leftSize i32) (local $left i32) (local $root|10 i32) (local $tail|11 i32)
    (local.set $end
      (i32.wrap_i64
        (local.get $endU64)))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (i64.le_u
          (i64.extend_i32_u
            (local.get $start))
          (local.get $endU64)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 382)
          (i32.const 14))
        (unreachable)))
    (local.set $start
      (i32.sub
        (i32.and
          (i32.add
            (i32.add
              (local.get $start)
              (i32.const 4))
            (i32.const 15))
          (i32.xor
            (i32.const 15)
            (i32.const -1)))
        (i32.const 4)))
    (local.set $end
      (i32.and
        (local.get $end)
        (i32.xor
          (i32.const 15)
          (i32.const -1))))
    (local.set $tail
      (block (result i32)  ;; label = @1
        (local.set $root|4
          (local.get $root))
        (br 0 (;@1;)
          (i32.load offset=1568
            (local.get $root|4)))))
    (local.set $tailInfo
      (i32.const 0))
    (if  ;; label = @1
      (local.get $tail)
      (then
        (drop
          (i32.const 1))
        (if  ;; label = @2
          (i32.eqz
            (i32.ge_u
              (local.get $start)
              (i32.add
                (local.get $tail)
                (i32.const 4))))
          (then
            (call $~lib/wasi_internal/wasi_abort
              (i32.const 0)
              (i32.const 672)
              (i32.const 389)
              (i32.const 16))
            (unreachable)))
        (if  ;; label = @2
          (i32.eq
            (i32.sub
              (local.get $start)
              (i32.const 16))
            (local.get $tail))
          (then
            (local.set $start
              (i32.sub
                (local.get $start)
                (i32.const 16)))
            (local.set $tailInfo
              (call $~lib/rt/common/BLOCK#get:mmInfo
                (local.get $tail))))
          (else
            (nop))))
      (else
        (drop
          (i32.const 1))
        (if  ;; label = @2
          (i32.eqz
            (i32.ge_u
              (local.get $start)
              (i32.add
                (local.get $root)
                (i32.const 1572))))
          (then
            (call $~lib/wasi_internal/wasi_abort
              (i32.const 0)
              (i32.const 672)
              (i32.const 402)
              (i32.const 5))
            (unreachable)))))
    (local.set $size
      (i32.sub
        (local.get $end)
        (local.get $start)))
    (if  ;; label = @1
      (i32.lt_u
        (local.get $size)
        (i32.add
          (i32.add
            (i32.const 4)
            (i32.const 12))
          (i32.const 4)))
      (then
        (return
          (i32.const 0))))
    (local.set $leftSize
      (i32.sub
        (local.get $size)
        (i32.mul
          (i32.const 2)
          (i32.const 4))))
    (local.set $left
      (local.get $start))
    (call $~lib/rt/common/BLOCK#set:mmInfo
      (local.get $left)
      (i32.or
        (i32.or
          (local.get $leftSize)
          (i32.const 1))
        (i32.and
          (local.get $tailInfo)
          (i32.const 2))))
    (call $~lib/rt/tlsf/Block#set:prev
      (local.get $left)
      (i32.const 0))
    (call $~lib/rt/tlsf/Block#set:next
      (local.get $left)
      (i32.const 0))
    (local.set $tail
      (i32.add
        (i32.add
          (local.get $start)
          (i32.const 4))
        (local.get $leftSize)))
    (call $~lib/rt/common/BLOCK#set:mmInfo
      (local.get $tail)
      (i32.or
        (i32.const 0)
        (i32.const 2)))
    (block  ;; label = @1
      (local.set $root|10
        (local.get $root))
      (local.set $tail|11
        (local.get $tail))
      (i32.store offset=1568
        (local.get $root|10)
        (local.get $tail|11)))
    (call $~lib/rt/tlsf/insertBlock
      (local.get $root)
      (local.get $left))
    (return
      (i32.const 1)))
  (func $~lib/rt/tlsf/initialize (type 8)
    (local $rootOffset i32) (local $pagesBefore i32) (local $pagesNeeded i32) (local $root i32) (local $root|4 i32) (local $tail i32) (local $fl i32) (local $root|7 i32) (local $fl|8 i32) (local $slMap i32) (local $sl i32) (local $root|11 i32) (local $fl|12 i32) (local $sl|13 i32) (local $head i32) (local $memStart i32)
    (drop
      (i32.const 0))
    (local.set $rootOffset
      (i32.and
        (i32.add
          (global.get $~lib/memory/__heap_base)
          (i32.const 15))
        (i32.xor
          (i32.const 15)
          (i32.const -1))))
    (local.set $pagesBefore
      (memory.size))
    (local.set $pagesNeeded
      (i32.shr_u
        (i32.and
          (i32.add
            (i32.add
              (local.get $rootOffset)
              (i32.const 1572))
            (i32.const 65535))
          (i32.xor
            (i32.const 65535)
            (i32.const -1)))
        (i32.const 16)))
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.gt_s
          (local.get $pagesNeeded)
          (local.get $pagesBefore))
        (then
          (i32.lt_s
            (memory.grow
              (i32.sub
                (local.get $pagesNeeded)
                (local.get $pagesBefore)))
            (i32.const 0)))
        (else
          (i32.const 0)))
      (then
        (unreachable)))
    (local.set $root
      (local.get $rootOffset))
    (call $~lib/rt/tlsf/Root#set:flMap
      (local.get $root)
      (i32.const 0))
    (block  ;; label = @1
      (local.set $root|4
        (local.get $root))
      (local.set $tail
        (i32.const 0))
      (i32.store offset=1568
        (local.get $root|4)
        (local.get $tail)))
    (local.set $fl
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_u
          (local.get $fl)
          (i32.const 23))
        (then
          (block  ;; label = @3
            (local.set $root|7
              (local.get $root))
            (local.set $fl|8
              (local.get $fl))
            (local.set $slMap
              (i32.const 0))
            (i32.store offset=4
              (i32.add
                (local.get $root|7)
                (i32.shl
                  (local.get $fl|8)
                  (i32.const 2)))
              (local.get $slMap)))
          (local.set $sl
            (i32.const 0))
          (loop  ;; label = @3
            (if  ;; label = @4
              (i32.lt_u
                (local.get $sl)
                (i32.const 16))
              (then
                (block  ;; label = @5
                  (local.set $root|11
                    (local.get $root))
                  (local.set $fl|12
                    (local.get $fl))
                  (local.set $sl|13
                    (local.get $sl))
                  (local.set $head
                    (i32.const 0))
                  (i32.store offset=96
                    (i32.add
                      (local.get $root|11)
                      (i32.shl
                        (i32.add
                          (i32.shl
                            (local.get $fl|12)
                            (i32.const 4))
                          (local.get $sl|13))
                        (i32.const 2)))
                    (local.get $head)))
                (local.set $sl
                  (i32.add
                    (local.get $sl)
                    (i32.const 1)))
                (br 1 (;@3;)))))
          (local.set $fl
            (i32.add
              (local.get $fl)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $memStart
      (i32.add
        (local.get $rootOffset)
        (i32.const 1572)))
    (drop
      (i32.const 0))
    (drop
      (call $~lib/rt/tlsf/addMemory
        (local.get $root)
        (local.get $memStart)
        (i64.shl
          (i64.extend_i32_s
            (memory.size))
          (i64.const 16))))
    (global.set $~lib/rt/tlsf/ROOT
      (local.get $root)))
  (func $~lib/rt/tlsf/checkUsedBlock (type 1) (param $ptr i32) (result i32)
    (local $block i32)
    (local.set $block
      (i32.sub
        (local.get $ptr)
        (i32.const 4)))
    (if  ;; label = @1
      (i32.eqz
        (if (result i32)  ;; label = @2
          (if (result i32)  ;; label = @3
            (i32.ne
              (local.get $ptr)
              (i32.const 0))
            (then
              (i32.eqz
                (i32.and
                  (local.get $ptr)
                  (i32.const 15))))
            (else
              (i32.const 0)))
          (then
            (i32.eqz
              (i32.and
                (call $~lib/rt/common/BLOCK#get:mmInfo
                  (local.get $block))
                (i32.const 1))))
          (else
            (i32.const 0))))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 562)
          (i32.const 3))
        (unreachable)))
    (return
      (local.get $block)))
  (func $~lib/rt/tlsf/freeBlock (type 0) (param $root i32) (param $block i32)
    (drop
      (i32.const 0))
    (call $~lib/rt/common/BLOCK#set:mmInfo
      (local.get $block)
      (i32.or
        (call $~lib/rt/common/BLOCK#get:mmInfo
          (local.get $block))
        (i32.const 1)))
    (call $~lib/rt/tlsf/insertBlock
      (local.get $root)
      (local.get $block)))
  (func $~lib/rt/tlsf/__free (type 6) (param $ptr i32)
    (if  ;; label = @1
      (i32.lt_u
        (local.get $ptr)
        (global.get $~lib/memory/__heap_base))
      (then
        (return)))
    (if  ;; label = @1
      (i32.eqz
        (global.get $~lib/rt/tlsf/ROOT))
      (then
        (call $~lib/rt/tlsf/initialize)))
    (call $~lib/rt/tlsf/freeBlock
      (global.get $~lib/rt/tlsf/ROOT)
      (call $~lib/rt/tlsf/checkUsedBlock
        (local.get $ptr))))
  (func $~lib/rt/itcms/free (type 6) (param $obj i32)
    (if  ;; label = @1
      (i32.lt_u
        (local.get $obj)
        (global.get $~lib/memory/__heap_base))
      (then
        (call $~lib/rt/itcms/Object#set:nextWithColor
          (local.get $obj)
          (i32.const 0))
        (call $~lib/rt/itcms/Object#set:prev
          (local.get $obj)
          (i32.const 0)))
      (else
        (global.set $~lib/rt/itcms/total
          (i32.sub
            (global.get $~lib/rt/itcms/total)
            (call $~lib/rt/itcms/Object#get:size
              (local.get $obj))))
        (drop
          (i32.const 0))
        (call $~lib/rt/tlsf/__free
          (i32.add
            (local.get $obj)
            (i32.const 4))))))
  (func $~lib/rt/itcms/step (type 19) (result i32)
    (local $obj i32) (local $1 i32) (local $black i32) (local $from i32)
    (block  ;; label = @1
      (block  ;; label = @2
        (block  ;; label = @3
          (block  ;; label = @4
            (local.set $1
              (global.get $~lib/rt/itcms/state))
            (br_if 0 (;@4;)
              (i32.eq
                (local.get $1)
                (i32.const 0)))
            (br_if 1 (;@3;)
              (i32.eq
                (local.get $1)
                (i32.const 1)))
            (br_if 2 (;@2;)
              (i32.eq
                (local.get $1)
                (i32.const 2)))
            (br 3 (;@1;)))
          (global.set $~lib/rt/itcms/state
            (i32.const 1))
          (global.set $~lib/rt/itcms/visitCount
            (i32.const 0))
          (call $~lib/rt/itcms/visitRoots
            (i32.const 0))
          (global.set $~lib/rt/itcms/iter
            (global.get $~lib/rt/itcms/toSpace))
          (return
            (i32.mul
              (global.get $~lib/rt/itcms/visitCount)
              (i32.const 1))))
        (local.set $black
          (i32.eqz
            (global.get $~lib/rt/itcms/white)))
        (local.set $obj
          (call $~lib/rt/itcms/Object#get:next
            (global.get $~lib/rt/itcms/iter)))
        (block  ;; label = @3
          (loop  ;; label = @4
            (if  ;; label = @5
              (i32.ne
                (local.get $obj)
                (global.get $~lib/rt/itcms/toSpace))
              (then
                (global.set $~lib/rt/itcms/iter
                  (local.get $obj))
                (if  ;; label = @6
                  (i32.ne
                    (call $~lib/rt/itcms/Object#get:color
                      (local.get $obj))
                    (local.get $black))
                  (then
                    (call $~lib/rt/itcms/Object#set:color
                      (local.get $obj)
                      (local.get $black))
                    (global.set $~lib/rt/itcms/visitCount
                      (i32.const 0))
                    (call $~lib/rt/__visit_members
                      (i32.add
                        (local.get $obj)
                        (i32.const 20))
                      (i32.const 0))
                    (return
                      (i32.mul
                        (global.get $~lib/rt/itcms/visitCount)
                        (i32.const 1)))))
                (local.set $obj
                  (call $~lib/rt/itcms/Object#get:next
                    (local.get $obj)))
                (br 1 (;@4;))))))
        (global.set $~lib/rt/itcms/visitCount
          (i32.const 0))
        (call $~lib/rt/itcms/visitRoots
          (i32.const 0))
        (local.set $obj
          (call $~lib/rt/itcms/Object#get:next
            (global.get $~lib/rt/itcms/iter)))
        (if  ;; label = @3
          (i32.eq
            (local.get $obj)
            (global.get $~lib/rt/itcms/toSpace))
          (then
            (call $~lib/rt/itcms/visitStack
              (i32.const 0))
            (local.set $obj
              (call $~lib/rt/itcms/Object#get:next
                (global.get $~lib/rt/itcms/iter)))
            (block  ;; label = @4
              (loop  ;; label = @5
                (if  ;; label = @6
                  (i32.ne
                    (local.get $obj)
                    (global.get $~lib/rt/itcms/toSpace))
                  (then
                    (if  ;; label = @7
                      (i32.ne
                        (call $~lib/rt/itcms/Object#get:color
                          (local.get $obj))
                        (local.get $black))
                      (then
                        (call $~lib/rt/itcms/Object#set:color
                          (local.get $obj)
                          (local.get $black))
                        (call $~lib/rt/__visit_members
                          (i32.add
                            (local.get $obj)
                            (i32.const 20))
                          (i32.const 0))))
                    (local.set $obj
                      (call $~lib/rt/itcms/Object#get:next
                        (local.get $obj)))
                    (br 1 (;@5;))))))
            (local.set $from
              (global.get $~lib/rt/itcms/fromSpace))
            (global.set $~lib/rt/itcms/fromSpace
              (global.get $~lib/rt/itcms/toSpace))
            (global.set $~lib/rt/itcms/toSpace
              (local.get $from))
            (global.set $~lib/rt/itcms/white
              (local.get $black))
            (global.set $~lib/rt/itcms/iter
              (call $~lib/rt/itcms/Object#get:next
                (local.get $from)))
            (global.set $~lib/rt/itcms/state
              (i32.const 2))))
        (return
          (i32.mul
            (global.get $~lib/rt/itcms/visitCount)
            (i32.const 1))))
      (local.set $obj
        (global.get $~lib/rt/itcms/iter))
      (if  ;; label = @2
        (i32.ne
          (local.get $obj)
          (global.get $~lib/rt/itcms/toSpace))
        (then
          (global.set $~lib/rt/itcms/iter
            (call $~lib/rt/itcms/Object#get:next
              (local.get $obj)))
          (drop
            (i32.const 1))
          (if  ;; label = @3
            (i32.eqz
              (i32.eq
                (call $~lib/rt/itcms/Object#get:color
                  (local.get $obj))
                (i32.eqz
                  (global.get $~lib/rt/itcms/white))))
            (then
              (call $~lib/wasi_internal/wasi_abort
                (i32.const 0)
                (i32.const 400)
                (i32.const 229)
                (i32.const 20))
              (unreachable)))
          (call $~lib/rt/itcms/free
            (local.get $obj))
          (return
            (i32.const 10))))
      (call $~lib/rt/itcms/Object#set:nextWithColor
        (global.get $~lib/rt/itcms/toSpace)
        (global.get $~lib/rt/itcms/toSpace))
      (call $~lib/rt/itcms/Object#set:prev
        (global.get $~lib/rt/itcms/toSpace)
        (global.get $~lib/rt/itcms/toSpace))
      (global.set $~lib/rt/itcms/state
        (i32.const 0))
      (br 0 (;@1;)))
    (return
      (i32.const 0)))
  (func $~lib/rt/itcms/interrupt (type 8)
    (local $budget i32)
    (drop
      (i32.const 0))
    (drop
      (i32.const 0))
    (local.set $budget
      (i32.div_u
        (i32.mul
          (i32.const 1024)
          (i32.const 200))
        (i32.const 100)))
    (loop  ;; label = @1
      (local.set $budget
        (i32.sub
          (local.get $budget)
          (call $~lib/rt/itcms/step)))
      (if  ;; label = @2
        (i32.eq
          (global.get $~lib/rt/itcms/state)
          (i32.const 0))
        (then
          (drop
            (i32.const 0))
          (global.set $~lib/rt/itcms/threshold
            (i32.add
              (i32.wrap_i64
                (i64.div_u
                  (i64.mul
                    (i64.extend_i32_u
                      (global.get $~lib/rt/itcms/total))
                    (i64.extend_i32_u
                      (i32.const 200)))
                  (i64.const 100)))
              (i32.const 1024)))
          (drop
            (i32.const 0))
          (return)))
      (br_if 0 (;@1;)
        (i32.gt_s
          (local.get $budget)
          (i32.const 0))))
    (drop
      (i32.const 0))
    (global.set $~lib/rt/itcms/threshold
      (i32.add
        (global.get $~lib/rt/itcms/total)
        (i32.mul
          (i32.const 1024)
          (i32.lt_u
            (i32.sub
              (global.get $~lib/rt/itcms/total)
              (global.get $~lib/rt/itcms/threshold))
            (i32.const 1024)))))
    (drop
      (i32.const 0)))
  (func $~lib/rt/tlsf/computeSize (type 1) (param $size i32) (result i32)
    (return
      (if (result i32)  ;; label = @1
        (i32.le_u
          (local.get $size)
          (i32.const 12))
        (then
          (i32.const 12))
        (else
          (i32.sub
            (i32.and
              (i32.add
                (i32.add
                  (local.get $size)
                  (i32.const 4))
                (i32.const 15))
              (i32.xor
                (i32.const 15)
                (i32.const -1)))
            (i32.const 4))))))
  (func $~lib/rt/tlsf/prepareSize (type 1) (param $size i32) (result i32)
    (if  ;; label = @1
      (i32.gt_u
        (local.get $size)
        (i32.const 1073741820))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 336)
          (i32.const 672)
          (i32.const 461)
          (i32.const 29))
        (unreachable)))
    (return
      (call $~lib/rt/tlsf/computeSize
        (local.get $size))))
  (func $~lib/rt/tlsf/roundSize (type 1) (param $size i32) (result i32)
    (return
      (if (result i32)  ;; label = @1
        (i32.lt_u
          (local.get $size)
          (i32.const 536870910))
        (then
          (i32.sub
            (i32.add
              (local.get $size)
              (i32.shl
                (i32.const 1)
                (i32.sub
                  (i32.const 27)
                  (i32.clz
                    (local.get $size)))))
            (i32.const 1)))
        (else
          (local.get $size)))))
  (func $~lib/rt/tlsf/searchBlock (type 2) (param $root i32) (param $size i32) (result i32)
    (local $fl i32) (local $sl i32) (local $requestSize i32) (local $root|5 i32) (local $fl|6 i32) (local $slMap i32) (local $head i32) (local $flMap i32) (local $root|10 i32) (local $fl|11 i32) (local $root|12 i32) (local $fl|13 i32) (local $sl|14 i32) (local $root|15 i32) (local $fl|16 i32) (local $sl|17 i32)
    (if  ;; label = @1
      (i32.lt_u
        (local.get $size)
        (i32.const 256))
      (then
        (local.set $fl
          (i32.const 0))
        (local.set $sl
          (i32.shr_u
            (local.get $size)
            (i32.const 4))))
      (else
        (local.set $requestSize
          (call $~lib/rt/tlsf/roundSize
            (local.get $size)))
        (local.set $fl
          (i32.sub
            (i32.sub
              (i32.mul
                (i32.const 4)
                (i32.const 8))
              (i32.const 1))
            (i32.clz
              (local.get $requestSize))))
        (local.set $sl
          (i32.xor
            (i32.shr_u
              (local.get $requestSize)
              (i32.sub
                (local.get $fl)
                (i32.const 4)))
            (i32.shl
              (i32.const 1)
              (i32.const 4))))
        (local.set $fl
          (i32.sub
            (local.get $fl)
            (i32.sub
              (i32.const 8)
              (i32.const 1))))))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (if (result i32)  ;; label = @2
          (i32.lt_u
            (local.get $fl)
            (i32.const 23))
          (then
            (i32.lt_u
              (local.get $sl)
              (i32.const 16)))
          (else
            (i32.const 0))))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 334)
          (i32.const 14))
        (unreachable)))
    (local.set $slMap
      (i32.and
        (block (result i32)  ;; label = @1
          (local.set $root|5
            (local.get $root))
          (local.set $fl|6
            (local.get $fl))
          (br 0 (;@1;)
            (i32.load offset=4
              (i32.add
                (local.get $root|5)
                (i32.shl
                  (local.get $fl|6)
                  (i32.const 2))))))
        (i32.shl
          (i32.xor
            (i32.const 0)
            (i32.const -1))
          (local.get $sl))))
    (local.set $head
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $slMap))
      (then
        (local.set $flMap
          (i32.and
            (call $~lib/rt/tlsf/Root#get:flMap
              (local.get $root))
            (i32.shl
              (i32.xor
                (i32.const 0)
                (i32.const -1))
              (i32.add
                (local.get $fl)
                (i32.const 1)))))
        (if  ;; label = @2
          (i32.eqz
            (local.get $flMap))
          (then
            (local.set $head
              (i32.const 0)))
          (else
            (local.set $fl
              (i32.ctz
                (local.get $flMap)))
            (local.set $slMap
              (block (result i32)  ;; label = @3
                (local.set $root|10
                  (local.get $root))
                (local.set $fl|11
                  (local.get $fl))
                (br 0 (;@3;)
                  (i32.load offset=4
                    (i32.add
                      (local.get $root|10)
                      (i32.shl
                        (local.get $fl|11)
                        (i32.const 2)))))))
            (drop
              (i32.const 1))
            (if  ;; label = @3
              (i32.eqz
                (local.get $slMap))
              (then
                (call $~lib/wasi_internal/wasi_abort
                  (i32.const 0)
                  (i32.const 672)
                  (i32.const 347)
                  (i32.const 18))
                (unreachable)))
            (local.set $head
              (block (result i32)  ;; label = @3
                (local.set $root|12
                  (local.get $root))
                (local.set $fl|13
                  (local.get $fl))
                (local.set $sl|14
                  (i32.ctz
                    (local.get $slMap)))
                (br 0 (;@3;)
                  (i32.load offset=96
                    (i32.add
                      (local.get $root|12)
                      (i32.shl
                        (i32.add
                          (i32.shl
                            (local.get $fl|13)
                            (i32.const 4))
                          (local.get $sl|14))
                        (i32.const 2))))))))))
      (else
        (local.set $head
          (block (result i32)  ;; label = @2
            (local.set $root|15
              (local.get $root))
            (local.set $fl|16
              (local.get $fl))
            (local.set $sl|17
              (i32.ctz
                (local.get $slMap)))
            (br 0 (;@2;)
              (i32.load offset=96
                (i32.add
                  (local.get $root|15)
                  (i32.shl
                    (i32.add
                      (i32.shl
                        (local.get $fl|16)
                        (i32.const 4))
                      (local.get $sl|17))
                    (i32.const 2)))))))))
    (return
      (local.get $head)))
  (func $~lib/rt/tlsf/growMemory (type 0) (param $root i32) (param $size i32)
    (local $pagesBefore i32) (local $root|3 i32) (local $pagesNeeded i32) (local $5 i32) (local $6 i32) (local $pagesWanted i32) (local $pagesAfter i32)
    (drop
      (i32.const 0))
    (if  ;; label = @1
      (i32.ge_u
        (local.get $size)
        (i32.const 256))
      (then
        (local.set $size
          (call $~lib/rt/tlsf/roundSize
            (local.get $size)))))
    (local.set $pagesBefore
      (memory.size))
    (local.set $size
      (i32.add
        (local.get $size)
        (i32.shl
          (i32.const 4)
          (i32.ne
            (i32.sub
              (i32.shl
                (local.get $pagesBefore)
                (i32.const 16))
              (i32.const 4))
            (block (result i32)  ;; label = @1
              (local.set $root|3
                (local.get $root))
              (br 0 (;@1;)
                (i32.load offset=1568
                  (local.get $root|3))))))))
    (local.set $pagesNeeded
      (i32.shr_u
        (i32.and
          (i32.add
            (local.get $size)
            (i32.const 65535))
          (i32.xor
            (i32.const 65535)
            (i32.const -1)))
        (i32.const 16)))
    (local.set $pagesWanted
      (select
        (local.tee $5
          (local.get $pagesBefore))
        (local.tee $6
          (local.get $pagesNeeded))
        (i32.gt_s
          (local.get $5)
          (local.get $6))))
    (if  ;; label = @1
      (i32.lt_s
        (memory.grow
          (local.get $pagesWanted))
        (i32.const 0))
      (then
        (if  ;; label = @2
          (i32.lt_s
            (memory.grow
              (local.get $pagesNeeded))
            (i32.const 0))
          (then
            (unreachable)))))
    (local.set $pagesAfter
      (memory.size))
    (drop
      (call $~lib/rt/tlsf/addMemory
        (local.get $root)
        (i32.shl
          (local.get $pagesBefore)
          (i32.const 16))
        (i64.shl
          (i64.extend_i32_s
            (local.get $pagesAfter))
          (i64.const 16)))))
  (func $~lib/rt/tlsf/prepareBlock (type 7) (param $root i32) (param $block i32) (param $size i32)
    (local $blockInfo i32) (local $remaining i32) (local $spare i32) (local $block|6 i32) (local $block|7 i32)
    (local.set $blockInfo
      (call $~lib/rt/common/BLOCK#get:mmInfo
        (local.get $block)))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (i32.eqz
          (i32.and
            (i32.add
              (local.get $size)
              (i32.const 4))
            (i32.const 15))))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 361)
          (i32.const 14))
        (unreachable)))
    (local.set $remaining
      (i32.sub
        (i32.and
          (local.get $blockInfo)
          (i32.xor
            (i32.const 3)
            (i32.const -1)))
        (local.get $size)))
    (if  ;; label = @1
      (i32.ge_u
        (local.get $remaining)
        (i32.add
          (i32.const 4)
          (i32.const 12)))
      (then
        (call $~lib/rt/common/BLOCK#set:mmInfo
          (local.get $block)
          (i32.or
            (local.get $size)
            (i32.and
              (local.get $blockInfo)
              (i32.const 2))))
        (local.set $spare
          (i32.add
            (i32.add
              (local.get $block)
              (i32.const 4))
            (local.get $size)))
        (call $~lib/rt/common/BLOCK#set:mmInfo
          (local.get $spare)
          (i32.or
            (i32.sub
              (local.get $remaining)
              (i32.const 4))
            (i32.const 1)))
        (call $~lib/rt/tlsf/insertBlock
          (local.get $root)
          (local.get $spare)))
      (else
        (call $~lib/rt/common/BLOCK#set:mmInfo
          (local.get $block)
          (i32.and
            (local.get $blockInfo)
            (i32.xor
              (i32.const 1)
              (i32.const -1))))
        (call $~lib/rt/common/BLOCK#set:mmInfo
          (block (result i32)  ;; label = @2
            (local.set $block|7
              (local.get $block))
            (br 0 (;@2;)
              (i32.add
                (i32.add
                  (local.get $block|7)
                  (i32.const 4))
                (i32.and
                  (call $~lib/rt/common/BLOCK#get:mmInfo
                    (local.get $block|7))
                  (i32.xor
                    (i32.const 3)
                    (i32.const -1))))))
          (i32.and
            (call $~lib/rt/common/BLOCK#get:mmInfo
              (block (result i32)  ;; label = @2
                (local.set $block|6
                  (local.get $block))
                (br 0 (;@2;)
                  (i32.add
                    (i32.add
                      (local.get $block|6)
                      (i32.const 4))
                    (i32.and
                      (call $~lib/rt/common/BLOCK#get:mmInfo
                        (local.get $block|6))
                      (i32.xor
                        (i32.const 3)
                        (i32.const -1)))))))
            (i32.xor
              (i32.const 2)
              (i32.const -1)))))))
  (func $~lib/rt/tlsf/allocateBlock (type 2) (param $root i32) (param $size i32) (result i32)
    (local $payloadSize i32) (local $block i32)
    (local.set $payloadSize
      (call $~lib/rt/tlsf/prepareSize
        (local.get $size)))
    (local.set $block
      (call $~lib/rt/tlsf/searchBlock
        (local.get $root)
        (local.get $payloadSize)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $block))
      (then
        (call $~lib/rt/tlsf/growMemory
          (local.get $root)
          (local.get $payloadSize))
        (local.set $block
          (call $~lib/rt/tlsf/searchBlock
            (local.get $root)
            (local.get $payloadSize)))
        (drop
          (i32.const 1))
        (if  ;; label = @2
          (i32.eqz
            (local.get $block))
          (then
            (call $~lib/wasi_internal/wasi_abort
              (i32.const 0)
              (i32.const 672)
              (i32.const 499)
              (i32.const 16))
            (unreachable)))))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (i32.ge_u
          (i32.and
            (call $~lib/rt/common/BLOCK#get:mmInfo
              (local.get $block))
            (i32.xor
              (i32.const 3)
              (i32.const -1)))
          (local.get $payloadSize)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 672)
          (i32.const 501)
          (i32.const 14))
        (unreachable)))
    (call $~lib/rt/tlsf/removeBlock
      (local.get $root)
      (local.get $block))
    (call $~lib/rt/tlsf/prepareBlock
      (local.get $root)
      (local.get $block)
      (local.get $payloadSize))
    (drop
      (i32.const 0))
    (return
      (local.get $block)))
  (func $~lib/rt/tlsf/__alloc (type 1) (param $size i32) (result i32)
    (if  ;; label = @1
      (i32.eqz
        (global.get $~lib/rt/tlsf/ROOT))
      (then
        (call $~lib/rt/tlsf/initialize)))
    (return
      (i32.add
        (call $~lib/rt/tlsf/allocateBlock
          (global.get $~lib/rt/tlsf/ROOT)
          (local.get $size))
        (i32.const 4))))
  (func $~lib/rt/itcms/Object#set:rtId (type 0) (param $this i32) (param $rtId i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $rtId)))
  (func $~lib/rt/itcms/Object#set:rtSize (type 0) (param $this i32) (param $rtSize i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $rtSize)))
  (func $~lib/rt/itcms/__new (type 2) (param $size i32) (param $id i32) (result i32)
    (local $obj i32) (local $ptr i32)
    (if  ;; label = @1
      (i32.ge_u
        (local.get $size)
        (i32.const 1073741804))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 336)
          (i32.const 400)
          (i32.const 261)
          (i32.const 31))
        (unreachable)))
    (if  ;; label = @1
      (i32.ge_u
        (global.get $~lib/rt/itcms/total)
        (global.get $~lib/rt/itcms/threshold))
      (then
        (call $~lib/rt/itcms/interrupt)))
    (local.set $obj
      (i32.sub
        (call $~lib/rt/tlsf/__alloc
          (i32.add
            (i32.const 16)
            (local.get $size)))
        (i32.const 4)))
    (call $~lib/rt/itcms/Object#set:rtId
      (local.get $obj)
      (local.get $id))
    (call $~lib/rt/itcms/Object#set:rtSize
      (local.get $obj)
      (local.get $size))
    (call $~lib/rt/itcms/Object#linkTo
      (local.get $obj)
      (global.get $~lib/rt/itcms/fromSpace)
      (global.get $~lib/rt/itcms/white))
    (global.set $~lib/rt/itcms/total
      (i32.add
        (global.get $~lib/rt/itcms/total)
        (call $~lib/rt/itcms/Object#get:size
          (local.get $obj))))
    (local.set $ptr
      (i32.add
        (local.get $obj)
        (i32.const 20)))
    (memory.fill
      (local.get $ptr)
      (i32.const 0)
      (local.get $size))
    (return
      (local.get $ptr)))
  (func $~lib/rt/__newBuffer (type 3) (param $size i32) (param $id i32) (param $data i32) (result i32)
    (local $buffer i32)
    (local.set $buffer
      (call $~lib/rt/itcms/__new
        (local.get $size)
        (local.get $id)))
    (if  ;; label = @1
      (local.get $data)
      (then
        (memory.copy
          (local.get $buffer)
          (local.get $data)
          (local.get $size))))
    (return
      (local.get $buffer)))
  (func $~lib/rt/itcms/__link (type 7) (param $parentPtr i32) (param $childPtr i32) (param $expectMultiple i32)
    (local $child i32) (local $parent i32) (local $parentColor i32)
    (if  ;; label = @1
      (i32.eqz
        (local.get $childPtr))
      (then
        (return)))
    (drop
      (i32.const 1))
    (if  ;; label = @1
      (i32.eqz
        (local.get $parentPtr))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 400)
          (i32.const 295)
          (i32.const 14))
        (unreachable)))
    (local.set $child
      (i32.sub
        (local.get $childPtr)
        (i32.const 20)))
    (if  ;; label = @1
      (i32.eq
        (call $~lib/rt/itcms/Object#get:color
          (local.get $child))
        (global.get $~lib/rt/itcms/white))
      (then
        (local.set $parent
          (i32.sub
            (local.get $parentPtr)
            (i32.const 20)))
        (local.set $parentColor
          (call $~lib/rt/itcms/Object#get:color
            (local.get $parent)))
        (if  ;; label = @2
          (i32.eq
            (local.get $parentColor)
            (i32.eqz
              (global.get $~lib/rt/itcms/white)))
          (then
            (if  ;; label = @3
              (local.get $expectMultiple)
              (then
                (call $~lib/rt/itcms/Object#makeGray
                  (local.get $parent)))
              (else
                (call $~lib/rt/itcms/Object#makeGray
                  (local.get $child)))))
          (else
            (if  ;; label = @3
              (if (result i32)  ;; label = @4
                (i32.eq
                  (local.get $parentColor)
                  (i32.const 3))
                (then
                  (i32.eq
                    (global.get $~lib/rt/itcms/state)
                    (i32.const 1)))
                (else
                  (i32.const 0)))
              (then
                (call $~lib/rt/itcms/Object#makeGray
                  (local.get $child)))))))))
  (func $~lib/as-wasi/assembly/as-wasi/CommandLine#set:args (type 0) (param $this i32) (param $args i32)
    (i32.store
      (local.get $this)
      (local.get $args))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $args)
      (i32.const 0)))
  (func $~lib/rt/itcms/Object#get:rtSize (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/rt/itcms/__renew (type 2) (param $oldPtr i32) (param $size i32) (result i32)
    (local $oldObj i32) (local $newPtr i32) (local $4 i32) (local $5 i32)
    (local.set $oldObj
      (i32.sub
        (local.get $oldPtr)
        (i32.const 20)))
    (if  ;; label = @1
      (i32.le_u
        (local.get $size)
        (i32.sub
          (i32.and
            (call $~lib/rt/common/BLOCK#get:mmInfo
              (local.get $oldObj))
            (i32.xor
              (i32.const 3)
              (i32.const -1)))
          (i32.const 16)))
      (then
        (call $~lib/rt/itcms/Object#set:rtSize
          (local.get $oldObj)
          (local.get $size))
        (return
          (local.get $oldPtr))))
    (local.set $newPtr
      (call $~lib/rt/itcms/__new
        (local.get $size)
        (call $~lib/rt/itcms/Object#get:rtId
          (local.get $oldObj))))
    (memory.copy
      (local.get $newPtr)
      (local.get $oldPtr)
      (select
        (local.tee $4
          (local.get $size))
        (local.tee $5
          (call $~lib/rt/itcms/Object#get:rtSize
            (local.get $oldObj)))
        (i32.lt_u
          (local.get $4)
          (local.get $5))))
    (return
      (local.get $newPtr)))
  (func $~lib/as-wasi/assembly/as-wasi/CommandLine#get:args (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<~lib/string/String>#get:length_ (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/arraybuffer/ArrayBufferView#get:byteLength (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/arraybuffer/ArrayBufferView#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<~lib/string/String>#get:dataStart (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/array/Array<~lib/string/String>#set:length_ (type 0) (param $this i32) (param $length_ i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $length_)))
  (func $~lib/as-wasi/assembly/as-wasi/Descriptor#constructor (type 2) (param $this i32) (param $rawfd i32) (result i32)
    (return
      (local.get $rawfd)))
  (func $~lib/string/String.UTF8.byteLength (type 2) (param $str i32) (param $nullTerminated i32) (result i32)
    (local $strOff i32) (local $strEnd i32) (local $bufLen i32) (local $c1 i32)
    (local.set $strOff
      (local.get $str))
    (local.set $strEnd
      (i32.add
        (local.get $strOff)
        (call $~lib/rt/common/OBJECT#get:rtSize
          (i32.sub
            (local.get $str)
            (i32.const 20)))))
    (local.set $bufLen
      (i32.ne
        (local.get $nullTerminated)
        (i32.const 0)))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $strOff)
            (local.get $strEnd))
          (then
            (local.set $c1
              (i32.load16_u
                (local.get $strOff)))
            (if  ;; label = @4
              (i32.lt_u
                (local.get $c1)
                (i32.const 128))
              (then
                (if  ;; label = @5
                  (i32.and
                    (local.get $nullTerminated)
                    (i32.eqz
                      (local.get $c1)))
                  (then
                    (br 4 (;@1;))))
                (local.set $bufLen
                  (i32.add
                    (local.get $bufLen)
                    (i32.const 1))))
              (else
                (if  ;; label = @5
                  (i32.lt_u
                    (local.get $c1)
                    (i32.const 2048))
                  (then
                    (local.set $bufLen
                      (i32.add
                        (local.get $bufLen)
                        (i32.const 2))))
                  (else
                    (if  ;; label = @6
                      (if (result i32)  ;; label = @7
                        (i32.eq
                          (i32.and
                            (local.get $c1)
                            (i32.const 64512))
                          (i32.const 55296))
                        (then
                          (i32.lt_u
                            (i32.add
                              (local.get $strOff)
                              (i32.const 2))
                            (local.get $strEnd)))
                        (else
                          (i32.const 0)))
                      (then
                        (if  ;; label = @7
                          (i32.eq
                            (i32.and
                              (i32.load16_u offset=2
                                (local.get $strOff))
                              (i32.const 64512))
                            (i32.const 56320))
                          (then
                            (local.set $bufLen
                              (i32.add
                                (local.get $bufLen)
                                (i32.const 4)))
                            (local.set $strOff
                              (i32.add
                                (local.get $strOff)
                                (i32.const 4)))
                            (br 5 (;@2;))))))
                    (local.set $bufLen
                      (i32.add
                        (local.get $bufLen)
                        (i32.const 3)))))))
            (local.set $strOff
              (i32.add
                (local.get $strOff)
                (i32.const 2)))
            (br 1 (;@2;))))))
    (return
      (local.get $bufLen)))
  (func $~lib/arraybuffer/ArrayBuffer#get:byteLength (type 1) (param $this i32) (result i32)
    (return
      (call $~lib/rt/common/OBJECT#get:rtSize
        (i32.sub
          (local.get $this)
          (i32.const 20)))))
  (func $~lib/as-wasi/assembly/as-wasi/FileSystem.dirfdForPath (type 1) (param $path i32) (result i32)
    (return
      (i32.const 3)))
  (func $~lib/array/Array<u8>#get:length_ (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/array/Array<u8>#get:dataStart (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/array/Array<u8>#set:length_ (type 0) (param $this i32) (param $length_ i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $length_)))
  (func $~lib/array/Array<~lib/string/String>#set:buffer (type 0) (param $this i32) (param $buffer i32)
    (i32.store
      (local.get $this)
      (local.get $buffer))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buffer)
      (i32.const 0)))
  (func $~lib/array/Array<~lib/string/String>#set:dataStart (type 0) (param $this i32) (param $dataStart i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $dataStart)))
  (func $~lib/array/Array<~lib/string/String>#set:byteLength (type 0) (param $this i32) (param $byteLength i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $byteLength)))
  (func $src/sourcemap/SourceMap#set:sources (type 0) (param $this i32) (param $sources i32)
    (i32.store
      (local.get $this)
      (local.get $sources))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $sources)
      (i32.const 0)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:buffer (type 0) (param $this i32) (param $buffer i32)
    (i32.store
      (local.get $this)
      (local.get $buffer))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buffer)
      (i32.const 0)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:dataStart (type 0) (param $this i32) (param $dataStart i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $dataStart)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:byteLength (type 0) (param $this i32) (param $byteLength i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $byteLength)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:length_ (type 0) (param $this i32) (param $length_ i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $length_)))
  (func $src/sourcemap/SourceMap#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $src/sourcemap/base64Decode (type 1) (param $ch i32) (result i32)
    ;; Source Map v3 parser.
    ;; Decodes VLQ-encoded mappings from WASM source maps.
    ;; For WASM source maps, generated line is always 0 and generated column
    ;; is the byte offset into the WASM binary.
    ;; A-Z
    ;; --- Base64 VLQ ---
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.ge_s
          (local.get $ch)
          (i32.const 65))
        (then
          (i32.le_s
            (local.get $ch)
            (i32.const 90)))
        (else
          (i32.const 0)))
      (then
        (return
          (i32.sub
            (local.get $ch)
            (i32.const 65)))))
    ;; a-z
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.ge_s
          (local.get $ch)
          (i32.const 97))
        (then
          (i32.le_s
            (local.get $ch)
            (i32.const 122)))
        (else
          (i32.const 0)))
      (then
        (return
          (i32.add
            (i32.sub
              (local.get $ch)
              (i32.const 97))
            (i32.const 26)))))
    ;; 0-9
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.ge_s
          (local.get $ch)
          (i32.const 48))
        (then
          (i32.le_s
            (local.get $ch)
            (i32.const 57)))
        (else
          (i32.const 0)))
      (then
        (return
          (i32.add
            (i32.sub
              (local.get $ch)
              (i32.const 48))
            (i32.const 52)))))
    ;; +
    (if  ;; label = @1
      (i32.eq
        (local.get $ch)
        (i32.const 43))
      (then
        (return
          (i32.const 62))))
    ;; /
    (if  ;; label = @1
      (i32.eq
        (local.get $ch)
        (i32.const 47))
      (then
        (return
          (i32.const 63))))
    (return
      (i32.const -1)))
  (func $src/sourcemap/VLQResult#set:value (type 0) (param $this i32) (param $value i32)
    (i32.store
      (local.get $this)
      (local.get $value)))
  (func $src/sourcemap/VLQResult#set:index (type 0) (param $this i32) (param $index i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $index)))
  (func $src/sourcemap/VLQResult#get:value (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $src/sourcemap/VLQResult#get:index (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $src/sourcemap/SourceMapEntry#set:generatedOffset (type 0) (param $this i32) (param $generatedOffset i32)
    (i32.store
      (local.get $this)
      (local.get $generatedOffset)))
  (func $src/sourcemap/SourceMapEntry#set:sourceIndex (type 0) (param $this i32) (param $sourceIndex i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $sourceIndex)))
  (func $src/sourcemap/SourceMapEntry#set:sourceLine (type 0) (param $this i32) (param $sourceLine i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $sourceLine)))
  (func $src/sourcemap/SourceMapEntry#set:sourceColumn (type 0) (param $this i32) (param $sourceColumn i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $sourceColumn)))
  (func $src/sourcemap/SourceMap#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length_ (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:dataStart (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $src/sourcemap/SourceMapEntry#get:generatedOffset (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/util/sort/nodePower (type 11) (param $left i32) (param $right i32) (param $startA i32) (param $startB i32) (param $endB i32) (result i32)
    (local $n i64) (local $a i64) (local $b i64) (local $s i32) (local $l i32) (local $r i32)
    (local.set $n
      (i64.extend_i32_u
        (i32.add
          (i32.sub
            (local.get $right)
            (local.get $left))
          (i32.const 1))))
    (local.set $s
      (i32.sub
        (local.get $startB)
        (i32.shl
          (local.get $left)
          (i32.const 1))))
    (local.set $l
      (i32.add
        (local.get $startA)
        (local.get $s)))
    (local.set $r
      (i32.add
        (i32.add
          (local.get $endB)
          (local.get $s))
        (i32.const 1)))
    (local.set $a
      (i64.div_u
        (i64.shl
          (i64.extend_i32_u
            (local.get $l))
          (i64.const 30))
        (local.get $n)))
    (local.set $b
      (i64.div_u
        (i64.shl
          (i64.extend_i32_u
            (local.get $r))
          (i64.const 30))
        (local.get $n)))
    (return
      (i32.clz
        (i32.wrap_i64
          (i64.xor
            (local.get $a)
            (local.get $b))))))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:buffer (type 0) (param $this i32) (param $buffer i32)
    (i32.store
      (local.get $this)
      (local.get $buffer))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buffer)
      (i32.const 0)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:dataStart (type 0) (param $this i32) (param $dataStart i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $dataStart)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:byteLength (type 0) (param $this i32) (param $byteLength i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $byteLength)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:length_ (type 0) (param $this i32) (param $length_ i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $length_)))
  (func $src/offsetmap/OffsetMapEntry#set:watLine (type 0) (param $this i32) (param $watLine i32)
    (i32.store
      (local.get $this)
      (local.get $watLine)))
  (func $src/offsetmap/OffsetMapEntry#set:offset (type 0) (param $this i32) (param $offset i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $offset)))
  (func $src/offsetmap/ParseIntResult#set:value (type 0) (param $this i32) (param $value i32)
    (i32.store
      (local.get $this)
      (local.get $value)))
  (func $src/offsetmap/ParseIntResult#set:index (type 0) (param $this i32) (param $index i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $index)))
  (func $src/offsetmap/ParseIntResult#get:index (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $src/offsetmap/ParseIntResult#get:value (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:length_ (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:dataStart (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/Map<u32_u32>#set:buckets (type 0) (param $this i32) (param $buckets i32)
    (i32.store
      (local.get $this)
      (local.get $buckets))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buckets)
      (i32.const 0)))
  (func $~lib/map/Map<u32_u32>#set:bucketsMask (type 0) (param $this i32) (param $bucketsMask i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $bucketsMask)))
  (func $~lib/map/Map<u32_u32>#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $~lib/map/Map<u32_u32>#set:entriesCapacity (type 0) (param $this i32) (param $entriesCapacity i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $entriesCapacity)))
  (func $~lib/map/Map<u32_u32>#set:entriesOffset (type 0) (param $this i32) (param $entriesOffset i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $entriesOffset)))
  (func $~lib/map/Map<u32_u32>#set:entriesCount (type 0) (param $this i32) (param $entriesCount i32)
    (i32.store offset=20
      (local.get $this)
      (local.get $entriesCount)))
  (func $src/offsetmap/OffsetMapEntry#get:watLine (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $src/offsetmap/OffsetMapEntry#get:offset (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/util/hash/HASH<u32> (type 1) (param $key i32) (result i32)
    (local $key|1 i32) (local $len i32) (local $h i32)
    (drop
      (i32.const 0))
    (drop
      (i32.const 0))
    (drop
      (i32.const 0))
    (drop
      (i32.le_u
        (i32.const 4)
        (i32.const 4)))
    (return
      (block (result i32)  ;; label = @1
        (local.set $key|1
          (local.get $key))
        (local.set $len
          (i32.const 4))
        (local.set $h
          (i32.add
            (i32.add
              (i32.const 0)
              (i32.const 374761393))
            (local.get $len)))
        (local.set $h
          (i32.add
            (local.get $h)
            (i32.mul
              (local.get $key|1)
              (i32.const -1028477379))))
        (local.set $h
          (i32.mul
            (i32.rotl
              (local.get $h)
              (i32.const 17))
            (i32.const 668265263)))
        (local.set $h
          (i32.xor
            (local.get $h)
            (i32.shr_u
              (local.get $h)
              (i32.const 15))))
        (local.set $h
          (i32.mul
            (local.get $h)
            (i32.const -2048144777)))
        (local.set $h
          (i32.xor
            (local.get $h)
            (i32.shr_u
              (local.get $h)
              (i32.const 13))))
        (local.set $h
          (i32.mul
            (local.get $h)
            (i32.const -1028477379)))
        (local.set $h
          (i32.xor
            (local.get $h)
            (i32.shr_u
              (local.get $h)
              (i32.const 16))))
        (br 0 (;@1;)
          (local.get $h)))))
  (func $~lib/map/Map<u32_u32>#get:buckets (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/Map<u32_u32>#get:bucketsMask (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_u32>#get:taggedNext (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_u32>#get:key (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_u32>#set:value (type 0) (param $this i32) (param $value i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $value)))
  (func $~lib/map/Map<u32_u32>#get:entriesOffset (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/map/Map<u32_u32>#get:entriesCapacity (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/map/Map<u32_u32>#get:entriesCount (type 1) (param $this i32) (result i32)
    (i32.load offset=20
      (local.get $this)))
  (func $~lib/map/Map<u32_u32>#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_u32>#set:key (type 0) (param $this i32) (param $key i32)
    (i32.store
      (local.get $this)
      (local.get $key)))
  (func $~lib/map/MapEntry<u32_u32>#get:value (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_u32>#set:taggedNext (type 0) (param $this i32) (param $taggedNext i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $taggedNext)))
  (func $~lib/map/Map<u64_~lib/string/String>#set:buckets (type 0) (param $this i32) (param $buckets i32)
    (i32.store
      (local.get $this)
      (local.get $buckets))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buckets)
      (i32.const 0)))
  (func $~lib/map/Map<u64_~lib/string/String>#set:bucketsMask (type 0) (param $this i32) (param $bucketsMask i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $bucketsMask)))
  (func $~lib/map/Map<u64_~lib/string/String>#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $~lib/map/Map<u64_~lib/string/String>#set:entriesCapacity (type 0) (param $this i32) (param $entriesCapacity i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $entriesCapacity)))
  (func $~lib/map/Map<u64_~lib/string/String>#set:entriesOffset (type 0) (param $this i32) (param $entriesOffset i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $entriesOffset)))
  (func $~lib/map/Map<u64_~lib/string/String>#set:entriesCount (type 0) (param $this i32) (param $entriesCount i32)
    (i32.store offset=20
      (local.get $this)
      (local.get $entriesCount)))
  (func $src/sourcemap/SourceMap#get:sources (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<src/comments/SourceComment>#set:buffer (type 0) (param $this i32) (param $buffer i32)
    (i32.store
      (local.get $this)
      (local.get $buffer))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buffer)
      (i32.const 0)))
  (func $~lib/array/Array<src/comments/SourceComment>#set:dataStart (type 0) (param $this i32) (param $dataStart i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $dataStart)))
  (func $~lib/array/Array<src/comments/SourceComment>#set:byteLength (type 0) (param $this i32) (param $byteLength i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $byteLength)))
  (func $~lib/array/Array<src/comments/SourceComment>#set:length_ (type 0) (param $this i32) (param $length_ i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $length_)))
  (func $src/comments/SourceComment#set:line (type 0) (param $this i32) (param $line i32)
    (i32.store
      (local.get $this)
      (local.get $line)))
  (func $src/comments/SourceComment#set:text (type 0) (param $this i32) (param $text i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $text))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $text)
      (i32.const 0)))
  (func $~lib/array/Array<src/comments/SourceComment>#get:length_ (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/array/Array<src/comments/SourceComment>#get:dataStart (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $src/comments/SourceComment#get:line (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $src/injector/commentKey (type 16) (param $sourceIndex i32) (param $line i32) (result i64)
    ;; Comment injector: combines offset map + source map + comments
    ;; to produce annotated WAT output.
    ;; Encode (sourceIndex, line) into a single u64 key.
    (return
      (i64.or
        (i64.shl
          (i64.extend_i32_u
            (local.get $sourceIndex))
          (i64.const 32))
        (i64.extend_i32_u
          (local.get $line)))))
  (func $src/comments/SourceComment#get:text (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/util/hash/HASH<u64> (type 21) (param $key i64) (result i32)
    (local $key|1 i64) (local $h i32)
    (drop
      (i32.const 0))
    (drop
      (i32.const 0))
    (drop
      (i32.const 0))
    (drop
      (i32.le_u
        (i32.const 8)
        (i32.const 4)))
    (drop
      (i32.eq
        (i32.const 8)
        (i32.const 8)))
    (return
      (block (result i32)  ;; label = @1
        (local.set $key|1
          (local.get $key))
        (local.set $h
          (i32.add
            (i32.add
              (i32.const 0)
              (i32.const 374761393))
            (i32.const 8)))
        (local.set $h
          (i32.add
            (local.get $h)
            (i32.mul
              (i32.wrap_i64
                (local.get $key|1))
              (i32.const -1028477379))))
        (local.set $h
          (i32.mul
            (i32.rotl
              (local.get $h)
              (i32.const 17))
            (i32.const 668265263)))
        (local.set $h
          (i32.add
            (local.get $h)
            (i32.mul
              (i32.wrap_i64
                (i64.shr_u
                  (local.get $key|1)
                  (i64.const 32)))
              (i32.const -1028477379))))
        (local.set $h
          (i32.mul
            (i32.rotl
              (local.get $h)
              (i32.const 17))
            (i32.const 668265263)))
        (local.set $h
          (i32.xor
            (local.get $h)
            (i32.shr_u
              (local.get $h)
              (i32.const 15))))
        (local.set $h
          (i32.mul
            (local.get $h)
            (i32.const -2048144777)))
        (local.set $h
          (i32.xor
            (local.get $h)
            (i32.shr_u
              (local.get $h)
              (i32.const 13))))
        (local.set $h
          (i32.mul
            (local.get $h)
            (i32.const -1028477379)))
        (local.set $h
          (i32.xor
            (local.get $h)
            (i32.shr_u
              (local.get $h)
              (i32.const 16))))
        (br 0 (;@1;)
          (local.get $h)))))
  (func $~lib/map/Map<u64_~lib/string/String>#get:buckets (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/Map<u64_~lib/string/String>#get:bucketsMask (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_~lib/string/String>#get:taggedNext (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_~lib/string/String>#get:key (type 12) (param $this i32) (result i64)
    (i64.load
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_~lib/string/String>#set:value (type 0) (param $this i32) (param $value i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $value)))
  (func $~lib/map/Map<u64_~lib/string/String>#get:entriesOffset (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/map/Map<u64_~lib/string/String>#get:entriesCapacity (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/map/Map<u64_~lib/string/String>#get:entriesCount (type 1) (param $this i32) (result i32)
    (i32.load offset=20
      (local.get $this)))
  (func $~lib/map/Map<u64_~lib/string/String>#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_~lib/string/String>#set:key (type 13) (param $this i32) (param $key i64)
    (i64.store
      (local.get $this)
      (local.get $key)))
  (func $~lib/map/MapEntry<u64_~lib/string/String>#get:value (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_~lib/string/String>#set:taggedNext (type 0) (param $this i32) (param $taggedNext i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $taggedNext)))
  (func $~lib/set/Set<u64>#set:buckets (type 0) (param $this i32) (param $buckets i32)
    (i32.store
      (local.get $this)
      (local.get $buckets))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buckets)
      (i32.const 0)))
  (func $~lib/set/Set<u64>#set:bucketsMask (type 0) (param $this i32) (param $bucketsMask i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $bucketsMask)))
  (func $~lib/set/Set<u64>#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $~lib/set/Set<u64>#set:entriesCapacity (type 0) (param $this i32) (param $entriesCapacity i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $entriesCapacity)))
  (func $~lib/set/Set<u64>#set:entriesOffset (type 0) (param $this i32) (param $entriesOffset i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $entriesOffset)))
  (func $~lib/set/Set<u64>#set:entriesCount (type 0) (param $this i32) (param $entriesCount i32)
    (i32.store offset=20
      (local.get $this)
      (local.get $entriesCount)))
  (func $~lib/array/Array<u32>#set:buffer (type 0) (param $this i32) (param $buffer i32)
    (i32.store
      (local.get $this)
      (local.get $buffer))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buffer)
      (i32.const 0)))
  (func $~lib/array/Array<u32>#set:dataStart (type 0) (param $this i32) (param $dataStart i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $dataStart)))
  (func $~lib/array/Array<u32>#set:byteLength (type 0) (param $this i32) (param $byteLength i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $byteLength)))
  (func $~lib/array/Array<u32>#set:length_ (type 0) (param $this i32) (param $length_ i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $length_)))
  (func $~lib/array/Array<u32>#get:length_ (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/array/Array<u32>#get:dataStart (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $src/sourcemap/SourceMapEntry#get:sourceIndex (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $src/sourcemap/SourceMapEntry#get:sourceLine (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/set/Set<u64>#get:buckets (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/set/Set<u64>#get:bucketsMask (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/set/SetEntry<u64>#get:taggedNext (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/set/SetEntry<u64>#get:key (type 12) (param $this i32) (result i64)
    (i64.load
      (local.get $this)))
  (func $~lib/set/Set<u64>#get:entriesOffset (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/set/Set<u64>#get:entriesCapacity (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/set/Set<u64>#get:entriesCount (type 1) (param $this i32) (result i32)
    (i32.load offset=20
      (local.get $this)))
  (func $~lib/set/Set<u64>#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/set/SetEntry<u64>#set:key (type 13) (param $this i32) (param $key i64)
    (i64.store
      (local.get $this)
      (local.get $key)))
  (func $~lib/set/SetEntry<u64>#set:taggedNext (type 0) (param $this i32) (param $taggedNext i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $taggedNext)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#set:buckets (type 0) (param $this i32) (param $buckets i32)
    (i32.store
      (local.get $this)
      (local.get $buckets))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buckets)
      (i32.const 0)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#set:bucketsMask (type 0) (param $this i32) (param $bucketsMask i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $bucketsMask)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesCapacity (type 0) (param $this i32) (param $entriesCapacity i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $entriesCapacity)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesOffset (type 0) (param $this i32) (param $entriesOffset i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $entriesOffset)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesCount (type 0) (param $this i32) (param $entriesCount i32)
    (i32.store offset=20
      (local.get $this)
      (local.get $entriesCount)))
  (func $~lib/array/Array<u64>#set:buffer (type 0) (param $this i32) (param $buffer i32)
    (i32.store
      (local.get $this)
      (local.get $buffer))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buffer)
      (i32.const 0)))
  (func $~lib/array/Array<u64>#set:dataStart (type 0) (param $this i32) (param $dataStart i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $dataStart)))
  (func $~lib/array/Array<u64>#set:byteLength (type 0) (param $this i32) (param $byteLength i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $byteLength)))
  (func $~lib/array/Array<u64>#set:length_ (type 0) (param $this i32) (param $length_ i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $length_)))
  (func $~lib/array/Array<u64>#get:length_ (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/array/Array<u64>#get:dataStart (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#get:buckets (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#get:bucketsMask (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:taggedNext (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:key (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:value (type 0) (param $this i32) (param $value i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $value)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesOffset (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesCapacity (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesCount (type 1) (param $this i32) (result i32)
    (i32.load offset=20
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:key (type 0) (param $this i32) (param $key i32)
    (i32.store
      (local.get $this)
      (local.get $key)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:value (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:taggedNext (type 0) (param $this i32) (param $taggedNext i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $taggedNext)))
  (func $src/injector/compareCommentKeys (type 4) (param $a i64) (param $b i64) (result i32)
    (if  ;; label = @1
      (i64.lt_u
        (local.get $a)
        (local.get $b))
      (then
        (return
          (i32.const -1))))
    (if  ;; label = @1
      (i64.gt_u
        (local.get $a)
        (local.get $b))
      (then
        (return
          (i32.const 1))))
    (return
      (i32.const 0)))
  (func $~lib/util/sort/insertionSort<u64> (type 14) (param $ptr i32) (param $left i32) (param $right i32) (param $presorted i32) (param $comparator i32)
    (local $range i32) (local $i i32) (local $j i32) (local $a i64) (local $b i64) (local $min i64) (local $max i64)
    (drop
      (i32.ge_s
        (i32.const 0)
        (i32.const 1)))
    (local.set $range
      (i32.add
        (i32.sub
          (local.get $right)
          (local.get $left))
        (i32.const 1)))
    (local.set $i
      (i32.add
        (local.get $left)
        (select
          (i32.and
            (local.get $range)
            (i32.const 1))
          (i32.sub
            (local.get $presorted)
            (i32.and
              (i32.sub
                (local.get $range)
                (local.get $presorted))
              (i32.const 1)))
          (i32.eq
            (local.get $presorted)
            (i32.const 0)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.le_s
            (local.get $i)
            (local.get $right))
          (then
            (local.set $a
              (i64.load
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $i)
                    (i32.const 3)))))
            (local.set $b
              (i64.load offset=8
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $i)
                    (i32.const 3)))))
            (local.set $min
              (local.get $b))
            (local.set $max
              (local.get $a))
            (local.get $a)
            (local.get $b)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (if  ;; label = @4
              (i32.le_s
                (call_indirect $0 (type 4))
                (i32.const 0))
              (then
                (local.set $min
                  (local.get $a))
                (local.set $max
                  (local.get $b))))
            (local.set $j
              (i32.sub
                (local.get $i)
                (i32.const 1)))
            (block  ;; label = @4
              (loop  ;; label = @5
                (if  ;; label = @6
                  (i32.ge_s
                    (local.get $j)
                    (local.get $left))
                  (then
                    (local.set $a
                      (i64.load
                        (i32.add
                          (local.get $ptr)
                          (i32.shl
                            (local.get $j)
                            (i32.const 3)))))
                    (local.get $a)
                    (local.get $max)
                    (global.set $~argumentsLength
                      (i32.const 2))
                    (i32.load
                      (local.get $comparator))
                    (if  ;; label = @7
                      (i32.gt_s
                        (call_indirect $0 (type 4))
                        (i32.const 0))
                      (then
                        (i64.store offset=16
                          (i32.add
                            (local.get $ptr)
                            (i32.shl
                              (local.get $j)
                              (i32.const 3)))
                          (local.get $a))
                        (local.set $j
                          (i32.sub
                            (local.get $j)
                            (i32.const 1))))
                      (else
                        (br 3 (;@4;))))
                    (br 1 (;@5;))))))
            (i64.store offset=16
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 3)))
              (local.get $max))
            (block  ;; label = @4
              (loop  ;; label = @5
                (if  ;; label = @6
                  (i32.ge_s
                    (local.get $j)
                    (local.get $left))
                  (then
                    (local.set $a
                      (i64.load
                        (i32.add
                          (local.get $ptr)
                          (i32.shl
                            (local.get $j)
                            (i32.const 3)))))
                    (local.get $a)
                    (local.get $min)
                    (global.set $~argumentsLength
                      (i32.const 2))
                    (i32.load
                      (local.get $comparator))
                    (if  ;; label = @7
                      (i32.gt_s
                        (call_indirect $0 (type 4))
                        (i32.const 0))
                      (then
                        (i64.store offset=8
                          (i32.add
                            (local.get $ptr)
                            (i32.shl
                              (local.get $j)
                              (i32.const 3)))
                          (local.get $a))
                        (local.set $j
                          (i32.sub
                            (local.get $j)
                            (i32.const 1))))
                      (else
                        (br 3 (;@4;))))
                    (br 1 (;@5;))))))
            (i64.store offset=8
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 3)))
              (local.get $min))
            (local.set $i
              (i32.add
                (local.get $i)
                (i32.const 2)))
            (br 1 (;@2;)))))))
  (func $~lib/util/sort/extendRunRight<u64> (type 5) (param $ptr i32) (param $i i32) (param $right i32) (param $comparator i32) (result i32)
    (local $j i32) (local $k i32) (local $tmp i64)
    (if  ;; label = @1
      (i32.eq
        (local.get $i)
        (local.get $right))
      (then
        (return
          (local.get $i))))
    (local.set $j
      (local.get $i))
    (i64.load
      (i32.add
        (local.get $ptr)
        (i32.shl
          (local.get $j)
          (i32.const 3))))
    (i64.load
      (i32.add
        (local.get $ptr)
        (i32.shl
          (local.tee $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (i32.const 3))))
    (global.set $~argumentsLength
      (i32.const 2))
    (i32.load
      (local.get $comparator))
    (if  ;; label = @1
      (i32.gt_s
        (call_indirect $0 (type 4))
        (i32.const 0))
      (then
        (block  ;; label = @2
          (loop  ;; label = @3
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.lt_s
                  (local.get $j)
                  (local.get $right))
                (then
                  (i64.load offset=8
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $j)
                        (i32.const 3))))
                  (i64.load
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $j)
                        (i32.const 3))))
                  (global.set $~argumentsLength
                    (i32.const 2))
                  (i32.load
                    (local.get $comparator))
                  (i32.shr_u
                    (call_indirect $0 (type 4))
                    (i32.const 31)))
                (else
                  (i32.const 0)))
              (then
                (local.set $j
                  (i32.add
                    (local.get $j)
                    (i32.const 1)))
                (br 1 (;@3;))))))
        (local.set $k
          (local.get $j))
        (block  ;; label = @2
          (loop  ;; label = @3
            (if  ;; label = @4
              (i32.lt_s
                (local.get $i)
                (local.get $k))
              (then
                (local.set $tmp
                  (i64.load
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $i)
                        (i32.const 3)))))
                (i64.store
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $i)
                      (i32.const 3)))
                  (i64.load
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $k)
                        (i32.const 3)))))
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 1)))
                (i64.store
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $k)
                      (i32.const 3)))
                  (local.get $tmp))
                (local.set $k
                  (i32.sub
                    (local.get $k)
                    (i32.const 1)))
                (br 1 (;@3;)))))))
      (else
        (loop  ;; label = @2
          (if  ;; label = @3
            (if (result i32)  ;; label = @4
              (i32.lt_s
                (local.get $j)
                (local.get $right))
              (then
                (i64.load offset=8
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $j)
                      (i32.const 3))))
                (i64.load
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $j)
                      (i32.const 3))))
                (global.set $~argumentsLength
                  (i32.const 2))
                (i32.load
                  (local.get $comparator))
                (i32.ge_s
                  (call_indirect $0 (type 4))
                  (i32.const 0)))
              (else
                (i32.const 0)))
            (then
              (local.set $j
                (i32.add
                  (local.get $j)
                  (i32.const 1)))
              (br 1 (;@2;)))))))
    (return
      (local.get $j)))
  (func $~lib/util/sort/mergeRuns<u64> (type 15) (param $ptr i32) (param $l i32) (param $m i32) (param $r i32) (param $buffer i32) (param $comparator i32)
    (local $i i32) (local $j i32) (local $t i32) (local $k i32) (local $a i64) (local $b i64)
    (local.set $m
      (i32.sub
        (local.get $m)
        (i32.const 1)))
    (local.set $t
      (i32.add
        (local.get $r)
        (local.get $m)))
    (local.set $i
      (i32.add
        (local.get $m)
        (i32.const 1)))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.gt_s
          (local.get $i)
          (local.get $l))
        (then
          (i64.store
            (i32.add
              (local.get $buffer)
              (i32.shl
                (i32.sub
                  (local.get $i)
                  (i32.const 1))
                (i32.const 3)))
            (i64.load
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (i32.sub
                    (local.get $i)
                    (i32.const 1))
                  (i32.const 3)))))
          (local.set $i
            (i32.sub
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $j
      (local.get $m))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_s
          (local.get $j)
          (local.get $r))
        (then
          (i64.store
            (i32.add
              (local.get $buffer)
              (i32.shl
                (i32.sub
                  (local.get $t)
                  (local.get $j))
                (i32.const 3)))
            (i64.load offset=8
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 3)))))
          (local.set $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $k
      (local.get $l))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.le_s
          (local.get $k)
          (local.get $r))
        (then
          (local.set $a
            (i64.load
              (i32.add
                (local.get $buffer)
                (i32.shl
                  (local.get $j)
                  (i32.const 3)))))
          (local.set $b
            (i64.load
              (i32.add
                (local.get $buffer)
                (i32.shl
                  (local.get $i)
                  (i32.const 3)))))
          (local.get $a)
          (local.get $b)
          (global.set $~argumentsLength
            (i32.const 2))
          (i32.load
            (local.get $comparator))
          (if  ;; label = @3
            (i32.lt_s
              (call_indirect $0 (type 4))
              (i32.const 0))
            (then
              (i64.store
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $k)
                    (i32.const 3)))
                (local.get $a))
              (local.set $j
                (i32.sub
                  (local.get $j)
                  (i32.const 1))))
            (else
              (i64.store
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $k)
                    (i32.const 3)))
                (local.get $b))
              (local.set $i
                (i32.add
                  (local.get $i)
                  (i32.const 1)))))
          (local.set $k
            (i32.add
              (local.get $k)
              (i32.const 1)))
          (br 1 (;@1;))))))
  (func $~lib/set/Set<u32>#set:buckets (type 0) (param $this i32) (param $buckets i32)
    (i32.store
      (local.get $this)
      (local.get $buckets))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buckets)
      (i32.const 0)))
  (func $~lib/set/Set<u32>#set:bucketsMask (type 0) (param $this i32) (param $bucketsMask i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $bucketsMask)))
  (func $~lib/set/Set<u32>#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $~lib/set/Set<u32>#set:entriesCapacity (type 0) (param $this i32) (param $entriesCapacity i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $entriesCapacity)))
  (func $~lib/set/Set<u32>#set:entriesOffset (type 0) (param $this i32) (param $entriesOffset i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $entriesOffset)))
  (func $~lib/set/Set<u32>#set:entriesCount (type 0) (param $this i32) (param $entriesCount i32)
    (i32.store offset=20
      (local.get $this)
      (local.get $entriesCount)))
  (func $~lib/set/Set<u32>#get:buckets (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/set/Set<u32>#get:bucketsMask (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/set/SetEntry<u32>#get:taggedNext (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/set/SetEntry<u32>#get:key (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/set/Set<u32>#get:entriesOffset (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/set/Set<u32>#get:entriesCapacity (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/set/Set<u32>#get:entriesCount (type 1) (param $this i32) (result i32)
    (i32.load offset=20
      (local.get $this)))
  (func $~lib/set/Set<u32>#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/set/SetEntry<u32>#set:key (type 0) (param $this i32) (param $key i32)
    (i32.store
      (local.get $this)
      (local.get $key)))
  (func $~lib/set/SetEntry<u32>#set:taggedNext (type 0) (param $this i32) (param $taggedNext i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $taggedNext)))
  (func $~lib/util/string/isSpace (type 1) (param $c i32) (result i32)
    (local $1 i32)
    (if  ;; label = @1
      (i32.lt_u
        (local.get $c)
        (i32.const 5760))
      (then
        (return
          (if (result i32)  ;; label = @2
            (i32.eq
              (i32.or
                (local.get $c)
                (i32.const 128))
              (i32.const 160))
            (then
              (i32.const 1))
            (else
              (i32.le_u
                (i32.sub
                  (local.get $c)
                  (i32.const 9))
                (i32.sub
                  (i32.const 13)
                  (i32.const 9))))))))
    (if  ;; label = @1
      (i32.le_u
        (i32.sub
          (local.get $c)
          (i32.const 8192))
        (i32.sub
          (i32.const 8202)
          (i32.const 8192)))
      (then
        (return
          (i32.const 1))))
    (block  ;; label = @1
      (block  ;; label = @2
        (block  ;; label = @3
          (block  ;; label = @4
            (block  ;; label = @5
              (block  ;; label = @6
                (block  ;; label = @7
                  (block  ;; label = @8
                    (local.set $1
                      (local.get $c))
                    (br_if 0 (;@8;)
                      (i32.eq
                        (local.get $1)
                        (i32.const 5760)))
                    (br_if 1 (;@7;)
                      (i32.eq
                        (local.get $1)
                        (i32.const 8232)))
                    (br_if 2 (;@6;)
                      (i32.eq
                        (local.get $1)
                        (i32.const 8233)))
                    (br_if 3 (;@5;)
                      (i32.eq
                        (local.get $1)
                        (i32.const 8239)))
                    (br_if 4 (;@4;)
                      (i32.eq
                        (local.get $1)
                        (i32.const 8287)))
                    (br_if 5 (;@3;)
                      (i32.eq
                        (local.get $1)
                        (i32.const 12288)))
                    (br_if 6 (;@2;)
                      (i32.eq
                        (local.get $1)
                        (i32.const 65279)))
                    (br 7 (;@1;)))))))))
      (return
        (i32.const 1)))
    (return
      (i32.const 0)))
  (func $~lib/map/Map<u64_u32>#set:buckets (type 0) (param $this i32) (param $buckets i32)
    (i32.store
      (local.get $this)
      (local.get $buckets))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buckets)
      (i32.const 0)))
  (func $~lib/map/Map<u64_u32>#set:bucketsMask (type 0) (param $this i32) (param $bucketsMask i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $bucketsMask)))
  (func $~lib/map/Map<u64_u32>#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $~lib/map/Map<u64_u32>#set:entriesCapacity (type 0) (param $this i32) (param $entriesCapacity i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $entriesCapacity)))
  (func $~lib/map/Map<u64_u32>#set:entriesOffset (type 0) (param $this i32) (param $entriesOffset i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $entriesOffset)))
  (func $~lib/map/Map<u64_u32>#set:entriesCount (type 0) (param $this i32) (param $entriesCount i32)
    (i32.store offset=20
      (local.get $this)
      (local.get $entriesCount)))
  (func $src/injector/compareU32 (type 2) (param $a i32) (param $b i32) (result i32)
    (if  ;; label = @1
      (i32.lt_u
        (local.get $a)
        (local.get $b))
      (then
        (return
          (i32.const -1))))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $a)
        (local.get $b))
      (then
        (return
          (i32.const 1))))
    (return
      (i32.const 0)))
  (func $~lib/util/sort/insertionSort<u32> (type 14) (param $ptr i32) (param $left i32) (param $right i32) (param $presorted i32) (param $comparator i32)
    (local $range i32) (local $i i32) (local $a i32) (local $b i32) (local $min i32) (local $max i32) (local $j i32)
    (drop
      (i32.ge_s
        (i32.const 0)
        (i32.const 1)))
    (local.set $range
      (i32.add
        (i32.sub
          (local.get $right)
          (local.get $left))
        (i32.const 1)))
    (local.set $i
      (i32.add
        (local.get $left)
        (select
          (i32.and
            (local.get $range)
            (i32.const 1))
          (i32.sub
            (local.get $presorted)
            (i32.and
              (i32.sub
                (local.get $range)
                (local.get $presorted))
              (i32.const 1)))
          (i32.eq
            (local.get $presorted)
            (i32.const 0)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.le_s
            (local.get $i)
            (local.get $right))
          (then
            (local.set $a
              (i32.load
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $i)
                    (i32.const 2)))))
            (local.set $b
              (i32.load offset=4
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $i)
                    (i32.const 2)))))
            (local.set $min
              (local.get $b))
            (local.set $max
              (local.get $a))
            (local.get $a)
            (local.get $b)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (if  ;; label = @4
              (i32.le_s
                (call_indirect $0 (type 2))
                (i32.const 0))
              (then
                (local.set $min
                  (local.get $a))
                (local.set $max
                  (local.get $b))))
            (local.set $j
              (i32.sub
                (local.get $i)
                (i32.const 1)))
            (block  ;; label = @4
              (loop  ;; label = @5
                (if  ;; label = @6
                  (i32.ge_s
                    (local.get $j)
                    (local.get $left))
                  (then
                    (local.set $a
                      (i32.load
                        (i32.add
                          (local.get $ptr)
                          (i32.shl
                            (local.get $j)
                            (i32.const 2)))))
                    (local.get $a)
                    (local.get $max)
                    (global.set $~argumentsLength
                      (i32.const 2))
                    (i32.load
                      (local.get $comparator))
                    (if  ;; label = @7
                      (i32.gt_s
                        (call_indirect $0 (type 2))
                        (i32.const 0))
                      (then
                        (i32.store offset=8
                          (i32.add
                            (local.get $ptr)
                            (i32.shl
                              (local.get $j)
                              (i32.const 2)))
                          (local.get $a))
                        (local.set $j
                          (i32.sub
                            (local.get $j)
                            (i32.const 1))))
                      (else
                        (br 3 (;@4;))))
                    (br 1 (;@5;))))))
            (i32.store offset=8
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 2)))
              (local.get $max))
            (block  ;; label = @4
              (loop  ;; label = @5
                (if  ;; label = @6
                  (i32.ge_s
                    (local.get $j)
                    (local.get $left))
                  (then
                    (local.set $a
                      (i32.load
                        (i32.add
                          (local.get $ptr)
                          (i32.shl
                            (local.get $j)
                            (i32.const 2)))))
                    (local.get $a)
                    (local.get $min)
                    (global.set $~argumentsLength
                      (i32.const 2))
                    (i32.load
                      (local.get $comparator))
                    (if  ;; label = @7
                      (i32.gt_s
                        (call_indirect $0 (type 2))
                        (i32.const 0))
                      (then
                        (i32.store offset=4
                          (i32.add
                            (local.get $ptr)
                            (i32.shl
                              (local.get $j)
                              (i32.const 2)))
                          (local.get $a))
                        (local.set $j
                          (i32.sub
                            (local.get $j)
                            (i32.const 1))))
                      (else
                        (br 3 (;@4;))))
                    (br 1 (;@5;))))))
            (i32.store offset=4
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 2)))
              (local.get $min))
            (local.set $i
              (i32.add
                (local.get $i)
                (i32.const 2)))
            (br 1 (;@2;)))))))
  (func $~lib/util/sort/extendRunRight<u32> (type 5) (param $ptr i32) (param $i i32) (param $right i32) (param $comparator i32) (result i32)
    (local $j i32) (local $k i32) (local $tmp i32)
    (if  ;; label = @1
      (i32.eq
        (local.get $i)
        (local.get $right))
      (then
        (return
          (local.get $i))))
    (local.set $j
      (local.get $i))
    (i32.load
      (i32.add
        (local.get $ptr)
        (i32.shl
          (local.get $j)
          (i32.const 2))))
    (i32.load
      (i32.add
        (local.get $ptr)
        (i32.shl
          (local.tee $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (i32.const 2))))
    (global.set $~argumentsLength
      (i32.const 2))
    (i32.load
      (local.get $comparator))
    (if  ;; label = @1
      (i32.gt_s
        (call_indirect $0 (type 2))
        (i32.const 0))
      (then
        (block  ;; label = @2
          (loop  ;; label = @3
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.lt_s
                  (local.get $j)
                  (local.get $right))
                (then
                  (i32.load offset=4
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $j)
                        (i32.const 2))))
                  (i32.load
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $j)
                        (i32.const 2))))
                  (global.set $~argumentsLength
                    (i32.const 2))
                  (i32.load
                    (local.get $comparator))
                  (i32.shr_u
                    (call_indirect $0 (type 2))
                    (i32.const 31)))
                (else
                  (i32.const 0)))
              (then
                (local.set $j
                  (i32.add
                    (local.get $j)
                    (i32.const 1)))
                (br 1 (;@3;))))))
        (local.set $k
          (local.get $j))
        (block  ;; label = @2
          (loop  ;; label = @3
            (if  ;; label = @4
              (i32.lt_s
                (local.get $i)
                (local.get $k))
              (then
                (local.set $tmp
                  (i32.load
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $i)
                        (i32.const 2)))))
                (i32.store
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $i)
                      (i32.const 2)))
                  (i32.load
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $k)
                        (i32.const 2)))))
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 1)))
                (i32.store
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $k)
                      (i32.const 2)))
                  (local.get $tmp))
                (local.set $k
                  (i32.sub
                    (local.get $k)
                    (i32.const 1)))
                (br 1 (;@3;)))))))
      (else
        (loop  ;; label = @2
          (if  ;; label = @3
            (if (result i32)  ;; label = @4
              (i32.lt_s
                (local.get $j)
                (local.get $right))
              (then
                (i32.load offset=4
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $j)
                      (i32.const 2))))
                (i32.load
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $j)
                      (i32.const 2))))
                (global.set $~argumentsLength
                  (i32.const 2))
                (i32.load
                  (local.get $comparator))
                (i32.ge_s
                  (call_indirect $0 (type 2))
                  (i32.const 0)))
              (else
                (i32.const 0)))
            (then
              (local.set $j
                (i32.add
                  (local.get $j)
                  (i32.const 1)))
              (br 1 (;@2;)))))))
    (return
      (local.get $j)))
  (func $~lib/util/sort/mergeRuns<u32> (type 15) (param $ptr i32) (param $l i32) (param $m i32) (param $r i32) (param $buffer i32) (param $comparator i32)
    (local $i i32) (local $j i32) (local $t i32) (local $k i32) (local $a i32) (local $b i32)
    (local.set $m
      (i32.sub
        (local.get $m)
        (i32.const 1)))
    (local.set $t
      (i32.add
        (local.get $r)
        (local.get $m)))
    (local.set $i
      (i32.add
        (local.get $m)
        (i32.const 1)))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.gt_s
          (local.get $i)
          (local.get $l))
        (then
          (i32.store
            (i32.add
              (local.get $buffer)
              (i32.shl
                (i32.sub
                  (local.get $i)
                  (i32.const 1))
                (i32.const 2)))
            (i32.load
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (i32.sub
                    (local.get $i)
                    (i32.const 1))
                  (i32.const 2)))))
          (local.set $i
            (i32.sub
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $j
      (local.get $m))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_s
          (local.get $j)
          (local.get $r))
        (then
          (i32.store
            (i32.add
              (local.get $buffer)
              (i32.shl
                (i32.sub
                  (local.get $t)
                  (local.get $j))
                (i32.const 2)))
            (i32.load offset=4
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 2)))))
          (local.set $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $k
      (local.get $l))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.le_s
          (local.get $k)
          (local.get $r))
        (then
          (local.set $a
            (i32.load
              (i32.add
                (local.get $buffer)
                (i32.shl
                  (local.get $j)
                  (i32.const 2)))))
          (local.set $b
            (i32.load
              (i32.add
                (local.get $buffer)
                (i32.shl
                  (local.get $i)
                  (i32.const 2)))))
          (local.get $a)
          (local.get $b)
          (global.set $~argumentsLength
            (i32.const 2))
          (i32.load
            (local.get $comparator))
          (if  ;; label = @3
            (i32.lt_s
              (call_indirect $0 (type 2))
              (i32.const 0))
            (then
              (i32.store
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $k)
                    (i32.const 2)))
                (local.get $a))
              (local.set $j
                (i32.sub
                  (local.get $j)
                  (i32.const 1))))
            (else
              (i32.store
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $k)
                    (i32.const 2)))
                (local.get $b))
              (local.set $i
                (i32.add
                  (local.get $i)
                  (i32.const 1)))))
          (local.set $k
            (i32.add
              (local.get $k)
              (i32.const 1)))
          (br 1 (;@1;))))))
  (func $~lib/map/Map<u64_u32>#get:buckets (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/Map<u64_u32>#get:bucketsMask (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_u32>#get:taggedNext (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_u32>#get:key (type 12) (param $this i32) (result i64)
    (i64.load
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_u32>#set:value (type 0) (param $this i32) (param $value i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $value)))
  (func $~lib/map/Map<u64_u32>#get:entriesOffset (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/map/Map<u64_u32>#get:entriesCapacity (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/map/Map<u64_u32>#get:entriesCount (type 1) (param $this i32) (result i32)
    (i32.load offset=20
      (local.get $this)))
  (func $~lib/map/Map<u64_u32>#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_u32>#set:key (type 13) (param $this i32) (param $key i64)
    (i64.store
      (local.get $this)
      (local.get $key)))
  (func $~lib/map/MapEntry<u64_u32>#get:value (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u64_u32>#set:taggedNext (type 0) (param $this i32) (param $taggedNext i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $taggedNext)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#set:buckets (type 0) (param $this i32) (param $buckets i32)
    (i32.store
      (local.get $this)
      (local.get $buckets))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buckets)
      (i32.const 0)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#set:bucketsMask (type 0) (param $this i32) (param $bucketsMask i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $bucketsMask)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesCapacity (type 0) (param $this i32) (param $entriesCapacity i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $entriesCapacity)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesOffset (type 0) (param $this i32) (param $entriesOffset i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $entriesOffset)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesCount (type 0) (param $this i32) (param $entriesCount i32)
    (i32.store offset=20
      (local.get $this)
      (local.get $entriesCount)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#get:buckets (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#get:bucketsMask (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:taggedNext (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:key (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:value (type 0) (param $this i32) (param $value i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $value)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesOffset (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesCapacity (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesCount (type 1) (param $this i32) (result i32)
    (i32.load offset=20
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:key (type 0) (param $this i32) (param $key i32)
    (i32.store
      (local.get $this)
      (local.get $key)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:value (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:taggedNext (type 0) (param $this i32) (param $taggedNext i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $taggedNext)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:buckets (type 0) (param $this i32) (param $buckets i32)
    (i32.store
      (local.get $this)
      (local.get $buckets))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $buckets)
      (i32.const 0)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:bucketsMask (type 0) (param $this i32) (param $bucketsMask i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $bucketsMask)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entries (type 0) (param $this i32) (param $entries i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $entries))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $entries)
      (i32.const 0)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesCapacity (type 0) (param $this i32) (param $entriesCapacity i32)
    (i32.store offset=12
      (local.get $this)
      (local.get $entriesCapacity)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesOffset (type 0) (param $this i32) (param $entriesOffset i32)
    (i32.store offset=16
      (local.get $this)
      (local.get $entriesOffset)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesCount (type 0) (param $this i32) (param $entriesCount i32)
    (i32.store offset=20
      (local.get $this)
      (local.get $entriesCount)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:buckets (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:bucketsMask (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:taggedNext (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:key (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:value (type 0) (param $this i32) (param $value i32)
    (i32.store offset=4
      (local.get $this)
      (local.get $value)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesOffset (type 1) (param $this i32) (result i32)
    (i32.load offset=16
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesCapacity (type 1) (param $this i32) (result i32)
    (i32.load offset=12
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesCount (type 1) (param $this i32) (result i32)
    (i32.load offset=20
      (local.get $this)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entries (type 1) (param $this i32) (result i32)
    (i32.load offset=8
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:key (type 0) (param $this i32) (param $key i32)
    (i32.store
      (local.get $this)
      (local.get $key)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:value (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:taggedNext (type 0) (param $this i32) (param $taggedNext i32)
    (i32.store offset=8
      (local.get $this)
      (local.get $taggedNext)))
  (func $~lib/rt/__visit_globals (type 6) (param i32)
    (local i32)
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/args))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/sourceMapPath))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/watPath))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/offsetMapPath))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/sourceMapJson))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/sourceMap))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/watText))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/offsetMapJson))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/offsetEntries))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/lineToOffset))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/cMap))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/index/annotatedWat))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0))))
    (call $~lib/rt/itcms/__visit
      (i32.const 528)
      (local.get 0))
    (call $~lib/rt/itcms/__visit
      (i32.const 768)
      (local.get 0))
    (call $~lib/rt/itcms/__visit
      (i32.const 1248)
      (local.get 0))
    (call $~lib/rt/itcms/__visit
      (i32.const 2336)
      (local.get 0))
    (call $~lib/rt/itcms/__visit
      (i32.const 336)
      (local.get 0))
    (call $~lib/rt/itcms/__visit
      (i32.const 224)
      (local.get 0))
    (if  ;; label = @1
      (local.tee 1
        (global.get $src/sourcemap/BASE64_CHARS))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 1)
          (local.get 0)))))
  (func $~lib/arraybuffer/ArrayBufferView~visit (type 0) (param i32 i32)
    (local i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (if  ;; label = @1
      (local.tee 2
        (i32.load
          (local.get 0)))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 2)
          (local.get 1)))))
  (func $~lib/object/Object~visit (type 0) (param i32 i32)
    (nop))
  (func $~lib/array/Array<~lib/string/String>#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<~lib/string/String>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/array/Array<~lib/string/String>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/as-wasi/assembly/as-wasi/CommandLine~visit (type 0) (param i32 i32)
    (local i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (if  ;; label = @1
      (local.tee 2
        (i32.load
          (local.get 0)))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 2)
          (local.get 1)))))
  (func $~lib/array/Array<i32>#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<i32>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/array/Array<i32>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/array/Array<u8>#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<u8>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/array/Array<u8>#__visit
      (local.get 0)
      (local.get 1)))
  (func $src/sourcemap/SourceMap~visit (type 0) (param i32 i32)
    (local i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (if  ;; label = @1
      (local.tee 2
        (i32.load
          (local.get 0)))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 2)
          (local.get 1))))
    (if  ;; label = @1
      (local.tee 2
        (i32.load offset=4
          (local.get 0)))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 2)
          (local.get 1)))))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/function/Function<%28src/sourcemap/SourceMapEntry%2Csrc/sourcemap/SourceMapEntry%29=>i32>#get:_env (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/function/Function<%28src/sourcemap/SourceMapEntry%2Csrc/sourcemap/SourceMapEntry%29=>i32>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/function/Function<%28src/sourcemap/SourceMapEntry%2Csrc/sourcemap/SourceMapEntry%29=>i32>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/map/Map<u32_u32>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/map/Map<u32_u32>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/map/Map<u64_~lib/string/String>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/map/Map<u64_~lib/string/String>#__visit
      (local.get 0)
      (local.get 1)))
  (func $src/comments/SourceComment~visit (type 0) (param i32 i32)
    (local i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (if  ;; label = @1
      (local.tee 2
        (i32.load offset=4
          (local.get 0)))
      (then
        (call $~lib/rt/itcms/__visit
          (local.get 2)
          (local.get 1)))))
  (func $~lib/array/Array<src/comments/SourceComment>#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<src/comments/SourceComment>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/array/Array<src/comments/SourceComment>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/set/Set<u64>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/set/Set<u64>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/array/Array<u32>#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<u32>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/array/Array<u32>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/array/Array<u64>#get:buffer (type 1) (param $this i32) (result i32)
    (i32.load
      (local.get $this)))
  (func $~lib/array/Array<u64>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/array/Array<u64>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/function/Function<%28u64%2Cu64%29=>i32>#get:_env (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/function/Function<%28u64%2Cu64%29=>i32>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/function/Function<%28u64%2Cu64%29=>i32>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/set/Set<u32>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/set/Set<u32>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/map/Map<u64_u32>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/map/Map<u64_u32>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/function/Function<%28u32%2Cu32%29=>i32>#get:_env (type 1) (param $this i32) (result i32)
    (i32.load offset=4
      (local.get $this)))
  (func $~lib/function/Function<%28u32%2Cu32%29=>i32>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/function/Function<%28u32%2Cu32%29=>i32>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>~visit (type 0) (param i32 i32)
    (call $~lib/object/Object~visit
      (local.get 0)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#__visit
      (local.get 0)
      (local.get 1)))
  (func $~lib/rt/__visit_members (type 0) (param i32 i32)
    (block  ;; label = @1
      (block  ;; label = @2
        (block  ;; label = @3
          (block  ;; label = @4
            (block  ;; label = @5
              (block  ;; label = @6
                (block  ;; label = @7
                  (block  ;; label = @8
                    (block  ;; label = @9
                      (block  ;; label = @10
                        (block  ;; label = @11
                          (block  ;; label = @12
                            (block  ;; label = @13
                              (block  ;; label = @14
                                (block  ;; label = @15
                                  (block  ;; label = @16
                                    (block  ;; label = @17
                                      (block  ;; label = @18
                                        (block  ;; label = @19
                                          (block  ;; label = @20
                                            (block  ;; label = @21
                                              (block  ;; label = @22
                                                (block  ;; label = @23
                                                  (block  ;; label = @24
                                                    (block  ;; label = @25
                                                      (block  ;; label = @26
                                                        (block  ;; label = @27
                                                          (block  ;; label = @28
                                                            (block  ;; label = @29
                                                              (block  ;; label = @30
                                                                (block  ;; label = @31
                                                                  (br_table 0 (;@31;) 1 (;@30;) 2 (;@29;) 3 (;@28;) 4 (;@27;) 5 (;@26;) 6 (;@25;) 7 (;@24;) 8 (;@23;) 9 (;@22;) 10 (;@21;) 11 (;@20;) 12 (;@19;) 13 (;@18;) 14 (;@17;) 15 (;@16;) 16 (;@15;) 17 (;@14;) 18 (;@13;) 19 (;@12;) 20 (;@11;) 21 (;@10;) 22 (;@9;) 23 (;@8;) 24 (;@7;) 25 (;@6;) 26 (;@5;) 27 (;@4;) 28 (;@3;) 29 (;@2;) 30 (;@1;)
                                                                    (i32.load
                                                                      (i32.sub
                                                                        (local.get 0)
                                                                        (i32.const 8)))))
                                                                (return))
                                                              (return))
                                                            (return))
                                                          (call $~lib/arraybuffer/ArrayBufferView~visit
                                                            (local.get 0)
                                                            (local.get 1))
                                                          (return))
                                                        (call $~lib/array/Array<~lib/string/String>~visit
                                                          (local.get 0)
                                                          (local.get 1))
                                                        (return))
                                                      (call $~lib/as-wasi/assembly/as-wasi/CommandLine~visit
                                                        (local.get 0)
                                                        (local.get 1))
                                                      (return))
                                                    (call $~lib/array/Array<i32>~visit
                                                      (local.get 0)
                                                      (local.get 1))
                                                    (return))
                                                  (call $~lib/array/Array<u8>~visit
                                                    (local.get 0)
                                                    (local.get 1))
                                                  (return))
                                                (call $src/sourcemap/SourceMap~visit
                                                  (local.get 0)
                                                  (local.get 1))
                                                (return))
                                              (return))
                                            (call $~lib/array/Array<src/sourcemap/SourceMapEntry>~visit
                                              (local.get 0)
                                              (local.get 1))
                                            (return))
                                          (return))
                                        (call $~lib/function/Function<%28src/sourcemap/SourceMapEntry%2Csrc/sourcemap/SourceMapEntry%29=>i32>~visit
                                          (local.get 0)
                                          (local.get 1))
                                        (return))
                                      (return))
                                    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>~visit
                                      (local.get 0)
                                      (local.get 1))
                                    (return))
                                  (return))
                                (call $~lib/map/Map<u32_u32>~visit
                                  (local.get 0)
                                  (local.get 1))
                                (return))
                              (call $~lib/map/Map<u64_~lib/string/String>~visit
                                (local.get 0)
                                (local.get 1))
                              (return))
                            (call $src/comments/SourceComment~visit
                              (local.get 0)
                              (local.get 1))
                            (return))
                          (call $~lib/array/Array<src/comments/SourceComment>~visit
                            (local.get 0)
                            (local.get 1))
                          (return))
                        (call $~lib/set/Set<u64>~visit
                          (local.get 0)
                          (local.get 1))
                        (return))
                      (call $~lib/array/Array<u32>~visit
                        (local.get 0)
                        (local.get 1))
                      (return))
                    (call $~lib/array/Array<u64>~visit
                      (local.get 0)
                      (local.get 1))
                    (return))
                  (call $~lib/map/Map<u32_~lib/array/Array<u64>>~visit
                    (local.get 0)
                    (local.get 1))
                  (return))
                (call $~lib/function/Function<%28u64%2Cu64%29=>i32>~visit
                  (local.get 0)
                  (local.get 1))
                (return))
              (call $~lib/set/Set<u32>~visit
                (local.get 0)
                (local.get 1))
              (return))
            (call $~lib/map/Map<u64_u32>~visit
              (local.get 0)
              (local.get 1))
            (return))
          (call $~lib/function/Function<%28u32%2Cu32%29=>i32>~visit
            (local.get 0)
            (local.get 1))
          (return))
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>~visit
          (local.get 0)
          (local.get 1))
        (return))
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>~visit
        (local.get 0)
        (local.get 1))
      (return))
    (unreachable))
  (func $~start (type 8)
    (if  ;; label = @1
      (global.get $~started)
      (then
        (return)))
    (global.set $~started
      (i32.const 1))
    (call $start:src/index))
  (func $~stack_check (type 8)
    (if  ;; label = @1
      (i32.lt_s
        (global.get $~lib/memory/__stack_pointer)
        (global.get $~lib/memory/__data_end))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 35568)
          (i32.const 35616)
          (i32.const 1)
          (i32.const 1))
        (unreachable))))
  (func $~lib/string/String.__eq (type 2) (param $left i32) (param $right i32) (result i32)
    (local $leftLength i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eq
        (local.get $left)
        (local.get $right))
      (then
        (local.set 3
          (i32.const 1))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 3))))
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.eq
          (local.get $left)
          (i32.const 0))
        (then
          (i32.const 1))
        (else
          (i32.eq
            (local.get $right)
            (i32.const 0))))
      (then
        (local.set 3
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 3))))
    (local.set 3
      (local.get $left))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $leftLength
      (call $~lib/string/String#get:length
        (local.get 3)))
    (local.get $leftLength)
    (local.set 3
      (local.get $right))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/string/String#get:length
      (local.get 3))
    (if  ;; label = @1
      (i32.ne)
      (then
        (local.set 3
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 3))))
    (local.set 3
      (local.get $left))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (i32.const 0)
    (local.set 3
      (local.get $right))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (i32.const 0)
    (local.get $leftLength)
    (local.set 3
      (i32.eqz
        (call $~lib/util/string/compareImpl)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 3)))
  (func $~lib/string/String.__ne (type 2) (param $left i32) (param $right i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 2
      (local.get $left))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (local.set 2
      (local.get $right))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (local.set 2
      (i32.eqz
        (call $~lib/string/String.__eq)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 2)))
  (func $~lib/wasi_internal/wasi_abort (type 17) (param $message i32) (param $fileName i32) (param $lineNumber i32) (param $columnNumber i32)
    (local $ptr i32) (local $5 i32) (local $len i32) (local $t i32) (local $8 i32) (local $t|9 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (call $~lib/bindings/wasi_snapshot_preview1/iovec#set:buf
      (i32.const 0)
      (i32.const 12))
    (local.set $ptr
      (i32.const 12))
    (i64.store
      (local.get $ptr)
      (i64.const 9071471065260641))
    (local.set $ptr
      (i32.add
        (local.get $ptr)
        (i32.const 7)))
    (local.set 10
      (local.get $message))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (if  ;; label = @1
      (call $~lib/string/String.__ne
        (local.get 10)
        (i32.const 0))
      (then
        (local.get $ptr)
        (local.get $message)
        (local.set 10
          (local.get $message))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 10))
        (call $~lib/string/String#get:length
          (local.get 10))
        (local.get $ptr)
        (i32.const 0)
        (global.set $~argumentsLength
          (i32.const 3))
        (local.set $ptr
          (i32.add
            (i32.const 0)
            (call $~lib/string/String.UTF8.encodeUnsafe@varargs)))))
    (i32.store
      (local.get $ptr)
      (i32.const 544106784))
    (local.set $ptr
      (i32.add
        (local.get $ptr)
        (i32.const 4)))
    (local.set 10
      (local.get $fileName))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (if  ;; label = @1
      (call $~lib/string/String.__ne
        (local.get 10)
        (i32.const 0))
      (then
        (local.get $ptr)
        (local.get $fileName)
        (local.set 10
          (local.get $fileName))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 10))
        (call $~lib/string/String#get:length
          (local.get 10))
        (local.get $ptr)
        (i32.const 0)
        (global.set $~argumentsLength
          (i32.const 3))
        (local.set $ptr
          (i32.add
            (i32.const 0)
            (call $~lib/string/String.UTF8.encodeUnsafe@varargs)))))
    (local.set $ptr
      (i32.add
        (local.tee $5
          (local.get $ptr))
        (i32.const 1)))
    (i32.store8
      (local.get $5)
      (i32.const 40))
    (local.set $len
      (call $~lib/util/number/decimalCount32
        (local.get $lineNumber)))
    (local.set $ptr
      (i32.add
        (local.get $ptr)
        (local.get $len)))
    (loop  ;; label = @1
      (local.set $t
        (i32.div_u
          (local.get $lineNumber)
          (i32.const 10)))
      (i32.store8
        (local.tee $ptr
          (i32.sub
            (local.get $ptr)
            (i32.const 1)))
        (i32.add
          (i32.const 48)
          (i32.rem_u
            (local.get $lineNumber)
            (i32.const 10))))
      (local.set $lineNumber
        (local.get $t))
      (br_if 0 (;@1;)
        (local.get $lineNumber)))
    (local.set $ptr
      (i32.add
        (local.get $ptr)
        (local.get $len)))
    (local.set $ptr
      (i32.add
        (local.tee $8
          (local.get $ptr))
        (i32.const 1)))
    (i32.store8
      (local.get $8)
      (i32.const 58))
    (local.set $len
      (call $~lib/util/number/decimalCount32
        (local.get $columnNumber)))
    (local.set $ptr
      (i32.add
        (local.get $ptr)
        (local.get $len)))
    (loop  ;; label = @1
      (local.set $t|9
        (i32.div_u
          (local.get $columnNumber)
          (i32.const 10)))
      (i32.store8
        (local.tee $ptr
          (i32.sub
            (local.get $ptr)
            (i32.const 1)))
        (i32.add
          (i32.const 48)
          (i32.rem_u
            (local.get $columnNumber)
            (i32.const 10))))
      (local.set $columnNumber
        (local.get $t|9))
      (br_if 0 (;@1;)
        (local.get $columnNumber)))
    (local.set $ptr
      (i32.add
        (local.get $ptr)
        (local.get $len)))
    (i32.store16
      (local.get $ptr)
      (i32.const 2601))
    (local.set $ptr
      (i32.add
        (local.get $ptr)
        (i32.const 2)))
    (call $~lib/bindings/wasi_snapshot_preview1/iovec#set:buf_len
      (i32.const 0)
      (i32.sub
        (local.get $ptr)
        (i32.const 12)))
    (drop
      (call $~lib/bindings/wasi_snapshot_preview1/fd_write
        (i32.const 2)
        (i32.const 0)
        (i32.const 1)
        (i32.const 8)))
    (call $~lib/bindings/wasi_snapshot_preview1/proc_exit
      (i32.const 255))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/ensureCapacity (type 17) (param $array i32) (param $newSize i32) (param $alignLog2 i32) (param $canGrow i32)
    (local $oldCapacity i32) (local $oldData i32) (local $6 i32) (local $7 i32) (local $newCapacity i32) (local $9 i32) (local $10 i32) (local $11 i32) (local $12 i32) (local $newData i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 14
      (local.get $array))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.set $oldCapacity
      (call $~lib/arraybuffer/ArrayBufferView#get:byteLength
        (local.get 14)))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $newSize)
        (i32.shr_u
          (local.get $oldCapacity)
          (local.get $alignLog2)))
      (then
        (if  ;; label = @2
          (i32.gt_u
            (local.get $newSize)
            (i32.shr_u
              (i32.const 1073741820)
              (local.get $alignLog2)))
          (then
            (call $~lib/wasi_internal/wasi_abort
              (i32.const 768)
              (i32.const 880)
              (i32.const 19)
              (i32.const 48))
            (unreachable)))
        (local.set 14
          (local.get $array))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 14))
        (local.set $oldData
          (call $~lib/arraybuffer/ArrayBufferView#get:buffer
            (local.get 14)))
        (local.set $newCapacity
          (i32.shl
            (select
              (local.tee $6
                (local.get $newSize))
              (local.tee $7
                (i32.const 8))
              (i32.gt_u
                (local.get $6)
                (local.get $7)))
            (local.get $alignLog2)))
        (if  ;; label = @2
          (local.get $canGrow)
          (then
            (local.set $newCapacity
              (select
                (local.tee $11
                  (select
                    (local.tee $9
                      (i32.shl
                        (local.get $oldCapacity)
                        (i32.const 1)))
                    (local.tee $10
                      (i32.const 1073741820))
                    (i32.lt_u
                      (local.get $9)
                      (local.get $10))))
                (local.tee $12
                  (local.get $newCapacity))
                (i32.gt_u
                  (local.get $11)
                  (local.get $12))))))
        (local.set $newData
          (call $~lib/rt/itcms/__renew
            (local.get $oldData)
            (local.get $newCapacity)))
        (drop
          (i32.ne
            (i32.const 2)
            (global.get $~lib/shared/runtime/Runtime.Incremental)))
        (if  ;; label = @2
          (i32.ne
            (local.get $newData)
            (local.get $oldData))
          (then
            (i32.store
              (local.get $array)
              (local.get $newData))
            (i32.store offset=4
              (local.get $array)
              (local.get $newData))
            (call $~lib/rt/itcms/__link
              (local.get $array)
              (local.get $newData)
              (i32.const 0))))
        (i32.store offset=8
          (local.get $array)
          (local.get $newCapacity))))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<~lib/string/String>#push (type 2) (param $this i32) (param $value i32) (result i32)
    (local $oldLen i32) (local $len i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.set $oldLen
      (call $~lib/array/Array<~lib/string/String>#get:length_
        (local.get 4)))
    (local.set $len
      (i32.add
        (local.get $oldLen)
        (i32.const 1)))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $len)
      (i32.const 2)
      (i32.const 1))
    (drop
      (i32.const 1))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (i32.store
      (i32.add
        (call $~lib/array/Array<~lib/string/String>#get:dataStart
          (local.get 4))
        (i32.shl
          (local.get $oldLen)
          (i32.const 2)))
      (local.get $value))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $value)
      (i32.const 1))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/array/Array<~lib/string/String>#set:length_
      (local.get 4)
      (local.get $len))
    (local.set 4
      (local.get $len))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 4)))
  (func $~lib/as-wasi/assembly/as-wasi/CommandLine#constructor (type 1) (param $this i32) (result i32)
    (local $1 i32) (local $2 i32) (local $count_and_size i32) (local $ret i32) (local $count i32) (local $size i32) (local $env_ptrs i32) (local $buf i32) (local $i i32) (local $env_ptr i32) (local $cstring i32) (local $size|12 i32) (local $arg i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 20)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 20))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 4)
              (i32.const 5))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/as-wasi/assembly/as-wasi/CommandLine#set:args
      (local.get 14)
      (i32.const 0))
    (local.set 14
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (call $~lib/rt/__newArray
        (i32.const 0)
        (i32.const 2)
        (i32.const 4)
        (i32.const 192)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/as-wasi/assembly/as-wasi/CommandLine#set:args)
    (local.set $count_and_size
      (i32.const 720))
    (local.set $ret
      (call $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/args_sizes_get
        (local.get $count_and_size)
        (i32.add
          (local.get $count_and_size)
          (i32.const 4))))
    (if  ;; label = @1
      (i32.ne
        (i32.and
          (local.get $ret)
          (i32.const 65535))
        (i32.const 0))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 0)
          (i32.const 0)
          (i32.const 0))))
    (local.set $count
      (i32.load
        (local.get $count_and_size)))
    (local.set $size
      (i32.load offset=4
        (local.get $count_and_size)))
    (local.set $env_ptrs
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.add
            (local.get $count)
            (i32.const 1))
          (i32.const 4))))
    (local.set $buf
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (local.get $size)))
    (if  ;; label = @1
      (i32.ne
        (i32.and
          (call $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/args_get
            (local.get $env_ptrs)
            (local.get $buf))
          (i32.const 65535))
        (i32.const 0))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 0)
          (i32.const 0)
          (i32.const 0))))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_u
          (local.get $i)
          (local.get $count))
        (then
          (local.set $env_ptr
            (i32.load
              (i32.add
                (local.get $env_ptrs)
                (i32.mul
                  (local.get $i)
                  (i32.const 4)))))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.tee $arg
              (block (result i32)  ;; label = @3
                (local.set $cstring
                  (local.get $env_ptr))
                (local.set $size|12
                  (i32.const 0))
                (block  ;; label = @4
                  (loop  ;; label = @5
                    (if  ;; label = @6
                      (i32.ne
                        (i32.load8_u
                          (i32.add
                            (local.get $cstring)
                            (local.get $size|12)))
                        (i32.const 0))
                      (then
                        (local.set $size|12
                          (i32.add
                            (local.get $size|12)
                            (i32.const 1)))
                        (br 1 (;@5;))))))
                (br 0 (;@3;)
                  (call $~lib/string/String.UTF8.decodeUnsafe
                    (local.get $cstring)
                    (local.get $size|12)
                    (i32.const 0))))))
          (local.set 14
            (local.get $this))
          (i32.store offset=16
            (global.get $~lib/memory/__stack_pointer)
            (local.get 14))
          (local.set 14
            (call $~lib/as-wasi/assembly/as-wasi/CommandLine#get:args
              (local.get 14)))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 14))
          (local.get 14)
          (local.set 14
            (local.get $arg))
          (i32.store offset=8
            (global.get $~lib/memory/__stack_pointer)
            (local.get 14))
          (local.get 14)
          (drop
            (call $~lib/array/Array<~lib/string/String>#push))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 14
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 20)))
    (local.get 14))
  (func $~lib/array/Array<~lib/string/String>#get:length (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.set 1
      (call $~lib/array/Array<~lib/string/String>#get:length_
        (local.get 1)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 1)))
  (func $~lib/string/String.UTF8.encode (type 3) (param $str i32) (param $nullTerminated i32) (param $errorMode i32) (result i32)
    (local $buf i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 4
      (local.get $str))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.tee $buf
      (call $~lib/rt/itcms/__new
        (call $~lib/string/String.UTF8.byteLength
          (local.get 4)
          (local.get $nullTerminated))
        (i32.const 1)))
    (i32.store offset=4)
    (local.get $str)
    (local.set 4
      (local.get $str))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/string/String#get:length
      (local.get 4))
    (local.get $buf)
    (local.get $nullTerminated)
    (local.get $errorMode)
    (drop
      (call $~lib/string/String.UTF8.encodeUnsafe))
    (local.set 4
      (local.get $buf))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 4)))
  (func $~lib/string/String.UTF8.encode@varargs (type 3) (param $str i32) (param $nullTerminated i32) (param $errorMode i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (block  ;; label = @1
      (block  ;; label = @2
        (block  ;; label = @3
          (block  ;; label = @4
            (br_table 1 (;@3;) 2 (;@2;) 3 (;@1;) 0 (;@4;)
              (i32.sub
                (global.get $~argumentsLength)
                (i32.const 1))))
          (unreachable))
        (local.set $nullTerminated
          (i32.const 0)))
      (local.set $errorMode
        (i32.const 0)))
    (local.set 3
      (local.get $str))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set 3
      (call $~lib/string/String.UTF8.encode
        (local.get 3)
        (local.get $nullTerminated)
        (local.get $errorMode)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (local.get 3))
  (func $~lib/as-wasi/assembly/as-wasi/Descriptor#writeStringLn (type 0) (param $this i32) (param $s i32)
    (local $s_utf8_buf i32) (local $s_utf8_len i32) (local $iov i32) (local $lf i32) (local $written_ptr i32) (local $this|7 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 8
      (local.get $s))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.get 8)
    (i32.const 0)
    (global.set $~argumentsLength
      (i32.const 1))
    (i32.store offset=4
      (i32.const 0)
      (local.tee $s_utf8_buf
        (call $~lib/string/String.UTF8.encode@varargs)))
    (local.set 8
      (local.get $s_utf8_buf))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $s_utf8_len
      (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
        (local.get 8)))
    (local.set $iov
      (i32.const 1136))
    (i32.store
      (local.get $iov)
      (local.get $s_utf8_buf))
    (i32.store offset=4
      (local.get $iov)
      (local.get $s_utf8_len))
    (local.set $lf
      (i32.const 1168))
    (i32.store8
      (local.get $lf)
      (i32.const 10))
    (i32.store offset=8
      (local.get $iov)
      (local.get $lf))
    (i32.store offset=12
      (local.get $iov)
      (i32.const 1))
    (local.set $written_ptr
      (i32.const 1184))
    (drop
      (call $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/fd_write
        (block (result i32)  ;; label = @1
          (local.set $this|7
            (local.get $this))
          (br 0 (;@1;)
            (local.get $this|7)))
        (local.get $iov)
        (i32.const 2)
        (local.get $written_ptr)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8))))
  (func $~lib/as-wasi/assembly/as-wasi/Descriptor#writeString (type 7) (param $this i32) (param $s i32) (param $newline i32)
    (local $s_utf8_buf i32) (local $s_utf8_len i32) (local $iov i32) (local $written_ptr i32) (local $this|7 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (local.get $newline)
      (then
        (local.get $this)
        (local.set 8
          (local.get $s))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/as-wasi/assembly/as-wasi/Descriptor#writeStringLn)
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return)))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 8
      (local.get $s))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.get 8)
    (i32.const 0)
    (global.set $~argumentsLength
      (i32.const 1))
    (i32.store offset=4
      (i32.const 0)
      (local.tee $s_utf8_buf
        (call $~lib/string/String.UTF8.encode@varargs)))
    (local.set 8
      (local.get $s_utf8_buf))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $s_utf8_len
      (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
        (local.get 8)))
    (local.set $iov
      (i32.const 1200))
    (i32.store
      (local.get $iov)
      (local.get $s_utf8_buf))
    (i32.store offset=4
      (local.get $iov)
      (local.get $s_utf8_len))
    (local.set $written_ptr
      (i32.const 1216))
    (drop
      (call $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/fd_write
        (block (result i32)  ;; label = @1
          (local.set $this|7
            (local.get $this))
          (br 0 (;@1;)
            (local.get $this|7)))
        (local.get $iov)
        (i32.const 1)
        (local.get $written_ptr)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8))))
  (func $~lib/as-wasi/assembly/as-wasi/Console.error (type 0) (param $s i32) (param $newline i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (block (result i32)  ;; label = @1
      (br 0 (;@1;)
        (call $~lib/as-wasi/assembly/as-wasi/Descriptor#constructor
          (i32.const 0)
          (i32.const 2))))
    (local.set 2
      (local.get $s))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (local.get $newline)
    (call $~lib/as-wasi/assembly/as-wasi/Descriptor#writeString)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<~lib/string/String>#__get (type 2) (param $this i32) (param $index i32) (result i32)
    (local $value i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.get $index)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<~lib/string/String>#get:length_
      (local.get 3))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 528)
          (i32.const 880)
          (i32.const 114)
          (i32.const 42))
        (unreachable)))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.tee $value
      (i32.load
        (i32.add
          (call $~lib/array/Array<~lib/string/String>#get:dataStart
            (local.get 3))
          (i32.shl
            (local.get $index)
            (i32.const 2)))))
    (i32.store offset=4)
    (drop
      (i32.const 1))
    (drop
      (i32.eqz
        (i32.const 0)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $value))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 1248)
          (i32.const 880)
          (i32.const 118)
          (i32.const 40))
        (unreachable)))
    (local.set 3
      (local.get $value))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 3)))
  (func $~lib/as-wasi/assembly/as-wasi/FileSystem.open (type 2) (param $path i32) (param $flags i32) (result i32)
    (local $dirfd i32) (local $fd_lookup_flags i32) (local $fd_oflags i32) (local $fd_flags i32) (local $path_utf8_buf i32) (local $path_utf8_len i32) (local $path_utf8 i32) (local $fd_buf i32) (local $res i32) (local $fd i32) (local i32) (local $fd_rights i64) (local $fd_rights_inherited i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 12
      (local.get $path))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 12))
    (local.set $dirfd
      (call $~lib/as-wasi/assembly/as-wasi/FileSystem.dirfdForPath
        (local.get 12)))
    (local.set $fd_lookup_flags
      (i32.const 1))
    (local.set $fd_oflags
      (i32.const 0))
    (local.set $fd_rights
      (i64.const 0))
    (local.set 12
      (local.get $flags))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 12))
    (local.get 12)
    (local.set 12
      (i32.const 1376))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 12))
    (local.get 12)
    (if  ;; label = @1
      (call $~lib/string/String.__eq)
      (then
        (local.set $fd_rights
          (i64.or
            (i64.or
              (i64.or
                (i64.or
                  (i64.const 2)
                  (i64.const 4))
                (i64.const 32))
              (i64.const 2097152))
            (i64.const 16384))))
      (else
        (local.set 12
          (local.get $flags))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 12))
        (local.get 12)
        (local.set 12
          (i32.const 1408))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 12))
        (local.get 12)
        (if  ;; label = @2
          (call $~lib/string/String.__eq)
          (then
            (local.set $fd_rights
              (i64.or
                (i64.or
                  (i64.or
                    (i64.or
                      (i64.or
                        (i64.const 64)
                        (i64.const 2))
                      (i64.const 4))
                    (i64.const 32))
                  (i64.const 2097152))
                (i64.const 1024))))
          (else
            (local.set 12
              (local.get $flags))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 12))
            (local.get 12)
            (local.set 12
              (i32.const 1440))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 12))
            (local.get 12)
            (if  ;; label = @3
              (call $~lib/string/String.__eq)
              (then
                (local.set $fd_oflags
                  (i32.or
                    (i32.const 1)
                    (i32.const 8)))
                (local.set $fd_rights
                  (i64.or
                    (i64.or
                      (i64.or
                        (i64.or
                          (i64.const 64)
                          (i64.const 4))
                        (i64.const 32))
                      (i64.const 2097152))
                    (i64.const 1024))))
              (else
                (local.set 12
                  (local.get $flags))
                (i32.store
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 12))
                (local.get 12)
                (local.set 12
                  (i32.const 1472))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 12))
                (local.get 12)
                (if  ;; label = @4
                  (call $~lib/string/String.__eq)
                  (then
                    (local.set $fd_oflags
                      (i32.or
                        (i32.or
                          (i32.const 1)
                          (i32.const 8))
                        (i32.const 4)))
                    (local.set $fd_rights
                      (i64.or
                        (i64.or
                          (i64.or
                            (i64.or
                              (i64.const 64)
                              (i64.const 4))
                            (i64.const 32))
                          (i64.const 2097152))
                        (i64.const 1024))))
                  (else
                    (local.set 12
                      (local.get $flags))
                    (i32.store
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (local.set 12
                      (i32.const 1504))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (if  ;; label = @5
                      (call $~lib/string/String.__eq)
                      (then
                        (local.set $fd_oflags
                          (i32.or
                            (i32.const 1)
                            (i32.const 8)))
                        (local.set $fd_rights
                          (i64.or
                            (i64.or
                              (i64.or
                                (i64.or
                                  (i64.or
                                    (i64.const 64)
                                    (i64.const 2))
                                  (i64.const 4))
                                (i64.const 32))
                              (i64.const 2097152))
                            (i64.const 1024))))
                      (else
                        (local.set 12
                          (local.get $flags))
                        (i32.store
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 12))
                        (local.get 12)
                        (local.set 12
                          (i32.const 1536))
                        (i32.store offset=4
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 12))
                        (local.get 12)
                        (if  ;; label = @6
                          (call $~lib/string/String.__eq)
                          (then
                            (local.set $fd_oflags
                              (i32.or
                                (i32.or
                                  (i32.const 1)
                                  (i32.const 8))
                                (i32.const 4)))
                            (local.set $fd_rights
                              (i64.or
                                (i64.or
                                  (i64.or
                                    (i64.or
                                      (i64.or
                                        (i64.const 64)
                                        (i64.const 2))
                                      (i64.const 4))
                                    (i64.const 32))
                                  (i64.const 2097152))
                                (i64.const 1024))))
                          (else
                            (local.set 12
                              (i32.const 0))
                            (global.set $~lib/memory/__stack_pointer
                              (i32.add
                                (global.get $~lib/memory/__stack_pointer)
                                (i32.const 12)))
                            (return
                              (local.get 12))))))))))))))
    (local.set $fd_rights_inherited
      (local.get $fd_rights))
    (local.set $fd_flags
      (i32.const 0))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 12
      (local.get $path))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 12))
    (local.get 12)
    (i32.const 0)
    (global.set $~argumentsLength
      (i32.const 1))
    (i32.store offset=8
      (i32.const 0)
      (local.tee $path_utf8_buf
        (call $~lib/string/String.UTF8.encode@varargs)))
    (local.set 12
      (local.get $path_utf8_buf))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 12))
    (local.set $path_utf8_len
      (call $~lib/arraybuffer/ArrayBuffer#get:byteLength
        (local.get 12)))
    (local.set $path_utf8
      (local.get $path_utf8_buf))
    (local.set $fd_buf
      (i32.const 1552))
    (local.set $res
      (call $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/path_open
        (local.get $dirfd)
        (local.get $fd_lookup_flags)
        (local.get $path_utf8)
        (local.get $path_utf8_len)
        (local.get $fd_oflags)
        (local.get $fd_rights)
        (local.get $fd_rights_inherited)
        (local.get $fd_flags)
        (local.get $fd_buf)))
    (if  ;; label = @1
      (i32.ne
        (i32.and
          (local.get $res)
          (i32.const 65535))
        (i32.const 0))
      (then
        (local.set 12
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 12)))
        (return
          (local.get 12))))
    (local.set $fd
      (i32.load
        (local.get $fd_buf)))
    (local.set 12
      (call $~lib/as-wasi/assembly/as-wasi/Descriptor#constructor
        (i32.const 0)
        (local.get $fd)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 12)))
  (func $~lib/string/String#concat (type 2) (param $this i32) (param $other i32) (result i32)
    (local $thisSize i32) (local $otherSize i32) (local $outSize i32) (local $out i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 6
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.set $thisSize
      (i32.shl
        (call $~lib/string/String#get:length
          (local.get 6))
        (i32.const 1)))
    (local.set 6
      (local.get $other))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.set $otherSize
      (i32.shl
        (call $~lib/string/String#get:length
          (local.get 6))
        (i32.const 1)))
    (local.set $outSize
      (i32.add
        (local.get $thisSize)
        (local.get $otherSize)))
    (if  ;; label = @1
      (i32.eq
        (local.get $outSize)
        (i32.const 0))
      (then
        (local.set 6
          (i32.const 1664))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 6))))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $out
        (call $~lib/rt/itcms/__new
          (local.get $outSize)
          (i32.const 2))))
    (memory.copy
      (local.get $out)
      (local.get $this)
      (local.get $thisSize))
    (memory.copy
      (i32.add
        (local.get $out)
        (local.get $thisSize))
      (local.get $other)
      (local.get $otherSize))
    (local.set 6
      (local.get $out))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 6)))
  (func $~lib/string/String.__concat (type 2) (param $left i32) (param $right i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 2
      (local.get $left))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (local.set 2
      (local.get $right))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (local.set 2
      (call $~lib/string/String#concat))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 2)))
  (func $~lib/array/Array<u8>#push (type 2) (param $this i32) (param $value i32) (result i32)
    (local $oldLen i32) (local $len i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.set $oldLen
      (call $~lib/array/Array<u8>#get:length_
        (local.get 4)))
    (local.set $len
      (i32.add
        (local.get $oldLen)
        (i32.const 1)))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $len)
      (i32.const 0)
      (i32.const 1))
    (drop
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (i32.store8
      (i32.add
        (call $~lib/array/Array<u8>#get:dataStart
          (local.get 4))
        (i32.shl
          (local.get $oldLen)
          (i32.const 0)))
      (local.get $value))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/array/Array<u8>#set:length_
      (local.get 4)
      (local.get $len))
    (local.set 4
      (local.get $len))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 4)))
  (func $~lib/as-wasi/assembly/as-wasi/Descriptor#readAll (type 3) (param $this i32) (param $data i32) (param $chunk_size i32) (result i32)
    (local $data_partial_len i32) (local $data_partial i32) (local $iov i32) (local $read_ptr i32) (local $read i32) (local $this|8 i32) (local $rawfd i32) (local $i i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $data_partial_len
      (local.get $chunk_size))
    (local.set $data_partial
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (local.get $data_partial_len)))
    (local.set $iov
      (i32.const 1712))
    (i32.store
      (local.get $iov)
      (local.get $data_partial))
    (i32.store offset=4
      (local.get $iov)
      (local.get $data_partial_len))
    (local.set $read_ptr
      (i32.const 1728))
    (local.set $read
      (i32.const 0))
    (local.set $rawfd
      (block (result i32)  ;; label = @1
        (local.set $this|8
          (local.get $this))
        (br 0 (;@1;)
          (local.get $this|8))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.const 1)
          (then
            (if  ;; label = @4
              (i32.ne
                (i32.and
                  (call $~lib/@assemblyscript/wasi-shim/assembly/bindings/wasi_snapshot_preview1/fd_read
                    (local.get $rawfd)
                    (local.get $iov)
                    (i32.const 1)
                    (local.get $read_ptr))
                  (i32.const 65535))
                (i32.const 0))
              (then
                (local.set 11
                  (i32.const 0))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 11))))
            (local.set $read
              (i32.load
                (local.get $read_ptr)))
            (if  ;; label = @4
              (i32.le_u
                (local.get $read)
                (i32.const 0))
              (then
                (br 3 (;@1;))))
            (local.set $i
              (i32.const 0))
            (loop  ;; label = @4
              (if  ;; label = @5
                (i32.lt_u
                  (local.get $i)
                  (local.get $read))
                (then
                  (local.set 11
                    (local.get $data))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 11))
                  (drop
                    (call $~lib/array/Array<u8>#push
                      (local.get 11)
                      (i32.load8_u
                        (i32.add
                          (local.get $data_partial)
                          (local.get $i)))))
                  (local.set $i
                    (i32.add
                      (local.get $i)
                      (i32.const 1)))
                  (br 1 (;@4;)))))
            (br 1 (;@2;))))))
    (if  ;; label = @1
      (i32.lt_u
        (local.get $read)
        (i32.const 0))
      (then
        (local.set 11
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 4)))
        (return
          (local.get 11))))
    (local.set 11
      (local.get $data))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 11)))
  (func $~lib/as-wasi/assembly/as-wasi/Descriptor#readAll@varargs (type 3) (param $this i32) (param $data i32) (param $chunk_size i32) (result i32)
    (local $3 i32) (local $4 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (block  ;; label = @1
      (block  ;; label = @2
        (block  ;; label = @3
          (block  ;; label = @4
            (br_table 1 (;@3;) 2 (;@2;) 3 (;@1;) 0 (;@4;)
              (global.get $~argumentsLength)))
          (unreachable))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $data
            (call $~lib/rt/__newArray
              (i32.const 0)
              (i32.const 0)
              (i32.const 7)
              (i32.const 1760)))))
      (local.set $chunk_size
        (i32.const 4096)))
    (local.get $this)
    (local.set 5
      (local.get $data))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.get 5)
    (local.get $chunk_size)
    (local.set 5
      (call $~lib/as-wasi/assembly/as-wasi/Descriptor#readAll))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (local.get 5))
  (func $~lib/array/Array<u8>#get:length (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.set 1
      (call $~lib/array/Array<u8>#get:length_
        (local.get 1)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 1)))
  (func $~lib/as-wasi/assembly/as-wasi/Descriptor#readString (type 2) (param $this i32) (param $chunk_size i32) (result i32)
    (local $s_utf8 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (global.get $~lib/memory/__stack_pointer)
    (local.get $this)
    (i32.const 0)
    (global.set $~argumentsLength
      (i32.const 0))
    (i32.store
      (i32.const 4096)
      (local.tee $s_utf8
        (call $~lib/as-wasi/assembly/as-wasi/Descriptor#readAll@varargs)))
    (if  ;; label = @1
      (i32.eq
        (local.get $s_utf8)
        (i32.const 0))
      (then
        (local.set 3
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 3))))
    (local.set 3
      (local.get $s_utf8))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<u8>#get:dataStart
      (local.get 3))
    (local.set 3
      (local.get $s_utf8))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<u8>#get:length
      (local.get 3))
    (i32.const 0)
    (local.set 3
      (call $~lib/string/String.UTF8.decodeUnsafe))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 3)))
  (func $src/index/readFileText (type 1) (param $path i32) (result i32)
    (local $fd i32) (local $text i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 24))
    ;; watnot: Annotated WAT generator.
    ;; Injects source comments into disassembled WAT output.
    ;;
    ;; Usage:
    ;;   wasmtime --dir . watnot.wasm <source.wasm.map> <source.wat> <source.offsets.json> <source1.ts> [source2.ts] ...
    ;; --- Main ---
    ;; Step 1: Parse source map and offset map
    ;; Step 2: Extract comments from each source file
    ;; Step 3: Inject comments into WAT
    ;; Step 4: Write output to stdout
    ;; --- Helpers ---
    ;; Write each line including its newline as a single string.
    ;; We avoid Console.write(s, true) because as-wasi's writeStringLn
    ;; has a bug: memory.data(8) is reused for both the '\n' byte and
    ;; fd_write's output pointer, so the newline gets overwritten.
    (local.set 3
      (local.get $path))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (local.set 3
      (i32.const 1376))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (local.set $fd
      (call $~lib/as-wasi/assembly/as-wasi/FileSystem.open))
    (if  ;; label = @1
      (i32.eq
        (local.get $fd)
        (i32.const 0))
      (then
        (local.set 3
          (i32.const 1584))
        (i32.store offset=12
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (local.get $path))
        (i32.store offset=16
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (call $~lib/string/String.__concat))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (i32.const 1696))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (call $~lib/string/String.__concat))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (call $~lib/as-wasi/assembly/as-wasi/Console.error
          (local.get 3)
          (i32.const 1))
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 0)
          (i32.const 0)
          (i32.const 0))
        ;; unreachable
        (local.set 3
          (i32.const 1664))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 24)))
        (return
          (local.get 3))))
    (i32.store offset=20
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $text
        (call $~lib/as-wasi/assembly/as-wasi/Descriptor#readString
          (local.get $fd)
          (i32.const 4096))))
    (local.set 3
      (local.get $text))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (if  ;; label = @1
      (call $~lib/string/String.__eq
        (local.get 3)
        (i32.const 0))
      (then
        (local.set 3
          (i32.const 1792))
        (i32.store offset=12
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (local.get $path))
        (i32.store offset=16
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (call $~lib/string/String.__concat))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (i32.const 1696))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (call $~lib/string/String.__concat))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (call $~lib/as-wasi/assembly/as-wasi/Console.error
          (local.get 3)
          (i32.const 1))
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 0)
          (i32.const 0)
          (i32.const 0))
        ;; unreachable
        (local.set 3
          (i32.const 1664))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 24)))
        (return
          (local.get 3))))
    (local.set 3
      (local.get $text))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (return
      (local.get 3)))
  (func $~lib/array/Array<~lib/string/String>#constructor (type 2) (param $this i32) (param $length i32) (result i32)
    (local $2 i32) (local $3 i32) (local $bufferSize i32) (local $buffer i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 4))))))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<~lib/string/String>#set:buffer
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<~lib/string/String>#set:dataStart
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<~lib/string/String>#set:byteLength
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<~lib/string/String>#set:length_
      (local.get 6)
      (i32.const 0))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $length)
        (i32.shr_u
          (i32.const 1073741820)
          (i32.const 2)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 768)
          (i32.const 880)
          (i32.const 70)
          (i32.const 60))
        (unreachable)))
    (local.set $bufferSize
      (i32.shl
        (select
          (local.tee $2
            (local.get $length))
          (local.tee $3
            (i32.const 8))
          (i32.gt_u
            (local.get $2)
            (local.get $3)))
        (i32.const 2)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $buffer
        (call $~lib/rt/itcms/__new
          (local.get $bufferSize)
          (i32.const 1))))
    (drop
      (i32.ne
        (i32.const 2)
        (global.get $~lib/shared/runtime/Runtime.Incremental)))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (local.get $buffer))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (call $~lib/array/Array<~lib/string/String>#set:buffer)
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<~lib/string/String>#set:dataStart
      (local.get 6)
      (local.get $buffer))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<~lib/string/String>#set:byteLength
      (local.get 6)
      (local.get $bufferSize))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<~lib/string/String>#set:length_
      (local.get 6)
      (local.get $length))
    (local.set 6
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (local.get 6))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#constructor (type 2) (param $this i32) (param $length i32) (result i32)
    (local $2 i32) (local $3 i32) (local $bufferSize i32) (local $buffer i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 10))))))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:buffer
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:dataStart
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:byteLength
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:length_
      (local.get 6)
      (i32.const 0))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $length)
        (i32.shr_u
          (i32.const 1073741820)
          (i32.const 2)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 768)
          (i32.const 880)
          (i32.const 70)
          (i32.const 60))
        (unreachable)))
    (local.set $bufferSize
      (i32.shl
        (select
          (local.tee $2
            (local.get $length))
          (local.tee $3
            (i32.const 8))
          (i32.gt_u
            (local.get $2)
            (local.get $3)))
        (i32.const 2)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $buffer
        (call $~lib/rt/itcms/__new
          (local.get $bufferSize)
          (i32.const 1))))
    (drop
      (i32.ne
        (i32.const 2)
        (global.get $~lib/shared/runtime/Runtime.Incremental)))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (local.get $buffer))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:buffer)
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:dataStart
      (local.get 6)
      (local.get $buffer))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:byteLength
      (local.get 6)
      (local.get $bufferSize))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:length_
      (local.get 6)
      (local.get $length))
    (local.set 6
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (local.get 6))
  (func $src/sourcemap/SourceMap#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 8)
              (i32.const 8))))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.tee $this
      (call $~lib/object/Object#constructor
        (local.get 1)))
    (i32.store)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/array/Array<~lib/string/String>#constructor
        (i32.const 0)
        (i32.const 0)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $src/sourcemap/SourceMap#set:sources)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#constructor
        (i32.const 0)
        (i32.const 0)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $src/sourcemap/SourceMap#set:entries)
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/string/String#indexOf (type 3) (param $this i32) (param $search i32) (param $start i32) (result i32)
    (local $searchLen i32) (local $len i32) (local $5 i32) (local $6 i32) (local $7 i32) (local $8 i32) (local $searchStart i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 10
      (local.get $search))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (local.set $searchLen
      (call $~lib/string/String#get:length
        (local.get 10)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $searchLen))
      (then
        (local.set 10
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 10))))
    (local.set 10
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (local.set $len
      (call $~lib/string/String#get:length
        (local.get 10)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $len))
      (then
        (local.set 10
          (i32.const -1))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 10))))
    (local.set $searchStart
      (select
        (local.tee $7
          (select
            (local.tee $5
              (local.get $start))
            (local.tee $6
              (i32.const 0))
            (i32.gt_s
              (local.get $5)
              (local.get $6))))
        (local.tee $8
          (local.get $len))
        (i32.lt_s
          (local.get $7)
          (local.get $8))))
    (local.set $len
      (i32.sub
        (local.get $len)
        (local.get $searchLen)))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.le_s
          (local.get $searchStart)
          (local.get $len))
        (then
          (local.set 10
            (local.get $this))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 10))
          (local.get 10)
          (local.get $searchStart)
          (local.set 10
            (local.get $search))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 10))
          (local.get 10)
          (i32.const 0)
          (local.get $searchLen)
          (if  ;; label = @3
            (i32.eqz
              (call $~lib/util/string/compareImpl))
            (then
              (local.set 10
                (local.get $searchStart))
              (global.set $~lib/memory/__stack_pointer
                (i32.add
                  (global.get $~lib/memory/__stack_pointer)
                  (i32.const 8)))
              (return
                (local.get 10))))
          (local.set $searchStart
            (i32.add
              (local.get $searchStart)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 10
      (i32.const -1))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 10)))
  (func $~lib/string/String#charCodeAt (type 2) (param $this i32) (param $pos i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.get $pos)
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/string/String#get:length
      (local.get 2))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (local.set 2
          (i32.const -1))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 4)))
        (return
          (local.get 2))))
    (local.set 2
      (i32.load16_u
        (i32.add
          (local.get $this)
          (i32.shl
            (local.get $pos)
            (i32.const 1)))))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/string/String#substring (type 3) (param $this i32) (param $start i32) (param $end i32) (result i32)
    (local $len i32) (local $4 i32) (local $5 i32) (local $6 i32) (local $7 i32) (local $finalStart i32) (local $9 i32) (local $10 i32) (local $11 i32) (local $12 i32) (local $finalEnd i32) (local $14 i32) (local $15 i32) (local $fromPos i32) (local $17 i32) (local $18 i32) (local $toPos i32) (local $size i32) (local $out i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 22
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 22))
    (local.set $len
      (call $~lib/string/String#get:length
        (local.get 22)))
    (local.set $finalStart
      (select
        (local.tee $6
          (select
            (local.tee $4
              (local.get $start))
            (local.tee $5
              (i32.const 0))
            (i32.gt_s
              (local.get $4)
              (local.get $5))))
        (local.tee $7
          (local.get $len))
        (i32.lt_s
          (local.get $6)
          (local.get $7))))
    (local.set $finalEnd
      (select
        (local.tee $11
          (select
            (local.tee $9
              (local.get $end))
            (local.tee $10
              (i32.const 0))
            (i32.gt_s
              (local.get $9)
              (local.get $10))))
        (local.tee $12
          (local.get $len))
        (i32.lt_s
          (local.get $11)
          (local.get $12))))
    (local.set $fromPos
      (i32.shl
        (select
          (local.tee $14
            (local.get $finalStart))
          (local.tee $15
            (local.get $finalEnd))
          (i32.lt_s
            (local.get $14)
            (local.get $15)))
        (i32.const 1)))
    (local.set $toPos
      (i32.shl
        (select
          (local.tee $17
            (local.get $finalStart))
          (local.tee $18
            (local.get $finalEnd))
          (i32.gt_s
            (local.get $17)
            (local.get $18)))
        (i32.const 1)))
    (local.set $size
      (i32.sub
        (local.get $toPos)
        (local.get $fromPos)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $size))
      (then
        (local.set 22
          (i32.const 1664))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 22))))
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.eqz
          (local.get $fromPos))
        (then
          (i32.eq
            (local.get $toPos)
            (i32.shl
              (local.get $len)
              (i32.const 1))))
        (else
          (i32.const 0)))
      (then
        (local.set 22
          (local.get $this))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 22))))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $out
        (call $~lib/rt/itcms/__new
          (local.get $size)
          (i32.const 2))))
    (memory.copy
      (local.get $out)
      (i32.add
        (local.get $this)
        (local.get $fromPos))
      (local.get $size))
    (local.set 22
      (local.get $out))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 22)))
  (func $src/sourcemap/extractJsonStringArray (type 2) (param $json i32) (param $field i32) (result i32)
    (local $result i32) (local $key i32) (local $pos i32) (local $ch i32) (local $end i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 24))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $result
        (call $~lib/array/Array<~lib/string/String>#constructor
          (i32.const 0)
          (i32.const 0))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 7
      (i32.const 1920))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.get 7)
    (local.set 7
      (local.get $field))
    (i32.store offset=16
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.get 7)
    (local.set 7
      (call $~lib/string/String.__concat))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.get 7)
    (local.set 7
      (i32.const 1920))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (i32.store offset=20
      (local.get 7)
      (local.tee $key
        (call $~lib/string/String.__concat)))
    (local.set 7
      (local.get $json))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.get 7)
    (local.set 7
      (local.get $key))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.get 7)
    (i32.const 0)
    (local.set $pos
      (call $~lib/string/String#indexOf))
    (if  ;; label = @1
      (i32.lt_s
        (local.get $pos)
        (i32.const 0))
      (then
        (local.set 7
          (local.get $result))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 24)))
        (return
          (local.get 7))))
    (local.get $pos)
    (local.set 7
      (local.get $key))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $~lib/string/String#get:length
      (local.get 7))
    (local.set $pos
      (i32.add))
    ;; Skip to '['
    ;; '['
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $pos)
        (local.set 7
          (local.get $json))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 7))
        (call $~lib/string/String#get:length
          (local.get 7))
        (if  ;; label = @3
          (if (result i32)  ;; label = @4
            (i32.lt_s)
            (then
              (local.set 7
                (local.get $json))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 7))
              (i32.ne
                (call $~lib/string/String#charCodeAt
                  (local.get 7)
                  (local.get $pos))
                (i32.const 91)))
            (else
              (i32.const 0)))
          (then
            (local.set $pos
              (i32.add
                (local.get $pos)
                (i32.const 1)))
            (br 1 (;@2;))))))
    (local.get $pos)
    (local.set 7
      (local.get $json))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $~lib/string/String#get:length
      (local.get 7))
    (if  ;; label = @1
      (i32.ge_s)
      (then
        (local.set 7
          (local.get $result))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 24)))
        (return
          (local.get 7))))
    ;; skip '['
    (local.set $pos
      (i32.add
        (local.get $pos)
        (i32.const 1)))
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $pos)
        (local.set 7
          (local.get $json))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 7))
        (call $~lib/string/String#get:length
          (local.get 7))
        (if  ;; label = @3
          (i32.lt_s)
          (then
            ;; Skip whitespace and commas
            (local.set 7
              (local.get $json))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 7))
            (local.set $ch
              (call $~lib/string/String#charCodeAt
                (local.get 7)
                (local.get $pos)))
            ;; ' ', '\t', '\n', '\r', ','
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (if (result i32)  ;; label = @6
                  (if (result i32)  ;; label = @7
                    (if (result i32)  ;; label = @8
                      (i32.eq
                        (local.get $ch)
                        (i32.const 32))
                      (then
                        (i32.const 1))
                      (else
                        (i32.eq
                          (local.get $ch)
                          (i32.const 9))))
                    (then
                      (i32.const 1))
                    (else
                      (i32.eq
                        (local.get $ch)
                        (i32.const 10))))
                  (then
                    (i32.const 1))
                  (else
                    (i32.eq
                      (local.get $ch)
                      (i32.const 13))))
                (then
                  (i32.const 1))
                (else
                  (i32.eq
                    (local.get $ch)
                    (i32.const 44))))
              (then
                (local.set $pos
                  (i32.add
                    (local.get $pos)
                    (i32.const 1)))
                (br 2 (;@2;))))
            ;; ']'
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (i32.const 93))
              (then
                (br 3 (;@1;))))
            ;; '"'
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (i32.const 34))
              (then
                ;; skip opening quote
                (local.set $pos
                  (i32.add
                    (local.get $pos)
                    (i32.const 1)))
                (local.set $end
                  (local.get $pos))
                (block  ;; label = @5
                  (loop  ;; label = @6
                    (local.get $end)
                    (local.set 7
                      (local.get $json))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 7))
                    (call $~lib/string/String#get:length
                      (local.get 7))
                    (if  ;; label = @7
                      (if (result i32)  ;; label = @8
                        (i32.lt_s)
                        (then
                          (local.set 7
                            (local.get $json))
                          (i32.store offset=4
                            (global.get $~lib/memory/__stack_pointer)
                            (local.get 7))
                          (i32.ne
                            (call $~lib/string/String#charCodeAt
                              (local.get 7)
                              (local.get $end))
                            (i32.const 34)))
                        (else
                          (i32.const 0)))
                      (then
                        (local.set 7
                          (local.get $json))
                        (i32.store offset=4
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 7))
                        (if  ;; label = @8
                          (i32.eq
                            (call $~lib/string/String#charCodeAt
                              (local.get 7)
                              (local.get $end))
                            (i32.const 92))
                          (then
                            (local.set $end
                              (i32.add
                                (local.get $end)
                                (i32.const 2))))
                          (else
                            (local.set $end
                              (i32.add
                                (local.get $end)
                                (i32.const 1)))))
                        (br 1 (;@6;))))))
                (local.set 7
                  (local.get $result))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 7))
                (local.get 7)
                (local.set 7
                  (local.get $json))
                (i32.store offset=12
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 7))
                (local.set 7
                  (call $~lib/string/String#substring
                    (local.get 7)
                    (local.get $pos)
                    (local.get $end)))
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 7))
                (local.get 7)
                (drop
                  (call $~lib/array/Array<~lib/string/String>#push))
                ;; skip closing quote
                (local.set $pos
                  (i32.add
                    (local.get $end)
                    (i32.const 1))))
              (else
                (local.set $pos
                  (i32.add
                    (local.get $pos)
                    (i32.const 1)))))
            (br 1 (;@2;))))))
    (local.set 7
      (local.get $result))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (return
      (local.get 7)))
  (func $src/sourcemap/extractJsonStringField (type 2) (param $json i32) (param $field i32) (result i32)
    (local $key i32) (local $pos i32) (local $ch i32) (local $end i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 20)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 20))
    (global.get $~lib/memory/__stack_pointer)
    ;; --- Minimal JSON field extraction ---
    (local.set 6
      (i32.const 1920))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (local.get $field))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (call $~lib/string/String.__concat))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (i32.const 1920))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (i32.store offset=16
      (local.get 6)
      (local.tee $key
        (call $~lib/string/String.__concat)))
    (local.set 6
      (local.get $json))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (local.get $key))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (i32.const 0)
    (local.set $pos
      (call $~lib/string/String#indexOf))
    (if  ;; label = @1
      (i32.lt_s
        (local.get $pos)
        (i32.const 0))
      (then
        (local.set 6
          (i32.const 1664))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 20)))
        (return
          (local.get 6))))
    (local.get $pos)
    (local.set 6
      (local.get $key))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/string/String#get:length
      (local.get 6))
    (local.set $pos
      (i32.add))
    ;; Skip whitespace and colon
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $pos)
        (local.set 6
          (local.get $json))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/string/String#get:length
          (local.get 6))
        (if  ;; label = @3
          (i32.lt_s)
          (then
            (local.set 6
              (local.get $json))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.set $ch
              (call $~lib/string/String#charCodeAt
                (local.get 6)
                (local.get $pos)))
            ;; ':', ' ', '\t', '\n', '\r'
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (if (result i32)  ;; label = @6
                  (if (result i32)  ;; label = @7
                    (if (result i32)  ;; label = @8
                      (i32.eq
                        (local.get $ch)
                        (i32.const 58))
                      (then
                        (i32.const 1))
                      (else
                        (i32.eq
                          (local.get $ch)
                          (i32.const 32))))
                    (then
                      (i32.const 1))
                    (else
                      (i32.eq
                        (local.get $ch)
                        (i32.const 9))))
                  (then
                    (i32.const 1))
                  (else
                    (i32.eq
                      (local.get $ch)
                      (i32.const 10))))
                (then
                  (i32.const 1))
                (else
                  (i32.eq
                    (local.get $ch)
                    (i32.const 13))))
              (then
                (local.set $pos
                  (i32.add
                    (local.get $pos)
                    (i32.const 1))))
              (else
                (br 3 (;@1;))))
            (br 1 (;@2;))))))
    ;; expect '"'
    (local.get $pos)
    (local.set 6
      (local.get $json))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/string/String#get:length
      (local.get 6))
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.ge_s)
        (then
          (i32.const 1))
        (else
          (local.set 6
            (local.get $json))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 6))
          (i32.ne
            (call $~lib/string/String#charCodeAt
              (local.get 6)
              (local.get $pos))
            (i32.const 34))))
      (then
        (local.set 6
          (i32.const 1664))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 20)))
        (return
          (local.get 6))))
    ;; skip opening quote
    (local.set $pos
      (i32.add
        (local.get $pos)
        (i32.const 1)))
    (local.set $end
      (local.get $pos))
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $end)
        (local.set 6
          (local.get $json))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/string/String#get:length
          (local.get 6))
        (if  ;; label = @3
          (if (result i32)  ;; label = @4
            (i32.lt_s)
            (then
              (local.set 6
                (local.get $json))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 6))
              (i32.ne
                (call $~lib/string/String#charCodeAt
                  (local.get 6)
                  (local.get $end))
                (i32.const 34)))
            (else
              (i32.const 0)))
          (then
            ;; backslash escape
            (local.set 6
              (local.get $json))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (if  ;; label = @4
              (i32.eq
                (call $~lib/string/String#charCodeAt
                  (local.get 6)
                  (local.get $end))
                (i32.const 92))
              (then
                (local.set $end
                  (i32.add
                    (local.get $end)
                    (i32.const 2))))
              (else
                (local.set $end
                  (i32.add
                    (local.get $end)
                    (i32.const 1)))))
            (br 1 (;@2;))))))
    (local.set 6
      (local.get $json))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.set 6
      (call $~lib/string/String#substring
        (local.get 6)
        (local.get $pos)
        (local.get $end)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 20)))
    (return
      (local.get 6)))
  (func $src/sourcemap/VLQResult#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 8)
              (i32.const 11))))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.tee $this
      (call $~lib/object/Object#constructor
        (local.get 1)))
    (i32.store)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/sourcemap/VLQResult#set:value
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/sourcemap/VLQResult#set:index
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (local.get 1))
  (func $src/sourcemap/decodeVLQ (type 2) (param $mappings i32) (param $index i32) (result i32)
    (local $shift i32) (local $result i32) (local $i i32) (local $digit i32) (local $continuation i32) (local $negate i32) (local $out i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $shift
      (i32.const 0))
    (local.set $result
      (i32.const 0))
    (local.set $i
      (local.get $index))
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $i)
        (local.set 9
          (local.get $mappings))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 9))
        (call $~lib/string/String#get:length
          (local.get 9))
        (if  ;; label = @3
          (i32.lt_s)
          (then
            (local.set 9
              (local.get $mappings))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 9))
            (local.set $digit
              (call $src/sourcemap/base64Decode
                (call $~lib/string/String#charCodeAt
                  (local.get 9)
                  (local.get $i))))
            (local.set $i
              (i32.add
                (local.get $i)
                (i32.const 1)))
            (local.set $continuation
              (i32.and
                (local.get $digit)
                (i32.const 32)))
            (local.set $result
              (i32.or
                (local.get $result)
                (i32.shl
                  (i32.and
                    (local.get $digit)
                    (i32.const 31))
                  (local.get $shift))))
            (local.set $shift
              (i32.add
                (local.get $shift)
                (i32.const 5)))
            (if  ;; label = @4
              (i32.eqz
                (local.get $continuation))
              (then
                (br 3 (;@1;))))
            (br 1 (;@2;))))))
    ;; Sign is in LSB
    (local.set $negate
      (i32.and
        (local.get $result)
        (i32.const 1)))
    (local.set $result
      (i32.shr_s
        (local.get $result)
        (i32.const 1)))
    (if  ;; label = @1
      (local.get $negate)
      (then
        (local.set $result
          (i32.sub
            (i32.const 0)
            (local.get $result)))))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $out
        (call $src/sourcemap/VLQResult#constructor
          (i32.const 0))))
    (local.set 9
      (local.get $out))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (call $src/sourcemap/VLQResult#set:value
      (local.get 9)
      (local.get $result))
    (local.set 9
      (local.get $out))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (call $src/sourcemap/VLQResult#set:index
      (local.get 9)
      (local.get $i))
    (local.set 9
      (local.get $out))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 9)))
  (func $src/sourcemap/SourceMapEntry#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 9))))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.tee $this
      (call $~lib/object/Object#constructor
        (local.get 1)))
    (i32.store)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/sourcemap/SourceMapEntry#set:generatedOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/sourcemap/SourceMapEntry#set:sourceIndex
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/sourcemap/SourceMapEntry#set:sourceLine
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/sourcemap/SourceMapEntry#set:sourceColumn
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (local.get 1))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#push (type 2) (param $this i32) (param $value i32) (result i32)
    (local $oldLen i32) (local $len i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.set $oldLen
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length_
        (local.get 4)))
    (local.set $len
      (i32.add
        (local.get $oldLen)
        (i32.const 1)))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $len)
      (i32.const 2)
      (i32.const 1))
    (drop
      (i32.const 1))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (i32.store
      (i32.add
        (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:dataStart
          (local.get 4))
        (i32.shl
          (local.get $oldLen)
          (i32.const 2)))
      (local.get $value))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $value)
      (i32.const 1))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#set:length_
      (local.get 4)
      (local.get $len))
    (local.set 4
      (local.get $len))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 4)))
  (func $src/sourcemap/parseMappingsComparator (type 2) (param $a i32) (param $b i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    ;; --- Main parser ---
    (local.set 2
      (local.get $a))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $src/sourcemap/SourceMapEntry#get:generatedOffset
      (local.get 2))
    (local.set 2
      (local.get $b))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $src/sourcemap/SourceMapEntry#get:generatedOffset
      (local.get 2))
    (local.set 2
      (i32.sub))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/util/sort/insertionSort<src/sourcemap/SourceMapEntry> (type 14) (param $ptr i32) (param $left i32) (param $right i32) (param $presorted i32) (param $comparator i32)
    (local $range i32) (local $i i32) (local $a i32) (local $b i32) (local $min i32) (local $max i32) (local $j i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 24))
    (drop
      (i32.ge_s
        (i32.const 0)
        (i32.const 1)))
    (local.set $range
      (i32.add
        (i32.sub
          (local.get $right)
          (local.get $left))
        (i32.const 1)))
    (local.set $i
      (i32.add
        (local.get $left)
        (select
          (i32.and
            (local.get $range)
            (i32.const 1))
          (i32.sub
            (local.get $presorted)
            (i32.and
              (i32.sub
                (local.get $range)
                (local.get $presorted))
              (i32.const 1)))
          (i32.eq
            (local.get $presorted)
            (i32.const 0)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.le_s
            (local.get $i)
            (local.get $right))
          (then
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $a
                (i32.load
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $i)
                      (i32.const 2))))))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $b
                (i32.load offset=4
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $i)
                      (i32.const 2))))))
            (i32.store offset=8
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $min
                (local.get $b)))
            (i32.store offset=12
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $max
                (local.get $a)))
            (local.set 12
              (local.get $a))
            (i32.store offset=16
              (global.get $~lib/memory/__stack_pointer)
              (local.get 12))
            (local.get 12)
            (local.set 12
              (local.get $b))
            (i32.store offset=20
              (global.get $~lib/memory/__stack_pointer)
              (local.get 12))
            (local.get 12)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (if  ;; label = @4
              (i32.le_s
                (call_indirect $0 (type 2))
                (i32.const 0))
              (then
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.tee $min
                    (local.get $a)))
                (i32.store offset=12
                  (global.get $~lib/memory/__stack_pointer)
                  (local.tee $max
                    (local.get $b)))))
            (local.set $j
              (i32.sub
                (local.get $i)
                (i32.const 1)))
            (block  ;; label = @4
              (loop  ;; label = @5
                (if  ;; label = @6
                  (i32.ge_s
                    (local.get $j)
                    (local.get $left))
                  (then
                    (i32.store
                      (global.get $~lib/memory/__stack_pointer)
                      (local.tee $a
                        (i32.load
                          (i32.add
                            (local.get $ptr)
                            (i32.shl
                              (local.get $j)
                              (i32.const 2))))))
                    (local.set 12
                      (local.get $a))
                    (i32.store offset=16
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (local.set 12
                      (local.get $max))
                    (i32.store offset=20
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (global.set $~argumentsLength
                      (i32.const 2))
                    (i32.load
                      (local.get $comparator))
                    (if  ;; label = @7
                      (i32.gt_s
                        (call_indirect $0 (type 2))
                        (i32.const 0))
                      (then
                        (i32.store offset=8
                          (i32.add
                            (local.get $ptr)
                            (i32.shl
                              (local.get $j)
                              (i32.const 2)))
                          (local.get $a))
                        (local.set $j
                          (i32.sub
                            (local.get $j)
                            (i32.const 1))))
                      (else
                        (br 3 (;@4;))))
                    (br 1 (;@5;))))))
            (i32.store offset=8
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 2)))
              (local.get $max))
            (block  ;; label = @4
              (loop  ;; label = @5
                (if  ;; label = @6
                  (i32.ge_s
                    (local.get $j)
                    (local.get $left))
                  (then
                    (i32.store
                      (global.get $~lib/memory/__stack_pointer)
                      (local.tee $a
                        (i32.load
                          (i32.add
                            (local.get $ptr)
                            (i32.shl
                              (local.get $j)
                              (i32.const 2))))))
                    (local.set 12
                      (local.get $a))
                    (i32.store offset=16
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (local.set 12
                      (local.get $min))
                    (i32.store offset=20
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (global.set $~argumentsLength
                      (i32.const 2))
                    (i32.load
                      (local.get $comparator))
                    (if  ;; label = @7
                      (i32.gt_s
                        (call_indirect $0 (type 2))
                        (i32.const 0))
                      (then
                        (i32.store offset=4
                          (i32.add
                            (local.get $ptr)
                            (i32.shl
                              (local.get $j)
                              (i32.const 2)))
                          (local.get $a))
                        (local.set $j
                          (i32.sub
                            (local.get $j)
                            (i32.const 1))))
                      (else
                        (br 3 (;@4;))))
                    (br 1 (;@5;))))))
            (i32.store offset=4
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 2)))
              (local.get $min))
            (local.set $i
              (i32.add
                (local.get $i)
                (i32.const 2)))
            (br 1 (;@2;))))))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24))))
  (func $~lib/util/sort/extendRunRight<src/sourcemap/SourceMapEntry> (type 5) (param $ptr i32) (param $i i32) (param $right i32) (param $comparator i32) (result i32)
    (local $j i32) (local $k i32) (local $tmp i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eq
        (local.get $i)
        (local.get $right))
      (then
        (local.set 7
          (local.get $i))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 12)))
        (return
          (local.get 7))))
    (local.set $j
      (local.get $i))
    (local.set 7
      (i32.load
        (i32.add
          (local.get $ptr)
          (i32.shl
            (local.get $j)
            (i32.const 2)))))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.get 7)
    (local.set 7
      (i32.load
        (i32.add
          (local.get $ptr)
          (i32.shl
            (local.tee $j
              (i32.add
                (local.get $j)
                (i32.const 1)))
            (i32.const 2)))))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.get 7)
    (global.set $~argumentsLength
      (i32.const 2))
    (i32.load
      (local.get $comparator))
    (if  ;; label = @1
      (i32.gt_s
        (call_indirect $0 (type 2))
        (i32.const 0))
      (then
        (block  ;; label = @2
          (loop  ;; label = @3
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.lt_s
                  (local.get $j)
                  (local.get $right))
                (then
                  (local.set 7
                    (i32.load offset=4
                      (i32.add
                        (local.get $ptr)
                        (i32.shl
                          (local.get $j)
                          (i32.const 2)))))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 7))
                  (local.get 7)
                  (local.set 7
                    (i32.load
                      (i32.add
                        (local.get $ptr)
                        (i32.shl
                          (local.get $j)
                          (i32.const 2)))))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 7))
                  (local.get 7)
                  (global.set $~argumentsLength
                    (i32.const 2))
                  (i32.load
                    (local.get $comparator))
                  (i32.shr_u
                    (call_indirect $0 (type 2))
                    (i32.const 31)))
                (else
                  (i32.const 0)))
              (then
                (local.set $j
                  (i32.add
                    (local.get $j)
                    (i32.const 1)))
                (br 1 (;@3;))))))
        (local.set $k
          (local.get $j))
        (block  ;; label = @2
          (loop  ;; label = @3
            (if  ;; label = @4
              (i32.lt_s
                (local.get $i)
                (local.get $k))
              (then
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.tee $tmp
                    (i32.load
                      (i32.add
                        (local.get $ptr)
                        (i32.shl
                          (local.get $i)
                          (i32.const 2))))))
                (i32.store
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $i)
                      (i32.const 2)))
                  (i32.load
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $k)
                        (i32.const 2)))))
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 1)))
                (i32.store
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $k)
                      (i32.const 2)))
                  (local.get $tmp))
                (local.set $k
                  (i32.sub
                    (local.get $k)
                    (i32.const 1)))
                (br 1 (;@3;)))))))
      (else
        (loop  ;; label = @2
          (if  ;; label = @3
            (if (result i32)  ;; label = @4
              (i32.lt_s
                (local.get $j)
                (local.get $right))
              (then
                (local.set 7
                  (i32.load offset=4
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $j)
                        (i32.const 2)))))
                (i32.store
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 7))
                (local.get 7)
                (local.set 7
                  (i32.load
                    (i32.add
                      (local.get $ptr)
                      (i32.shl
                        (local.get $j)
                        (i32.const 2)))))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 7))
                (local.get 7)
                (global.set $~argumentsLength
                  (i32.const 2))
                (i32.load
                  (local.get $comparator))
                (i32.ge_s
                  (call_indirect $0 (type 2))
                  (i32.const 0)))
              (else
                (i32.const 0)))
            (then
              (local.set $j
                (i32.add
                  (local.get $j)
                  (i32.const 1)))
              (br 1 (;@2;)))))))
    (local.set 7
      (local.get $j))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 7)))
  (func $~lib/util/sort/mergeRuns<src/sourcemap/SourceMapEntry> (type 15) (param $ptr i32) (param $l i32) (param $m i32) (param $r i32) (param $buffer i32) (param $comparator i32)
    (local $i i32) (local $j i32) (local $t i32) (local $k i32) (local $a i32) (local $b i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $m
      (i32.sub
        (local.get $m)
        (i32.const 1)))
    (local.set $t
      (i32.add
        (local.get $r)
        (local.get $m)))
    (local.set $i
      (i32.add
        (local.get $m)
        (i32.const 1)))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.gt_s
          (local.get $i)
          (local.get $l))
        (then
          (i32.store
            (i32.add
              (local.get $buffer)
              (i32.shl
                (i32.sub
                  (local.get $i)
                  (i32.const 1))
                (i32.const 2)))
            (i32.load
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (i32.sub
                    (local.get $i)
                    (i32.const 1))
                  (i32.const 2)))))
          (local.set $i
            (i32.sub
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $j
      (local.get $m))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_s
          (local.get $j)
          (local.get $r))
        (then
          (i32.store
            (i32.add
              (local.get $buffer)
              (i32.shl
                (i32.sub
                  (local.get $t)
                  (local.get $j))
                (i32.const 2)))
            (i32.load offset=4
              (i32.add
                (local.get $ptr)
                (i32.shl
                  (local.get $j)
                  (i32.const 2)))))
          (local.set $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $k
      (local.get $l))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.le_s
          (local.get $k)
          (local.get $r))
        (then
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.tee $a
              (i32.load
                (i32.add
                  (local.get $buffer)
                  (i32.shl
                    (local.get $j)
                    (i32.const 2))))))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.tee $b
              (i32.load
                (i32.add
                  (local.get $buffer)
                  (i32.shl
                    (local.get $i)
                    (i32.const 2))))))
          (local.set 12
            (local.get $a))
          (i32.store offset=8
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (local.get 12)
          (local.set 12
            (local.get $b))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (local.get 12)
          (global.set $~argumentsLength
            (i32.const 2))
          (i32.load
            (local.get $comparator))
          (if  ;; label = @3
            (i32.lt_s
              (call_indirect $0 (type 2))
              (i32.const 0))
            (then
              (i32.store
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $k)
                    (i32.const 2)))
                (local.get $a))
              (local.set $j
                (i32.sub
                  (local.get $j)
                  (i32.const 1))))
            (else
              (i32.store
                (i32.add
                  (local.get $ptr)
                  (i32.shl
                    (local.get $k)
                    (i32.const 2)))
                (local.get $b))
              (local.set $i
                (i32.add
                  (local.get $i)
                  (i32.const 1)))))
          (local.set $k
            (i32.add
              (local.get $k)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/util/sort/SORT<src/sourcemap/SourceMapEntry> (type 7) (param $ptr i32) (param $len i32) (param $comparator i32)
    (local $3 i32) (local $a i32) (local $b i32) (local $c i32) (local $a|7 i32) (local $b|8 i32) (local $c|9 i32) (local $n i32) (local $lgPlus2 i32) (local $lgPlus2Size i32) (local $leftRunStartBuf i32) (local $leftRunEndBuf i32) (local $i i32) (local $buffer i32) (local $hi i32) (local $endA i32) (local $lenA i32) (local $20 i32) (local $21 i32) (local $top i32) (local $startA i32) (local $startB i32) (local $endB i32) (local $lenB i32) (local $27 i32) (local $28 i32) (local $k i32) (local $i|30 i32) (local $start i32) (local $i|32 i32) (local $start|33 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 24))
    (if  ;; label = @1
      (i32.le_s
        (local.get $len)
        (i32.const 48))
      (then
        (if  ;; label = @2
          (i32.le_s
            (local.get $len)
            (i32.const 1))
          (then
            (global.set $~lib/memory/__stack_pointer
              (i32.add
                (global.get $~lib/memory/__stack_pointer)
                (i32.const 24)))
            (return)))
        (drop
          (i32.lt_s
            (i32.const 0)
            (i32.const 1)))
        (block  ;; label = @2
          (block  ;; label = @3
            (block  ;; label = @4
              (local.set $3
                (local.get $len))
              (br_if 0 (;@4;)
                (i32.eq
                  (local.get $3)
                  (i32.const 3)))
              (br_if 1 (;@3;)
                (i32.eq
                  (local.get $3)
                  (i32.const 2)))
              (br 2 (;@2;)))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $a
                (i32.load
                  (local.get $ptr))))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $b
                (i32.load offset=4
                  (local.get $ptr))))
            (local.set 34
              (local.get $a))
            (i32.store offset=8
              (global.get $~lib/memory/__stack_pointer)
              (local.get 34))
            (local.get 34)
            (local.set 34
              (local.get $b))
            (i32.store offset=12
              (global.get $~lib/memory/__stack_pointer)
              (local.get 34))
            (local.get 34)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (local.set $c
              (i32.gt_s
                (call_indirect $0 (type 2))
                (i32.const 0)))
            (i32.store
              (local.get $ptr)
              (select
                (local.get $b)
                (local.get $a)
                (local.get $c)))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $a
                (select
                  (local.get $a)
                  (local.get $b)
                  (local.get $c))))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $b
                (i32.load offset=8
                  (local.get $ptr))))
            (local.set 34
              (local.get $a))
            (i32.store offset=8
              (global.get $~lib/memory/__stack_pointer)
              (local.get 34))
            (local.get 34)
            (local.set 34
              (local.get $b))
            (i32.store offset=12
              (global.get $~lib/memory/__stack_pointer)
              (local.get 34))
            (local.get 34)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (local.set $c
              (i32.gt_s
                (call_indirect $0 (type 2))
                (i32.const 0)))
            (i32.store offset=4
              (local.get $ptr)
              (select
                (local.get $b)
                (local.get $a)
                (local.get $c)))
            (i32.store offset=8
              (local.get $ptr)
              (select
                (local.get $a)
                (local.get $b)
                (local.get $c))))
          (i32.store offset=16
            (global.get $~lib/memory/__stack_pointer)
            (local.tee $a|7
              (i32.load
                (local.get $ptr))))
          (i32.store offset=20
            (global.get $~lib/memory/__stack_pointer)
            (local.tee $b|8
              (i32.load offset=4
                (local.get $ptr))))
          (local.set 34
            (local.get $a|7))
          (i32.store offset=8
            (global.get $~lib/memory/__stack_pointer)
            (local.get 34))
          (local.get 34)
          (local.set 34
            (local.get $b|8))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 34))
          (local.get 34)
          (global.set $~argumentsLength
            (i32.const 2))
          (i32.load
            (local.get $comparator))
          (local.set $c|9
            (i32.gt_s
              (call_indirect $0 (type 2))
              (i32.const 0)))
          (i32.store
            (local.get $ptr)
            (select
              (local.get $b|8)
              (local.get $a|7)
              (local.get $c|9)))
          (i32.store offset=4
            (local.get $ptr)
            (select
              (local.get $a|7)
              (local.get $b|8)
              (local.get $c|9)))
          (global.set $~lib/memory/__stack_pointer
            (i32.add
              (global.get $~lib/memory/__stack_pointer)
              (i32.const 24)))
          (return))
        (local.get $ptr)
        (i32.const 0)
        (i32.sub
          (local.get $len)
          (i32.const 1))
        (i32.const 0)
        (local.set 34
          (local.get $comparator))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 34))
        (local.get 34)
        (call $~lib/util/sort/insertionSort<src/sourcemap/SourceMapEntry>)
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 24)))
        (return)))
    (local.set $lgPlus2
      (i32.add
        (block (result i32)  ;; label = @1
          (local.set $n
            (local.get $len))
          (br 0 (;@1;)
            (i32.sub
              (i32.const 31)
              (i32.clz
                (local.get $n)))))
        (i32.const 2)))
    (local.set $lgPlus2Size
      (i32.shl
        (local.get $lgPlus2)
        (i32.const 2)))
    (local.set $leftRunStartBuf
      (call $~lib/rt/tlsf/__alloc
        (i32.shl
          (local.get $lgPlus2Size)
          (i32.const 1))))
    (local.set $leftRunEndBuf
      (i32.add
        (local.get $leftRunStartBuf)
        (local.get $lgPlus2Size)))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_u
          (local.get $i)
          (local.get $lgPlus2))
        (then
          (i32.store
            (i32.add
              (local.get $leftRunStartBuf)
              (i32.shl
                (local.get $i)
                (i32.const 2)))
            (i32.const -1))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $buffer
      (call $~lib/rt/tlsf/__alloc
        (i32.shl
          (local.get $len)
          (i32.const 2))))
    (local.set $hi
      (i32.sub
        (local.get $len)
        (i32.const 1)))
    (local.get $ptr)
    (i32.const 0)
    (local.get $hi)
    (local.set 34
      (local.get $comparator))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 34))
    (local.get 34)
    (local.set $endA
      (call $~lib/util/sort/extendRunRight<src/sourcemap/SourceMapEntry>))
    (local.set $lenA
      (i32.add
        (local.get $endA)
        (i32.const 1)))
    (if  ;; label = @1
      (i32.lt_s
        (local.get $lenA)
        (i32.const 32))
      (then
        (local.set $endA
          (select
            (local.tee $20
              (local.get $hi))
            (local.tee $21
              (i32.sub
                (i32.const 32)
                (i32.const 1)))
            (i32.lt_s
              (local.get $20)
              (local.get $21))))
        (local.get $ptr)
        (i32.const 0)
        (local.get $endA)
        (local.get $lenA)
        (local.set 34
          (local.get $comparator))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 34))
        (local.get 34)
        (call $~lib/util/sort/insertionSort<src/sourcemap/SourceMapEntry>)))
    (local.set $top
      (i32.const 0))
    (local.set $startA
      (i32.const 0))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_s
            (local.get $endA)
            (local.get $hi))
          (then
            (local.set $startB
              (i32.add
                (local.get $endA)
                (i32.const 1)))
            (local.get $ptr)
            (local.get $startB)
            (local.get $hi)
            (local.set 34
              (local.get $comparator))
            (i32.store offset=8
              (global.get $~lib/memory/__stack_pointer)
              (local.get 34))
            (local.get 34)
            (local.set $endB
              (call $~lib/util/sort/extendRunRight<src/sourcemap/SourceMapEntry>))
            (local.set $lenB
              (i32.add
                (i32.sub
                  (local.get $endB)
                  (local.get $startB))
                (i32.const 1)))
            (if  ;; label = @4
              (i32.lt_s
                (local.get $lenB)
                (i32.const 32))
              (then
                (local.set $endB
                  (select
                    (local.tee $27
                      (local.get $hi))
                    (local.tee $28
                      (i32.sub
                        (i32.add
                          (local.get $startB)
                          (i32.const 32))
                        (i32.const 1)))
                    (i32.lt_s
                      (local.get $27)
                      (local.get $28))))
                (local.get $ptr)
                (local.get $startB)
                (local.get $endB)
                (local.get $lenB)
                (local.set 34
                  (local.get $comparator))
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 34))
                (local.get 34)
                (call $~lib/util/sort/insertionSort<src/sourcemap/SourceMapEntry>)))
            (local.set $k
              (call $~lib/util/sort/nodePower
                (i32.const 0)
                (local.get $hi)
                (local.get $startA)
                (local.get $startB)
                (local.get $endB)))
            (local.set $i|30
              (local.get $top))
            (loop  ;; label = @4
              (if  ;; label = @5
                (i32.gt_u
                  (local.get $i|30)
                  (local.get $k))
                (then
                  (local.set $start
                    (i32.load
                      (i32.add
                        (local.get $leftRunStartBuf)
                        (i32.shl
                          (local.get $i|30)
                          (i32.const 2)))))
                  (if  ;; label = @6
                    (i32.ne
                      (local.get $start)
                      (i32.const -1))
                    (then
                      (local.get $ptr)
                      (local.get $start)
                      (i32.add
                        (i32.load
                          (i32.add
                            (local.get $leftRunEndBuf)
                            (i32.shl
                              (local.get $i|30)
                              (i32.const 2))))
                        (i32.const 1))
                      (local.get $endA)
                      (local.get $buffer)
                      (local.set 34
                        (local.get $comparator))
                      (i32.store offset=8
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 34))
                      (local.get 34)
                      (call $~lib/util/sort/mergeRuns<src/sourcemap/SourceMapEntry>)
                      (local.set $startA
                        (local.get $start))
                      (i32.store
                        (i32.add
                          (local.get $leftRunStartBuf)
                          (i32.shl
                            (local.get $i|30)
                            (i32.const 2)))
                        (i32.const -1))))
                  (local.set $i|30
                    (i32.sub
                      (local.get $i|30)
                      (i32.const 1)))
                  (br 1 (;@4;)))))
            (i32.store
              (i32.add
                (local.get $leftRunStartBuf)
                (i32.shl
                  (local.get $k)
                  (i32.const 2)))
              (local.get $startA))
            (i32.store
              (i32.add
                (local.get $leftRunEndBuf)
                (i32.shl
                  (local.get $k)
                  (i32.const 2)))
              (local.get $endA))
            (local.set $startA
              (local.get $startB))
            (local.set $endA
              (local.get $endB))
            (local.set $top
              (local.get $k))
            (br 1 (;@2;))))))
    (local.set $i|32
      (local.get $top))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.ne
          (local.get $i|32)
          (i32.const 0))
        (then
          (local.set $start|33
            (i32.load
              (i32.add
                (local.get $leftRunStartBuf)
                (i32.shl
                  (local.get $i|32)
                  (i32.const 2)))))
          (if  ;; label = @3
            (i32.ne
              (local.get $start|33)
              (i32.const -1))
            (then
              (local.get $ptr)
              (local.get $start|33)
              (i32.add
                (i32.load
                  (i32.add
                    (local.get $leftRunEndBuf)
                    (i32.shl
                      (local.get $i|32)
                      (i32.const 2))))
                (i32.const 1))
              (local.get $hi)
              (local.get $buffer)
              (local.set 34
                (local.get $comparator))
              (i32.store offset=8
                (global.get $~lib/memory/__stack_pointer)
                (local.get 34))
              (local.get 34)
              (call $~lib/util/sort/mergeRuns<src/sourcemap/SourceMapEntry>)))
          (local.set $i|32
            (i32.sub
              (local.get $i|32)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (call $~lib/rt/tlsf/__free
      (local.get $buffer))
    (call $~lib/rt/tlsf/__free
      (local.get $leftRunStartBuf))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24))))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#sort (type 2) (param $this i32) (param $comparator i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 2
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:dataStart
      (local.get 2))
    (local.set 2
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length_
      (local.get 2))
    (local.set 2
      (local.get $comparator))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (call $~lib/util/sort/SORT<src/sourcemap/SourceMapEntry>)
    (local.set 2
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 2)))
  (func $src/sourcemap/parseSourceMap (type 1) (param $json i32) (result i32)
    (local $sourceMap i32) (local $mappings i32) (local $genColumn i32) (local $srcIndex i32) (local $srcLine i32) (local $srcColumn i32) (local $i i32) (local $ch i32) (local $vlq1 i32) (local $vlq2 i32) (local $vlq3 i32) (local $vlq4 i32) (local $vlq5 i32) (local $entry i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 48)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 48))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $sourceMap
        (call $src/sourcemap/SourceMap#constructor
          (i32.const 0))))
    (local.set 15
      (local.get $sourceMap))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (local.get 15)
    (local.set 15
      (local.get $json))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (local.get 15)
    (local.set 15
      (i32.const 1872))
    (i32.store offset=16
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (local.get 15)
    (local.set 15
      (call $src/sourcemap/extractJsonStringArray))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (local.get 15)
    (call $src/sourcemap/SourceMap#set:sources)
    (global.get $~lib/memory/__stack_pointer)
    (local.set 15
      (local.get $json))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (local.get 15)
    (local.set 15
      (i32.const 1952))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (i32.store offset=20
      (local.get 15)
      (local.tee $mappings
        (call $src/sourcemap/extractJsonStringField)))
    (local.set 15
      (local.get $mappings))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (if  ;; label = @1
      (i32.eq
        (call $~lib/string/String#get:length
          (local.get 15))
        (i32.const 0))
      (then
        (local.set 15
          (local.get $sourceMap))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 48)))
        (return
          (local.get 15))))
    ;; State: all values are delta-encoded
    (local.set $genColumn
      (i32.const 0))
    (local.set $srcIndex
      (i32.const 0))
    (local.set $srcLine
      (i32.const 0))
    (local.set $srcColumn
      (i32.const 0))
    (local.set $i
      (i32.const 0))
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $i)
        (local.set 15
          (local.get $mappings))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 15))
        (call $~lib/string/String#get:length
          (local.get 15))
        (if  ;; label = @3
          (i32.lt_s)
          (then
            (local.set 15
              (local.get $mappings))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.set $ch
              (call $~lib/string/String#charCodeAt
                (local.get 15)
                (local.get $i)))
            ;; ';' — next generated line (not used for WASM source maps)
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (i32.const 59))
              (then
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 1)))
                (local.set $genColumn
                  (i32.const 0))
                (br 2 (;@2;))))
            ;; ',' — next segment
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (i32.const 44))
              (then
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 1)))
                (br 2 (;@2;))))
            (global.get $~lib/memory/__stack_pointer)
            ;; Decode a segment: 1, 4, or 5 VLQ values
            (local.set 15
              (local.get $mappings))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.tee $vlq1
              (call $src/sourcemap/decodeVLQ
                (local.get 15)
                (local.get $i)))
            (i32.store offset=24)
            (local.get $genColumn)
            (local.set 15
              (local.get $vlq1))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $src/sourcemap/VLQResult#get:value
              (local.get 15))
            (local.set $genColumn
              (i32.add))
            (local.set 15
              (local.get $vlq1))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.set $i
              (call $src/sourcemap/VLQResult#get:index
                (local.get 15)))
            (local.get $i)
            (local.set 15
              (local.get $mappings))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $~lib/string/String#get:length
              (local.get 15))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (if (result i32)  ;; label = @6
                  (i32.ge_s)
                  (then
                    (i32.const 1))
                  (else
                    (local.set 15
                      (local.get $mappings))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 15))
                    (i32.eq
                      (call $~lib/string/String#charCodeAt
                        (local.get 15)
                        (local.get $i))
                      (i32.const 44))))
                (then
                  (i32.const 1))
                (else
                  (local.set 15
                    (local.get $mappings))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 15))
                  (i32.eq
                    (call $~lib/string/String#charCodeAt
                      (local.get 15)
                      (local.get $i))
                    (i32.const 59))))
              (then
                ;; 1-value segment — generated column only, no source mapping
                (br 2 (;@2;))))
            (global.get $~lib/memory/__stack_pointer)
            (local.set 15
              (local.get $mappings))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.tee $vlq2
              (call $src/sourcemap/decodeVLQ
                (local.get 15)
                (local.get $i)))
            (i32.store offset=28)
            (local.get $srcIndex)
            (local.set 15
              (local.get $vlq2))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $src/sourcemap/VLQResult#get:value
              (local.get 15))
            (local.set $srcIndex
              (i32.add))
            (local.set 15
              (local.get $vlq2))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.set $i
              (call $src/sourcemap/VLQResult#get:index
                (local.get 15)))
            (global.get $~lib/memory/__stack_pointer)
            (local.set 15
              (local.get $mappings))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.tee $vlq3
              (call $src/sourcemap/decodeVLQ
                (local.get 15)
                (local.get $i)))
            (i32.store offset=32)
            (local.get $srcLine)
            (local.set 15
              (local.get $vlq3))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $src/sourcemap/VLQResult#get:value
              (local.get 15))
            (local.set $srcLine
              (i32.add))
            (local.set 15
              (local.get $vlq3))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.set $i
              (call $src/sourcemap/VLQResult#get:index
                (local.get 15)))
            (global.get $~lib/memory/__stack_pointer)
            (local.set 15
              (local.get $mappings))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.tee $vlq4
              (call $src/sourcemap/decodeVLQ
                (local.get 15)
                (local.get $i)))
            (i32.store offset=36)
            (local.get $srcColumn)
            (local.set 15
              (local.get $vlq4))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $src/sourcemap/VLQResult#get:value
              (local.get 15))
            (local.set $srcColumn
              (i32.add))
            (local.set 15
              (local.get $vlq4))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.set $i
              (call $src/sourcemap/VLQResult#get:index
                (local.get 15)))
            ;; Optional 5th value (name index) — skip if present
            (local.get $i)
            (local.set 15
              (local.get $mappings))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $~lib/string/String#get:length
              (local.get 15))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (if (result i32)  ;; label = @6
                  (i32.lt_s)
                  (then
                    (local.set 15
                      (local.get $mappings))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 15))
                    (i32.ne
                      (call $~lib/string/String#charCodeAt
                        (local.get 15)
                        (local.get $i))
                      (i32.const 44)))
                  (else
                    (i32.const 0)))
                (then
                  (local.set 15
                    (local.get $mappings))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 15))
                  (i32.ne
                    (call $~lib/string/String#charCodeAt
                      (local.get 15)
                      (local.get $i))
                    (i32.const 59)))
                (else
                  (i32.const 0)))
              (then
                (global.get $~lib/memory/__stack_pointer)
                (local.set 15
                  (local.get $mappings))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 15))
                (local.tee $vlq5
                  (call $src/sourcemap/decodeVLQ
                    (local.get 15)
                    (local.get $i)))
                (i32.store offset=40)
                (local.set 15
                  (local.get $vlq5))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 15))
                (local.set $i
                  (call $src/sourcemap/VLQResult#get:index
                    (local.get 15)))))
            (i32.store offset=44
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $entry
                (call $src/sourcemap/SourceMapEntry#constructor
                  (i32.const 0))))
            (local.set 15
              (local.get $entry))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $src/sourcemap/SourceMapEntry#set:generatedOffset
              (local.get 15)
              (local.get $genColumn))
            (local.set 15
              (local.get $entry))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $src/sourcemap/SourceMapEntry#set:sourceIndex
              (local.get 15)
              (local.get $srcIndex))
            (local.set 15
              (local.get $entry))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $src/sourcemap/SourceMapEntry#set:sourceLine
              (local.get 15)
              (local.get $srcLine))
            (local.set 15
              (local.get $entry))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (call $src/sourcemap/SourceMapEntry#set:sourceColumn
              (local.get 15)
              (local.get $srcColumn))
            (local.set 15
              (local.get $sourceMap))
            (i32.store offset=12
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.set 15
              (call $src/sourcemap/SourceMap#get:entries
                (local.get 15)))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.get 15)
            (local.set 15
              (local.get $entry))
            (i32.store offset=8
              (global.get $~lib/memory/__stack_pointer)
              (local.get 15))
            (local.get 15)
            (drop
              (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#push))
            (br 1 (;@2;))))))
    (local.set 15
      (local.get $sourceMap))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (local.set 15
      (call $src/sourcemap/SourceMap#get:entries
        (local.get 15)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (local.get 15)
    (local.set 15
      (i32.const 2000))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 15))
    (local.get 15)
    (drop
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#sort))
    (local.set 15
      (local.get $sourceMap))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 48)))
    (return
      (local.get 15)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#constructor (type 2) (param $this i32) (param $length i32) (result i32)
    (local $2 i32) (local $3 i32) (local $bufferSize i32) (local $buffer i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 14))))))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:buffer
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:dataStart
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:byteLength
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:length_
      (local.get 6)
      (i32.const 0))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $length)
        (i32.shr_u
          (i32.const 1073741820)
          (i32.const 2)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 768)
          (i32.const 880)
          (i32.const 70)
          (i32.const 60))
        (unreachable)))
    (local.set $bufferSize
      (i32.shl
        (select
          (local.tee $2
            (local.get $length))
          (local.tee $3
            (i32.const 8))
          (i32.gt_u
            (local.get $2)
            (local.get $3)))
        (i32.const 2)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $buffer
        (call $~lib/rt/itcms/__new
          (local.get $bufferSize)
          (i32.const 1))))
    (drop
      (i32.ne
        (i32.const 2)
        (global.get $~lib/shared/runtime/Runtime.Incremental)))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (local.get $buffer))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:buffer)
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:dataStart
      (local.get 6)
      (local.get $buffer))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:byteLength
      (local.get 6)
      (local.get $bufferSize))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:length_
      (local.get 6)
      (local.get $length))
    (local.set 6
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (local.get 6))
  (func $src/offsetmap/OffsetMapEntry#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 8)
              (i32.const 13))))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.tee $this
      (call $~lib/object/Object#constructor
        (local.get 1)))
    (i32.store)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    ;; Offset map parser: reads the JSON output of wasm2wat --offset-map.
    ;; Format: { "version": 1, "mappings": [{ "watLine": N, "offset": M }, ...] }
    (call $src/offsetmap/OffsetMapEntry#set:watLine
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/offsetmap/OffsetMapEntry#set:offset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (local.get 1))
  (func $src/offsetmap/ParseIntResult#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 8)
              (i32.const 15))))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.tee $this
      (call $~lib/object/Object#constructor
        (local.get 1)))
    (i32.store)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/offsetmap/ParseIntResult#set:value
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/offsetmap/ParseIntResult#set:index
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (local.get 1))
  (func $src/offsetmap/parseInteger (type 2) (param $s i32) (param $start i32) (result i32)
    (local $i i32) (local $negative i32) (local $value i32) (local $ch i32) (local $result i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $i
      (local.get $start))
    (local.set $negative
      (i32.const 0))
    ;; '-'
    (local.get $i)
    (local.set 7
      (local.get $s))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $~lib/string/String#get:length
      (local.get 7))
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 7
            (local.get $s))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 7))
          (i32.eq
            (call $~lib/string/String#charCodeAt
              (local.get 7)
              (local.get $i))
            (i32.const 45)))
        (else
          (i32.const 0)))
      (then
        (local.set $negative
          (i32.const 1))
        (local.set $i
          (i32.add
            (local.get $i)
            (i32.const 1)))))
    (local.set $value
      (i32.const 0))
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $i)
        (local.set 7
          (local.get $s))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 7))
        (call $~lib/string/String#get:length
          (local.get 7))
        (if  ;; label = @3
          (i32.lt_s)
          (then
            (local.set 7
              (local.get $s))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 7))
            (local.set $ch
              (call $~lib/string/String#charCodeAt
                (local.get 7)
                (local.get $i)))
            ;; '0'-'9'
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.ge_s
                  (local.get $ch)
                  (i32.const 48))
                (then
                  (i32.le_s
                    (local.get $ch)
                    (i32.const 57)))
                (else
                  (i32.const 0)))
              (then
                (local.set $value
                  (i32.add
                    (i32.mul
                      (local.get $value)
                      (i32.const 10))
                    (i32.sub
                      (local.get $ch)
                      (i32.const 48))))
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 1))))
              (else
                (br 3 (;@1;))))
            (br 1 (;@2;))))))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $result
        (call $src/offsetmap/ParseIntResult#constructor
          (i32.const 0))))
    (local.set 7
      (local.get $result))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $src/offsetmap/ParseIntResult#set:value
      (local.get 7)
      (if (result i32)  ;; label = @1
        (local.get $negative)
        (then
          (i32.sub
            (i32.const 0)
            (local.get $value)))
        (else
          (local.get $value))))
    (local.set 7
      (local.get $result))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $src/offsetmap/ParseIntResult#set:index
      (local.get 7)
      (local.get $i))
    (local.set 7
      (local.get $result))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 7)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#push (type 2) (param $this i32) (param $value i32) (result i32)
    (local $oldLen i32) (local $len i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.set $oldLen
      (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:length_
        (local.get 4)))
    (local.set $len
      (i32.add
        (local.get $oldLen)
        (i32.const 1)))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $len)
      (i32.const 2)
      (i32.const 1))
    (drop
      (i32.const 1))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (i32.store
      (i32.add
        (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:dataStart
          (local.get 4))
        (i32.shl
          (local.get $oldLen)
          (i32.const 2)))
      (local.get $value))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $value)
      (i32.const 1))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#set:length_
      (local.get 4)
      (local.get $len))
    (local.set 4
      (local.get $len))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 4)))
  (func $src/offsetmap/parseOffsetMap (type 1) (param $json i32) (result i32)
    (local $entries i32) (local $pos i32) (local $ch i32) (local $entry i32) (local $foundWatLine i32) (local $foundOffset i32) (local $keyEnd i32) (local $fieldName i32) (local $wch i32) (local $numResult i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 24))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $entries
        (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#constructor
          (i32.const 0)
          (i32.const 0))))
    ;; Find the "mappings" array
    (local.set 11
      (local.get $json))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 11))
    (local.get 11)
    (local.set 11
      (i32.const 2032))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 11))
    (local.get 11)
    (i32.const 0)
    (local.set $pos
      (call $~lib/string/String#indexOf))
    (if  ;; label = @1
      (i32.lt_s
        (local.get $pos)
        (i32.const 0))
      (then
        (local.set 11
          (local.get $entries))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 24)))
        (return
          (local.get 11))))
    (local.get $pos)
    (local.set 11
      (i32.const 2032))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 11))
    (call $~lib/string/String#get:length
      (local.get 11))
    (local.set $pos
      (i32.add))
    ;; Skip to '['
    ;; '['
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $pos)
        (local.set 11
          (local.get $json))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 11))
        (call $~lib/string/String#get:length
          (local.get 11))
        (if  ;; label = @3
          (if (result i32)  ;; label = @4
            (i32.lt_s)
            (then
              (local.set 11
                (local.get $json))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 11))
              (i32.ne
                (call $~lib/string/String#charCodeAt
                  (local.get 11)
                  (local.get $pos))
                (i32.const 91)))
            (else
              (i32.const 0)))
          (then
            (local.set $pos
              (i32.add
                (local.get $pos)
                (i32.const 1)))
            (br 1 (;@2;))))))
    (local.get $pos)
    (local.set 11
      (local.get $json))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 11))
    (call $~lib/string/String#get:length
      (local.get 11))
    (if  ;; label = @1
      (i32.ge_s)
      (then
        (local.set 11
          (local.get $entries))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 24)))
        (return
          (local.get 11))))
    ;; skip '['
    (local.set $pos
      (i32.add
        (local.get $pos)
        (i32.const 1)))
    ;; Parse each { "watLine": N, "offset": M } object
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $pos)
        (local.set 11
          (local.get $json))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 11))
        (call $~lib/string/String#get:length
          (local.get 11))
        (if  ;; label = @3
          (i32.lt_s)
          (then
            (local.set 11
              (local.get $json))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 11))
            (local.set $ch
              (call $~lib/string/String#charCodeAt
                (local.get 11)
                (local.get $pos)))
            ;; ']'
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (i32.const 93))
              (then
                (br 3 (;@1;))))
            ;; '{'
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (i32.const 123))
              (then
                ;; skip '{'
                (local.set $pos
                  (i32.add
                    (local.get $pos)
                    (i32.const 1)))
                (i32.store offset=12
                  (global.get $~lib/memory/__stack_pointer)
                  (local.tee $entry
                    (call $src/offsetmap/OffsetMapEntry#constructor
                      (i32.const 0))))
                (local.set $foundWatLine
                  (i32.const 0))
                (local.set $foundOffset
                  (i32.const 0))
                ;; '}'
                (block  ;; label = @5
                  (loop  ;; label = @6
                    (local.get $pos)
                    (local.set 11
                      (local.get $json))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 11))
                    (call $~lib/string/String#get:length
                      (local.get 11))
                    (if  ;; label = @7
                      (if (result i32)  ;; label = @8
                        (i32.lt_s)
                        (then
                          (local.set 11
                            (local.get $json))
                          (i32.store offset=4
                            (global.get $~lib/memory/__stack_pointer)
                            (local.get 11))
                          (i32.ne
                            (call $~lib/string/String#charCodeAt
                              (local.get 11)
                              (local.get $pos))
                            (i32.const 125)))
                        (else
                          (i32.const 0)))
                      (then
                        ;; Look for "watLine" or "offset" keys
                        ;; '"'
                        (local.set 11
                          (local.get $json))
                        (i32.store offset=4
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 11))
                        (if  ;; label = @8
                          (i32.eq
                            (call $~lib/string/String#charCodeAt
                              (local.get 11)
                              (local.get $pos))
                            (i32.const 34))
                          (then
                            ;; skip opening quote
                            (local.set $pos
                              (i32.add
                                (local.get $pos)
                                (i32.const 1)))
                            (local.set $keyEnd
                              (local.get $pos))
                            (block  ;; label = @9
                              (loop  ;; label = @10
                                (local.get $keyEnd)
                                (local.set 11
                                  (local.get $json))
                                (i32.store offset=4
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 11))
                                (call $~lib/string/String#get:length
                                  (local.get 11))
                                (if  ;; label = @11
                                  (if (result i32)  ;; label = @12
                                    (i32.lt_s)
                                    (then
                                      (local.set 11
                                        (local.get $json))
                                      (i32.store offset=4
                                        (global.get $~lib/memory/__stack_pointer)
                                        (local.get 11))
                                      (i32.ne
                                        (call $~lib/string/String#charCodeAt
                                          (local.get 11)
                                          (local.get $keyEnd))
                                        (i32.const 34)))
                                    (else
                                      (i32.const 0)))
                                  (then
                                    (local.set $keyEnd
                                      (i32.add
                                        (local.get $keyEnd)
                                        (i32.const 1)))
                                    (br 1 (;@10;))))))
                            (global.get $~lib/memory/__stack_pointer)
                            (local.set 11
                              (local.get $json))
                            (i32.store offset=4
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 11))
                            (local.tee $fieldName
                              (call $~lib/string/String#substring
                                (local.get 11)
                                (local.get $pos)
                                (local.get $keyEnd)))
                            (i32.store offset=16)
                            ;; skip closing quote
                            (local.set $pos
                              (i32.add
                                (local.get $keyEnd)
                                (i32.const 1)))
                            ;; Skip to ':'
                            (block  ;; label = @9
                              (loop  ;; label = @10
                                (local.get $pos)
                                (local.set 11
                                  (local.get $json))
                                (i32.store offset=4
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 11))
                                (call $~lib/string/String#get:length
                                  (local.get 11))
                                (if  ;; label = @11
                                  (if (result i32)  ;; label = @12
                                    (i32.lt_s)
                                    (then
                                      (local.set 11
                                        (local.get $json))
                                      (i32.store offset=4
                                        (global.get $~lib/memory/__stack_pointer)
                                        (local.get 11))
                                      (i32.ne
                                        (call $~lib/string/String#charCodeAt
                                          (local.get 11)
                                          (local.get $pos))
                                        (i32.const 58)))
                                    (else
                                      (i32.const 0)))
                                  (then
                                    (local.set $pos
                                      (i32.add
                                        (local.get $pos)
                                        (i32.const 1)))
                                    (br 1 (;@10;))))))
                            ;; skip ':'
                            (local.set $pos
                              (i32.add
                                (local.get $pos)
                                (i32.const 1)))
                            ;; Skip whitespace
                            (block  ;; label = @9
                              (loop  ;; label = @10
                                (local.get $pos)
                                (local.set 11
                                  (local.get $json))
                                (i32.store offset=4
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 11))
                                (call $~lib/string/String#get:length
                                  (local.get 11))
                                (if  ;; label = @11
                                  (i32.lt_s)
                                  (then
                                    (local.set 11
                                      (local.get $json))
                                    (i32.store offset=4
                                      (global.get $~lib/memory/__stack_pointer)
                                      (local.get 11))
                                    (local.set $wch
                                      (call $~lib/string/String#charCodeAt
                                        (local.get 11)
                                        (local.get $pos)))
                                    (if  ;; label = @12
                                      (if (result i32)  ;; label = @13
                                        (if (result i32)  ;; label = @14
                                          (if (result i32)  ;; label = @15
                                            (i32.eq
                                              (local.get $wch)
                                              (i32.const 32))
                                            (then
                                              (i32.const 1))
                                            (else
                                              (i32.eq
                                                (local.get $wch)
                                                (i32.const 9))))
                                          (then
                                            (i32.const 1))
                                          (else
                                            (i32.eq
                                              (local.get $wch)
                                              (i32.const 10))))
                                        (then
                                          (i32.const 1))
                                        (else
                                          (i32.eq
                                            (local.get $wch)
                                            (i32.const 13))))
                                      (then
                                        (local.set $pos
                                          (i32.add
                                            (local.get $pos)
                                            (i32.const 1))))
                                      (else
                                        (br 3 (;@9;))))
                                    (br 1 (;@10;))))))
                            (global.get $~lib/memory/__stack_pointer)
                            ;; Parse integer value
                            (local.set 11
                              (local.get $json))
                            (i32.store offset=4
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 11))
                            (local.tee $numResult
                              (call $src/offsetmap/parseInteger
                                (local.get 11)
                                (local.get $pos)))
                            (i32.store offset=20)
                            (local.set 11
                              (local.get $numResult))
                            (i32.store offset=4
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 11))
                            (local.set $pos
                              (call $src/offsetmap/ParseIntResult#get:index
                                (local.get 11)))
                            (local.set 11
                              (local.get $fieldName))
                            (i32.store offset=4
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 11))
                            (local.get 11)
                            (local.set 11
                              (i32.const 2080))
                            (i32.store offset=8
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 11))
                            (local.get 11)
                            (if  ;; label = @9
                              (call $~lib/string/String.__eq)
                              (then
                                (local.set 11
                                  (local.get $entry))
                                (i32.store offset=4
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 11))
                                (local.get 11)
                                (local.set 11
                                  (local.get $numResult))
                                (i32.store offset=8
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 11))
                                (call $src/offsetmap/ParseIntResult#get:value
                                  (local.get 11))
                                (call $src/offsetmap/OffsetMapEntry#set:watLine)
                                (local.set $foundWatLine
                                  (i32.const 1)))
                              (else
                                (local.set 11
                                  (local.get $fieldName))
                                (i32.store offset=4
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 11))
                                (local.get 11)
                                (local.set 11
                                  (i32.const 2128))
                                (i32.store offset=8
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 11))
                                (local.get 11)
                                (if  ;; label = @10
                                  (call $~lib/string/String.__eq)
                                  (then
                                    (local.set 11
                                      (local.get $entry))
                                    (i32.store offset=4
                                      (global.get $~lib/memory/__stack_pointer)
                                      (local.get 11))
                                    (local.get 11)
                                    (local.set 11
                                      (local.get $numResult))
                                    (i32.store offset=8
                                      (global.get $~lib/memory/__stack_pointer)
                                      (local.get 11))
                                    (call $src/offsetmap/ParseIntResult#get:value
                                      (local.get 11))
                                    (call $src/offsetmap/OffsetMapEntry#set:offset)
                                    (local.set $foundOffset
                                      (i32.const 1)))))))
                          (else
                            (local.set $pos
                              (i32.add
                                (local.get $pos)
                                (i32.const 1)))))
                        (br 1 (;@6;))))))
                ;; skip '}'
                (local.get $pos)
                (local.set 11
                  (local.get $json))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 11))
                (call $~lib/string/String#get:length
                  (local.get 11))
                (if  ;; label = @5
                  (i32.lt_s)
                  (then
                    (local.set $pos
                      (i32.add
                        (local.get $pos)
                        (i32.const 1)))))
                (if  ;; label = @5
                  (if (result i32)  ;; label = @6
                    (local.get $foundWatLine)
                    (then
                      (local.get $foundOffset))
                    (else
                      (i32.const 0)))
                  (then
                    (local.set 11
                      (local.get $entries))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 11))
                    (local.get 11)
                    (local.set 11
                      (local.get $entry))
                    (i32.store offset=8
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 11))
                    (local.get 11)
                    (drop
                      (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#push)))))
              (else
                (local.set $pos
                  (i32.add
                    (local.get $pos)
                    (i32.const 1)))))
            (br 1 (;@2;))))))
    (local.set 11
      (local.get $entries))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (return
      (local.get 11)))
  (func $~lib/map/Map<u32_u32>#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 24)
              (i32.const 16))))))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (i32.const 4))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u32_u32>#set:buckets)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_u32>#set:bucketsMask
      (local.get 1)
      (i32.sub
        (i32.const 4)
        (i32.const 1)))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (block (result i32)  ;; label = @1
            (br 0 (;@1;)
              (i32.const 12))))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u32_u32>#set:entries)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_u32>#set:entriesCapacity
      (local.get 1)
      (i32.const 4))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_u32>#set:entriesOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_u32>#set:entriesCount
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:length (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.set 1
      (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:length_
        (local.get 1)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 1)))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#__get (type 2) (param $this i32) (param $index i32) (result i32)
    (local $value i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.get $index)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:length_
      (local.get 3))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 528)
          (i32.const 880)
          (i32.const 114)
          (i32.const 42))
        (unreachable)))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.tee $value
      (i32.load
        (i32.add
          (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:dataStart
            (local.get 3))
          (i32.shl
            (local.get $index)
            (i32.const 2)))))
    (i32.store offset=4)
    (drop
      (i32.const 1))
    (drop
      (i32.eqz
        (i32.const 0)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $value))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 1248)
          (i32.const 880)
          (i32.const 118)
          (i32.const 40))
        (unreachable)))
    (local.set 3
      (local.get $value))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 3)))
  (func $~lib/map/Map<u32_u32>#find (type 3) (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
    (local $entry i32) (local $taggedNext i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/map/Map<u32_u32>#get:buckets
      (local.get 5))
    (local.get $hashCode)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $entry
      (i32.load
        (i32.add
          (call $~lib/map/Map<u32_u32>#get:bucketsMask
            (local.get 5))
          (i32.mul
            (i32.and)
            (i32.const 4)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (local.get $entry)
          (then
            (local.set $taggedNext
              (call $~lib/map/MapEntry<u32_u32>#get:taggedNext
                (local.get $entry)))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eqz
                  (i32.and
                    (local.get $taggedNext)
                    (i32.const 1)))
                (then
                  (i32.eq
                    (call $~lib/map/MapEntry<u32_u32>#get:key
                      (local.get $entry))
                    (local.get $key)))
                (else
                  (i32.const 0)))
              (then
                (local.set 5
                  (local.get $entry))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 5))))
            (local.set $entry
              (i32.and
                (local.get $taggedNext)
                (i32.xor
                  (i32.const 1)
                  (i32.const -1))))
            (br 1 (;@2;))))))
    (local.set 5
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 5)))
  (func $~lib/map/Map<u32_u32>#rehash (type 0) (param $this i32) (param $newBucketsMask i32)
    (local $newBucketsCapacity i32) (local $newBuckets i32) (local $newEntriesCapacity i32) (local $newEntries i32) (local $oldPtr i32) (local $oldEnd i32) (local $newPtr i32) (local $oldEntry i32) (local $newEntry i32) (local $oldEntryKey i32) (local $newBucketIndex i32) (local $newBucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $newBucketsCapacity
      (i32.add
        (local.get $newBucketsMask)
        (i32.const 1)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newBuckets
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newBucketsCapacity)
            (i32.const 4)))))
    (local.set $newEntriesCapacity
      (i32.div_s
        (i32.mul
          (local.get $newBucketsCapacity)
          (i32.const 8))
        (i32.const 3)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newEntries
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newEntriesCapacity)
            (block (result i32)  ;; label = @1
              (br 0 (;@1;)
                (i32.const 12)))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.set $oldPtr
      (call $~lib/map/Map<u32_u32>#get:entries
        (local.get 14)))
    (local.get $oldPtr)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (i32.mul
      (call $~lib/map/Map<u32_u32>#get:entriesOffset
        (local.get 14))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 12))))
    (local.set $oldEnd
      (i32.add))
    (local.set $newPtr
      (local.get $newEntries))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $oldPtr)
            (local.get $oldEnd))
          (then
            (local.set $oldEntry
              (local.get $oldPtr))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u32_u32>#get:taggedNext
                    (local.get $oldEntry))
                  (i32.const 1)))
              (then
                (local.set $newEntry
                  (local.get $newPtr))
                (local.set $oldEntryKey
                  (call $~lib/map/MapEntry<u32_u32>#get:key
                    (local.get $oldEntry)))
                (call $~lib/map/MapEntry<u32_u32>#set:key
                  (local.get $newEntry)
                  (local.get $oldEntryKey))
                (call $~lib/map/MapEntry<u32_u32>#set:value
                  (local.get $newEntry)
                  (call $~lib/map/MapEntry<u32_u32>#get:value
                    (local.get $oldEntry)))
                (local.set $newBucketIndex
                  (i32.and
                    (call $~lib/util/hash/HASH<u32>
                      (local.get $oldEntryKey))
                    (local.get $newBucketsMask)))
                (local.set $newBucketPtrBase
                  (i32.add
                    (local.get $newBuckets)
                    (i32.mul
                      (local.get $newBucketIndex)
                      (i32.const 4))))
                (call $~lib/map/MapEntry<u32_u32>#set:taggedNext
                  (local.get $newEntry)
                  (i32.load
                    (local.get $newBucketPtrBase)))
                (i32.store
                  (local.get $newBucketPtrBase)
                  (local.get $newPtr))
                (local.set $newPtr
                  (i32.add
                    (local.get $newPtr)
                    (block (result i32)  ;; label = @5
                      (br 0 (;@5;)
                        (i32.const 12)))))))
            (local.set $oldPtr
              (i32.add
                (local.get $oldPtr)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 12)))))
            (br 1 (;@2;))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newBuckets))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/map/Map<u32_u32>#set:buckets)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_u32>#set:bucketsMask
      (local.get 14)
      (local.get $newBucketsMask))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newEntries))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/map/Map<u32_u32>#set:entries)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_u32>#set:entriesCapacity
      (local.get 14)
      (local.get $newEntriesCapacity))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $this))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_u32>#get:entriesCount
      (local.get 14))
    (call $~lib/map/Map<u32_u32>#set:entriesOffset)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/map/Map<u32_u32>#set (type 3) (param $this i32) (param $key i32) (param $value i32) (result i32)
    (local $hashCode i32) (local $entry i32) (local $entries i32) (local $6 i32) (local $bucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $hashCode
      (call $~lib/util/hash/HASH<u32>
        (local.get $key)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $entry
      (call $~lib/map/Map<u32_u32>#find
        (local.get 8)
        (local.get $key)
        (local.get $hashCode)))
    (if  ;; label = @1
      (local.get $entry)
      (then
        (call $~lib/map/MapEntry<u32_u32>#set:value
          (local.get $entry)
          (local.get $value))
        (drop
          (i32.const 0)))
      (else
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_u32>#get:entriesOffset
          (local.get 8))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_u32>#get:entriesCapacity
          (local.get 8))
        (if  ;; label = @2
          (i32.eq)
          (then
            (local.set 8
              (local.get $this))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (local.get 8)
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u32_u32>#get:entriesCount
              (local.get 8))
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u32_u32>#rehash
              (i32.div_s
                (i32.mul
                  (call $~lib/map/Map<u32_u32>#get:entriesCapacity
                    (local.get 8))
                  (i32.const 3))
                (i32.const 4))
              (if (result i32)  ;; label = @3
                (i32.lt_s)
                (then
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (call $~lib/map/Map<u32_u32>#get:bucketsMask
                    (local.get 8)))
                (else
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (i32.or
                    (i32.shl
                      (call $~lib/map/Map<u32_u32>#get:bucketsMask
                        (local.get 8))
                      (i32.const 1))
                    (i32.const 1)))))))
        (global.get $~lib/memory/__stack_pointer)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.tee $entries
          (call $~lib/map/Map<u32_u32>#get:entries
            (local.get 8)))
        (i32.store offset=8)
        (local.get $entries)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (local.tee $6
            (call $~lib/map/Map<u32_u32>#get:entriesOffset
              (local.get 8)))
          (i32.const 1))
        (call $~lib/map/Map<u32_u32>#set:entriesOffset)
        (i32.mul
          (local.get $6)
          (block (result i32)  ;; label = @2
            (br 0 (;@2;)
              (i32.const 12))))
        (local.set $entry
          (i32.add))
        (call $~lib/map/MapEntry<u32_u32>#set:key
          (local.get $entry)
          (local.get $key))
        (drop
          (i32.const 0))
        (call $~lib/map/MapEntry<u32_u32>#set:value
          (local.get $entry)
          (local.get $value))
        (drop
          (i32.const 0))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (call $~lib/map/Map<u32_u32>#get:entriesCount
            (local.get 8))
          (i32.const 1))
        (call $~lib/map/Map<u32_u32>#set:entriesCount)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_u32>#get:buckets
          (local.get 8))
        (local.get $hashCode)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.set $bucketPtrBase
          (i32.add
            (call $~lib/map/Map<u32_u32>#get:bucketsMask
              (local.get 8))
            (i32.mul
              (i32.and)
              (i32.const 4))))
        (call $~lib/map/MapEntry<u32_u32>#set:taggedNext
          (local.get $entry)
          (i32.load
            (local.get $bucketPtrBase)))
        (i32.store
          (local.get $bucketPtrBase)
          (local.get $entry))))
    (local.set 8
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 8)))
  (func $src/offsetmap/buildLineToOffsetMap (type 1) (param $entries i32) (result i32)
    (local $map i32) (local $i i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    ;; Build a map from WAT line number to WASM byte offset for fast lookup.
    ;; Returns a Map<u32, u32> where key is watLine and value is offset.
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $map
        (call $~lib/map/Map<u32_u32>#constructor
          (i32.const 0))))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $i)
      (local.set 3
        (local.get $entries))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 3))
      (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:length
        (local.get 3))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 3
            (local.get $map))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (local.get 3)
          (local.set 3
            (local.get $entries))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (local.set 3
            (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#__get
              (local.get 3)
              (local.get $i)))
          (i32.store offset=8
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (call $src/offsetmap/OffsetMapEntry#get:watLine
            (local.get 3))
          (local.set 3
            (local.get $entries))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (local.set 3
            (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#__get
              (local.get 3)
              (local.get $i)))
          (i32.store offset=8
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (call $src/offsetmap/OffsetMapEntry#get:offset
            (local.get 3))
          (drop
            (call $~lib/map/Map<u32_u32>#set))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 3
      (local.get $map))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (return
      (local.get 3)))
  (func $~lib/map/Map<u64_~lib/string/String>#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 24)
              (i32.const 17))))))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (i32.const 4))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u64_~lib/string/String>#set:buckets)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u64_~lib/string/String>#set:bucketsMask
      (local.get 1)
      (i32.sub
        (i32.const 4)
        (i32.const 1)))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (block (result i32)  ;; label = @1
            (br 0 (;@1;)
              (i32.const 16))))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u64_~lib/string/String>#set:entries)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u64_~lib/string/String>#set:entriesCapacity
      (local.get 1)
      (i32.const 4))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u64_~lib/string/String>#set:entriesOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u64_~lib/string/String>#set:entriesCount
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/string/String#startsWith (type 3) (param $this i32) (param $search i32) (param $start i32) (result i32)
    (local $len i32) (local $4 i32) (local $5 i32) (local $6 i32) (local $7 i32) (local $searchStart i32) (local $searchLength i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 10
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (local.set $len
      (call $~lib/string/String#get:length
        (local.get 10)))
    (local.set $searchStart
      (select
        (local.tee $6
          (select
            (local.tee $4
              (local.get $start))
            (local.tee $5
              (i32.const 0))
            (i32.gt_s
              (local.get $4)
              (local.get $5))))
        (local.tee $7
          (local.get $len))
        (i32.lt_s
          (local.get $6)
          (local.get $7))))
    (local.set 10
      (local.get $search))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (local.set $searchLength
      (call $~lib/string/String#get:length
        (local.get 10)))
    (if  ;; label = @1
      (i32.gt_s
        (i32.add
          (local.get $searchLength)
          (local.get $searchStart))
        (local.get $len))
      (then
        (local.set 10
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 10))))
    (local.set 10
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (local.get 10)
    (local.get $searchStart)
    (local.set 10
      (local.get $search))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (local.get 10)
    (i32.const 0)
    (local.get $searchLength)
    (local.set 10
      (i32.eqz
        (call $~lib/util/string/compareImpl)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 10)))
  (func $~lib/string/String#substring@varargs (type 3) (param $this i32) (param $start i32) (param $end i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (block  ;; label = @1
      (block  ;; label = @2
        (block  ;; label = @3
          (br_table 1 (;@2;) 2 (;@1;) 0 (;@3;)
            (i32.sub
              (global.get $~argumentsLength)
              (i32.const 1))))
        (unreachable))
      (local.set $end
        (global.get $~lib/builtins/i32.MAX_VALUE)))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set 3
      (call $~lib/string/String#substring
        (local.get 3)
        (local.get $start)
        (local.get $end)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (local.get 3))
  (func $~lib/string/String#endsWith (type 3) (param $this i32) (param $search i32) (param $end i32) (result i32)
    (local $3 i32) (local $4 i32) (local $5 i32) (local $6 i32) (local $searchLength i32) (local $searchStart i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.tee $5
      (select
        (local.tee $3
          (local.get $end))
        (local.tee $4
          (i32.const 0))
        (i32.gt_s
          (local.get $3)
          (local.get $4))))
    (local.set 9
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (local.tee $6
      (call $~lib/string/String#get:length
        (local.get 9)))
    (i32.lt_s
      (local.get $5)
      (local.get $6))
    (local.set $end
      (select))
    (local.set 9
      (local.get $search))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (local.set $searchLength
      (call $~lib/string/String#get:length
        (local.get 9)))
    (local.set $searchStart
      (i32.sub
        (local.get $end)
        (local.get $searchLength)))
    (if  ;; label = @1
      (i32.lt_s
        (local.get $searchStart)
        (i32.const 0))
      (then
        (local.set 9
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 9))))
    (local.set 9
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (local.get 9)
    (local.get $searchStart)
    (local.set 9
      (local.get $search))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (local.get 9)
    (i32.const 0)
    (local.get $searchLength)
    (local.set 9
      (i32.eqz
        (call $~lib/util/string/compareImpl)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 9)))
  (func $~lib/string/String#endsWith@varargs (type 3) (param $this i32) (param $search i32) (param $end i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (block  ;; label = @1
      (block  ;; label = @2
        (block  ;; label = @3
          (br_table 1 (;@2;) 2 (;@1;) 0 (;@3;)
            (i32.sub
              (global.get $~argumentsLength)
              (i32.const 1))))
        (unreachable))
      (local.set $end
        (global.get $~lib/string/String.MAX_LENGTH)))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (local.set 3
      (local.get $search))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (local.get $end)
    (local.set 3
      (call $~lib/string/String#endsWith))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (local.get 3))
  (func $src/index/findSourceIndex (type 2) (param $sources i32) (param $path i32) (result i32)
    (local $normalized i32) (local $i i32) (local $i|4 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (global.get $~lib/memory/__stack_pointer)
    ;; Find a source file path in the source map's sources array.
    ;; Tries exact match, then suffix match. Returns -1 if not found.
    (local.set 5
      (local.get $path))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.get 5)
    (local.set 5
      (i32.const 2160))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.get 5)
    (i32.store offset=8
      (i32.const 0)
      (local.tee $normalized
        (if (result i32)  ;; label = @1
          (call $~lib/string/String#startsWith)
          (then
            (local.set 5
              (local.get $path))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 5))
            (local.get 5)
            (i32.const 2)
            (global.set $~argumentsLength
              (i32.const 1))
            (i32.const 0)
            (call $~lib/string/String#substring@varargs))
          (else
            (local.get $path)))))
    ;; Exact match
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $i)
      (local.set 5
        (local.get $sources))
      (i32.store
        (global.get $~lib/memory/__stack_pointer)
        (local.get 5))
      (call $~lib/array/Array<~lib/string/String>#get:length
        (local.get 5))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 5
            (local.get $sources))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 5))
          (local.set 5
            (call $~lib/array/Array<~lib/string/String>#__get
              (local.get 5)
              (local.get $i)))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 5))
          (local.get 5)
          (local.set 5
            (local.get $normalized))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 5))
          (local.get 5)
          (if  ;; label = @3
            (call $~lib/string/String.__eq)
            (then
              (local.set 5
                (local.get $i))
              (global.set $~lib/memory/__stack_pointer
                (i32.add
                  (global.get $~lib/memory/__stack_pointer)
                  (i32.const 16)))
              (return
                (local.get 5))))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    ;; Suffix match
    (local.set $i|4
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $i|4)
      (local.set 5
        (local.get $sources))
      (i32.store
        (global.get $~lib/memory/__stack_pointer)
        (local.get 5))
      (call $~lib/array/Array<~lib/string/String>#get:length
        (local.get 5))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 5
            (local.get $sources))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 5))
          (local.set 5
            (call $~lib/array/Array<~lib/string/String>#__get
              (local.get 5)
              (local.get $i|4)))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 5))
          (local.get 5)
          (local.set 5
            (local.get $normalized))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 5))
          (local.get 5)
          (global.set $~argumentsLength
            (i32.const 1))
          (i32.const 0)
          (if  ;; label = @3
            (call $~lib/string/String#endsWith@varargs)
            (then
              (local.set 5
                (local.get $i|4))
              (global.set $~lib/memory/__stack_pointer
                (i32.add
                  (global.get $~lib/memory/__stack_pointer)
                  (i32.const 16)))
              (return
                (local.get 5))))
          (local.set $i|4
            (i32.add
              (local.get $i|4)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 5
      (i32.const -1))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (return
      (local.get 5)))
  (func $~lib/array/Array<src/comments/SourceComment>#constructor (type 2) (param $this i32) (param $length i32) (result i32)
    (local $2 i32) (local $3 i32) (local $bufferSize i32) (local $buffer i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 19))))))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/comments/SourceComment>#set:buffer
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/comments/SourceComment>#set:dataStart
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/comments/SourceComment>#set:byteLength
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/comments/SourceComment>#set:length_
      (local.get 6)
      (i32.const 0))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $length)
        (i32.shr_u
          (i32.const 1073741820)
          (i32.const 2)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 768)
          (i32.const 880)
          (i32.const 70)
          (i32.const 60))
        (unreachable)))
    (local.set $bufferSize
      (i32.shl
        (select
          (local.tee $2
            (local.get $length))
          (local.tee $3
            (i32.const 8))
          (i32.gt_u
            (local.get $2)
            (local.get $3)))
        (i32.const 2)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $buffer
        (call $~lib/rt/itcms/__new
          (local.get $bufferSize)
          (i32.const 1))))
    (drop
      (i32.ne
        (i32.const 2)
        (global.get $~lib/shared/runtime/Runtime.Incremental)))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (local.get $buffer))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (call $~lib/array/Array<src/comments/SourceComment>#set:buffer)
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/comments/SourceComment>#set:dataStart
      (local.get 6)
      (local.get $buffer))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/comments/SourceComment>#set:byteLength
      (local.get 6)
      (local.get $bufferSize))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<src/comments/SourceComment>#set:length_
      (local.get 6)
      (local.get $length))
    (local.set 6
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (local.get 6))
  (func $src/comments/skipStringLiteral (type 3) (param $source i32) (param $start i32) (param $len i32) (result i32)
    (local $quote i32) (local $i i32) (local $ch i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    ;; Comment extractor: parses AssemblyScript source and extracts comments
    ;; with their line numbers.
    (local.set 6
      (local.get $source))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.set $quote
      (call $~lib/string/String#charCodeAt
        (local.get 6)
        (local.get $start)))
    (local.set $i
      (i32.add
        (local.get $start)
        (i32.const 1)))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_s
            (local.get $i)
            (local.get $len))
          (then
            (local.set 6
              (local.get $source))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.set $ch
              (call $~lib/string/String#charCodeAt
                (local.get 6)
                (local.get $i)))
            ;; '\\' escape
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (i32.const 92))
              (then
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 2)))
                (br 2 (;@2;))))
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (local.get $quote))
              (then
                (local.set 6
                  (i32.add
                    (local.get $i)
                    (i32.const 1)))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 6))))
            ;; newline ends non-template strings
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eq
                  (local.get $ch)
                  (i32.const 10))
                (then
                  (i32.ne
                    (local.get $quote)
                    (i32.const 96)))
                (else
                  (i32.const 0)))
              (then
                (local.set 6
                  (local.get $i))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 6))))
            (local.set $i
              (i32.add
                (local.get $i)
                (i32.const 1)))
            (br 1 (;@2;))))))
    (local.set 6
      (local.get $i))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 6)))
  (func $src/comments/SourceComment#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 8)
              (i32.const 18))))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.tee $this
      (call $~lib/object/Object#constructor
        (local.get 1)))
    (i32.store)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $src/comments/SourceComment#set:line
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (i32.const 1664))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $src/comments/SourceComment#set:text)
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/array/Array<src/comments/SourceComment>#push (type 2) (param $this i32) (param $value i32) (result i32)
    (local $oldLen i32) (local $len i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.set $oldLen
      (call $~lib/array/Array<src/comments/SourceComment>#get:length_
        (local.get 4)))
    (local.set $len
      (i32.add
        (local.get $oldLen)
        (i32.const 1)))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $len)
      (i32.const 2)
      (i32.const 1))
    (drop
      (i32.const 1))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (i32.store
      (i32.add
        (call $~lib/array/Array<src/comments/SourceComment>#get:dataStart
          (local.get 4))
        (i32.shl
          (local.get $oldLen)
          (i32.const 2)))
      (local.get $value))
    (call $~lib/rt/itcms/__link
      (local.get $this)
      (local.get $value)
      (i32.const 1))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/array/Array<src/comments/SourceComment>#set:length_
      (local.get 4)
      (local.get $len))
    (local.set 4
      (local.get $len))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 4)))
  (func $src/comments/extractComments (type 1) (param $source i32) (result i32)
    (local $comments i32) (local $i i32) (local $line i32) (local $len i32) (local $ch i32) (local $next i32) (local $start i32) (local $comment i32) (local $startLine i32) (local $start|10 i32) (local $comment|11 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 24))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $comments
        (call $~lib/array/Array<src/comments/SourceComment>#constructor
          (i32.const 0)
          (i32.const 0))))
    (local.set $i
      (i32.const 0))
    (local.set $line
      (i32.const 1))
    (local.set 12
      (local.get $source))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 12))
    (local.set $len
      (call $~lib/string/String#get:length
        (local.get 12)))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_s
            (local.get $i)
            (local.get $len))
          (then
            (local.set 12
              (local.get $source))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 12))
            (local.set $ch
              (call $~lib/string/String#charCodeAt
                (local.get 12)
                (local.get $i)))
            ;; Track line numbers
            ;; '\n'
            (if  ;; label = @4
              (i32.eq
                (local.get $ch)
                (i32.const 10))
              (then
                (local.set $line
                  (i32.add
                    (local.get $line)
                    (i32.const 1)))
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 1)))
                (br 2 (;@2;))))
            ;; Skip string literals to avoid false matches
            ;; '"', "'", '`'
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (if (result i32)  ;; label = @6
                  (i32.eq
                    (local.get $ch)
                    (i32.const 34))
                  (then
                    (i32.const 1))
                  (else
                    (i32.eq
                      (local.get $ch)
                      (i32.const 39))))
                (then
                  (i32.const 1))
                (else
                  (i32.eq
                    (local.get $ch)
                    (i32.const 96))))
              (then
                (local.set 12
                  (local.get $source))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 12))
                (local.set $i
                  (call $src/comments/skipStringLiteral
                    (local.get 12)
                    (local.get $i)
                    (local.get $len)))
                (br 2 (;@2;))))
            ;; Check for comments
            ;; '/'
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eq
                  (local.get $ch)
                  (i32.const 47))
                (then
                  (i32.lt_s
                    (i32.add
                      (local.get $i)
                      (i32.const 1))
                    (local.get $len)))
                (else
                  (i32.const 0)))
              (then
                (local.set 12
                  (local.get $source))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 12))
                (local.set $next
                  (call $~lib/string/String#charCodeAt
                    (local.get 12)
                    (i32.add
                      (local.get $i)
                      (i32.const 1))))
                ;; '//' single-line comment
                (if  ;; label = @5
                  (i32.eq
                    (local.get $next)
                    (i32.const 47))
                  (then
                    (local.set $start
                      (local.get $i))
                    (local.set $i
                      (i32.add
                        (local.get $i)
                        (i32.const 2)))
                    (block  ;; label = @6
                      (loop  ;; label = @7
                        (if  ;; label = @8
                          (if (result i32)  ;; label = @9
                            (i32.lt_s
                              (local.get $i)
                              (local.get $len))
                            (then
                              (local.set 12
                                (local.get $source))
                              (i32.store offset=4
                                (global.get $~lib/memory/__stack_pointer)
                                (local.get 12))
                              (i32.ne
                                (call $~lib/string/String#charCodeAt
                                  (local.get 12)
                                  (local.get $i))
                                (i32.const 10)))
                            (else
                              (i32.const 0)))
                          (then
                            (local.set $i
                              (i32.add
                                (local.get $i)
                                (i32.const 1)))
                            (br 1 (;@7;))))))
                    (i32.store offset=8
                      (global.get $~lib/memory/__stack_pointer)
                      (local.tee $comment
                        (call $src/comments/SourceComment#constructor
                          (i32.const 0))))
                    (local.set 12
                      (local.get $comment))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (call $src/comments/SourceComment#set:line
                      (local.get 12)
                      (local.get $line))
                    (local.set 12
                      (local.get $comment))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (local.set 12
                      (local.get $source))
                    (i32.store offset=16
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.set 12
                      (call $~lib/string/String#substring
                        (local.get 12)
                        (local.get $start)
                        (local.get $i)))
                    (i32.store offset=12
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (call $src/comments/SourceComment#set:text)
                    (local.set 12
                      (local.get $comments))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (local.set 12
                      (local.get $comment))
                    (i32.store offset=12
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (drop
                      (call $~lib/array/Array<src/comments/SourceComment>#push))
                    (br 3 (;@2;))))
                ;; '/*' multi-line comment
                (if  ;; label = @5
                  (i32.eq
                    (local.get $next)
                    (i32.const 42))
                  (then
                    (local.set $startLine
                      (local.get $line))
                    (local.set $start|10
                      (local.get $i))
                    (local.set $i
                      (i32.add
                        (local.get $i)
                        (i32.const 2)))
                    (block  ;; label = @6
                      (loop  ;; label = @7
                        (if  ;; label = @8
                          (i32.lt_s
                            (i32.add
                              (local.get $i)
                              (i32.const 1))
                            (local.get $len))
                          (then
                            (local.set 12
                              (local.get $source))
                            (i32.store offset=4
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 12))
                            (if  ;; label = @9
                              (i32.eq
                                (call $~lib/string/String#charCodeAt
                                  (local.get 12)
                                  (local.get $i))
                                (i32.const 10))
                              (then
                                (local.set $line
                                  (i32.add
                                    (local.get $line)
                                    (i32.const 1)))))
                            (local.set 12
                              (local.get $source))
                            (i32.store offset=4
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 12))
                            (if  ;; label = @9
                              (if (result i32)  ;; label = @10
                                (i32.eq
                                  (call $~lib/string/String#charCodeAt
                                    (local.get 12)
                                    (local.get $i))
                                  (i32.const 42))
                                (then
                                  (local.set 12
                                    (local.get $source))
                                  (i32.store offset=4
                                    (global.get $~lib/memory/__stack_pointer)
                                    (local.get 12))
                                  (i32.eq
                                    (call $~lib/string/String#charCodeAt
                                      (local.get 12)
                                      (i32.add
                                        (local.get $i)
                                        (i32.const 1)))
                                    (i32.const 47)))
                                (else
                                  (i32.const 0)))
                              (then
                                (local.set $i
                                  (i32.add
                                    (local.get $i)
                                    (i32.const 2)))
                                (br 3 (;@6;))))
                            (local.set $i
                              (i32.add
                                (local.get $i)
                                (i32.const 1)))
                            (br 1 (;@7;))))))
                    (i32.store offset=20
                      (global.get $~lib/memory/__stack_pointer)
                      (local.tee $comment|11
                        (call $src/comments/SourceComment#constructor
                          (i32.const 0))))
                    (local.set 12
                      (local.get $comment|11))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (call $src/comments/SourceComment#set:line
                      (local.get 12)
                      (local.get $startLine))
                    (local.set 12
                      (local.get $comment|11))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (local.set 12
                      (local.get $source))
                    (i32.store offset=16
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.set 12
                      (call $~lib/string/String#substring
                        (local.get 12)
                        (local.get $start|10)
                        (local.get $i)))
                    (i32.store offset=12
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (call $src/comments/SourceComment#set:text)
                    (local.set 12
                      (local.get $comments))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (local.set 12
                      (local.get $comment|11))
                    (i32.store offset=12
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 12))
                    (local.get 12)
                    (drop
                      (call $~lib/array/Array<src/comments/SourceComment>#push))
                    (br 3 (;@2;))))))
            (local.set $i
              (i32.add
                (local.get $i)
                (i32.const 1)))
            (br 1 (;@2;))))))
    (local.set 12
      (local.get $comments))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (return
      (local.get 12)))
  (func $~lib/array/Array<src/comments/SourceComment>#get:length (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.set 1
      (call $~lib/array/Array<src/comments/SourceComment>#get:length_
        (local.get 1)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 1)))
  (func $~lib/array/Array<src/comments/SourceComment>#__get (type 2) (param $this i32) (param $index i32) (result i32)
    (local $value i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.get $index)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<src/comments/SourceComment>#get:length_
      (local.get 3))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 528)
          (i32.const 880)
          (i32.const 114)
          (i32.const 42))
        (unreachable)))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.tee $value
      (i32.load
        (i32.add
          (call $~lib/array/Array<src/comments/SourceComment>#get:dataStart
            (local.get 3))
          (i32.shl
            (local.get $index)
            (i32.const 2)))))
    (i32.store offset=4)
    (drop
      (i32.const 1))
    (drop
      (i32.eqz
        (i32.const 0)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $value))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 1248)
          (i32.const 880)
          (i32.const 118)
          (i32.const 40))
        (unreachable)))
    (local.set 3
      (local.get $value))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 3)))
  (func $~lib/map/Map<u64_~lib/string/String>#find (type 10) (param $this i32) (param $key i64) (param $hashCode i32) (result i32)
    (local $entry i32) (local $taggedNext i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/map/Map<u64_~lib/string/String>#get:buckets
      (local.get 5))
    (local.get $hashCode)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $entry
      (i32.load
        (i32.add
          (call $~lib/map/Map<u64_~lib/string/String>#get:bucketsMask
            (local.get 5))
          (i32.mul
            (i32.and)
            (i32.const 4)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (local.get $entry)
          (then
            (local.set $taggedNext
              (call $~lib/map/MapEntry<u64_~lib/string/String>#get:taggedNext
                (local.get $entry)))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eqz
                  (i32.and
                    (local.get $taggedNext)
                    (i32.const 1)))
                (then
                  (i64.eq
                    (call $~lib/map/MapEntry<u64_~lib/string/String>#get:key
                      (local.get $entry))
                    (local.get $key)))
                (else
                  (i32.const 0)))
              (then
                (local.set 5
                  (local.get $entry))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 5))))
            (local.set $entry
              (i32.and
                (local.get $taggedNext)
                (i32.xor
                  (i32.const 1)
                  (i32.const -1))))
            (br 1 (;@2;))))))
    (local.set 5
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 5)))
  (func $~lib/map/Map<u64_~lib/string/String>#rehash (type 0) (param $this i32) (param $newBucketsMask i32)
    (local $newBucketsCapacity i32) (local $newBuckets i32) (local $newEntriesCapacity i32) (local $newEntries i32) (local $oldPtr i32) (local $oldEnd i32) (local $newPtr i32) (local $oldEntry i32) (local $newEntry i32) (local $newBucketIndex i32) (local $newBucketPtrBase i32) (local i32) (local $oldEntryKey i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $newBucketsCapacity
      (i32.add
        (local.get $newBucketsMask)
        (i32.const 1)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newBuckets
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newBucketsCapacity)
            (i32.const 4)))))
    (local.set $newEntriesCapacity
      (i32.div_s
        (i32.mul
          (local.get $newBucketsCapacity)
          (i32.const 8))
        (i32.const 3)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newEntries
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newEntriesCapacity)
            (block (result i32)  ;; label = @1
              (br 0 (;@1;)
                (i32.const 16)))))))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.set $oldPtr
      (call $~lib/map/Map<u64_~lib/string/String>#get:entries
        (local.get 13)))
    (local.get $oldPtr)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (i32.mul
      (call $~lib/map/Map<u64_~lib/string/String>#get:entriesOffset
        (local.get 13))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 16))))
    (local.set $oldEnd
      (i32.add))
    (local.set $newPtr
      (local.get $newEntries))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $oldPtr)
            (local.get $oldEnd))
          (then
            (local.set $oldEntry
              (local.get $oldPtr))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u64_~lib/string/String>#get:taggedNext
                    (local.get $oldEntry))
                  (i32.const 1)))
              (then
                (local.set $newEntry
                  (local.get $newPtr))
                (local.set $oldEntryKey
                  (call $~lib/map/MapEntry<u64_~lib/string/String>#get:key
                    (local.get $oldEntry)))
                (call $~lib/map/MapEntry<u64_~lib/string/String>#set:key
                  (local.get $newEntry)
                  (local.get $oldEntryKey))
                (local.get $newEntry)
                (local.set 13
                  (call $~lib/map/MapEntry<u64_~lib/string/String>#get:value
                    (local.get $oldEntry)))
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 13))
                (local.get 13)
                (call $~lib/map/MapEntry<u64_~lib/string/String>#set:value)
                (local.set $newBucketIndex
                  (i32.and
                    (call $~lib/util/hash/HASH<u64>
                      (local.get $oldEntryKey))
                    (local.get $newBucketsMask)))
                (local.set $newBucketPtrBase
                  (i32.add
                    (local.get $newBuckets)
                    (i32.mul
                      (local.get $newBucketIndex)
                      (i32.const 4))))
                (call $~lib/map/MapEntry<u64_~lib/string/String>#set:taggedNext
                  (local.get $newEntry)
                  (i32.load
                    (local.get $newBucketPtrBase)))
                (i32.store
                  (local.get $newBucketPtrBase)
                  (local.get $newPtr))
                (local.set $newPtr
                  (i32.add
                    (local.get $newPtr)
                    (block (result i32)  ;; label = @5
                      (br 0 (;@5;)
                        (i32.const 16)))))))
            (local.set $oldPtr
              (i32.add
                (local.get $oldPtr)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 16)))))
            (br 1 (;@2;))))))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $newBuckets))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (call $~lib/map/Map<u64_~lib/string/String>#set:buckets)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/map/Map<u64_~lib/string/String>#set:bucketsMask
      (local.get 13)
      (local.get $newBucketsMask))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $newEntries))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (call $~lib/map/Map<u64_~lib/string/String>#set:entries)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/map/Map<u64_~lib/string/String>#set:entriesCapacity
      (local.get 13)
      (local.get $newEntriesCapacity))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $this))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/map/Map<u64_~lib/string/String>#get:entriesCount
      (local.get 13))
    (call $~lib/map/Map<u64_~lib/string/String>#set:entriesOffset)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/map/Map<u64_~lib/string/String>#set (type 10) (param $this i32) (param $key i64) (param $value i32) (result i32)
    (local $hashCode i32) (local $entry i32) (local $entries i32) (local $6 i32) (local $bucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $hashCode
      (call $~lib/util/hash/HASH<u64>
        (local.get $key)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $entry
      (call $~lib/map/Map<u64_~lib/string/String>#find
        (local.get 8)
        (local.get $key)
        (local.get $hashCode)))
    (if  ;; label = @1
      (local.get $entry)
      (then
        (local.get $entry)
        (local.set 8
          (local.get $value))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/map/MapEntry<u64_~lib/string/String>#set:value)
        (drop
          (i32.const 1))
        (call $~lib/rt/itcms/__link
          (local.get $this)
          (local.get $value)
          (i32.const 1)))
      (else
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u64_~lib/string/String>#get:entriesOffset
          (local.get 8))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u64_~lib/string/String>#get:entriesCapacity
          (local.get 8))
        (if  ;; label = @2
          (i32.eq)
          (then
            (local.set 8
              (local.get $this))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (local.get 8)
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u64_~lib/string/String>#get:entriesCount
              (local.get 8))
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u64_~lib/string/String>#rehash
              (i32.div_s
                (i32.mul
                  (call $~lib/map/Map<u64_~lib/string/String>#get:entriesCapacity
                    (local.get 8))
                  (i32.const 3))
                (i32.const 4))
              (if (result i32)  ;; label = @3
                (i32.lt_s)
                (then
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (call $~lib/map/Map<u64_~lib/string/String>#get:bucketsMask
                    (local.get 8)))
                (else
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (i32.or
                    (i32.shl
                      (call $~lib/map/Map<u64_~lib/string/String>#get:bucketsMask
                        (local.get 8))
                      (i32.const 1))
                    (i32.const 1)))))))
        (global.get $~lib/memory/__stack_pointer)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.tee $entries
          (call $~lib/map/Map<u64_~lib/string/String>#get:entries
            (local.get 8)))
        (i32.store offset=8)
        (local.get $entries)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (local.tee $6
            (call $~lib/map/Map<u64_~lib/string/String>#get:entriesOffset
              (local.get 8)))
          (i32.const 1))
        (call $~lib/map/Map<u64_~lib/string/String>#set:entriesOffset)
        (i32.mul
          (local.get $6)
          (block (result i32)  ;; label = @2
            (br 0 (;@2;)
              (i32.const 16))))
        (local.set $entry
          (i32.add))
        (call $~lib/map/MapEntry<u64_~lib/string/String>#set:key
          (local.get $entry)
          (local.get $key))
        (drop
          (i32.const 0))
        (local.get $entry)
        (local.set 8
          (local.get $value))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/map/MapEntry<u64_~lib/string/String>#set:value)
        (drop
          (i32.const 1))
        (call $~lib/rt/itcms/__link
          (local.get $this)
          (local.get $value)
          (i32.const 1))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (call $~lib/map/Map<u64_~lib/string/String>#get:entriesCount
            (local.get 8))
          (i32.const 1))
        (call $~lib/map/Map<u64_~lib/string/String>#set:entriesCount)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u64_~lib/string/String>#get:buckets
          (local.get 8))
        (local.get $hashCode)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.set $bucketPtrBase
          (i32.add
            (call $~lib/map/Map<u64_~lib/string/String>#get:bucketsMask
              (local.get 8))
            (i32.mul
              (i32.and)
              (i32.const 4))))
        (call $~lib/map/MapEntry<u64_~lib/string/String>#set:taggedNext
          (local.get $entry)
          (i32.load
            (local.get $bucketPtrBase)))
        (i32.store
          (local.get $bucketPtrBase)
          (local.get $entry))))
    (local.set 8
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 8)))
  (func $src/injector/splitLines (type 1) (param $text i32) (result i32)
    (local $lines i32) (local $start i32) (local $i i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $lines
        (call $~lib/array/Array<~lib/string/String>#constructor
          (i32.const 0)
          (i32.const 0))))
    (local.set $start
      (i32.const 0))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $i)
      (local.set 4
        (local.get $text))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 4))
      (call $~lib/string/String#get:length
        (local.get 4))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          ;; '\n'
          (local.set 4
            (local.get $text))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 4))
          (if  ;; label = @3
            (i32.eq
              (call $~lib/string/String#charCodeAt
                (local.get 4)
                (local.get $i))
              (i32.const 10))
            (then
              (local.set 4
                (local.get $lines))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 4))
              (local.get 4)
              (local.set 4
                (local.get $text))
              (i32.store offset=12
                (global.get $~lib/memory/__stack_pointer)
                (local.get 4))
              (local.set 4
                (call $~lib/string/String#substring
                  (local.get 4)
                  (local.get $start)
                  (local.get $i)))
              (i32.store offset=8
                (global.get $~lib/memory/__stack_pointer)
                (local.get 4))
              (local.get 4)
              (drop
                (call $~lib/array/Array<~lib/string/String>#push))
              (local.set $start
                (i32.add
                  (local.get $i)
                  (i32.const 1)))))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.get $start)
    (local.set 4
      (local.get $text))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/string/String#get:length
      (local.get 4))
    (if  ;; label = @1
      (i32.lt_s)
      (then
        (local.set 4
          (local.get $lines))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 4))
        (local.get 4)
        (local.set 4
          (local.get $text))
        (i32.store offset=12
          (global.get $~lib/memory/__stack_pointer)
          (local.get 4))
        (local.get 4)
        (local.get $start)
        (global.set $~argumentsLength
          (i32.const 1))
        (i32.const 0)
        (local.set 4
          (call $~lib/string/String#substring@varargs))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 4))
        (local.get 4)
        (drop
          (call $~lib/array/Array<~lib/string/String>#push))))
    (local.set 4
      (local.get $lines))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (return
      (local.get 4)))
  (func $~lib/set/Set<u64>#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 24)
              (i32.const 20))))))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (i32.const 4))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/set/Set<u64>#set:buckets)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/set/Set<u64>#set:bucketsMask
      (local.get 1)
      (i32.sub
        (i32.const 4)
        (i32.const 1)))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (block (result i32)  ;; label = @1
            (br 0 (;@1;)
              (i32.const 16))))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/set/Set<u64>#set:entries)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/set/Set<u64>#set:entriesCapacity
      (local.get 1)
      (i32.const 4))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/set/Set<u64>#set:entriesOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/set/Set<u64>#set:entriesCount
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/array/Array<u32>#constructor (type 2) (param $this i32) (param $length i32) (result i32)
    (local $2 i32) (local $3 i32) (local $bufferSize i32) (local $buffer i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 21))))))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u32>#set:buffer
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u32>#set:dataStart
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u32>#set:byteLength
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u32>#set:length_
      (local.get 6)
      (i32.const 0))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $length)
        (i32.shr_u
          (i32.const 1073741820)
          (i32.const 2)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 768)
          (i32.const 880)
          (i32.const 70)
          (i32.const 60))
        (unreachable)))
    (local.set $bufferSize
      (i32.shl
        (select
          (local.tee $2
            (local.get $length))
          (local.tee $3
            (i32.const 8))
          (i32.gt_u
            (local.get $2)
            (local.get $3)))
        (i32.const 2)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $buffer
        (call $~lib/rt/itcms/__new
          (local.get $bufferSize)
          (i32.const 1))))
    (drop
      (i32.ne
        (i32.const 2)
        (global.get $~lib/shared/runtime/Runtime.Incremental)))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (local.get $buffer))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (call $~lib/array/Array<u32>#set:buffer)
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u32>#set:dataStart
      (local.get 6)
      (local.get $buffer))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u32>#set:byteLength
      (local.get 6)
      (local.get $bufferSize))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u32>#set:length_
      (local.get 6)
      (local.get $length))
    (local.set 6
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (local.get 6))
  (func $~lib/array/Array<u32>#__set (type 7) (param $this i32) (param $index i32) (param $value i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.get $index)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<u32>#get:length_
      (local.get 3))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (if  ;; label = @2
          (i32.lt_s
            (local.get $index)
            (i32.const 0))
          (then
            (call $~lib/wasi_internal/wasi_abort
              (i32.const 528)
              (i32.const 880)
              (i32.const 130)
              (i32.const 22))
            (unreachable)))
        (call $~lib/array/ensureCapacity
          (local.get $this)
          (i32.add
            (local.get $index)
            (i32.const 1))
          (i32.const 2)
          (i32.const 1))
        (local.set 3
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (call $~lib/array/Array<u32>#set:length_
          (local.get 3)
          (i32.add
            (local.get $index)
            (i32.const 1)))))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (i32.store
      (i32.add
        (call $~lib/array/Array<u32>#get:dataStart
          (local.get 3))
        (i32.shl
          (local.get $index)
          (i32.const 2)))
      (local.get $value))
    (drop
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<u32>#set:length (type 0) (param $this i32) (param $newLength i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $newLength)
      (i32.const 2)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/array/Array<u32>#set:length_
      (local.get 2)
      (local.get $newLength))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/map/Map<u32_u32>#keys (type 1) (param $this i32) (result i32)
    (local $start i32) (local $size i32) (local $keys i32) (local $length i32) (local $i i32) (local $entry i32) (local $7 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $start
      (call $~lib/map/Map<u32_u32>#get:entries
        (local.get 8)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $size
      (call $~lib/map/Map<u32_u32>#get:entriesOffset
        (local.get 8)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $keys
        (call $~lib/array/Array<u32>#constructor
          (i32.const 0)
          (local.get $size))))
    (local.set $length
      (i32.const 0))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_s
          (local.get $i)
          (local.get $size))
        (then
          (local.set $entry
            (i32.add
              (local.get $start)
              (i32.mul
                (local.get $i)
                (block (result i32)  ;; label = @3
                  (br 0 (;@3;)
                    (i32.const 12))))))
          (if  ;; label = @3
            (i32.eqz
              (i32.and
                (call $~lib/map/MapEntry<u32_u32>#get:taggedNext
                  (local.get $entry))
                (i32.const 1)))
            (then
              (local.set 8
                (local.get $keys))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 8))
              (local.get 8)
              (local.set $length
                (i32.add
                  (local.tee $7
                    (local.get $length))
                  (i32.const 1)))
              (local.get $7)
              (call $~lib/map/MapEntry<u32_u32>#get:key
                (local.get $entry))
              (call $~lib/array/Array<u32>#__set)))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 8
      (local.get $keys))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (call $~lib/array/Array<u32>#set:length
      (local.get 8)
      (local.get $length))
    (local.set 8
      (local.get $keys))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 8)))
  (func $~lib/array/Array<u32>#get:length (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.set 1
      (call $~lib/array/Array<u32>#get:length_
        (local.get 1)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 1)))
  (func $~lib/array/Array<u32>#__get (type 2) (param $this i32) (param $index i32) (result i32)
    (local $value i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.get $index)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<u32>#get:length_
      (local.get 3))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 528)
          (i32.const 880)
          (i32.const 114)
          (i32.const 42))
        (unreachable)))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $value
      (i32.load
        (i32.add
          (call $~lib/array/Array<u32>#get:dataStart
            (local.get 3))
          (i32.shl
            (local.get $index)
            (i32.const 2)))))
    (drop
      (i32.const 0))
    (local.set 3
      (local.get $value))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/map/Map<u32_u32>#get (type 2) (param $this i32) (param $key i32) (result i32)
    (local $entry i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entry
      (call $~lib/map/Map<u32_u32>#find
        (local.get 3)
        (local.get $key)
        (call $~lib/util/hash/HASH<u32>
          (local.get $key))))
    (if  ;; label = @1
      (i32.eqz
        (local.get $entry))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 2336)
          (i32.const 2400)
          (i32.const 105)
          (i32.const 17))
        (unreachable)))
    (local.set 3
      (call $~lib/map/MapEntry<u32_u32>#get:value
        (local.get $entry)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.set 1
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length_
        (local.get 1)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 1)))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#__get (type 2) (param $this i32) (param $index i32) (result i32)
    (local $value i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.get $index)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length_
      (local.get 3))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 528)
          (i32.const 880)
          (i32.const 114)
          (i32.const 42))
        (unreachable)))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.tee $value
      (i32.load
        (i32.add
          (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:dataStart
            (local.get 3))
          (i32.shl
            (local.get $index)
            (i32.const 2)))))
    (i32.store offset=4)
    (drop
      (i32.const 1))
    (drop
      (i32.eqz
        (i32.const 0)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $value))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 1248)
          (i32.const 880)
          (i32.const 118)
          (i32.const 40))
        (unreachable)))
    (local.set 3
      (local.get $value))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 3)))
  (func $src/sourcemap/lookupOffset (type 2) (param $entries i32) (param $offset i32) (result i32)
    (local $lo i32) (local $hi i32) (local $mid i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    ;; Binary search: find the source map entry for a given WASM byte offset.
    ;; Returns the entry with the largest generatedOffset <= the given offset,
    ;; or null if no entry matches.
    (local.set 5
      (local.get $entries))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (if  ;; label = @1
      (i32.eq
        (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length
          (local.get 5))
        (i32.const 0))
      (then
        (local.set 5
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 5))))
    (local.set $lo
      (i32.const 0))
    (local.set 5
      (local.get $entries))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $hi
      (i32.sub
        (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length
          (local.get 5))
        (i32.const 1)))
    ;; If offset is before the first entry, no match
    (local.get $offset)
    (local.set 5
      (local.get $entries))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set 5
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#__get
        (local.get 5)
        (i32.const 0)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $src/sourcemap/SourceMapEntry#get:generatedOffset
      (local.get 5))
    (if  ;; label = @1
      (i32.lt_u)
      (then
        (local.set 5
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 5))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_s
            (local.get $lo)
            (local.get $hi))
          (then
            (local.set $mid
              (i32.add
                (local.get $lo)
                (i32.shr_s
                  (i32.add
                    (i32.sub
                      (local.get $hi)
                      (local.get $lo))
                    (i32.const 1))
                  (i32.const 1))))
            (local.set 5
              (local.get $entries))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 5))
            (local.set 5
              (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#__get
                (local.get 5)
                (local.get $mid)))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 5))
            (if  ;; label = @4
              (i32.le_u
                (call $src/sourcemap/SourceMapEntry#get:generatedOffset
                  (local.get 5))
                (local.get $offset))
              (then
                (local.set $lo
                  (local.get $mid)))
              (else
                (local.set $hi
                  (i32.sub
                    (local.get $mid)
                    (i32.const 1)))))
            (br 1 (;@2;))))))
    (local.set 5
      (local.get $entries))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set 5
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#__get
        (local.get 5)
        (local.get $lo)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 5)))
  (func $~lib/set/Set<u64>#find (type 10) (param $this i32) (param $key i64) (param $hashCode i32) (result i32)
    (local $entry i32) (local $taggedNext i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/set/Set<u64>#get:buckets
      (local.get 5))
    (local.get $hashCode)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $entry
      (i32.load
        (i32.add
          (call $~lib/set/Set<u64>#get:bucketsMask
            (local.get 5))
          (i32.mul
            (i32.and)
            (i32.const 4)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (local.get $entry)
          (then
            (local.set $taggedNext
              (call $~lib/set/SetEntry<u64>#get:taggedNext
                (local.get $entry)))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eqz
                  (i32.and
                    (local.get $taggedNext)
                    (i32.const 1)))
                (then
                  (i64.eq
                    (call $~lib/set/SetEntry<u64>#get:key
                      (local.get $entry))
                    (local.get $key)))
                (else
                  (i32.const 0)))
              (then
                (local.set 5
                  (local.get $entry))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 5))))
            (local.set $entry
              (i32.and
                (local.get $taggedNext)
                (i32.xor
                  (i32.const 1)
                  (i32.const -1))))
            (br 1 (;@2;))))))
    (local.set 5
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 5)))
  (func $~lib/set/Set<u64>#rehash (type 0) (param $this i32) (param $newBucketsMask i32)
    (local $newBucketsCapacity i32) (local $newBuckets i32) (local $newEntriesCapacity i32) (local $newEntries i32) (local $oldPtr i32) (local $oldEnd i32) (local $newPtr i32) (local $oldEntry i32) (local $newEntry i32) (local $newBucketIndex i32) (local $newBucketPtrBase i32) (local i32) (local $oldEntryKey i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $newBucketsCapacity
      (i32.add
        (local.get $newBucketsMask)
        (i32.const 1)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newBuckets
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newBucketsCapacity)
            (i32.const 4)))))
    (local.set $newEntriesCapacity
      (i32.div_s
        (i32.mul
          (local.get $newBucketsCapacity)
          (i32.const 8))
        (i32.const 3)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newEntries
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newEntriesCapacity)
            (block (result i32)  ;; label = @1
              (br 0 (;@1;)
                (i32.const 16)))))))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.set $oldPtr
      (call $~lib/set/Set<u64>#get:entries
        (local.get 13)))
    (local.get $oldPtr)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (i32.mul
      (call $~lib/set/Set<u64>#get:entriesOffset
        (local.get 13))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 16))))
    (local.set $oldEnd
      (i32.add))
    (local.set $newPtr
      (local.get $newEntries))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $oldPtr)
            (local.get $oldEnd))
          (then
            (local.set $oldEntry
              (local.get $oldPtr))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/set/SetEntry<u64>#get:taggedNext
                    (local.get $oldEntry))
                  (i32.const 1)))
              (then
                (local.set $newEntry
                  (local.get $newPtr))
                (local.set $oldEntryKey
                  (call $~lib/set/SetEntry<u64>#get:key
                    (local.get $oldEntry)))
                (call $~lib/set/SetEntry<u64>#set:key
                  (local.get $newEntry)
                  (local.get $oldEntryKey))
                (local.set $newBucketIndex
                  (i32.and
                    (call $~lib/util/hash/HASH<u64>
                      (local.get $oldEntryKey))
                    (local.get $newBucketsMask)))
                (local.set $newBucketPtrBase
                  (i32.add
                    (local.get $newBuckets)
                    (i32.mul
                      (local.get $newBucketIndex)
                      (i32.const 4))))
                (call $~lib/set/SetEntry<u64>#set:taggedNext
                  (local.get $newEntry)
                  (i32.load
                    (local.get $newBucketPtrBase)))
                (i32.store
                  (local.get $newBucketPtrBase)
                  (local.get $newPtr))
                (local.set $newPtr
                  (i32.add
                    (local.get $newPtr)
                    (block (result i32)  ;; label = @5
                      (br 0 (;@5;)
                        (i32.const 16)))))))
            (local.set $oldPtr
              (i32.add
                (local.get $oldPtr)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 16)))))
            (br 1 (;@2;))))))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $newBuckets))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (call $~lib/set/Set<u64>#set:buckets)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/set/Set<u64>#set:bucketsMask
      (local.get 13)
      (local.get $newBucketsMask))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $newEntries))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (call $~lib/set/Set<u64>#set:entries)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/set/Set<u64>#set:entriesCapacity
      (local.get 13)
      (local.get $newEntriesCapacity))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $this))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/set/Set<u64>#get:entriesCount
      (local.get 13))
    (call $~lib/set/Set<u64>#set:entriesOffset)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/set/Set<u64>#add (type 9) (param $this i32) (param $key i64) (result i32)
    (local $hashCode i32) (local $entry i32) (local $4 i32) (local $bucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $hashCode
      (call $~lib/util/hash/HASH<u64>
        (local.get $key)))
    (local.set 6
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.set $entry
      (call $~lib/set/Set<u64>#find
        (local.get 6)
        (local.get $key)
        (local.get $hashCode)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $entry))
      (then
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/set/Set<u64>#get:entriesOffset
          (local.get 6))
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/set/Set<u64>#get:entriesCapacity
          (local.get 6))
        (if  ;; label = @2
          (i32.eq)
          (then
            (local.set 6
              (local.get $this))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.get 6)
            (local.set 6
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (call $~lib/set/Set<u64>#get:entriesCount
              (local.get 6))
            (local.set 6
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (call $~lib/set/Set<u64>#rehash
              (i32.div_s
                (i32.mul
                  (call $~lib/set/Set<u64>#get:entriesCapacity
                    (local.get 6))
                  (i32.const 3))
                (i32.const 4))
              (if (result i32)  ;; label = @3
                (i32.lt_s)
                (then
                  (local.set 6
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (call $~lib/set/Set<u64>#get:bucketsMask
                    (local.get 6)))
                (else
                  (local.set 6
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (i32.or
                    (i32.shl
                      (call $~lib/set/Set<u64>#get:bucketsMask
                        (local.get 6))
                      (i32.const 1))
                    (i32.const 1)))))))
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/set/Set<u64>#get:entries
          (local.get 6))
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (local.get 6)
        (local.set 6
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (i32.add
          (local.tee $4
            (call $~lib/set/Set<u64>#get:entriesOffset
              (local.get 6)))
          (i32.const 1))
        (call $~lib/set/Set<u64>#set:entriesOffset)
        (i32.mul
          (local.get $4)
          (block (result i32)  ;; label = @2
            (br 0 (;@2;)
              (i32.const 16))))
        (local.set $entry
          (i32.add))
        (call $~lib/set/SetEntry<u64>#set:key
          (local.get $entry)
          (local.get $key))
        (drop
          (i32.const 0))
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (local.get 6)
        (local.set 6
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (i32.add
          (call $~lib/set/Set<u64>#get:entriesCount
            (local.get 6))
          (i32.const 1))
        (call $~lib/set/Set<u64>#set:entriesCount)
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/set/Set<u64>#get:buckets
          (local.get 6))
        (local.get $hashCode)
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (local.set $bucketPtrBase
          (i32.add
            (call $~lib/set/Set<u64>#get:bucketsMask
              (local.get 6))
            (i32.mul
              (i32.and)
              (i32.const 4))))
        (call $~lib/set/SetEntry<u64>#set:taggedNext
          (local.get $entry)
          (i32.load
            (local.get $bucketPtrBase)))
        (i32.store
          (local.get $bucketPtrBase)
          (local.get $entry))))
    (local.set 6
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 6)))
  (func $src/injector/buildMappedLinesSet (type 2) (param $lineToOffset i32) (param $sourceEntries i32) (result i32)
    (local $mapped i32) (local $watLines i32) (local $i i32) (local $byteOffset i32) (local $entry i32) (local $e i32) (local i32) (local $key i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 24))
    ;; Build a set of (sourceIndex, sourceLine) keys for all source lines
    ;; that are mapped to by any WAT instruction via the source map.
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $mapped
        (call $~lib/set/Set<u64>#constructor
          (i32.const 0))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 8
      (local.get $lineToOffset))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.tee $watLines
      (call $~lib/map/Map<u32_u32>#keys
        (local.get 8)))
    (i32.store offset=8)
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $i)
      (local.set 8
        (local.get $watLines))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 8))
      (call $~lib/array/Array<u32>#get:length
        (local.get 8))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 8
            (local.get $lineToOffset))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 8))
          (local.get 8)
          (local.set 8
            (local.get $watLines))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 8))
          (call $~lib/array/Array<u32>#__get
            (local.get 8)
            (local.get $i))
          (local.set $byteOffset
            (call $~lib/map/Map<u32_u32>#get))
          (global.get $~lib/memory/__stack_pointer)
          (local.set 8
            (local.get $sourceEntries))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 8))
          (local.tee $entry
            (call $src/sourcemap/lookupOffset
              (local.get 8)
              (local.get $byteOffset)))
          (i32.store offset=16)
          (if  ;; label = @3
            (i32.ne
              (local.get $entry)
              (i32.const 0))
            (then
              (i32.store offset=20
                (global.get $~lib/memory/__stack_pointer)
                (local.tee $e
                  (local.get $entry)))
              (local.set 8
                (local.get $e))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 8))
              (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                (local.get 8))
              (local.set 8
                (local.get $e))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 8))
              (i32.add
                (call $src/sourcemap/SourceMapEntry#get:sourceLine
                  (local.get 8))
                (i32.const 1))
              (local.set $key
                (call $src/injector/commentKey))
              (local.set 8
                (local.get $mapped))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 8))
              (drop
                (call $~lib/set/Set<u64>#add
                  (local.get 8)
                  (local.get $key)))))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 8
      (local.get $mapped))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (return
      (local.get 8)))
  (func $~lib/map/Map<u32_u32>#has (type 2) (param $this i32) (param $key i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.set 2
      (i32.ne
        (call $~lib/map/Map<u32_u32>#find
          (local.get 2)
          (local.get $key)
          (call $~lib/util/hash/HASH<u32>
            (local.get $key)))
        (i32.const 0)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 24)
              (i32.const 23))))))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (i32.const 4))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:buckets)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:bucketsMask
      (local.get 1)
      (i32.sub
        (i32.const 4)
        (i32.const 1)))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (block (result i32)  ;; label = @1
            (br 0 (;@1;)
              (i32.const 12))))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entries)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesCapacity
      (local.get 1)
      (i32.const 4))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesCount
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/array/Array<u64>#constructor (type 2) (param $this i32) (param $length i32) (result i32)
    (local $2 i32) (local $3 i32) (local $bufferSize i32) (local $buffer i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 22))))))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u64>#set:buffer
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u64>#set:dataStart
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u64>#set:byteLength
      (local.get 6)
      (i32.const 0))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u64>#set:length_
      (local.get 6)
      (i32.const 0))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $length)
        (i32.shr_u
          (i32.const 1073741820)
          (i32.const 3)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 768)
          (i32.const 880)
          (i32.const 70)
          (i32.const 60))
        (unreachable)))
    (local.set $bufferSize
      (i32.shl
        (select
          (local.tee $2
            (local.get $length))
          (local.tee $3
            (i32.const 8))
          (i32.gt_u
            (local.get $2)
            (local.get $3)))
        (i32.const 3)))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $buffer
        (call $~lib/rt/itcms/__new
          (local.get $bufferSize)
          (i32.const 1))))
    (drop
      (i32.ne
        (i32.const 2)
        (global.get $~lib/shared/runtime/Runtime.Incremental)))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (local.get $buffer))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (call $~lib/array/Array<u64>#set:buffer)
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u64>#set:dataStart
      (local.get 6)
      (local.get $buffer))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u64>#set:byteLength
      (local.get 6)
      (local.get $bufferSize))
    (local.set 6
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $~lib/array/Array<u64>#set:length_
      (local.get 6)
      (local.get $length))
    (local.set 6
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (local.get 6))
  (func $~lib/array/Array<u64>#__set (type 22) (param $this i32) (param $index i32) (param $value i64)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.get $index)
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/array/Array<u64>#get:length_
      (local.get 3))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (if  ;; label = @2
          (i32.lt_s
            (local.get $index)
            (i32.const 0))
          (then
            (call $~lib/wasi_internal/wasi_abort
              (i32.const 528)
              (i32.const 880)
              (i32.const 130)
              (i32.const 22))
            (unreachable)))
        (call $~lib/array/ensureCapacity
          (local.get $this)
          (i32.add
            (local.get $index)
            (i32.const 1))
          (i32.const 3)
          (i32.const 1))
        (local.set 3
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (call $~lib/array/Array<u64>#set:length_
          (local.get 3)
          (i32.add
            (local.get $index)
            (i32.const 1)))))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (i64.store
      (i32.add
        (call $~lib/array/Array<u64>#get:dataStart
          (local.get 3))
        (i32.shl
          (local.get $index)
          (i32.const 3)))
      (local.get $value))
    (drop
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<u64>#set:length (type 0) (param $this i32) (param $newLength i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $newLength)
      (i32.const 3)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/array/Array<u64>#set:length_
      (local.get 2)
      (local.get $newLength))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/map/Map<u64_~lib/string/String>#keys (type 1) (param $this i32) (result i32)
    (local $start i32) (local $size i32) (local $keys i32) (local $length i32) (local $i i32) (local $entry i32) (local $7 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $start
      (call $~lib/map/Map<u64_~lib/string/String>#get:entries
        (local.get 8)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $size
      (call $~lib/map/Map<u64_~lib/string/String>#get:entriesOffset
        (local.get 8)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $keys
        (call $~lib/array/Array<u64>#constructor
          (i32.const 0)
          (local.get $size))))
    (local.set $length
      (i32.const 0))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_s
          (local.get $i)
          (local.get $size))
        (then
          (local.set $entry
            (i32.add
              (local.get $start)
              (i32.mul
                (local.get $i)
                (block (result i32)  ;; label = @3
                  (br 0 (;@3;)
                    (i32.const 16))))))
          (if  ;; label = @3
            (i32.eqz
              (i32.and
                (call $~lib/map/MapEntry<u64_~lib/string/String>#get:taggedNext
                  (local.get $entry))
                (i32.const 1)))
            (then
              (local.set 8
                (local.get $keys))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 8))
              (local.get 8)
              (local.set $length
                (i32.add
                  (local.tee $7
                    (local.get $length))
                  (i32.const 1)))
              (local.get $7)
              (call $~lib/map/MapEntry<u64_~lib/string/String>#get:key
                (local.get $entry))
              (call $~lib/array/Array<u64>#__set)))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 8
      (local.get $keys))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (call $~lib/array/Array<u64>#set:length
      (local.get 8)
      (local.get $length))
    (local.set 8
      (local.get $keys))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 8)))
  (func $~lib/array/Array<u64>#get:length (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.set 1
      (call $~lib/array/Array<u64>#get:length_
        (local.get 1)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 1)))
  (func $~lib/array/Array<u64>#__get (type 16) (param $this i32) (param $index i32) (result i64)
    (local $value i64) (local i64 i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.get $index)
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/array/Array<u64>#get:length_
      (local.get 4))
    (if  ;; label = @1
      (i32.ge_u)
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 528)
          (i32.const 880)
          (i32.const 114)
          (i32.const 42))
        (unreachable)))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.set $value
      (i64.load
        (i32.add
          (call $~lib/array/Array<u64>#get:dataStart
            (local.get 4))
          (i32.shl
            (local.get $index)
            (i32.const 3)))))
    (drop
      (i32.const 0))
    (local.set 3
      (local.get $value))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#find (type 3) (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
    (local $entry i32) (local $taggedNext i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:buckets
      (local.get 5))
    (local.get $hashCode)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $entry
      (i32.load
        (i32.add
          (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:bucketsMask
            (local.get 5))
          (i32.mul
            (i32.and)
            (i32.const 4)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (local.get $entry)
          (then
            (local.set $taggedNext
              (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:taggedNext
                (local.get $entry)))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eqz
                  (i32.and
                    (local.get $taggedNext)
                    (i32.const 1)))
                (then
                  (i32.eq
                    (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:key
                      (local.get $entry))
                    (local.get $key)))
                (else
                  (i32.const 0)))
              (then
                (local.set 5
                  (local.get $entry))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 5))))
            (local.set $entry
              (i32.and
                (local.get $taggedNext)
                (i32.xor
                  (i32.const 1)
                  (i32.const -1))))
            (br 1 (;@2;))))))
    (local.set 5
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 5)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#has (type 2) (param $this i32) (param $key i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.set 2
      (i32.ne
        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#find
          (local.get 2)
          (local.get $key)
          (call $~lib/util/hash/HASH<u32>
            (local.get $key)))
        (i32.const 0)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#rehash (type 0) (param $this i32) (param $newBucketsMask i32)
    (local $newBucketsCapacity i32) (local $newBuckets i32) (local $newEntriesCapacity i32) (local $newEntries i32) (local $oldPtr i32) (local $oldEnd i32) (local $newPtr i32) (local $oldEntry i32) (local $newEntry i32) (local $oldEntryKey i32) (local $newBucketIndex i32) (local $newBucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $newBucketsCapacity
      (i32.add
        (local.get $newBucketsMask)
        (i32.const 1)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newBuckets
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newBucketsCapacity)
            (i32.const 4)))))
    (local.set $newEntriesCapacity
      (i32.div_s
        (i32.mul
          (local.get $newBucketsCapacity)
          (i32.const 8))
        (i32.const 3)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newEntries
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newEntriesCapacity)
            (block (result i32)  ;; label = @1
              (br 0 (;@1;)
                (i32.const 12)))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.set $oldPtr
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entries
        (local.get 14)))
    (local.get $oldPtr)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (i32.mul
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesOffset
        (local.get 14))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 12))))
    (local.set $oldEnd
      (i32.add))
    (local.set $newPtr
      (local.get $newEntries))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $oldPtr)
            (local.get $oldEnd))
          (then
            (local.set $oldEntry
              (local.get $oldPtr))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:taggedNext
                    (local.get $oldEntry))
                  (i32.const 1)))
              (then
                (local.set $newEntry
                  (local.get $newPtr))
                (local.set $oldEntryKey
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:key
                    (local.get $oldEntry)))
                (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:key
                  (local.get $newEntry)
                  (local.get $oldEntryKey))
                (local.get $newEntry)
                (local.set 14
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:value
                    (local.get $oldEntry)))
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 14))
                (local.get 14)
                (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:value)
                (local.set $newBucketIndex
                  (i32.and
                    (call $~lib/util/hash/HASH<u32>
                      (local.get $oldEntryKey))
                    (local.get $newBucketsMask)))
                (local.set $newBucketPtrBase
                  (i32.add
                    (local.get $newBuckets)
                    (i32.mul
                      (local.get $newBucketIndex)
                      (i32.const 4))))
                (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:taggedNext
                  (local.get $newEntry)
                  (i32.load
                    (local.get $newBucketPtrBase)))
                (i32.store
                  (local.get $newBucketPtrBase)
                  (local.get $newPtr))
                (local.set $newPtr
                  (i32.add
                    (local.get $newPtr)
                    (block (result i32)  ;; label = @5
                      (br 0 (;@5;)
                        (i32.const 12)))))))
            (local.set $oldPtr
              (i32.add
                (local.get $oldPtr)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 12)))))
            (br 1 (;@2;))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newBuckets))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:buckets)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:bucketsMask
      (local.get 14)
      (local.get $newBucketsMask))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newEntries))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entries)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesCapacity
      (local.get 14)
      (local.get $newEntriesCapacity))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $this))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesCount
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesOffset)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#set (type 3) (param $this i32) (param $key i32) (param $value i32) (result i32)
    (local $hashCode i32) (local $entry i32) (local $entries i32) (local $6 i32) (local $bucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $hashCode
      (call $~lib/util/hash/HASH<u32>
        (local.get $key)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $entry
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#find
        (local.get 8)
        (local.get $key)
        (local.get $hashCode)))
    (if  ;; label = @1
      (local.get $entry)
      (then
        (local.get $entry)
        (local.set 8
          (local.get $value))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:value)
        (drop
          (i32.const 1))
        (call $~lib/rt/itcms/__link
          (local.get $this)
          (local.get $value)
          (i32.const 1)))
      (else
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesOffset
          (local.get 8))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesCapacity
          (local.get 8))
        (if  ;; label = @2
          (i32.eq)
          (then
            (local.set 8
              (local.get $this))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (local.get 8)
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesCount
              (local.get 8))
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u32_~lib/array/Array<u64>>#rehash
              (i32.div_s
                (i32.mul
                  (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesCapacity
                    (local.get 8))
                  (i32.const 3))
                (i32.const 4))
              (if (result i32)  ;; label = @3
                (i32.lt_s)
                (then
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:bucketsMask
                    (local.get 8)))
                (else
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (i32.or
                    (i32.shl
                      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:bucketsMask
                        (local.get 8))
                      (i32.const 1))
                    (i32.const 1)))))))
        (global.get $~lib/memory/__stack_pointer)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.tee $entries
          (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entries
            (local.get 8)))
        (i32.store offset=8)
        (local.get $entries)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (local.tee $6
            (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesOffset
              (local.get 8)))
          (i32.const 1))
        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesOffset)
        (i32.mul
          (local.get $6)
          (block (result i32)  ;; label = @2
            (br 0 (;@2;)
              (i32.const 12))))
        (local.set $entry
          (i32.add))
        (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:key
          (local.get $entry)
          (local.get $key))
        (drop
          (i32.const 0))
        (local.get $entry)
        (local.set 8
          (local.get $value))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:value)
        (drop
          (i32.const 1))
        (call $~lib/rt/itcms/__link
          (local.get $this)
          (local.get $value)
          (i32.const 1))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesCount
            (local.get 8))
          (i32.const 1))
        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set:entriesCount)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:buckets
          (local.get 8))
        (local.get $hashCode)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.set $bucketPtrBase
          (i32.add
            (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:bucketsMask
              (local.get 8))
            (i32.mul
              (i32.and)
              (i32.const 4))))
        (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#set:taggedNext
          (local.get $entry)
          (i32.load
            (local.get $bucketPtrBase)))
        (i32.store
          (local.get $bucketPtrBase)
          (local.get $entry))))
    (local.set 8
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 8)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#get (type 2) (param $this i32) (param $key i32) (result i32)
    (local $entry i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entry
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#find
        (local.get 3)
        (local.get $key)
        (call $~lib/util/hash/HASH<u32>
          (local.get $key))))
    (if  ;; label = @1
      (i32.eqz
        (local.get $entry))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 2336)
          (i32.const 2400)
          (i32.const 105)
          (i32.const 17))
        (unreachable)))
    (local.set 3
      (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:value
        (local.get $entry)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/array/Array<u64>#push (type 9) (param $this i32) (param $value i64) (result i32)
    (local $oldLen i32) (local $len i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.set $oldLen
      (call $~lib/array/Array<u64>#get:length_
        (local.get 4)))
    (local.set $len
      (i32.add
        (local.get $oldLen)
        (i32.const 1)))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $len)
      (i32.const 3)
      (i32.const 1))
    (drop
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (i64.store
      (i32.add
        (call $~lib/array/Array<u64>#get:dataStart
          (local.get 4))
        (i32.shl
          (local.get $oldLen)
          (i32.const 3)))
      (local.get $value))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/array/Array<u64>#set:length_
      (local.get 4)
      (local.get $len))
    (local.set 4
      (local.get $len))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 4)))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#keys (type 1) (param $this i32) (result i32)
    (local $start i32) (local $size i32) (local $keys i32) (local $length i32) (local $i i32) (local $entry i32) (local $7 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $start
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entries
        (local.get 8)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $size
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesOffset
        (local.get 8)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $keys
        (call $~lib/array/Array<u32>#constructor
          (i32.const 0)
          (local.get $size))))
    (local.set $length
      (i32.const 0))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_s
          (local.get $i)
          (local.get $size))
        (then
          (local.set $entry
            (i32.add
              (local.get $start)
              (i32.mul
                (local.get $i)
                (block (result i32)  ;; label = @3
                  (br 0 (;@3;)
                    (i32.const 12))))))
          (if  ;; label = @3
            (i32.eqz
              (i32.and
                (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:taggedNext
                  (local.get $entry))
                (i32.const 1)))
            (then
              (local.set 8
                (local.get $keys))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 8))
              (local.get 8)
              (local.set $length
                (i32.add
                  (local.tee $7
                    (local.get $length))
                  (i32.const 1)))
              (local.get $7)
              (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:key
                (local.get $entry))
              (call $~lib/array/Array<u32>#__set)))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 8
      (local.get $keys))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (call $~lib/array/Array<u32>#set:length
      (local.get 8)
      (local.get $length))
    (local.set 8
      (local.get $keys))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 8)))
  (func $~lib/util/sort/SORT<u64> (type 7) (param $ptr i32) (param $len i32) (param $comparator i32)
    (local $3 i32) (local $c i32) (local $c|9 i32) (local $n i32) (local $lgPlus2 i32) (local $lgPlus2Size i32) (local $leftRunStartBuf i32) (local $leftRunEndBuf i32) (local $i i32) (local $buffer i32) (local $hi i32) (local $endA i32) (local $lenA i32) (local $20 i32) (local $21 i32) (local $top i32) (local $startA i32) (local $startB i32) (local $endB i32) (local $lenB i32) (local $27 i32) (local $28 i32) (local $k i32) (local $i|30 i32) (local $start i32) (local $i|32 i32) (local $start|33 i32) (local i32) (local $a i64) (local $b i64) (local $a|7 i64) (local $b|8 i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.le_s
        (local.get $len)
        (i32.const 48))
      (then
        (if  ;; label = @2
          (i32.le_s
            (local.get $len)
            (i32.const 1))
          (then
            (global.set $~lib/memory/__stack_pointer
              (i32.add
                (global.get $~lib/memory/__stack_pointer)
                (i32.const 4)))
            (return)))
        (drop
          (i32.lt_s
            (i32.const 0)
            (i32.const 1)))
        (block  ;; label = @2
          (block  ;; label = @3
            (block  ;; label = @4
              (local.set $3
                (local.get $len))
              (br_if 0 (;@4;)
                (i32.eq
                  (local.get $3)
                  (i32.const 3)))
              (br_if 1 (;@3;)
                (i32.eq
                  (local.get $3)
                  (i32.const 2)))
              (br 2 (;@2;)))
            (local.set $a
              (i64.load
                (local.get $ptr)))
            (local.set $b
              (i64.load offset=8
                (local.get $ptr)))
            (local.get $a)
            (local.get $b)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (local.set $c
              (i32.gt_s
                (call_indirect $0 (type 4))
                (i32.const 0)))
            (i64.store
              (local.get $ptr)
              (select
                (local.get $b)
                (local.get $a)
                (local.get $c)))
            (local.set $a
              (select
                (local.get $a)
                (local.get $b)
                (local.get $c)))
            (local.set $b
              (i64.load offset=16
                (local.get $ptr)))
            (local.get $a)
            (local.get $b)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (local.set $c
              (i32.gt_s
                (call_indirect $0 (type 4))
                (i32.const 0)))
            (i64.store offset=8
              (local.get $ptr)
              (select
                (local.get $b)
                (local.get $a)
                (local.get $c)))
            (i64.store offset=16
              (local.get $ptr)
              (select
                (local.get $a)
                (local.get $b)
                (local.get $c))))
          (local.set $a|7
            (i64.load
              (local.get $ptr)))
          (local.set $b|8
            (i64.load offset=8
              (local.get $ptr)))
          (local.get $a|7)
          (local.get $b|8)
          (global.set $~argumentsLength
            (i32.const 2))
          (i32.load
            (local.get $comparator))
          (local.set $c|9
            (i32.gt_s
              (call_indirect $0 (type 4))
              (i32.const 0)))
          (i64.store
            (local.get $ptr)
            (select
              (local.get $b|8)
              (local.get $a|7)
              (local.get $c|9)))
          (i64.store offset=8
            (local.get $ptr)
            (select
              (local.get $a|7)
              (local.get $b|8)
              (local.get $c|9)))
          (global.set $~lib/memory/__stack_pointer
            (i32.add
              (global.get $~lib/memory/__stack_pointer)
              (i32.const 4)))
          (return))
        (local.get $ptr)
        (i32.const 0)
        (i32.sub
          (local.get $len)
          (i32.const 1))
        (i32.const 0)
        (local.set 30
          (local.get $comparator))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 30))
        (local.get 30)
        (call $~lib/util/sort/insertionSort<u64>)
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 4)))
        (return)))
    (local.set $lgPlus2
      (i32.add
        (block (result i32)  ;; label = @1
          (local.set $n
            (local.get $len))
          (br 0 (;@1;)
            (i32.sub
              (i32.const 31)
              (i32.clz
                (local.get $n)))))
        (i32.const 2)))
    (local.set $lgPlus2Size
      (i32.shl
        (local.get $lgPlus2)
        (i32.const 2)))
    (local.set $leftRunStartBuf
      (call $~lib/rt/tlsf/__alloc
        (i32.shl
          (local.get $lgPlus2Size)
          (i32.const 1))))
    (local.set $leftRunEndBuf
      (i32.add
        (local.get $leftRunStartBuf)
        (local.get $lgPlus2Size)))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_u
          (local.get $i)
          (local.get $lgPlus2))
        (then
          (i32.store
            (i32.add
              (local.get $leftRunStartBuf)
              (i32.shl
                (local.get $i)
                (i32.const 2)))
            (i32.const -1))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $buffer
      (call $~lib/rt/tlsf/__alloc
        (i32.shl
          (local.get $len)
          (i32.const 3))))
    (local.set $hi
      (i32.sub
        (local.get $len)
        (i32.const 1)))
    (local.get $ptr)
    (i32.const 0)
    (local.get $hi)
    (local.set 30
      (local.get $comparator))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 30))
    (local.get 30)
    (local.set $endA
      (call $~lib/util/sort/extendRunRight<u64>))
    (local.set $lenA
      (i32.add
        (local.get $endA)
        (i32.const 1)))
    (if  ;; label = @1
      (i32.lt_s
        (local.get $lenA)
        (i32.const 32))
      (then
        (local.set $endA
          (select
            (local.tee $20
              (local.get $hi))
            (local.tee $21
              (i32.sub
                (i32.const 32)
                (i32.const 1)))
            (i32.lt_s
              (local.get $20)
              (local.get $21))))
        (local.get $ptr)
        (i32.const 0)
        (local.get $endA)
        (local.get $lenA)
        (local.set 30
          (local.get $comparator))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 30))
        (local.get 30)
        (call $~lib/util/sort/insertionSort<u64>)))
    (local.set $top
      (i32.const 0))
    (local.set $startA
      (i32.const 0))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_s
            (local.get $endA)
            (local.get $hi))
          (then
            (local.set $startB
              (i32.add
                (local.get $endA)
                (i32.const 1)))
            (local.get $ptr)
            (local.get $startB)
            (local.get $hi)
            (local.set 30
              (local.get $comparator))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 30))
            (local.get 30)
            (local.set $endB
              (call $~lib/util/sort/extendRunRight<u64>))
            (local.set $lenB
              (i32.add
                (i32.sub
                  (local.get $endB)
                  (local.get $startB))
                (i32.const 1)))
            (if  ;; label = @4
              (i32.lt_s
                (local.get $lenB)
                (i32.const 32))
              (then
                (local.set $endB
                  (select
                    (local.tee $27
                      (local.get $hi))
                    (local.tee $28
                      (i32.sub
                        (i32.add
                          (local.get $startB)
                          (i32.const 32))
                        (i32.const 1)))
                    (i32.lt_s
                      (local.get $27)
                      (local.get $28))))
                (local.get $ptr)
                (local.get $startB)
                (local.get $endB)
                (local.get $lenB)
                (local.set 30
                  (local.get $comparator))
                (i32.store
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 30))
                (local.get 30)
                (call $~lib/util/sort/insertionSort<u64>)))
            (local.set $k
              (call $~lib/util/sort/nodePower
                (i32.const 0)
                (local.get $hi)
                (local.get $startA)
                (local.get $startB)
                (local.get $endB)))
            (local.set $i|30
              (local.get $top))
            (loop  ;; label = @4
              (if  ;; label = @5
                (i32.gt_u
                  (local.get $i|30)
                  (local.get $k))
                (then
                  (local.set $start
                    (i32.load
                      (i32.add
                        (local.get $leftRunStartBuf)
                        (i32.shl
                          (local.get $i|30)
                          (i32.const 2)))))
                  (if  ;; label = @6
                    (i32.ne
                      (local.get $start)
                      (i32.const -1))
                    (then
                      (local.get $ptr)
                      (local.get $start)
                      (i32.add
                        (i32.load
                          (i32.add
                            (local.get $leftRunEndBuf)
                            (i32.shl
                              (local.get $i|30)
                              (i32.const 2))))
                        (i32.const 1))
                      (local.get $endA)
                      (local.get $buffer)
                      (local.set 30
                        (local.get $comparator))
                      (i32.store
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 30))
                      (local.get 30)
                      (call $~lib/util/sort/mergeRuns<u64>)
                      (local.set $startA
                        (local.get $start))
                      (i32.store
                        (i32.add
                          (local.get $leftRunStartBuf)
                          (i32.shl
                            (local.get $i|30)
                            (i32.const 2)))
                        (i32.const -1))))
                  (local.set $i|30
                    (i32.sub
                      (local.get $i|30)
                      (i32.const 1)))
                  (br 1 (;@4;)))))
            (i32.store
              (i32.add
                (local.get $leftRunStartBuf)
                (i32.shl
                  (local.get $k)
                  (i32.const 2)))
              (local.get $startA))
            (i32.store
              (i32.add
                (local.get $leftRunEndBuf)
                (i32.shl
                  (local.get $k)
                  (i32.const 2)))
              (local.get $endA))
            (local.set $startA
              (local.get $startB))
            (local.set $endA
              (local.get $endB))
            (local.set $top
              (local.get $k))
            (br 1 (;@2;))))))
    (local.set $i|32
      (local.get $top))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.ne
          (local.get $i|32)
          (i32.const 0))
        (then
          (local.set $start|33
            (i32.load
              (i32.add
                (local.get $leftRunStartBuf)
                (i32.shl
                  (local.get $i|32)
                  (i32.const 2)))))
          (if  ;; label = @3
            (i32.ne
              (local.get $start|33)
              (i32.const -1))
            (then
              (local.get $ptr)
              (local.get $start|33)
              (i32.add
                (i32.load
                  (i32.add
                    (local.get $leftRunEndBuf)
                    (i32.shl
                      (local.get $i|32)
                      (i32.const 2))))
                (i32.const 1))
              (local.get $hi)
              (local.get $buffer)
              (local.set 30
                (local.get $comparator))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 30))
              (local.get 30)
              (call $~lib/util/sort/mergeRuns<u64>)))
          (local.set $i|32
            (i32.sub
              (local.get $i|32)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (call $~lib/rt/tlsf/__free
      (local.get $buffer))
    (call $~lib/rt/tlsf/__free
      (local.get $leftRunStartBuf))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<u64>#sort (type 2) (param $this i32) (param $comparator i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 2
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/array/Array<u64>#get:dataStart
      (local.get 2))
    (local.set 2
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/array/Array<u64>#get:length_
      (local.get 2))
    (local.set 2
      (local.get $comparator))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (call $~lib/util/sort/SORT<u64>)
    (local.set 2
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 2)))
  (func $src/injector/collectFileLevelComments (type 3) (param $commentMap i32) (param $lineToOffset i32) (param $sourceEntries i32) (result i32)
    (local $minMappedLine i32) (local $watLineKeys i32) (local $j i32) (local $byteOffset i32) (local $entry i32) (local $e i32) (local $srcLine i32) (local $cur i32) (local $result i32) (local $commentKeys i32) (local $j|13 i32) (local $srcIndex i32) (local $line i32) (local $minLine i32) (local $srcIndices i32) (local $j|19 i32) (local i32) (local $key i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 44)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 44))
    ;; Find the minimum mapped source line per source index
    ;; Collect file-level comments for each source file.
    ;; A file-level comment is any comment with a line number below the
    ;; minimum mapped source line for that file — i.e., comments that
    ;; appear before any code that generates WASM instructions.
    ;; Returns a map from sourceIndex to sorted array of comment keys.
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $minMappedLine
        (call $~lib/map/Map<u32_u32>#constructor
          (i32.const 0))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 19
      (local.get $lineToOffset))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 19))
    (local.tee $watLineKeys
      (call $~lib/map/Map<u32_u32>#keys
        (local.get 19)))
    (i32.store offset=8)
    (local.set $j
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $j)
      (local.set 19
        (local.get $watLineKeys))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 19))
      (call $~lib/array/Array<u32>#get:length
        (local.get 19))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 19
            (local.get $lineToOffset))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (local.get 19)
          (local.set 19
            (local.get $watLineKeys))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (call $~lib/array/Array<u32>#__get
            (local.get 19)
            (local.get $j))
          (local.set $byteOffset
            (call $~lib/map/Map<u32_u32>#get))
          (global.get $~lib/memory/__stack_pointer)
          (local.set 19
            (local.get $sourceEntries))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (local.tee $entry
            (call $src/sourcemap/lookupOffset
              (local.get 19)
              (local.get $byteOffset)))
          (i32.store offset=16)
          (if  ;; label = @3
            (i32.ne
              (local.get $entry)
              (i32.const 0))
            (then
              (i32.store offset=20
                (global.get $~lib/memory/__stack_pointer)
                (local.tee $e
                  (local.get $entry)))
              ;; 1-indexed
              (local.set 19
                (local.get $e))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 19))
              (local.set $srcLine
                (i32.add
                  (call $src/sourcemap/SourceMapEntry#get:sourceLine
                    (local.get 19))
                  (i32.const 1)))
              (local.set 19
                (local.get $minMappedLine))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 19))
              (local.get 19)
              (local.set 19
                (local.get $e))
              (i32.store offset=12
                (global.get $~lib/memory/__stack_pointer)
                (local.get 19))
              (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                (local.get 19))
              (if  ;; label = @4
                (i32.eqz
                  (call $~lib/map/Map<u32_u32>#has))
                (then
                  (local.set 19
                    (local.get $minMappedLine))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 19))
                  (local.get 19)
                  (local.set 19
                    (local.get $e))
                  (i32.store offset=12
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 19))
                  (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                    (local.get 19))
                  (local.get $srcLine)
                  (drop
                    (call $~lib/map/Map<u32_u32>#set)))
                (else
                  (local.set 19
                    (local.get $minMappedLine))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 19))
                  (local.get 19)
                  (local.set 19
                    (local.get $e))
                  (i32.store offset=12
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 19))
                  (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                    (local.get 19))
                  (local.set $cur
                    (call $~lib/map/Map<u32_u32>#get))
                  (if  ;; label = @5
                    (i32.lt_u
                      (local.get $srcLine)
                      (local.get $cur))
                    (then
                      (local.set 19
                        (local.get $minMappedLine))
                      (i32.store offset=4
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 19))
                      (local.get 19)
                      (local.set 19
                        (local.get $e))
                      (i32.store offset=12
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 19))
                      (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                        (local.get 19))
                      (local.get $srcLine)
                      (drop
                        (call $~lib/map/Map<u32_u32>#set))))))))
          (local.set $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (br 1 (;@1;)))))
    ;; Gather comments below the minimum mapped line for each file
    (i32.store offset=24
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $result
        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#constructor
          (i32.const 0))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 19
      (local.get $commentMap))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 19))
    (local.tee $commentKeys
      (call $~lib/map/Map<u64_~lib/string/String>#keys
        (local.get 19)))
    (i32.store offset=28)
    (local.set $j|13
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $j|13)
      (local.set 19
        (local.get $commentKeys))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 19))
      (call $~lib/array/Array<u64>#get:length
        (local.get 19))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 19
            (local.get $commentKeys))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (local.set $key
            (call $~lib/array/Array<u64>#__get
              (local.get 19)
              (local.get $j|13)))
          (local.set $srcIndex
            (i32.wrap_i64
              (i64.shr_u
                (local.get $key)
                (i64.const 32))))
          (local.set $line
            (i32.wrap_i64
              (i64.and
                (local.get $key)
                (i64.const 4294967295))))
          (local.set 19
            (local.get $minMappedLine))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (local.set $minLine
            (if (result i32)  ;; label = @3
              (call $~lib/map/Map<u32_u32>#has
                (local.get 19)
                (local.get $srcIndex))
              (then
                (local.set 19
                  (local.get $minMappedLine))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 19))
                (call $~lib/map/Map<u32_u32>#get
                  (local.get 19)
                  (local.get $srcIndex)))
              (else
                (i32.const 0))))
          (local.set 19
            (local.get $minMappedLine))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (if  ;; label = @3
            (if (result i32)  ;; label = @4
              (call $~lib/map/Map<u32_u32>#has
                (local.get 19)
                (local.get $srcIndex))
              (then
                (i32.lt_u
                  (local.get $line)
                  (local.get $minLine)))
              (else
                (i32.const 0)))
            (then
              (local.set 19
                (local.get $result))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 19))
              (if  ;; label = @4
                (i32.eqz
                  (call $~lib/map/Map<u32_~lib/array/Array<u64>>#has
                    (local.get 19)
                    (local.get $srcIndex)))
                (then
                  (local.set 19
                    (local.get $result))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 19))
                  (local.get 19)
                  (local.get $srcIndex)
                  (local.set 19
                    (call $~lib/array/Array<u64>#constructor
                      (i32.const 0)
                      (i32.const 0)))
                  (i32.store offset=12
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 19))
                  (local.get 19)
                  (drop
                    (call $~lib/map/Map<u32_~lib/array/Array<u64>>#set))))
              (local.set 19
                (local.get $result))
              (i32.store offset=12
                (global.get $~lib/memory/__stack_pointer)
                (local.get 19))
              (local.set 19
                (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get
                  (local.get 19)
                  (local.get $srcIndex)))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 19))
              (drop
                (call $~lib/array/Array<u64>#push
                  (local.get 19)
                  (local.get $key)))))
          (local.set $j|13
            (i32.add
              (local.get $j|13)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (global.get $~lib/memory/__stack_pointer)
    ;; Sort each file's comments by line number (ascending)
    (local.set 19
      (local.get $result))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 19))
    (local.tee $srcIndices
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#keys
        (local.get 19)))
    (i32.store offset=32)
    (local.set $j|19
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $j|19)
      (local.set 19
        (local.get $srcIndices))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 19))
      (call $~lib/array/Array<u32>#get:length
        (local.get 19))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 19
            (local.get $result))
          (i32.store offset=36
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (local.get 19)
          (local.set 19
            (local.get $srcIndices))
          (i32.store offset=40
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (call $~lib/array/Array<u32>#__get
            (local.get 19)
            (local.get $j|19))
          (local.set 19
            (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (local.get 19)
          (local.set 19
            (i32.const 2448))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 19))
          (local.get 19)
          (drop
            (call $~lib/array/Array<u64>#sort))
          (local.set $j|19
            (i32.add
              (local.get $j|19)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 19
      (local.get $result))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 44)))
    (return
      (local.get 19)))
  (func $~lib/set/Set<u32>#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 24)
              (i32.const 25))))))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (i32.const 4))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/set/Set<u32>#set:buckets)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/set/Set<u32>#set:bucketsMask
      (local.get 1)
      (i32.sub
        (i32.const 4)
        (i32.const 1)))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (block (result i32)  ;; label = @1
            (br 0 (;@1;)
              (i32.const 8))))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/set/Set<u32>#set:entries)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/set/Set<u32>#set:entriesCapacity
      (local.get 1)
      (i32.const 4))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/set/Set<u32>#set:entriesOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/set/Set<u32>#set:entriesCount
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/set/Set<u32>#find (type 3) (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
    (local $entry i32) (local $taggedNext i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/set/Set<u32>#get:buckets
      (local.get 5))
    (local.get $hashCode)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $entry
      (i32.load
        (i32.add
          (call $~lib/set/Set<u32>#get:bucketsMask
            (local.get 5))
          (i32.mul
            (i32.and)
            (i32.const 4)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (local.get $entry)
          (then
            (local.set $taggedNext
              (call $~lib/set/SetEntry<u32>#get:taggedNext
                (local.get $entry)))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eqz
                  (i32.and
                    (local.get $taggedNext)
                    (i32.const 1)))
                (then
                  (i32.eq
                    (call $~lib/set/SetEntry<u32>#get:key
                      (local.get $entry))
                    (local.get $key)))
                (else
                  (i32.const 0)))
              (then
                (local.set 5
                  (local.get $entry))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 5))))
            (local.set $entry
              (i32.and
                (local.get $taggedNext)
                (i32.xor
                  (i32.const 1)
                  (i32.const -1))))
            (br 1 (;@2;))))))
    (local.set 5
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 5)))
  (func $~lib/set/Set<u32>#has (type 2) (param $this i32) (param $key i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.set 2
      (i32.ne
        (call $~lib/set/Set<u32>#find
          (local.get 2)
          (local.get $key)
          (call $~lib/util/hash/HASH<u32>
            (local.get $key)))
        (i32.const 0)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/set/Set<u32>#rehash (type 0) (param $this i32) (param $newBucketsMask i32)
    (local $newBucketsCapacity i32) (local $newBuckets i32) (local $newEntriesCapacity i32) (local $newEntries i32) (local $oldPtr i32) (local $oldEnd i32) (local $newPtr i32) (local $oldEntry i32) (local $newEntry i32) (local $oldEntryKey i32) (local $newBucketIndex i32) (local $newBucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $newBucketsCapacity
      (i32.add
        (local.get $newBucketsMask)
        (i32.const 1)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newBuckets
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newBucketsCapacity)
            (i32.const 4)))))
    (local.set $newEntriesCapacity
      (i32.div_s
        (i32.mul
          (local.get $newBucketsCapacity)
          (i32.const 8))
        (i32.const 3)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newEntries
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newEntriesCapacity)
            (block (result i32)  ;; label = @1
              (br 0 (;@1;)
                (i32.const 8)))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.set $oldPtr
      (call $~lib/set/Set<u32>#get:entries
        (local.get 14)))
    (local.get $oldPtr)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (i32.mul
      (call $~lib/set/Set<u32>#get:entriesOffset
        (local.get 14))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 8))))
    (local.set $oldEnd
      (i32.add))
    (local.set $newPtr
      (local.get $newEntries))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $oldPtr)
            (local.get $oldEnd))
          (then
            (local.set $oldEntry
              (local.get $oldPtr))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/set/SetEntry<u32>#get:taggedNext
                    (local.get $oldEntry))
                  (i32.const 1)))
              (then
                (local.set $newEntry
                  (local.get $newPtr))
                (local.set $oldEntryKey
                  (call $~lib/set/SetEntry<u32>#get:key
                    (local.get $oldEntry)))
                (call $~lib/set/SetEntry<u32>#set:key
                  (local.get $newEntry)
                  (local.get $oldEntryKey))
                (local.set $newBucketIndex
                  (i32.and
                    (call $~lib/util/hash/HASH<u32>
                      (local.get $oldEntryKey))
                    (local.get $newBucketsMask)))
                (local.set $newBucketPtrBase
                  (i32.add
                    (local.get $newBuckets)
                    (i32.mul
                      (local.get $newBucketIndex)
                      (i32.const 4))))
                (call $~lib/set/SetEntry<u32>#set:taggedNext
                  (local.get $newEntry)
                  (i32.load
                    (local.get $newBucketPtrBase)))
                (i32.store
                  (local.get $newBucketPtrBase)
                  (local.get $newPtr))
                (local.set $newPtr
                  (i32.add
                    (local.get $newPtr)
                    (block (result i32)  ;; label = @5
                      (br 0 (;@5;)
                        (i32.const 8)))))))
            (local.set $oldPtr
              (i32.add
                (local.get $oldPtr)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 8)))))
            (br 1 (;@2;))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newBuckets))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/set/Set<u32>#set:buckets)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/set/Set<u32>#set:bucketsMask
      (local.get 14)
      (local.get $newBucketsMask))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newEntries))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/set/Set<u32>#set:entries)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/set/Set<u32>#set:entriesCapacity
      (local.get 14)
      (local.get $newEntriesCapacity))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $this))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/set/Set<u32>#get:entriesCount
      (local.get 14))
    (call $~lib/set/Set<u32>#set:entriesOffset)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/set/Set<u32>#add (type 2) (param $this i32) (param $key i32) (result i32)
    (local $hashCode i32) (local $entry i32) (local $4 i32) (local $bucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $hashCode
      (call $~lib/util/hash/HASH<u32>
        (local.get $key)))
    (local.set 6
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.set $entry
      (call $~lib/set/Set<u32>#find
        (local.get 6)
        (local.get $key)
        (local.get $hashCode)))
    (if  ;; label = @1
      (i32.eqz
        (local.get $entry))
      (then
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/set/Set<u32>#get:entriesOffset
          (local.get 6))
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/set/Set<u32>#get:entriesCapacity
          (local.get 6))
        (if  ;; label = @2
          (i32.eq)
          (then
            (local.set 6
              (local.get $this))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.get 6)
            (local.set 6
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (call $~lib/set/Set<u32>#get:entriesCount
              (local.get 6))
            (local.set 6
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (call $~lib/set/Set<u32>#rehash
              (i32.div_s
                (i32.mul
                  (call $~lib/set/Set<u32>#get:entriesCapacity
                    (local.get 6))
                  (i32.const 3))
                (i32.const 4))
              (if (result i32)  ;; label = @3
                (i32.lt_s)
                (then
                  (local.set 6
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (call $~lib/set/Set<u32>#get:bucketsMask
                    (local.get 6)))
                (else
                  (local.set 6
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (i32.or
                    (i32.shl
                      (call $~lib/set/Set<u32>#get:bucketsMask
                        (local.get 6))
                      (i32.const 1))
                    (i32.const 1)))))))
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/set/Set<u32>#get:entries
          (local.get 6))
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (local.get 6)
        (local.set 6
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (i32.add
          (local.tee $4
            (call $~lib/set/Set<u32>#get:entriesOffset
              (local.get 6)))
          (i32.const 1))
        (call $~lib/set/Set<u32>#set:entriesOffset)
        (i32.mul
          (local.get $4)
          (block (result i32)  ;; label = @2
            (br 0 (;@2;)
              (i32.const 8))))
        (local.set $entry
          (i32.add))
        (call $~lib/set/SetEntry<u32>#set:key
          (local.get $entry)
          (local.get $key))
        (drop
          (i32.const 0))
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (local.get 6)
        (local.set 6
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (i32.add
          (call $~lib/set/Set<u32>#get:entriesCount
            (local.get 6))
          (i32.const 1))
        (call $~lib/set/Set<u32>#set:entriesCount)
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/set/Set<u32>#get:buckets
          (local.get 6))
        (local.get $hashCode)
        (local.set 6
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (local.set $bucketPtrBase
          (i32.add
            (call $~lib/set/Set<u32>#get:bucketsMask
              (local.get 6))
            (i32.mul
              (i32.and)
              (i32.const 4))))
        (call $~lib/set/SetEntry<u32>#set:taggedNext
          (local.get $entry)
          (i32.load
            (local.get $bucketPtrBase)))
        (i32.store
          (local.get $bucketPtrBase)
          (local.get $entry))))
    (local.set 6
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 6)))
  (func $~lib/set/Set<u64>#has (type 9) (param $this i32) (param $key i64) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.set 2
      (i32.ne
        (call $~lib/set/Set<u64>#find
          (local.get 2)
          (local.get $key)
          (call $~lib/util/hash/HASH<u64>
            (local.get $key)))
        (i32.const 0)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/map/Map<u64_~lib/string/String>#get (type 9) (param $this i32) (param $key i64) (result i32)
    (local $entry i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entry
      (call $~lib/map/Map<u64_~lib/string/String>#find
        (local.get 3)
        (local.get $key)
        (call $~lib/util/hash/HASH<u64>
          (local.get $key))))
    (if  ;; label = @1
      (i32.eqz
        (local.get $entry))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 2336)
          (i32.const 2400)
          (i32.const 105)
          (i32.const 17))
        (unreachable)))
    (local.set 3
      (call $~lib/map/MapEntry<u64_~lib/string/String>#get:value
        (local.get $entry)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/string/String#trim (type 1) (param $this i32) (result i32)
    (local $len i32) (local $size i32) (local $offset i32) (local $out i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $len
      (call $~lib/string/String#get:length
        (local.get 5)))
    (local.set $size
      (i32.shl
        (local.get $len)
        (i32.const 1)))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (if (result i32)  ;; label = @4
            (local.get $size)
            (then
              (call $~lib/util/string/isSpace
                (i32.load16_u
                  (i32.sub
                    (i32.add
                      (local.get $this)
                      (local.get $size))
                    (i32.const 2)))))
            (else
              (i32.const 0)))
          (then
            (local.set $size
              (i32.sub
                (local.get $size)
                (i32.const 2)))
            (br 1 (;@2;))))))
    (local.set $offset
      (i32.const 0))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (if (result i32)  ;; label = @4
            (i32.lt_u
              (local.get $offset)
              (local.get $size))
            (then
              (call $~lib/util/string/isSpace
                (i32.load16_u
                  (i32.add
                    (local.get $this)
                    (local.get $offset)))))
            (else
              (i32.const 0)))
          (then
            (local.set $offset
              (i32.add
                (local.get $offset)
                (i32.const 2)))
            (local.set $size
              (i32.sub
                (local.get $size)
                (i32.const 2)))
            (br 1 (;@2;))))))
    (if  ;; label = @1
      (i32.eqz
        (local.get $size))
      (then
        (local.set 5
          (i32.const 1664))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 5))))
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.eqz
          (local.get $offset))
        (then
          (i32.eq
            (local.get $size)
            (i32.shl
              (local.get $len)
              (i32.const 1))))
        (else
          (i32.const 0)))
      (then
        (local.set 5
          (local.get $this))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 8)))
        (return
          (local.get 5))))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $out
        (call $~lib/rt/itcms/__new
          (local.get $size)
          (i32.const 2))))
    (memory.copy
      (local.get $out)
      (i32.add
        (local.get $this)
        (local.get $offset))
      (local.get $size))
    (local.set 5
      (local.get $out))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 5)))
  (func $src/injector/convertToWatComment (type 1) (param $text i32) (result i32)
    (local $s i32) (local $inner i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 20)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 20))
    (global.get $~lib/memory/__stack_pointer)
    ;; Convert a source comment to a WAT comment.
    ;; "// foo" → ";; foo"
    ;; "/* foo */" → ";; foo"
    (local.set 3
      (local.get $text))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.tee $s
      (call $~lib/string/String#trim
        (local.get 3)))
    (i32.store offset=4)
    (local.set 3
      (local.get $s))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (local.set 3
      (i32.const 2480))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (i32.const 0)
    (if  ;; label = @1
      (call $~lib/string/String#startsWith)
      (then
        (local.set 3
          (i32.const 2512))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (local.get $s))
        (i32.store offset=12
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (i32.const 2)
        (global.set $~argumentsLength
          (i32.const 1))
        (i32.const 0)
        (local.set 3
          (call $~lib/string/String#substring@varargs))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (call $~lib/string/String.__concat))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 20)))
        (return
          (local.get 3))))
    (local.set 3
      (local.get $s))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (local.set 3
      (i32.const 2544))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (i32.const 0)
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (call $~lib/string/String#startsWith)
        (then
          (local.set 3
            (local.get $s))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (local.get 3)
          (local.set 3
            (i32.const 2576))
          (i32.store offset=8
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (local.get 3)
          (global.set $~argumentsLength
            (i32.const 1))
          (i32.const 0)
          (call $~lib/string/String#endsWith@varargs))
        (else
          (i32.const 0)))
      (then
        (global.get $~lib/memory/__stack_pointer)
        (local.set 3
          (local.get $s))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (i32.const 2)
        (local.set 3
          (local.get $s))
        (i32.store offset=12
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (i32.sub
          (call $~lib/string/String#get:length
            (local.get 3))
          (i32.const 2))
        (local.set 3
          (call $~lib/string/String#substring))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.tee $inner
          (call $~lib/string/String#trim
            (local.get 3)))
        (i32.store offset=16)
        (local.set 3
          (i32.const 2608))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (local.get $inner))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.set 3
          (call $~lib/string/String.__concat))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 20)))
        (return
          (local.get 3))))
    (local.set 3
      (i32.const 2608))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (local.set 3
      (local.get $s))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.get 3)
    (local.set 3
      (call $~lib/string/String.__concat))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 20)))
    (return
      (local.get 3)))
  (func $src/injector/getIndent (type 1) (param $line i32) (result i32)
    (local $i i32) (local $ch i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $i
      (i32.const 0))
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $i)
        (local.set 3
          (local.get $line))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (call $~lib/string/String#get:length
          (local.get 3))
        (if  ;; label = @3
          (i32.lt_s)
          (then
            (local.set 3
              (local.get $line))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 3))
            (local.set $ch
              (call $~lib/string/String#charCodeAt
                (local.get 3)
                (local.get $i)))
            ;; space or tab
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eq
                  (local.get $ch)
                  (i32.const 32))
                (then
                  (i32.const 1))
                (else
                  (i32.eq
                    (local.get $ch)
                    (i32.const 9))))
              (then
                (local.set $i
                  (i32.add
                    (local.get $i)
                    (i32.const 1))))
              (else
                (br 3 (;@1;))))
            (br 1 (;@2;))))))
    (local.set 3
      (local.get $line))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set 3
      (call $~lib/string/String#substring
        (local.get 3)
        (i32.const 0)
        (local.get $i)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/map/Map<u64_~lib/string/String>#has (type 9) (param $this i32) (param $key i64) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.set 2
      (i32.ne
        (call $~lib/map/Map<u64_~lib/string/String>#find
          (local.get 2)
          (local.get $key)
          (call $~lib/util/hash/HASH<u64>
            (local.get $key)))
        (i32.const 0)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $src/injector/scanUpwardForComments (type 5) (param $commentMap i32) (param $mappedLines i32) (param $sourceIndex i32) (param $sourceLine i32) (result i32)
    (local $keys i32) (local $line i32) (local $isMapped i32) (local $nextLine i32) (local $reversed i32) (local $i i32) (local i32) (local $selfKey i64) (local $key i64) (local $nextKey i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    ;; Scan upward from the given source line to find all comment keys.
    ;; Stops when it hits a line that is mapped to another instruction
    ;; (present in mappedLines) or when it runs out of comments to collect.
    ;; Returns keys in top-down order (lowest line number first).
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $keys
        (call $~lib/array/Array<u64>#constructor
          (i32.const 0)
          (i32.const 0))))
    ;; Check the source line itself
    (local.set $selfKey
      (call $src/injector/commentKey
        (local.get $sourceIndex)
        (local.get $sourceLine)))
    (local.set 10
      (local.get $commentMap))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (if  ;; label = @1
      (call $~lib/map/Map<u64_~lib/string/String>#has
        (local.get 10)
        (local.get $selfKey))
      (then
        (local.set 10
          (local.get $keys))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 10))
        (drop
          (call $~lib/array/Array<u64>#push
            (local.get 10)
            (local.get $selfKey)))))
    ;; Scan upward from sourceLine - 1
    (local.set $line
      (local.get $sourceLine))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.gt_u
            (local.get $line)
            (i32.const 1))
          (then
            (local.set $line
              (i32.sub
                (local.get $line)
                (i32.const 1)))
            (local.set $key
              (call $src/injector/commentKey
                (local.get $sourceIndex)
                (local.get $line)))
            (local.set 10
              (local.get $mappedLines))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 10))
            (local.set $isMapped
              (call $~lib/set/Set<u64>#has
                (local.get 10)
                (local.get $key)))
            (if  ;; label = @4
              (local.get $isMapped)
              (then
                ;; Hit another mapped instruction's line — stop
                (br 3 (;@1;))))
            (local.set 10
              (local.get $commentMap))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 10))
            (if  ;; label = @4
              (call $~lib/map/Map<u64_~lib/string/String>#has
                (local.get 10)
                (local.get $key))
              (then
                (local.set 10
                  (local.get $keys))
                (i32.store offset=4
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 10))
                (drop
                  (call $~lib/array/Array<u64>#push
                    (local.get 10)
                    (local.get $key))))
              (else
                ;; No comment on this line — could be blank or code.
                ;; Keep scanning past gaps (blank lines between comments
                ;; and the instruction), but limit gap size to avoid
                ;; reaching unrelated comments far above.
                ;; Allow up to 2 consecutive non-comment lines as gaps
                ;; (e.g., blank line + function signature).
                (local.set $nextLine
                  (i32.sub
                    (local.get $line)
                    (i32.const 1)))
                (if  ;; label = @5
                  (i32.ge_u
                    (local.get $nextLine)
                    (i32.const 1))
                  (then
                    (local.set $nextKey
                      (call $src/injector/commentKey
                        (local.get $sourceIndex)
                        (local.get $nextLine)))
                    (local.set 10
                      (local.get $commentMap))
                    (i32.store offset=4
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 10))
                    (if  ;; label = @6
                      (if (result i32)  ;; label = @7
                        (call $~lib/map/Map<u64_~lib/string/String>#has
                          (local.get 10)
                          (local.get $nextKey))
                        (then
                          (local.set 10
                            (local.get $mappedLines))
                          (i32.store offset=4
                            (global.get $~lib/memory/__stack_pointer)
                            (local.get 10))
                          (i32.eqz
                            (call $~lib/set/Set<u64>#has
                              (local.get 10)
                              (local.get $nextKey))))
                        (else
                          (i32.const 0)))
                      (then
                        ;; There's a comment just above this gap — keep scanning
                        (br 4 (;@2;))))))
                (br 3 (;@1;))))
            (br 1 (;@2;))))))
    ;; Reverse to get top-down order
    (local.set 10
      (local.get $keys))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 10))
    (if  ;; label = @1
      (i32.gt_s
        (call $~lib/array/Array<u64>#get:length
          (local.get 10))
        (i32.const 1))
      (then
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $reversed
            (call $~lib/array/Array<u64>#constructor
              (i32.const 0)
              (i32.const 0))))
        (local.set 10
          (local.get $keys))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 10))
        (local.set $i
          (i32.sub
            (call $~lib/array/Array<u64>#get:length
              (local.get 10))
            (i32.const 1)))
        (loop  ;; label = @2
          (if  ;; label = @3
            (i32.ge_s
              (local.get $i)
              (i32.const 0))
            (then
              (local.set 10
                (local.get $reversed))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 10))
              (local.get 10)
              (local.set 10
                (local.get $keys))
              (i32.store offset=12
                (global.get $~lib/memory/__stack_pointer)
                (local.get 10))
              (call $~lib/array/Array<u64>#__get
                (local.get 10)
                (local.get $i))
              (drop
                (call $~lib/array/Array<u64>#push))
              (local.set $i
                (i32.sub
                  (local.get $i)
                  (i32.const 1)))
              (br 1 (;@2;)))))
        (local.set 10
          (local.get $reversed))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 16)))
        (return
          (local.get 10))))
    (local.set 10
      (local.get $keys))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (return
      (local.get 10)))
  (func $src/injector/findOrphanKeys (type 2) (param $commentMap i32) (param $emittedComments i32) (result i32)
    (local $orphans i32) (local $allKeys i32) (local $j i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    ;; Find all comment keys that were not emitted by scan-upward or file-level injection.
    ;; Returns keys sorted by (sourceIndex, line) so orphans from the
    ;; same file appear in source order.
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $orphans
        (call $~lib/array/Array<u64>#constructor
          (i32.const 0)
          (i32.const 0))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 5
      (local.get $commentMap))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.tee $allKeys
      (call $~lib/map/Map<u64_~lib/string/String>#keys
        (local.get 5)))
    (i32.store offset=8)
    (local.set $j
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $j)
      (local.set 5
        (local.get $allKeys))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 5))
      (call $~lib/array/Array<u64>#get:length
        (local.get 5))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 5
            (local.get $emittedComments))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 5))
          (local.get 5)
          (local.set 5
            (local.get $allKeys))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 5))
          (call $~lib/array/Array<u64>#__get
            (local.get 5)
            (local.get $j))
          (if  ;; label = @3
            (i32.eqz
              (call $~lib/set/Set<u64>#has))
            (then
              (local.set 5
                (local.get $orphans))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 5))
              (local.get 5)
              (local.set 5
                (local.get $allKeys))
              (i32.store offset=12
                (global.get $~lib/memory/__stack_pointer)
                (local.get 5))
              (call $~lib/array/Array<u64>#__get
                (local.get 5)
                (local.get $j))
              (drop
                (call $~lib/array/Array<u64>#push))))
          (local.set $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 5
      (local.get $orphans))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.get 5)
    (local.set 5
      (i32.const 2448))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.get 5)
    (drop
      (call $~lib/array/Array<u64>#sort))
    (local.set 5
      (local.get $orphans))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (return
      (local.get 5)))
  (func $~lib/map/Map<u64_u32>#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 24)
              (i32.const 26))))))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (i32.const 4))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u64_u32>#set:buckets)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u64_u32>#set:bucketsMask
      (local.get 1)
      (i32.sub
        (i32.const 4)
        (i32.const 1)))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (block (result i32)  ;; label = @1
            (br 0 (;@1;)
              (i32.const 16))))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u64_u32>#set:entries)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u64_u32>#set:entriesCapacity
      (local.get 1)
      (i32.const 4))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u64_u32>#set:entriesOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u64_u32>#set:entriesCount
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/util/sort/SORT<u32> (type 7) (param $ptr i32) (param $len i32) (param $comparator i32)
    (local $3 i32) (local $a i32) (local $b i32) (local $c i32) (local $a|7 i32) (local $b|8 i32) (local $c|9 i32) (local $n i32) (local $lgPlus2 i32) (local $lgPlus2Size i32) (local $leftRunStartBuf i32) (local $leftRunEndBuf i32) (local $i i32) (local $buffer i32) (local $hi i32) (local $endA i32) (local $lenA i32) (local $20 i32) (local $21 i32) (local $top i32) (local $startA i32) (local $startB i32) (local $endB i32) (local $lenB i32) (local $27 i32) (local $28 i32) (local $k i32) (local $i|30 i32) (local $start i32) (local $i|32 i32) (local $start|33 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.le_s
        (local.get $len)
        (i32.const 48))
      (then
        (if  ;; label = @2
          (i32.le_s
            (local.get $len)
            (i32.const 1))
          (then
            (global.set $~lib/memory/__stack_pointer
              (i32.add
                (global.get $~lib/memory/__stack_pointer)
                (i32.const 4)))
            (return)))
        (drop
          (i32.lt_s
            (i32.const 0)
            (i32.const 1)))
        (block  ;; label = @2
          (block  ;; label = @3
            (block  ;; label = @4
              (local.set $3
                (local.get $len))
              (br_if 0 (;@4;)
                (i32.eq
                  (local.get $3)
                  (i32.const 3)))
              (br_if 1 (;@3;)
                (i32.eq
                  (local.get $3)
                  (i32.const 2)))
              (br 2 (;@2;)))
            (local.set $a
              (i32.load
                (local.get $ptr)))
            (local.set $b
              (i32.load offset=4
                (local.get $ptr)))
            (local.get $a)
            (local.get $b)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (local.set $c
              (i32.gt_s
                (call_indirect $0 (type 2))
                (i32.const 0)))
            (i32.store
              (local.get $ptr)
              (select
                (local.get $b)
                (local.get $a)
                (local.get $c)))
            (local.set $a
              (select
                (local.get $a)
                (local.get $b)
                (local.get $c)))
            (local.set $b
              (i32.load offset=8
                (local.get $ptr)))
            (local.get $a)
            (local.get $b)
            (global.set $~argumentsLength
              (i32.const 2))
            (i32.load
              (local.get $comparator))
            (local.set $c
              (i32.gt_s
                (call_indirect $0 (type 2))
                (i32.const 0)))
            (i32.store offset=4
              (local.get $ptr)
              (select
                (local.get $b)
                (local.get $a)
                (local.get $c)))
            (i32.store offset=8
              (local.get $ptr)
              (select
                (local.get $a)
                (local.get $b)
                (local.get $c))))
          (local.set $a|7
            (i32.load
              (local.get $ptr)))
          (local.set $b|8
            (i32.load offset=4
              (local.get $ptr)))
          (local.get $a|7)
          (local.get $b|8)
          (global.set $~argumentsLength
            (i32.const 2))
          (i32.load
            (local.get $comparator))
          (local.set $c|9
            (i32.gt_s
              (call_indirect $0 (type 2))
              (i32.const 0)))
          (i32.store
            (local.get $ptr)
            (select
              (local.get $b|8)
              (local.get $a|7)
              (local.get $c|9)))
          (i32.store offset=4
            (local.get $ptr)
            (select
              (local.get $a|7)
              (local.get $b|8)
              (local.get $c|9)))
          (global.set $~lib/memory/__stack_pointer
            (i32.add
              (global.get $~lib/memory/__stack_pointer)
              (i32.const 4)))
          (return))
        (local.get $ptr)
        (i32.const 0)
        (i32.sub
          (local.get $len)
          (i32.const 1))
        (i32.const 0)
        (local.set 34
          (local.get $comparator))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 34))
        (local.get 34)
        (call $~lib/util/sort/insertionSort<u32>)
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 4)))
        (return)))
    (local.set $lgPlus2
      (i32.add
        (block (result i32)  ;; label = @1
          (local.set $n
            (local.get $len))
          (br 0 (;@1;)
            (i32.sub
              (i32.const 31)
              (i32.clz
                (local.get $n)))))
        (i32.const 2)))
    (local.set $lgPlus2Size
      (i32.shl
        (local.get $lgPlus2)
        (i32.const 2)))
    (local.set $leftRunStartBuf
      (call $~lib/rt/tlsf/__alloc
        (i32.shl
          (local.get $lgPlus2Size)
          (i32.const 1))))
    (local.set $leftRunEndBuf
      (i32.add
        (local.get $leftRunStartBuf)
        (local.get $lgPlus2Size)))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_u
          (local.get $i)
          (local.get $lgPlus2))
        (then
          (i32.store
            (i32.add
              (local.get $leftRunStartBuf)
              (i32.shl
                (local.get $i)
                (i32.const 2)))
            (i32.const -1))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set $buffer
      (call $~lib/rt/tlsf/__alloc
        (i32.shl
          (local.get $len)
          (i32.const 2))))
    (local.set $hi
      (i32.sub
        (local.get $len)
        (i32.const 1)))
    (local.get $ptr)
    (i32.const 0)
    (local.get $hi)
    (local.set 34
      (local.get $comparator))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 34))
    (local.get 34)
    (local.set $endA
      (call $~lib/util/sort/extendRunRight<u32>))
    (local.set $lenA
      (i32.add
        (local.get $endA)
        (i32.const 1)))
    (if  ;; label = @1
      (i32.lt_s
        (local.get $lenA)
        (i32.const 32))
      (then
        (local.set $endA
          (select
            (local.tee $20
              (local.get $hi))
            (local.tee $21
              (i32.sub
                (i32.const 32)
                (i32.const 1)))
            (i32.lt_s
              (local.get $20)
              (local.get $21))))
        (local.get $ptr)
        (i32.const 0)
        (local.get $endA)
        (local.get $lenA)
        (local.set 34
          (local.get $comparator))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 34))
        (local.get 34)
        (call $~lib/util/sort/insertionSort<u32>)))
    (local.set $top
      (i32.const 0))
    (local.set $startA
      (i32.const 0))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_s
            (local.get $endA)
            (local.get $hi))
          (then
            (local.set $startB
              (i32.add
                (local.get $endA)
                (i32.const 1)))
            (local.get $ptr)
            (local.get $startB)
            (local.get $hi)
            (local.set 34
              (local.get $comparator))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 34))
            (local.get 34)
            (local.set $endB
              (call $~lib/util/sort/extendRunRight<u32>))
            (local.set $lenB
              (i32.add
                (i32.sub
                  (local.get $endB)
                  (local.get $startB))
                (i32.const 1)))
            (if  ;; label = @4
              (i32.lt_s
                (local.get $lenB)
                (i32.const 32))
              (then
                (local.set $endB
                  (select
                    (local.tee $27
                      (local.get $hi))
                    (local.tee $28
                      (i32.sub
                        (i32.add
                          (local.get $startB)
                          (i32.const 32))
                        (i32.const 1)))
                    (i32.lt_s
                      (local.get $27)
                      (local.get $28))))
                (local.get $ptr)
                (local.get $startB)
                (local.get $endB)
                (local.get $lenB)
                (local.set 34
                  (local.get $comparator))
                (i32.store
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 34))
                (local.get 34)
                (call $~lib/util/sort/insertionSort<u32>)))
            (local.set $k
              (call $~lib/util/sort/nodePower
                (i32.const 0)
                (local.get $hi)
                (local.get $startA)
                (local.get $startB)
                (local.get $endB)))
            (local.set $i|30
              (local.get $top))
            (loop  ;; label = @4
              (if  ;; label = @5
                (i32.gt_u
                  (local.get $i|30)
                  (local.get $k))
                (then
                  (local.set $start
                    (i32.load
                      (i32.add
                        (local.get $leftRunStartBuf)
                        (i32.shl
                          (local.get $i|30)
                          (i32.const 2)))))
                  (if  ;; label = @6
                    (i32.ne
                      (local.get $start)
                      (i32.const -1))
                    (then
                      (local.get $ptr)
                      (local.get $start)
                      (i32.add
                        (i32.load
                          (i32.add
                            (local.get $leftRunEndBuf)
                            (i32.shl
                              (local.get $i|30)
                              (i32.const 2))))
                        (i32.const 1))
                      (local.get $endA)
                      (local.get $buffer)
                      (local.set 34
                        (local.get $comparator))
                      (i32.store
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 34))
                      (local.get 34)
                      (call $~lib/util/sort/mergeRuns<u32>)
                      (local.set $startA
                        (local.get $start))
                      (i32.store
                        (i32.add
                          (local.get $leftRunStartBuf)
                          (i32.shl
                            (local.get $i|30)
                            (i32.const 2)))
                        (i32.const -1))))
                  (local.set $i|30
                    (i32.sub
                      (local.get $i|30)
                      (i32.const 1)))
                  (br 1 (;@4;)))))
            (i32.store
              (i32.add
                (local.get $leftRunStartBuf)
                (i32.shl
                  (local.get $k)
                  (i32.const 2)))
              (local.get $startA))
            (i32.store
              (i32.add
                (local.get $leftRunEndBuf)
                (i32.shl
                  (local.get $k)
                  (i32.const 2)))
              (local.get $endA))
            (local.set $startA
              (local.get $startB))
            (local.set $endA
              (local.get $endB))
            (local.set $top
              (local.get $k))
            (br 1 (;@2;))))))
    (local.set $i|32
      (local.get $top))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.ne
          (local.get $i|32)
          (i32.const 0))
        (then
          (local.set $start|33
            (i32.load
              (i32.add
                (local.get $leftRunStartBuf)
                (i32.shl
                  (local.get $i|32)
                  (i32.const 2)))))
          (if  ;; label = @3
            (i32.ne
              (local.get $start|33)
              (i32.const -1))
            (then
              (local.get $ptr)
              (local.get $start|33)
              (i32.add
                (i32.load
                  (i32.add
                    (local.get $leftRunEndBuf)
                    (i32.shl
                      (local.get $i|32)
                      (i32.const 2))))
                (i32.const 1))
              (local.get $hi)
              (local.get $buffer)
              (local.set 34
                (local.get $comparator))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 34))
              (local.get 34)
              (call $~lib/util/sort/mergeRuns<u32>)))
          (local.set $i|32
            (i32.sub
              (local.get $i|32)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (call $~lib/rt/tlsf/__free
      (local.get $buffer))
    (call $~lib/rt/tlsf/__free
      (local.get $leftRunStartBuf))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<u32>#sort (type 2) (param $this i32) (param $comparator i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 2
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/array/Array<u32>#get:dataStart
      (local.get 2))
    (local.set 2
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/array/Array<u32>#get:length_
      (local.get 2))
    (local.set 2
      (local.get $comparator))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (call $~lib/util/sort/SORT<u32>)
    (local.set 2
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 2)))
  (func $~lib/map/Map<u64_u32>#find (type 10) (param $this i32) (param $key i64) (param $hashCode i32) (result i32)
    (local $entry i32) (local $taggedNext i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/map/Map<u64_u32>#get:buckets
      (local.get 5))
    (local.get $hashCode)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $entry
      (i32.load
        (i32.add
          (call $~lib/map/Map<u64_u32>#get:bucketsMask
            (local.get 5))
          (i32.mul
            (i32.and)
            (i32.const 4)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (local.get $entry)
          (then
            (local.set $taggedNext
              (call $~lib/map/MapEntry<u64_u32>#get:taggedNext
                (local.get $entry)))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eqz
                  (i32.and
                    (local.get $taggedNext)
                    (i32.const 1)))
                (then
                  (i64.eq
                    (call $~lib/map/MapEntry<u64_u32>#get:key
                      (local.get $entry))
                    (local.get $key)))
                (else
                  (i32.const 0)))
              (then
                (local.set 5
                  (local.get $entry))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 5))))
            (local.set $entry
              (i32.and
                (local.get $taggedNext)
                (i32.xor
                  (i32.const 1)
                  (i32.const -1))))
            (br 1 (;@2;))))))
    (local.set 5
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 5)))
  (func $~lib/map/Map<u64_u32>#has (type 9) (param $this i32) (param $key i64) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.set 2
      (i32.ne
        (call $~lib/map/Map<u64_u32>#find
          (local.get 2)
          (local.get $key)
          (call $~lib/util/hash/HASH<u64>
            (local.get $key)))
        (i32.const 0)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/map/Map<u64_u32>#rehash (type 0) (param $this i32) (param $newBucketsMask i32)
    (local $newBucketsCapacity i32) (local $newBuckets i32) (local $newEntriesCapacity i32) (local $newEntries i32) (local $oldPtr i32) (local $oldEnd i32) (local $newPtr i32) (local $oldEntry i32) (local $newEntry i32) (local $newBucketIndex i32) (local $newBucketPtrBase i32) (local i32) (local $oldEntryKey i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $newBucketsCapacity
      (i32.add
        (local.get $newBucketsMask)
        (i32.const 1)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newBuckets
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newBucketsCapacity)
            (i32.const 4)))))
    (local.set $newEntriesCapacity
      (i32.div_s
        (i32.mul
          (local.get $newBucketsCapacity)
          (i32.const 8))
        (i32.const 3)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newEntries
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newEntriesCapacity)
            (block (result i32)  ;; label = @1
              (br 0 (;@1;)
                (i32.const 16)))))))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.set $oldPtr
      (call $~lib/map/Map<u64_u32>#get:entries
        (local.get 13)))
    (local.get $oldPtr)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (i32.mul
      (call $~lib/map/Map<u64_u32>#get:entriesOffset
        (local.get 13))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 16))))
    (local.set $oldEnd
      (i32.add))
    (local.set $newPtr
      (local.get $newEntries))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $oldPtr)
            (local.get $oldEnd))
          (then
            (local.set $oldEntry
              (local.get $oldPtr))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u64_u32>#get:taggedNext
                    (local.get $oldEntry))
                  (i32.const 1)))
              (then
                (local.set $newEntry
                  (local.get $newPtr))
                (local.set $oldEntryKey
                  (call $~lib/map/MapEntry<u64_u32>#get:key
                    (local.get $oldEntry)))
                (call $~lib/map/MapEntry<u64_u32>#set:key
                  (local.get $newEntry)
                  (local.get $oldEntryKey))
                (call $~lib/map/MapEntry<u64_u32>#set:value
                  (local.get $newEntry)
                  (call $~lib/map/MapEntry<u64_u32>#get:value
                    (local.get $oldEntry)))
                (local.set $newBucketIndex
                  (i32.and
                    (call $~lib/util/hash/HASH<u64>
                      (local.get $oldEntryKey))
                    (local.get $newBucketsMask)))
                (local.set $newBucketPtrBase
                  (i32.add
                    (local.get $newBuckets)
                    (i32.mul
                      (local.get $newBucketIndex)
                      (i32.const 4))))
                (call $~lib/map/MapEntry<u64_u32>#set:taggedNext
                  (local.get $newEntry)
                  (i32.load
                    (local.get $newBucketPtrBase)))
                (i32.store
                  (local.get $newBucketPtrBase)
                  (local.get $newPtr))
                (local.set $newPtr
                  (i32.add
                    (local.get $newPtr)
                    (block (result i32)  ;; label = @5
                      (br 0 (;@5;)
                        (i32.const 16)))))))
            (local.set $oldPtr
              (i32.add
                (local.get $oldPtr)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 16)))))
            (br 1 (;@2;))))))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $newBuckets))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (call $~lib/map/Map<u64_u32>#set:buckets)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/map/Map<u64_u32>#set:bucketsMask
      (local.get 13)
      (local.get $newBucketsMask))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $newEntries))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (call $~lib/map/Map<u64_u32>#set:entries)
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/map/Map<u64_u32>#set:entriesCapacity
      (local.get 13)
      (local.get $newEntriesCapacity))
    (local.set 13
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (local.get 13)
    (local.set 13
      (local.get $this))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 13))
    (call $~lib/map/Map<u64_u32>#get:entriesCount
      (local.get 13))
    (call $~lib/map/Map<u64_u32>#set:entriesOffset)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/map/Map<u64_u32>#set (type 10) (param $this i32) (param $key i64) (param $value i32) (result i32)
    (local $hashCode i32) (local $entry i32) (local $entries i32) (local $6 i32) (local $bucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $hashCode
      (call $~lib/util/hash/HASH<u64>
        (local.get $key)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $entry
      (call $~lib/map/Map<u64_u32>#find
        (local.get 8)
        (local.get $key)
        (local.get $hashCode)))
    (if  ;; label = @1
      (local.get $entry)
      (then
        (call $~lib/map/MapEntry<u64_u32>#set:value
          (local.get $entry)
          (local.get $value))
        (drop
          (i32.const 0)))
      (else
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u64_u32>#get:entriesOffset
          (local.get 8))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u64_u32>#get:entriesCapacity
          (local.get 8))
        (if  ;; label = @2
          (i32.eq)
          (then
            (local.set 8
              (local.get $this))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (local.get 8)
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u64_u32>#get:entriesCount
              (local.get 8))
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u64_u32>#rehash
              (i32.div_s
                (i32.mul
                  (call $~lib/map/Map<u64_u32>#get:entriesCapacity
                    (local.get 8))
                  (i32.const 3))
                (i32.const 4))
              (if (result i32)  ;; label = @3
                (i32.lt_s)
                (then
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (call $~lib/map/Map<u64_u32>#get:bucketsMask
                    (local.get 8)))
                (else
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (i32.or
                    (i32.shl
                      (call $~lib/map/Map<u64_u32>#get:bucketsMask
                        (local.get 8))
                      (i32.const 1))
                    (i32.const 1)))))))
        (global.get $~lib/memory/__stack_pointer)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.tee $entries
          (call $~lib/map/Map<u64_u32>#get:entries
            (local.get 8)))
        (i32.store offset=8)
        (local.get $entries)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (local.tee $6
            (call $~lib/map/Map<u64_u32>#get:entriesOffset
              (local.get 8)))
          (i32.const 1))
        (call $~lib/map/Map<u64_u32>#set:entriesOffset)
        (i32.mul
          (local.get $6)
          (block (result i32)  ;; label = @2
            (br 0 (;@2;)
              (i32.const 16))))
        (local.set $entry
          (i32.add))
        (call $~lib/map/MapEntry<u64_u32>#set:key
          (local.get $entry)
          (local.get $key))
        (drop
          (i32.const 0))
        (call $~lib/map/MapEntry<u64_u32>#set:value
          (local.get $entry)
          (local.get $value))
        (drop
          (i32.const 0))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (call $~lib/map/Map<u64_u32>#get:entriesCount
            (local.get 8))
          (i32.const 1))
        (call $~lib/map/Map<u64_u32>#set:entriesCount)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u64_u32>#get:buckets
          (local.get 8))
        (local.get $hashCode)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.set $bucketPtrBase
          (i32.add
            (call $~lib/map/Map<u64_u32>#get:bucketsMask
              (local.get 8))
            (i32.mul
              (i32.and)
              (i32.const 4))))
        (call $~lib/map/MapEntry<u64_u32>#set:taggedNext
          (local.get $entry)
          (i32.load
            (local.get $bucketPtrBase)))
        (i32.store
          (local.get $bucketPtrBase)
          (local.get $entry))))
    (local.set 8
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 8)))
  (func $src/injector/buildSourceLineToWatLine (type 2) (param $lineToOffset i32) (param $sourceEntries i32) (result i32)
    (local $result i32) (local $watLineKeys i32) (local $j i32) (local $wl i32) (local $byteOffset i32) (local $entry i32) (local $e i32) (local i32) (local $key i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 24))
    ;; Build a map from commentKey(sourceIndex, sourceLine) to the first
    ;; WAT line number that maps to that source location.
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $result
        (call $~lib/map/Map<u64_u32>#constructor
          (i32.const 0))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 9
      (local.get $lineToOffset))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (local.tee $watLineKeys
      (call $~lib/map/Map<u32_u32>#keys
        (local.get 9)))
    (i32.store offset=8)
    (local.set 9
      (local.get $watLineKeys))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (local.get 9)
    (local.set 9
      (i32.const 2640))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 9))
    (local.get 9)
    (drop
      (call $~lib/array/Array<u32>#sort))
    (local.set $j
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $j)
      (local.set 9
        (local.get $watLineKeys))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 9))
      (call $~lib/array/Array<u32>#get:length
        (local.get 9))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 9
            (local.get $watLineKeys))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 9))
          (local.set $wl
            (call $~lib/array/Array<u32>#__get
              (local.get 9)
              (local.get $j)))
          (local.set 9
            (local.get $lineToOffset))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 9))
          (local.set $byteOffset
            (call $~lib/map/Map<u32_u32>#get
              (local.get 9)
              (local.get $wl)))
          (global.get $~lib/memory/__stack_pointer)
          (local.set 9
            (local.get $sourceEntries))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 9))
          (local.tee $entry
            (call $src/sourcemap/lookupOffset
              (local.get 9)
              (local.get $byteOffset)))
          (i32.store offset=16)
          (if  ;; label = @3
            (i32.ne
              (local.get $entry)
              (i32.const 0))
            (then
              (i32.store offset=20
                (global.get $~lib/memory/__stack_pointer)
                (local.tee $e
                  (local.get $entry)))
              (local.set 9
                (local.get $e))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 9))
              (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                (local.get 9))
              (local.set 9
                (local.get $e))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 9))
              (i32.add
                (call $src/sourcemap/SourceMapEntry#get:sourceLine
                  (local.get 9))
                (i32.const 1))
              (local.set $key
                (call $src/injector/commentKey))
              (local.set 9
                (local.get $result))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 9))
              (if  ;; label = @4
                (i32.eqz
                  (call $~lib/map/Map<u64_u32>#has
                    (local.get 9)
                    (local.get $key)))
                (then
                  (local.set 9
                    (local.get $result))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 9))
                  (drop
                    (call $~lib/map/Map<u64_u32>#set
                      (local.get 9)
                      (local.get $key)
                      (local.get $wl)))))))
          (local.set $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 9
      (local.get $result))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 24)))
    (return
      (local.get 9)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 24)
              (i32.const 28))))))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (i32.const 4))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:buckets)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:bucketsMask
      (local.get 1)
      (i32.sub
        (i32.const 4)
        (i32.const 1)))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (block (result i32)  ;; label = @1
            (br 0 (;@1;)
              (i32.const 12))))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entries)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesCapacity
      (local.get 1)
      (i32.const 4))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesCount
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#find (type 3) (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
    (local $entry i32) (local $taggedNext i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:buckets
      (local.get 5))
    (local.get $hashCode)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $entry
      (i32.load
        (i32.add
          (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:bucketsMask
            (local.get 5))
          (i32.mul
            (i32.and)
            (i32.const 4)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (local.get $entry)
          (then
            (local.set $taggedNext
              (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:taggedNext
                (local.get $entry)))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eqz
                  (i32.and
                    (local.get $taggedNext)
                    (i32.const 1)))
                (then
                  (i32.eq
                    (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:key
                      (local.get $entry))
                    (local.get $key)))
                (else
                  (i32.const 0)))
              (then
                (local.set 5
                  (local.get $entry))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 5))))
            (local.set $entry
              (i32.and
                (local.get $taggedNext)
                (i32.xor
                  (i32.const 1)
                  (i32.const -1))))
            (br 1 (;@2;))))))
    (local.set 5
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 5)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#has (type 2) (param $this i32) (param $key i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.set 2
      (i32.ne
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>#find
          (local.get 2)
          (local.get $key)
          (call $~lib/util/hash/HASH<u32>
            (local.get $key)))
        (i32.const 0)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#rehash (type 0) (param $this i32) (param $newBucketsMask i32)
    (local $newBucketsCapacity i32) (local $newBuckets i32) (local $newEntriesCapacity i32) (local $newEntries i32) (local $oldPtr i32) (local $oldEnd i32) (local $newPtr i32) (local $oldEntry i32) (local $newEntry i32) (local $oldEntryKey i32) (local $newBucketIndex i32) (local $newBucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $newBucketsCapacity
      (i32.add
        (local.get $newBucketsMask)
        (i32.const 1)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newBuckets
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newBucketsCapacity)
            (i32.const 4)))))
    (local.set $newEntriesCapacity
      (i32.div_s
        (i32.mul
          (local.get $newBucketsCapacity)
          (i32.const 8))
        (i32.const 3)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newEntries
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newEntriesCapacity)
            (block (result i32)  ;; label = @1
              (br 0 (;@1;)
                (i32.const 12)))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.set $oldPtr
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entries
        (local.get 14)))
    (local.get $oldPtr)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (i32.mul
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesOffset
        (local.get 14))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 12))))
    (local.set $oldEnd
      (i32.add))
    (local.set $newPtr
      (local.get $newEntries))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $oldPtr)
            (local.get $oldEnd))
          (then
            (local.set $oldEntry
              (local.get $oldPtr))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:taggedNext
                    (local.get $oldEntry))
                  (i32.const 1)))
              (then
                (local.set $newEntry
                  (local.get $newPtr))
                (local.set $oldEntryKey
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:key
                    (local.get $oldEntry)))
                (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:key
                  (local.get $newEntry)
                  (local.get $oldEntryKey))
                (local.get $newEntry)
                (local.set 14
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:value
                    (local.get $oldEntry)))
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 14))
                (local.get 14)
                (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:value)
                (local.set $newBucketIndex
                  (i32.and
                    (call $~lib/util/hash/HASH<u32>
                      (local.get $oldEntryKey))
                    (local.get $newBucketsMask)))
                (local.set $newBucketPtrBase
                  (i32.add
                    (local.get $newBuckets)
                    (i32.mul
                      (local.get $newBucketIndex)
                      (i32.const 4))))
                (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:taggedNext
                  (local.get $newEntry)
                  (i32.load
                    (local.get $newBucketPtrBase)))
                (i32.store
                  (local.get $newBucketPtrBase)
                  (local.get $newPtr))
                (local.set $newPtr
                  (i32.add
                    (local.get $newPtr)
                    (block (result i32)  ;; label = @5
                      (br 0 (;@5;)
                        (i32.const 12)))))))
            (local.set $oldPtr
              (i32.add
                (local.get $oldPtr)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 12)))))
            (br 1 (;@2;))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newBuckets))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:buckets)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:bucketsMask
      (local.get 14)
      (local.get $newBucketsMask))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newEntries))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entries)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesCapacity
      (local.get 14)
      (local.get $newEntriesCapacity))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $this))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesCount
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesOffset)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#set (type 3) (param $this i32) (param $key i32) (param $value i32) (result i32)
    (local $hashCode i32) (local $entry i32) (local $entries i32) (local $6 i32) (local $bucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $hashCode
      (call $~lib/util/hash/HASH<u32>
        (local.get $key)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $entry
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#find
        (local.get 8)
        (local.get $key)
        (local.get $hashCode)))
    (if  ;; label = @1
      (local.get $entry)
      (then
        (local.get $entry)
        (local.set 8
          (local.get $value))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:value)
        (drop
          (i32.const 1))
        (call $~lib/rt/itcms/__link
          (local.get $this)
          (local.get $value)
          (i32.const 1)))
      (else
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesOffset
          (local.get 8))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesCapacity
          (local.get 8))
        (if  ;; label = @2
          (i32.eq)
          (then
            (local.set 8
              (local.get $this))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (local.get 8)
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesCount
              (local.get 8))
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u32_~lib/array/Array<u32>>#rehash
              (i32.div_s
                (i32.mul
                  (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesCapacity
                    (local.get 8))
                  (i32.const 3))
                (i32.const 4))
              (if (result i32)  ;; label = @3
                (i32.lt_s)
                (then
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:bucketsMask
                    (local.get 8)))
                (else
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (i32.or
                    (i32.shl
                      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:bucketsMask
                        (local.get 8))
                      (i32.const 1))
                    (i32.const 1)))))))
        (global.get $~lib/memory/__stack_pointer)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.tee $entries
          (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entries
            (local.get 8)))
        (i32.store offset=8)
        (local.get $entries)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (local.tee $6
            (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesOffset
              (local.get 8)))
          (i32.const 1))
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesOffset)
        (i32.mul
          (local.get $6)
          (block (result i32)  ;; label = @2
            (br 0 (;@2;)
              (i32.const 12))))
        (local.set $entry
          (i32.add))
        (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:key
          (local.get $entry)
          (local.get $key))
        (drop
          (i32.const 0))
        (local.get $entry)
        (local.set 8
          (local.get $value))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:value)
        (drop
          (i32.const 1))
        (call $~lib/rt/itcms/__link
          (local.get $this)
          (local.get $value)
          (i32.const 1))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesCount
            (local.get 8))
          (i32.const 1))
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set:entriesCount)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:buckets
          (local.get 8))
        (local.get $hashCode)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.set $bucketPtrBase
          (i32.add
            (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:bucketsMask
              (local.get 8))
            (i32.mul
              (i32.and)
              (i32.const 4))))
        (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#set:taggedNext
          (local.get $entry)
          (i32.load
            (local.get $bucketPtrBase)))
        (i32.store
          (local.get $bucketPtrBase)
          (local.get $entry))))
    (local.set 8
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 8)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#get (type 2) (param $this i32) (param $key i32) (result i32)
    (local $entry i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entry
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#find
        (local.get 3)
        (local.get $key)
        (call $~lib/util/hash/HASH<u32>
          (local.get $key))))
    (if  ;; label = @1
      (i32.eqz
        (local.get $entry))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 2336)
          (i32.const 2400)
          (i32.const 105)
          (i32.const 17))
        (unreachable)))
    (local.set 3
      (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:value
        (local.get $entry)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/array/Array<u32>#indexOf (type 3) (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
    (local $len i32) (local $4 i32) (local $5 i32) (local $ptr i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.set $len
      (call $~lib/array/Array<u32>#get:length_
        (local.get 7)))
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.eq
          (local.get $len)
          (i32.const 0))
        (then
          (i32.const 1))
        (else
          (i32.ge_s
            (local.get $fromIndex)
            (local.get $len))))
      (then
        (local.set 7
          (i32.const -1))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 4)))
        (return
          (local.get 7))))
    (if  ;; label = @1
      (i32.lt_s
        (local.get $fromIndex)
        (i32.const 0))
      (then
        (local.set $fromIndex
          (select
            (local.tee $4
              (i32.add
                (local.get $len)
                (local.get $fromIndex)))
            (local.tee $5
              (i32.const 0))
            (i32.gt_s
              (local.get $4)
              (local.get $5))))))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.set $ptr
      (call $~lib/array/Array<u32>#get:dataStart
        (local.get 7)))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_s
            (local.get $fromIndex)
            (local.get $len))
          (then
            (if  ;; label = @4
              (i32.eq
                (i32.load
                  (i32.add
                    (local.get $ptr)
                    (i32.shl
                      (local.get $fromIndex)
                      (i32.const 2))))
                (local.get $value))
              (then
                (local.set 7
                  (local.get $fromIndex))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 7))))
            (local.set $fromIndex
              (i32.add
                (local.get $fromIndex)
                (i32.const 1)))
            (br 1 (;@2;))))))
    (local.set 7
      (i32.const -1))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 7)))
  (func $~lib/array/Array<u32>#push (type 2) (param $this i32) (param $value i32) (result i32)
    (local $oldLen i32) (local $len i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (local.set $oldLen
      (call $~lib/array/Array<u32>#get:length_
        (local.get 4)))
    (local.set $len
      (i32.add
        (local.get $oldLen)
        (i32.const 1)))
    (call $~lib/array/ensureCapacity
      (local.get $this)
      (local.get $len)
      (i32.const 2)
      (i32.const 1))
    (drop
      (i32.const 0))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (i32.store
      (i32.add
        (call $~lib/array/Array<u32>#get:dataStart
          (local.get 4))
        (i32.shl
          (local.get $oldLen)
          (i32.const 2)))
      (local.get $value))
    (local.set 4
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 4))
    (call $~lib/array/Array<u32>#set:length_
      (local.get 4)
      (local.get $len))
    (local.set 4
      (local.get $len))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 4)))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#keys (type 1) (param $this i32) (result i32)
    (local $start i32) (local $size i32) (local $keys i32) (local $length i32) (local $i i32) (local $entry i32) (local $7 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $start
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entries
        (local.get 8)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $size
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesOffset
        (local.get 8)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $keys
        (call $~lib/array/Array<u32>#constructor
          (i32.const 0)
          (local.get $size))))
    (local.set $length
      (i32.const 0))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (if  ;; label = @2
        (i32.lt_s
          (local.get $i)
          (local.get $size))
        (then
          (local.set $entry
            (i32.add
              (local.get $start)
              (i32.mul
                (local.get $i)
                (block (result i32)  ;; label = @3
                  (br 0 (;@3;)
                    (i32.const 12))))))
          (if  ;; label = @3
            (i32.eqz
              (i32.and
                (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:taggedNext
                  (local.get $entry))
                (i32.const 1)))
            (then
              (local.set 8
                (local.get $keys))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 8))
              (local.get 8)
              (local.set $length
                (i32.add
                  (local.tee $7
                    (local.get $length))
                  (i32.const 1)))
              (local.get $7)
              (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:key
                (local.get $entry))
              (call $~lib/array/Array<u32>#__set)))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 8
      (local.get $keys))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (call $~lib/array/Array<u32>#set:length
      (local.get 8)
      (local.get $length))
    (local.set 8
      (local.get $keys))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (return
      (local.get 8)))
  (func $src/injector/buildMappedLinesByFile (type 2) (param $lineToOffset i32) (param $sourceEntries i32) (result i32)
    (local $result i32) (local $watLineKeys i32) (local $j i32) (local $byteOffset i32) (local $entry i32) (local $e i32) (local $srcLine i32) (local $arr i32) (local $indices i32) (local $j|11 i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 40)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 40))
    ;; Build a map from sourceIndex to a sorted array of mapped source
    ;; line numbers for that file.
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $result
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>#constructor
          (i32.const 0))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 12
      (local.get $lineToOffset))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 12))
    (local.tee $watLineKeys
      (call $~lib/map/Map<u32_u32>#keys
        (local.get 12)))
    (i32.store offset=8)
    (local.set $j
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $j)
      (local.set 12
        (local.get $watLineKeys))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 12))
      (call $~lib/array/Array<u32>#get:length
        (local.get 12))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 12
            (local.get $lineToOffset))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (local.get 12)
          (local.set 12
            (local.get $watLineKeys))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (call $~lib/array/Array<u32>#__get
            (local.get 12)
            (local.get $j))
          (local.set $byteOffset
            (call $~lib/map/Map<u32_u32>#get))
          (global.get $~lib/memory/__stack_pointer)
          (local.set 12
            (local.get $sourceEntries))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (local.tee $entry
            (call $src/sourcemap/lookupOffset
              (local.get 12)
              (local.get $byteOffset)))
          (i32.store offset=16)
          (if  ;; label = @3
            (i32.ne
              (local.get $entry)
              (i32.const 0))
            (then
              (i32.store offset=20
                (global.get $~lib/memory/__stack_pointer)
                (local.tee $e
                  (local.get $entry)))
              (local.set 12
                (local.get $e))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 12))
              (local.set $srcLine
                (i32.add
                  (call $src/sourcemap/SourceMapEntry#get:sourceLine
                    (local.get 12))
                  (i32.const 1)))
              (local.set 12
                (local.get $result))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 12))
              (local.get 12)
              (local.set 12
                (local.get $e))
              (i32.store offset=12
                (global.get $~lib/memory/__stack_pointer)
                (local.get 12))
              (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                (local.get 12))
              (if  ;; label = @4
                (i32.eqz
                  (call $~lib/map/Map<u32_~lib/array/Array<u32>>#has))
                (then
                  (local.set 12
                    (local.get $result))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 12))
                  (local.get 12)
                  (local.set 12
                    (local.get $e))
                  (i32.store offset=24
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 12))
                  (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                    (local.get 12))
                  (local.set 12
                    (call $~lib/array/Array<u32>#constructor
                      (i32.const 0)
                      (i32.const 0)))
                  (i32.store offset=12
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 12))
                  (local.get 12)
                  (drop
                    (call $~lib/map/Map<u32_~lib/array/Array<u32>>#set))))
              (global.get $~lib/memory/__stack_pointer)
              (local.set 12
                (local.get $result))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 12))
              (local.get 12)
              (local.set 12
                (local.get $e))
              (i32.store offset=12
                (global.get $~lib/memory/__stack_pointer)
                (local.get 12))
              (i32.store offset=28
                (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                  (local.get 12))
                (local.tee $arr
                  (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get)))
              (local.set 12
                (local.get $arr))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 12))
              (if  ;; label = @4
                (i32.lt_s
                  (call $~lib/array/Array<u32>#indexOf
                    (local.get 12)
                    (local.get $srcLine)
                    (i32.const 0))
                  (i32.const 0))
                (then
                  (local.set 12
                    (local.get $arr))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 12))
                  (drop
                    (call $~lib/array/Array<u32>#push
                      (local.get 12)
                      (local.get $srcLine)))))))
          (local.set $j
            (i32.add
              (local.get $j)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 12
      (local.get $result))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 12))
    (local.tee $indices
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#keys
        (local.get 12)))
    (i32.store offset=32)
    (local.set $j|11
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $j|11)
      (local.set 12
        (local.get $indices))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 12))
      (call $~lib/array/Array<u32>#get:length
        (local.get 12))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (local.set 12
            (local.get $result))
          (i32.store offset=24
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (local.get 12)
          (local.set 12
            (local.get $indices))
          (i32.store offset=36
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (call $~lib/array/Array<u32>#__get
            (local.get 12)
            (local.get $j|11))
          (local.set 12
            (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (local.get 12)
          (local.set 12
            (i32.const 2640))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 12))
          (local.get 12)
          (drop
            (call $~lib/array/Array<u32>#sort))
          (local.set $j|11
            (i32.add
              (local.get $j|11)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 12
      (local.get $result))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 40)))
    (return
      (local.get 12)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 24)
              (i32.const 29))))))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (i32.const 4))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:buckets)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:bucketsMask
      (local.get 1)
      (i32.sub
        (i32.const 4)
        (i32.const 1)))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (local.set 1
      (call $~lib/arraybuffer/ArrayBuffer#constructor
        (i32.const 0)
        (i32.mul
          (i32.const 4)
          (block (result i32)  ;; label = @1
            (br 0 (;@1;)
              (i32.const 12))))))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.get 1)
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entries)
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesCapacity
      (local.get 1)
      (i32.const 4))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesOffset
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesCount
      (local.get 1)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (local.get 1))
  (func $~lib/map/Map<u64_u32>#get (type 9) (param $this i32) (param $key i64) (result i32)
    (local $entry i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entry
      (call $~lib/map/Map<u64_u32>#find
        (local.get 3)
        (local.get $key)
        (call $~lib/util/hash/HASH<u64>
          (local.get $key))))
    (if  ;; label = @1
      (i32.eqz
        (local.get $entry))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 2336)
          (i32.const 2400)
          (i32.const 105)
          (i32.const 17))
        (unreachable)))
    (local.set 3
      (call $~lib/map/MapEntry<u64_u32>#get:value
        (local.get $entry)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $src/injector/findNearestWatLine (type 5) (param $sourceIndex i32) (param $commentLine i32) (param $mappedByFile i32) (param $srcLineToWatLine i32) (result i32)
    (local $lines i32) (local $bestLine i32) (local $j i32) (local i32) (local $key i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    ;; Find the WAT line for the nearest mapped source line to the given
    ;; comment line in the same file. Prefers the next instruction after
    ;; the comment (smallest sourceLine >= commentLine). Falls back to
    ;; the last instruction before the comment.
    (local.set 7
      (local.get $mappedByFile))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (if  ;; label = @1
      (i32.eqz
        (call $~lib/map/Map<u32_~lib/array/Array<u32>>#has
          (local.get 7)
          (local.get $sourceIndex)))
      (then
        (local.set 7
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 12)))
        (return
          (local.get 7))))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 7
      (local.get $mappedByFile))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.tee $lines
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get
        (local.get 7)
        (local.get $sourceIndex)))
    (i32.store offset=4)
    ;; Find smallest mapped line >= commentLine
    (local.set $bestLine
      (i32.const 0))
    (local.set $j
      (i32.const 0))
    (block  ;; label = @1
      (loop  ;; label = @2
        (local.get $j)
        (local.set 7
          (local.get $lines))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 7))
        (call $~lib/array/Array<u32>#get:length
          (local.get 7))
        (if  ;; label = @3
          (i32.lt_s)
          (then
            (local.set 7
              (local.get $lines))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 7))
            (if  ;; label = @4
              (i32.ge_u
                (call $~lib/array/Array<u32>#__get
                  (local.get 7)
                  (local.get $j))
                (local.get $commentLine))
              (then
                (local.set 7
                  (local.get $lines))
                (i32.store
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 7))
                (local.set $bestLine
                  (call $~lib/array/Array<u32>#__get
                    (local.get 7)
                    (local.get $j)))
                (br 3 (;@1;))))
            (local.set $j
              (i32.add
                (local.get $j)
                (i32.const 1)))
            (br 1 (;@2;))))))
    ;; Fall back to largest mapped line < commentLine
    (if  ;; label = @1
      (if (result i32)  ;; label = @2
        (i32.eq
          (local.get $bestLine)
          (i32.const 0))
        (then
          (local.set 7
            (local.get $lines))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 7))
          (i32.gt_s
            (call $~lib/array/Array<u32>#get:length
              (local.get 7))
            (i32.const 0)))
        (else
          (i32.const 0)))
      (then
        (local.set 7
          (local.get $lines))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 7))
        (local.get 7)
        (local.set 7
          (local.get $lines))
        (i32.store offset=8
          (global.get $~lib/memory/__stack_pointer)
          (local.get 7))
        (i32.sub
          (call $~lib/array/Array<u32>#get:length
            (local.get 7))
          (i32.const 1))
        (local.set $bestLine
          (call $~lib/array/Array<u32>#__get))))
    (if  ;; label = @1
      (i32.eq
        (local.get $bestLine)
        (i32.const 0))
      (then
        (local.set 7
          (i32.const 0))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 12)))
        (return
          (local.get 7))))
    (local.set $key
      (call $src/injector/commentKey
        (local.get $sourceIndex)
        (local.get $bestLine)))
    (local.set 7
      (local.get $srcLineToWatLine))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (if  ;; label = @1
      (call $~lib/map/Map<u64_u32>#has
        (local.get 7)
        (local.get $key))
      (then
        (local.set 7
          (local.get $srcLineToWatLine))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 7))
        (local.set 7
          (call $~lib/map/Map<u64_u32>#get
            (local.get 7)
            (local.get $key)))
        (global.set $~lib/memory/__stack_pointer
          (i32.add
            (global.get $~lib/memory/__stack_pointer)
            (i32.const 12)))
        (return
          (local.get 7))))
    (local.set 7
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 7)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#find (type 3) (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
    (local $entry i32) (local $taggedNext i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:buckets
      (local.get 5))
    (local.get $hashCode)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $entry
      (i32.load
        (i32.add
          (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:bucketsMask
            (local.get 5))
          (i32.mul
            (i32.and)
            (i32.const 4)))))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (local.get $entry)
          (then
            (local.set $taggedNext
              (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:taggedNext
                (local.get $entry)))
            (if  ;; label = @4
              (if (result i32)  ;; label = @5
                (i32.eqz
                  (i32.and
                    (local.get $taggedNext)
                    (i32.const 1)))
                (then
                  (i32.eq
                    (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:key
                      (local.get $entry))
                    (local.get $key)))
                (else
                  (i32.const 0)))
              (then
                (local.set 5
                  (local.get $entry))
                (global.set $~lib/memory/__stack_pointer
                  (i32.add
                    (global.get $~lib/memory/__stack_pointer)
                    (i32.const 4)))
                (return
                  (local.get 5))))
            (local.set $entry
              (i32.and
                (local.get $taggedNext)
                (i32.xor
                  (i32.const 1)
                  (i32.const -1))))
            (br 1 (;@2;))))))
    (local.set 5
      (i32.const 0))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 5)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#has (type 2) (param $this i32) (param $key i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.set 2
      (i32.ne
        (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#find
          (local.get 2)
          (local.get $key)
          (call $~lib/util/hash/HASH<u32>
            (local.get $key)))
        (i32.const 0)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 2)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#rehash (type 0) (param $this i32) (param $newBucketsMask i32)
    (local $newBucketsCapacity i32) (local $newBuckets i32) (local $newEntriesCapacity i32) (local $newEntries i32) (local $oldPtr i32) (local $oldEnd i32) (local $newPtr i32) (local $oldEntry i32) (local $newEntry i32) (local $oldEntryKey i32) (local $newBucketIndex i32) (local $newBucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $newBucketsCapacity
      (i32.add
        (local.get $newBucketsMask)
        (i32.const 1)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newBuckets
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newBucketsCapacity)
            (i32.const 4)))))
    (local.set $newEntriesCapacity
      (i32.div_s
        (i32.mul
          (local.get $newBucketsCapacity)
          (i32.const 8))
        (i32.const 3)))
    (i32.store offset=4
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $newEntries
        (call $~lib/arraybuffer/ArrayBuffer#constructor
          (i32.const 0)
          (i32.mul
            (local.get $newEntriesCapacity)
            (block (result i32)  ;; label = @1
              (br 0 (;@1;)
                (i32.const 12)))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.set $oldPtr
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entries
        (local.get 14)))
    (local.get $oldPtr)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (i32.mul
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesOffset
        (local.get 14))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 12))))
    (local.set $oldEnd
      (i32.add))
    (local.set $newPtr
      (local.get $newEntries))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.ne
            (local.get $oldPtr)
            (local.get $oldEnd))
          (then
            (local.set $oldEntry
              (local.get $oldPtr))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:taggedNext
                    (local.get $oldEntry))
                  (i32.const 1)))
              (then
                (local.set $newEntry
                  (local.get $newPtr))
                (local.set $oldEntryKey
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:key
                    (local.get $oldEntry)))
                (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:key
                  (local.get $newEntry)
                  (local.get $oldEntryKey))
                (local.get $newEntry)
                (local.set 14
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:value
                    (local.get $oldEntry)))
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 14))
                (local.get 14)
                (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:value)
                (local.set $newBucketIndex
                  (i32.and
                    (call $~lib/util/hash/HASH<u32>
                      (local.get $oldEntryKey))
                    (local.get $newBucketsMask)))
                (local.set $newBucketPtrBase
                  (i32.add
                    (local.get $newBuckets)
                    (i32.mul
                      (local.get $newBucketIndex)
                      (i32.const 4))))
                (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:taggedNext
                  (local.get $newEntry)
                  (i32.load
                    (local.get $newBucketPtrBase)))
                (i32.store
                  (local.get $newBucketPtrBase)
                  (local.get $newPtr))
                (local.set $newPtr
                  (i32.add
                    (local.get $newPtr)
                    (block (result i32)  ;; label = @5
                      (br 0 (;@5;)
                        (i32.const 12)))))))
            (local.set $oldPtr
              (i32.add
                (local.get $oldPtr)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 12)))))
            (br 1 (;@2;))))))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newBuckets))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:buckets)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:bucketsMask
      (local.get 14)
      (local.get $newBucketsMask))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $newEntries))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entries)
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesCapacity
      (local.get 14)
      (local.get $newEntriesCapacity))
    (local.set 14
      (local.get $this))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (local.get 14)
    (local.set 14
      (local.get $this))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesCount
      (local.get 14))
    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesOffset)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16))))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set (type 3) (param $this i32) (param $key i32) (param $value i32) (result i32)
    (local $hashCode i32) (local $entry i32) (local $entries i32) (local $6 i32) (local $bucketPtrBase i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $hashCode
      (call $~lib/util/hash/HASH<u32>
        (local.get $key)))
    (local.set 8
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 8))
    (local.set $entry
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#find
        (local.get 8)
        (local.get $key)
        (local.get $hashCode)))
    (if  ;; label = @1
      (local.get $entry)
      (then
        (local.get $entry)
        (local.set 8
          (local.get $value))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:value)
        (drop
          (i32.const 1))
        (call $~lib/rt/itcms/__link
          (local.get $this)
          (local.get $value)
          (i32.const 1)))
      (else
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesOffset
          (local.get 8))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesCapacity
          (local.get 8))
        (if  ;; label = @2
          (i32.eq)
          (then
            (local.set 8
              (local.get $this))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (local.get 8)
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesCount
              (local.get 8))
            (local.set 8
              (local.get $this))
            (i32.store offset=4
              (global.get $~lib/memory/__stack_pointer)
              (local.get 8))
            (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#rehash
              (i32.div_s
                (i32.mul
                  (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesCapacity
                    (local.get 8))
                  (i32.const 3))
                (i32.const 4))
              (if (result i32)  ;; label = @3
                (i32.lt_s)
                (then
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:bucketsMask
                    (local.get 8)))
                (else
                  (local.set 8
                    (local.get $this))
                  (i32.store offset=4
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 8))
                  (i32.or
                    (i32.shl
                      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:bucketsMask
                        (local.get 8))
                      (i32.const 1))
                    (i32.const 1)))))))
        (global.get $~lib/memory/__stack_pointer)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.tee $entries
          (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entries
            (local.get 8)))
        (i32.store offset=8)
        (local.get $entries)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (local.tee $6
            (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesOffset
              (local.get 8)))
          (i32.const 1))
        (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesOffset)
        (i32.mul
          (local.get $6)
          (block (result i32)  ;; label = @2
            (br 0 (;@2;)
              (i32.const 12))))
        (local.set $entry
          (i32.add))
        (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:key
          (local.get $entry)
          (local.get $key))
        (drop
          (i32.const 0))
        (local.get $entry)
        (local.set 8
          (local.get $value))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:value)
        (drop
          (i32.const 1))
        (call $~lib/rt/itcms/__link
          (local.get $this)
          (local.get $value)
          (i32.const 1))
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.get 8)
        (local.set 8
          (local.get $this))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (i32.add
          (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesCount
            (local.get 8))
          (i32.const 1))
        (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set:entriesCount)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:buckets
          (local.get 8))
        (local.get $hashCode)
        (local.set 8
          (local.get $this))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 8))
        (local.set $bucketPtrBase
          (i32.add
            (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:bucketsMask
              (local.get 8))
            (i32.mul
              (i32.and)
              (i32.const 4))))
        (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#set:taggedNext
          (local.get $entry)
          (i32.load
            (local.get $bucketPtrBase)))
        (i32.store
          (local.get $bucketPtrBase)
          (local.get $entry))))
    (local.set 8
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 12)))
    (return
      (local.get 8)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get (type 2) (param $this i32) (param $key i32) (result i32)
    (local $entry i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entry
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#find
        (local.get 3)
        (local.get $key)
        (call $~lib/util/hash/HASH<u32>
          (local.get $key))))
    (if  ;; label = @1
      (i32.eqz
        (local.get $entry))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 2336)
          (i32.const 2400)
          (i32.const 105)
          (i32.const 17))
        (unreachable)))
    (local.set 3
      (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:value
        (local.get $entry)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:size (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 1
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 1))
    (local.set 1
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesCount
        (local.get 1)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 1)))
  (func $src/injector/joinLines (type 1) (param $lines i32) (result i32)
    (local $result i32) (local $i i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i64.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $result
        (i32.const 1664)))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $i)
      (local.set 3
        (local.get $lines))
      (i32.store offset=4
        (global.get $~lib/memory/__stack_pointer)
        (local.get 3))
      (call $~lib/array/Array<~lib/string/String>#get:length
        (local.get 3))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (if  ;; label = @3
            (i32.gt_s
              (local.get $i)
              (i32.const 0))
            (then
              (global.get $~lib/memory/__stack_pointer)
              (local.set 3
                (local.get $result))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 3))
              (local.get 3)
              (local.set 3
                (i32.const 1696))
              (i32.store offset=8
                (global.get $~lib/memory/__stack_pointer)
                (local.get 3))
              (i32.store
                (local.get 3)
                (local.tee $result
                  (call $~lib/string/String.__concat)))))
          (global.get $~lib/memory/__stack_pointer)
          (local.set 3
            (local.get $result))
          (i32.store offset=4
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (local.get 3)
          (local.set 3
            (local.get $lines))
          (i32.store offset=12
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (local.set 3
            (call $~lib/array/Array<~lib/string/String>#__get
              (local.get 3)
              (local.get $i)))
          (i32.store offset=8
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (i32.store
            (local.get 3)
            (local.tee $result
              (call $~lib/string/String.__concat)))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 3
      (local.get $result))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 16)))
    (return
      (local.get 3)))
  (func $src/injector/injectComments (type 5) (param $watText i32) (param $lineToOffset i32) (param $sourceEntries i32) (param $commentMap i32) (result i32)
    (local $watLines i32) (local $output i32) (local $emittedComments i32) (local $watLineToOutputIndex i32) (local $mappedLines i32) (local $fileLevelComments i32) (local $headerInjected i32) (local $i i32) (local $watLine i32) (local $line i32) (local $byteOffset i32) (local $entry i32) (local $e i32) (local $srcIndex i32) (local $sourceLine i32) (local $fileComments i32) (local $fc i32) (local $commentText i32) (local $watComment i32) (local $indent i32) (local $keys i32) (local $k i32) (local $commentText|28 i32) (local $watComment|29 i32) (local $indent|30 i32) (local $orphanKeys i32) (local $srcLineToWatLine i32) (local $mappedByFile i32) (local $insertions i32) (local $j i32) (local $srcIndex|37 i32) (local $cLine i32) (local $targetWatLine i32) (local $outIdx i32) (local $commentText|41 i32) (local $watComment|42 i32) (local $indent|43 i32) (local $newOutput i32) (local $j|45 i32) (local $idx i32) (local $ins i32) (local $k|48 i32) (local i32) (local $fkey i64) (local $key i64) (local $key|36 i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 124)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 124))
    (global.get $~lib/memory/__stack_pointer)
    ;; Inject source comments into WAT text.
    ;; lineToOffset: Map from WAT line number → WASM byte offset
    ;; sourceEntries: sorted source map entries (byte offset → source location)
    ;; commentMap: Map from commentKey(sourceIndex, line) → comment text
    (local.set 46
      (local.get $watText))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (local.tee $watLines
      (call $src/injector/splitLines
        (local.get 46)))
    (i32.store offset=4)
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $output
        (call $~lib/array/Array<~lib/string/String>#constructor
          (i32.const 0)
          (i32.const 0))))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $emittedComments
        (call $~lib/set/Set<u64>#constructor
          (i32.const 0))))
    (i32.store offset=16
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $watLineToOutputIndex
        (call $~lib/map/Map<u32_u32>#constructor
          (i32.const 0))))
    (global.get $~lib/memory/__stack_pointer)
    ;; Build a set of mapped source lines so scan-upward knows
    ;; where to stop (at another instruction's source line).
    (local.set 46
      (local.get $lineToOffset))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (local.get 46)
    (local.set 46
      (local.get $sourceEntries))
    (i32.store offset=20
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (i32.store offset=24
      (local.get 46)
      (local.tee $mappedLines
        (call $src/injector/buildMappedLinesSet)))
    (global.get $~lib/memory/__stack_pointer)
    (local.set 46
      (local.get $commentMap))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (local.get 46)
    (local.set 46
      (local.get $lineToOffset))
    (i32.store offset=20
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (local.get 46)
    (local.set 46
      (local.get $sourceEntries))
    (i32.store offset=28
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    ;; File-level injection: collect file-level comments per source file.
    ;; Find the minimum mapped source line for each source index,
    ;; then gather all comments with line numbers below that minimum.
    (i32.store offset=32
      (local.get 46)
      (local.tee $fileLevelComments
        (call $src/injector/collectFileLevelComments)))
    (i32.store offset=36
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $headerInjected
        (call $~lib/set/Set<u32>#constructor
          (i32.const 0))))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $i)
      (local.set 46
        (local.get $watLines))
      (i32.store
        (global.get $~lib/memory/__stack_pointer)
        (local.get 46))
      (call $~lib/array/Array<~lib/string/String>#get:length
        (local.get 46))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          ;; 1-based
          (local.set $watLine
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (global.get $~lib/memory/__stack_pointer)
          (local.set 46
            (local.get $watLines))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 46))
          (local.tee $line
            (call $~lib/array/Array<~lib/string/String>#__get
              (local.get 46)
              (local.get $i)))
          (i32.store offset=40)
          (local.set 46
            (local.get $lineToOffset))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 46))
          (if  ;; label = @3
            (call $~lib/map/Map<u32_u32>#has
              (local.get 46)
              (local.get $watLine))
            (then
              (local.set 46
                (local.get $lineToOffset))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 46))
              (local.set $byteOffset
                (call $~lib/map/Map<u32_u32>#get
                  (local.get 46)
                  (local.get $watLine)))
              (global.get $~lib/memory/__stack_pointer)
              (local.set 46
                (local.get $sourceEntries))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 46))
              (local.tee $entry
                (call $src/sourcemap/lookupOffset
                  (local.get 46)
                  (local.get $byteOffset)))
              (i32.store offset=44)
              (if  ;; label = @4
                (i32.ne
                  (local.get $entry)
                  (i32.const 0))
                (then
                  (i32.store offset=48
                    (global.get $~lib/memory/__stack_pointer)
                    (local.tee $e
                      (local.get $entry)))
                  (local.set 46
                    (local.get $e))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.set $srcIndex
                    (call $src/sourcemap/SourceMapEntry#get:sourceIndex
                      (local.get 46)))
                  ;; source map lines are 0-indexed
                  (local.set 46
                    (local.get $e))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.set $sourceLine
                    (i32.add
                      (call $src/sourcemap/SourceMapEntry#get:sourceLine
                        (local.get 46))
                      (i32.const 1)))
                  ;; Inject file-level comments before the first instruction from this file
                  (local.set 46
                    (local.get $headerInjected))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (if  ;; label = @5
                    (if (result i32)  ;; label = @6
                      (i32.eqz
                        (call $~lib/set/Set<u32>#has
                          (local.get 46)
                          (local.get $srcIndex)))
                      (then
                        (local.set 46
                          (local.get $fileLevelComments))
                        (i32.store
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 46))
                        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#has
                          (local.get 46)
                          (local.get $srcIndex)))
                      (else
                        (i32.const 0)))
                    (then
                      (local.set 46
                        (local.get $headerInjected))
                      (i32.store
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 46))
                      (drop
                        (call $~lib/set/Set<u32>#add
                          (local.get 46)
                          (local.get $srcIndex)))
                      (global.get $~lib/memory/__stack_pointer)
                      (local.set 46
                        (local.get $fileLevelComments))
                      (i32.store
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 46))
                      (local.tee $fileComments
                        (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get
                          (local.get 46)
                          (local.get $srcIndex)))
                      (i32.store offset=52)
                      (local.set $fc
                        (i32.const 0))
                      (loop  ;; label = @6
                        (local.get $fc)
                        (local.set 46
                          (local.get $fileComments))
                        (i32.store
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 46))
                        (call $~lib/array/Array<u64>#get:length
                          (local.get 46))
                        (if  ;; label = @7
                          (i32.lt_s)
                          (then
                            (local.set 46
                              (local.get $fileComments))
                            (i32.store
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.set $fkey
                              (call $~lib/array/Array<u64>#__get
                                (local.get 46)
                                (local.get $fc)))
                            (local.set 46
                              (local.get $emittedComments))
                            (i32.store
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (if  ;; label = @8
                              (i32.eqz
                                (call $~lib/set/Set<u64>#has
                                  (local.get 46)
                                  (local.get $fkey)))
                              (then
                                (local.set 46
                                  (local.get $emittedComments))
                                (i32.store
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 46))
                                (drop
                                  (call $~lib/set/Set<u64>#add
                                    (local.get 46)
                                    (local.get $fkey)))
                                (global.get $~lib/memory/__stack_pointer)
                                (local.set 46
                                  (local.get $commentMap))
                                (i32.store
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 46))
                                (local.tee $commentText
                                  (call $~lib/map/Map<u64_~lib/string/String>#get
                                    (local.get 46)
                                    (local.get $fkey)))
                                (i32.store offset=56)
                                (global.get $~lib/memory/__stack_pointer)
                                (local.set 46
                                  (local.get $commentText))
                                (i32.store
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 46))
                                (local.tee $watComment
                                  (call $src/injector/convertToWatComment
                                    (local.get 46)))
                                (i32.store offset=60)
                                (global.get $~lib/memory/__stack_pointer)
                                (local.set 46
                                  (local.get $line))
                                (i32.store
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 46))
                                (local.tee $indent
                                  (call $src/injector/getIndent
                                    (local.get 46)))
                                (i32.store offset=64)
                                (local.set 46
                                  (local.get $output))
                                (i32.store
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 46))
                                (local.get 46)
                                (local.set 46
                                  (local.get $indent))
                                (i32.store offset=28
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 46))
                                (local.get 46)
                                (local.set 46
                                  (local.get $watComment))
                                (i32.store offset=68
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 46))
                                (local.get 46)
                                (local.set 46
                                  (call $~lib/string/String.__concat))
                                (i32.store offset=20
                                  (global.get $~lib/memory/__stack_pointer)
                                  (local.get 46))
                                (local.get 46)
                                (drop
                                  (call $~lib/array/Array<~lib/string/String>#push))))
                            (local.set $fc
                              (i32.add
                                (local.get $fc)
                                (i32.const 1)))
                            (br 1 (;@6;)))))))
                  (global.get $~lib/memory/__stack_pointer)
                  ;; Scan upward to collect all comments above this instruction
                  (local.set 46
                    (local.get $commentMap))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.get 46)
                  (local.set 46
                    (local.get $mappedLines))
                  (i32.store offset=20
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.get 46)
                  (local.get $srcIndex)
                  (i32.store offset=72
                    (local.get $sourceLine)
                    (local.tee $keys
                      (call $src/injector/scanUpwardForComments)))
                  (local.set $k
                    (i32.const 0))
                  (loop  ;; label = @5
                    (local.get $k)
                    (local.set 46
                      (local.get $keys))
                    (i32.store
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 46))
                    (call $~lib/array/Array<u64>#get:length
                      (local.get 46))
                    (if  ;; label = @6
                      (i32.lt_s)
                      (then
                        (local.set 46
                          (local.get $keys))
                        (i32.store
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 46))
                        (local.set $key
                          (call $~lib/array/Array<u64>#__get
                            (local.get 46)
                            (local.get $k)))
                        (local.set 46
                          (local.get $emittedComments))
                        (i32.store
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 46))
                        (if  ;; label = @7
                          (i32.eqz
                            (call $~lib/set/Set<u64>#has
                              (local.get 46)
                              (local.get $key)))
                          (then
                            (local.set 46
                              (local.get $emittedComments))
                            (i32.store
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (drop
                              (call $~lib/set/Set<u64>#add
                                (local.get 46)
                                (local.get $key)))
                            (global.get $~lib/memory/__stack_pointer)
                            (local.set 46
                              (local.get $commentMap))
                            (i32.store
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.tee $commentText|28
                              (call $~lib/map/Map<u64_~lib/string/String>#get
                                (local.get 46)
                                (local.get $key)))
                            (i32.store offset=76)
                            (global.get $~lib/memory/__stack_pointer)
                            (local.set 46
                              (local.get $commentText|28))
                            (i32.store
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.tee $watComment|29
                              (call $src/injector/convertToWatComment
                                (local.get 46)))
                            (i32.store offset=80)
                            (global.get $~lib/memory/__stack_pointer)
                            (local.set 46
                              (local.get $line))
                            (i32.store
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.tee $indent|30
                              (call $src/injector/getIndent
                                (local.get 46)))
                            (i32.store offset=84)
                            (local.set 46
                              (local.get $output))
                            (i32.store
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.get 46)
                            (local.set 46
                              (local.get $indent|30))
                            (i32.store offset=28
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.get 46)
                            (local.set 46
                              (local.get $watComment|29))
                            (i32.store offset=68
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.get 46)
                            (local.set 46
                              (call $~lib/string/String.__concat))
                            (i32.store offset=20
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.get 46)
                            (drop
                              (call $~lib/array/Array<~lib/string/String>#push))))
                        (local.set $k
                          (i32.add
                            (local.get $k)
                            (i32.const 1)))
                        (br 1 (;@5;)))))))))
          (local.set 46
            (local.get $watLineToOutputIndex))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 46))
          (local.get 46)
          (local.get $watLine)
          (local.set 46
            (local.get $output))
          (i32.store offset=20
            (global.get $~lib/memory/__stack_pointer)
            (local.get 46))
          (call $~lib/array/Array<~lib/string/String>#get:length
            (local.get 46))
          (drop
            (call $~lib/map/Map<u32_u32>#set))
          (local.set 46
            (local.get $output))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 46))
          (local.get 46)
          (local.set 46
            (local.get $line))
          (i32.store offset=20
            (global.get $~lib/memory/__stack_pointer)
            (local.get 46))
          (local.get 46)
          (drop
            (call $~lib/array/Array<~lib/string/String>#push))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (global.get $~lib/memory/__stack_pointer)
    ;; Orphan pass: collect comments not yet emitted and attach each to the
    ;; Collect comments not yet emitted and attach each to the
    ;; nearest WAT line from the same source file.
    (local.set 46
      (local.get $commentMap))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (local.get 46)
    (local.set 46
      (local.get $emittedComments))
    (i32.store offset=20
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (i32.store offset=88
      (local.get 46)
      (local.tee $orphanKeys
        (call $src/injector/findOrphanKeys)))
    (local.set 46
      (local.get $orphanKeys))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (if  ;; label = @1
      (i32.gt_s
        (call $~lib/array/Array<u64>#get:length
          (local.get 46))
        (i32.const 0))
      (then
        (global.get $~lib/memory/__stack_pointer)
        (local.set 46
          (local.get $lineToOffset))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 46))
        (local.get 46)
        (local.set 46
          (local.get $sourceEntries))
        (i32.store offset=20
          (global.get $~lib/memory/__stack_pointer)
          (local.get 46))
        (i32.store offset=92
          (local.get 46)
          (local.tee $srcLineToWatLine
            (call $src/injector/buildSourceLineToWatLine)))
        (global.get $~lib/memory/__stack_pointer)
        (local.set 46
          (local.get $lineToOffset))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 46))
        (local.get 46)
        (local.set 46
          (local.get $sourceEntries))
        (i32.store offset=20
          (global.get $~lib/memory/__stack_pointer)
          (local.get 46))
        (i32.store offset=96
          (local.get 46)
          (local.tee $mappedByFile
            (call $src/injector/buildMappedLinesByFile)))
        (i32.store offset=100
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $insertions
            (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#constructor
              (i32.const 0))))
        (local.set $j
          (i32.const 0))
        (loop  ;; label = @2
          (local.get $j)
          (local.set 46
            (local.get $orphanKeys))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 46))
          (call $~lib/array/Array<u64>#get:length
            (local.get 46))
          (if  ;; label = @3
            (i32.lt_s)
            (then
              (local.set 46
                (local.get $orphanKeys))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 46))
              (local.set $key|36
                (call $~lib/array/Array<u64>#__get
                  (local.get 46)
                  (local.get $j)))
              (local.set $srcIndex|37
                (i32.wrap_i64
                  (i64.shr_u
                    (local.get $key|36)
                    (i64.const 32))))
              (local.set $cLine
                (i32.wrap_i64
                  (i64.and
                    (local.get $key|36)
                    (i64.const 4294967295))))
              (local.get $srcIndex|37)
              (local.get $cLine)
              (local.set 46
                (local.get $mappedByFile))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 46))
              (local.get 46)
              (local.set 46
                (local.get $srcLineToWatLine))
              (i32.store offset=20
                (global.get $~lib/memory/__stack_pointer)
                (local.get 46))
              (local.get 46)
              (local.set $targetWatLine
                (call $src/injector/findNearestWatLine))
              (if  ;; label = @4
                (if (result i32)  ;; label = @5
                  (i32.gt_u
                    (local.get $targetWatLine)
                    (i32.const 0))
                  (then
                    (local.set 46
                      (local.get $watLineToOutputIndex))
                    (i32.store
                      (global.get $~lib/memory/__stack_pointer)
                      (local.get 46))
                    (call $~lib/map/Map<u32_u32>#has
                      (local.get 46)
                      (local.get $targetWatLine)))
                  (else
                    (i32.const 0)))
                (then
                  (local.set 46
                    (local.get $watLineToOutputIndex))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.set $outIdx
                    (call $~lib/map/Map<u32_u32>#get
                      (local.get 46)
                      (local.get $targetWatLine)))
                  (global.get $~lib/memory/__stack_pointer)
                  (local.set 46
                    (local.get $commentMap))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.tee $commentText|41
                    (call $~lib/map/Map<u64_~lib/string/String>#get
                      (local.get 46)
                      (local.get $key|36)))
                  (i32.store offset=104)
                  (global.get $~lib/memory/__stack_pointer)
                  (local.set 46
                    (local.get $commentText|41))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.tee $watComment|42
                    (call $src/injector/convertToWatComment
                      (local.get 46)))
                  (i32.store offset=108)
                  (global.get $~lib/memory/__stack_pointer)
                  (local.set 46
                    (local.get $output))
                  (i32.store offset=20
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.set 46
                    (call $~lib/array/Array<~lib/string/String>#__get
                      (local.get 46)
                      (local.get $outIdx)))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.tee $indent|43
                    (call $src/injector/getIndent
                      (local.get 46)))
                  (i32.store offset=112)
                  (local.set 46
                    (local.get $insertions))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (if  ;; label = @5
                    (i32.eqz
                      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#has
                        (local.get 46)
                        (local.get $outIdx)))
                    (then
                      (local.set 46
                        (local.get $insertions))
                      (i32.store
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 46))
                      (local.get 46)
                      (local.get $outIdx)
                      (local.set 46
                        (call $~lib/array/Array<~lib/string/String>#constructor
                          (i32.const 0)
                          (i32.const 0)))
                      (i32.store offset=20
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 46))
                      (local.get 46)
                      (drop
                        (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#set))))
                  (local.set 46
                    (local.get $insertions))
                  (i32.store offset=28
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.set 46
                    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get
                      (local.get 46)
                      (local.get $outIdx)))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.get 46)
                  (local.set 46
                    (local.get $indent|43))
                  (i32.store offset=28
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.get 46)
                  (local.set 46
                    (local.get $watComment|42))
                  (i32.store offset=68
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.get 46)
                  (local.set 46
                    (call $~lib/string/String.__concat))
                  (i32.store offset=20
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.get 46)
                  (drop
                    (call $~lib/array/Array<~lib/string/String>#push))))
              (local.set $j
                (i32.add
                  (local.get $j)
                  (i32.const 1)))
              (br 1 (;@2;)))))
        (local.set 46
          (local.get $insertions))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 46))
        (if  ;; label = @2
          (i32.gt_s
            (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:size
              (local.get 46))
            (i32.const 0))
          (then
            (i32.store offset=116
              (global.get $~lib/memory/__stack_pointer)
              (local.tee $newOutput
                (call $~lib/array/Array<~lib/string/String>#constructor
                  (i32.const 0)
                  (i32.const 0))))
            (local.set $j|45
              (i32.const 0))
            (loop  ;; label = @3
              (local.get $j|45)
              (local.set 46
                (local.get $output))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 46))
              (call $~lib/array/Array<~lib/string/String>#get:length
                (local.get 46))
              (if  ;; label = @4
                (i32.lt_s)
                (then
                  (local.set $idx
                    (local.get $j|45))
                  (local.set 46
                    (local.get $insertions))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (if  ;; label = @5
                    (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#has
                      (local.get 46)
                      (local.get $idx))
                    (then
                      (global.get $~lib/memory/__stack_pointer)
                      (local.set 46
                        (local.get $insertions))
                      (i32.store
                        (global.get $~lib/memory/__stack_pointer)
                        (local.get 46))
                      (local.tee $ins
                        (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get
                          (local.get 46)
                          (local.get $idx)))
                      (i32.store offset=120)
                      (local.set $k|48
                        (i32.const 0))
                      (loop  ;; label = @6
                        (local.get $k|48)
                        (local.set 46
                          (local.get $ins))
                        (i32.store
                          (global.get $~lib/memory/__stack_pointer)
                          (local.get 46))
                        (call $~lib/array/Array<~lib/string/String>#get:length
                          (local.get 46))
                        (if  ;; label = @7
                          (i32.lt_s)
                          (then
                            (local.set 46
                              (local.get $newOutput))
                            (i32.store
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.get 46)
                            (local.set 46
                              (local.get $ins))
                            (i32.store offset=28
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.set 46
                              (call $~lib/array/Array<~lib/string/String>#__get
                                (local.get 46)
                                (local.get $k|48)))
                            (i32.store offset=20
                              (global.get $~lib/memory/__stack_pointer)
                              (local.get 46))
                            (local.get 46)
                            (drop
                              (call $~lib/array/Array<~lib/string/String>#push))
                            (local.set $k|48
                              (i32.add
                                (local.get $k|48)
                                (i32.const 1)))
                            (br 1 (;@6;)))))))
                  (local.set 46
                    (local.get $newOutput))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.get 46)
                  (local.set 46
                    (local.get $output))
                  (i32.store offset=28
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.set 46
                    (call $~lib/array/Array<~lib/string/String>#__get
                      (local.get 46)
                      (local.get $j|45)))
                  (i32.store offset=20
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 46))
                  (local.get 46)
                  (drop
                    (call $~lib/array/Array<~lib/string/String>#push))
                  (local.set $j|45
                    (i32.add
                      (local.get $j|45)
                      (i32.const 1)))
                  (br 1 (;@3;)))))
            (local.set 46
              (local.get $newOutput))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 46))
            (local.set 46
              (call $src/injector/joinLines
                (local.get 46)))
            (global.set $~lib/memory/__stack_pointer
              (i32.add
                (global.get $~lib/memory/__stack_pointer)
                (i32.const 124)))
            (return
              (local.get 46))))))
    (local.set 46
      (local.get $output))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 46))
    (local.set 46
      (call $src/injector/joinLines
        (local.get 46)))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 124)))
    (return
      (local.get 46)))
  (func $~lib/as-wasi/assembly/as-wasi/Console.write (type 0) (param $s i32) (param $newline i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (block (result i32)  ;; label = @1
      (br 0 (;@1;)
        (call $~lib/as-wasi/assembly/as-wasi/Descriptor#constructor
          (i32.const 0)
          (i32.const 1))))
    (local.set 2
      (local.get $s))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (local.get 2)
    (local.get $newline)
    (call $~lib/as-wasi/assembly/as-wasi/Descriptor#writeString)
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $src/index/writeOutput (type 6) (param $text i32)
    (local $start i32) (local $i i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8)))
    (call $~stack_check)
    (i64.store
      (global.get $~lib/memory/__stack_pointer)
      (i64.const 0))
    (local.set $start
      (i32.const 0))
    (local.set $i
      (i32.const 0))
    (loop  ;; label = @1
      (local.get $i)
      (local.set 3
        (local.get $text))
      (i32.store
        (global.get $~lib/memory/__stack_pointer)
        (local.get 3))
      (call $~lib/string/String#get:length
        (local.get 3))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          ;; '\n'
          (local.set 3
            (local.get $text))
          (i32.store
            (global.get $~lib/memory/__stack_pointer)
            (local.get 3))
          (if  ;; label = @3
            (i32.eq
              (call $~lib/string/String#charCodeAt
                (local.get 3)
                (local.get $i))
              (i32.const 10))
            (then
              (local.set 3
                (local.get $text))
              (i32.store offset=4
                (global.get $~lib/memory/__stack_pointer)
                (local.get 3))
              (local.set 3
                (call $~lib/string/String#substring
                  (local.get 3)
                  (local.get $start)
                  (i32.add
                    (local.get $i)
                    (i32.const 1))))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 3))
              (call $~lib/as-wasi/assembly/as-wasi/Console.write
                (local.get 3)
                (i32.const 0))
              (local.set $start
                (i32.add
                  (local.get $i)
                  (i32.const 1)))))
          (local.set $i
            (i32.add
              (local.get $i)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.get $start)
    (local.set 3
      (local.get $text))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/string/String#get:length
      (local.get 3))
    (if  ;; label = @1
      (i32.lt_s)
      (then
        (local.set 3
          (local.get $text))
        (i32.store offset=4
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (local.get 3)
        (local.get $start)
        (global.set $~argumentsLength
          (i32.const 1))
        (i32.const 0)
        (local.set 3
          (call $~lib/string/String#substring@varargs))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 3))
        (call $~lib/as-wasi/assembly/as-wasi/Console.write
          (local.get 3)
          (i32.const 0))))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 8))))
  (func $start:src/index (type 8)
    (local i32 i32 i32 i32 i32 i32 i32 i64)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 32)))
    (call $~stack_check)
    (memory.fill
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0)
      (i32.const 32))
    (call $start:~lib/as-wasi/assembly/index)
    (global.set $~lib/rt/itcms/threshold
      (i32.shr_u
        (i32.sub
          (i32.shl
            (memory.size)
            (i32.const 16))
          (global.get $~lib/memory/__heap_base))
        (i32.const 1)))
    (global.set $~lib/rt/itcms/pinSpace
      (call $~lib/rt/itcms/initLazy
        (i32.const 448)))
    (global.set $~lib/rt/itcms/toSpace
      (call $~lib/rt/itcms/initLazy
        (i32.const 480)))
    (global.set $~lib/rt/itcms/fromSpace
      (call $~lib/rt/itcms/initLazy
        (i32.const 624)))
    (global.set $src/index/args
      (block (result i32)  ;; label = @1
        (local.set 6
          (call $~lib/as-wasi/assembly/as-wasi/CommandLine#constructor
            (i32.const 0)))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (br 0 (;@1;)
          (call $~lib/as-wasi/assembly/as-wasi/CommandLine#get:args
            (local.get 6)))))
    (local.set 6
      (global.get $src/index/args))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (if  ;; label = @1
      (i32.lt_s
        (call $~lib/array/Array<~lib/string/String>#get:length
          (local.get 6))
        (i32.const 5))
      (then
        (local.set 6
          (i32.const 928))
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.get 6))
        (call $~lib/as-wasi/assembly/as-wasi/Console.error
          (local.get 6)
          (i32.const 1))
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 0)
          (i32.const 0)
          (i32.const 0))))
    (local.set 6
      (global.get $src/index/args))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/sourceMapPath
      (call $~lib/array/Array<~lib/string/String>#__get
        (local.get 6)
        (i32.const 1)))
    (local.set 6
      (global.get $src/index/args))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/watPath
      (call $~lib/array/Array<~lib/string/String>#__get
        (local.get 6)
        (i32.const 2)))
    (local.set 6
      (global.get $src/index/args))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/offsetMapPath
      (call $~lib/array/Array<~lib/string/String>#__get
        (local.get 6)
        (i32.const 3)))
    (local.set 6
      (global.get $src/index/sourceMapPath))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/sourceMapJson
      (call $src/index/readFileText
        (local.get 6)))
    (local.set 6
      (global.get $src/index/sourceMapJson))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/sourceMap
      (call $src/sourcemap/parseSourceMap
        (local.get 6)))
    (local.set 6
      (global.get $src/index/watPath))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/watText
      (call $src/index/readFileText
        (local.get 6)))
    (local.set 6
      (global.get $src/index/offsetMapPath))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/offsetMapJson
      (call $src/index/readFileText
        (local.get 6)))
    (local.set 6
      (global.get $src/index/offsetMapJson))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/offsetEntries
      (call $src/offsetmap/parseOffsetMap
        (local.get 6)))
    (local.set 6
      (global.get $src/index/offsetEntries))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (global.set $src/index/lineToOffset
      (call $src/offsetmap/buildLineToOffsetMap
        (local.get 6)))
    (global.set $src/index/cMap
      (call $~lib/map/Map<u64_~lib/string/String>#constructor
        (i32.const 0)))
    (local.set 0
      (i32.const 4))
    (loop  ;; label = @1
      (local.get 0)
      (local.set 6
        (global.get $src/index/args))
      (i32.store
        (global.get $~lib/memory/__stack_pointer)
        (local.get 6))
      (call $~lib/array/Array<~lib/string/String>#get:length
        (local.get 6))
      (if  ;; label = @2
        (i32.lt_s)
        (then
          (block  ;; label = @3
            (global.get $~lib/memory/__stack_pointer)
            (local.set 6
              (global.get $src/index/args))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.tee 1
              (call $~lib/array/Array<~lib/string/String>#__get
                (local.get 6)
                (local.get 0)))
            (i32.store offset=4)
            (local.set 6
              (global.get $src/index/sourceMap))
            (i32.store offset=12
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.set 6
              (call $src/sourcemap/SourceMap#get:sources
                (local.get 6)))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.get 6)
            (local.set 6
              (local.get 1))
            (i32.store offset=8
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.get 6)
            (local.set 2
              (call $src/index/findSourceIndex))
            (if  ;; label = @4
              (i32.lt_s
                (local.get 2)
                (i32.const 0))
              (then
                (local.set 6
                  (i32.const 2192))
                (i32.store offset=16
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 6))
                (local.get 6)
                (local.set 6
                  (local.get 1))
                (i32.store offset=20
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 6))
                (local.get 6)
                (local.set 6
                  (call $~lib/string/String.__concat))
                (i32.store offset=8
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 6))
                (local.get 6)
                (local.set 6
                  (i32.const 2240))
                (i32.store offset=12
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 6))
                (local.get 6)
                (local.set 6
                  (call $~lib/string/String.__concat))
                (i32.store
                  (global.get $~lib/memory/__stack_pointer)
                  (local.get 6))
                (call $~lib/as-wasi/assembly/as-wasi/Console.error
                  (local.get 6)
                  (i32.const 1))
                (br 1 (;@3;))))
            (global.get $~lib/memory/__stack_pointer)
            (local.set 6
              (local.get 1))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.tee 3
              (call $src/index/readFileText
                (local.get 6)))
            (i32.store offset=24)
            (global.get $~lib/memory/__stack_pointer)
            (local.set 6
              (local.get 3))
            (i32.store
              (global.get $~lib/memory/__stack_pointer)
              (local.get 6))
            (local.tee 4
              (call $src/comments/extractComments
                (local.get 6)))
            (i32.store offset=28)
            (local.set 5
              (i32.const 0))
            (loop  ;; label = @4
              (local.get 5)
              (local.set 6
                (local.get 4))
              (i32.store
                (global.get $~lib/memory/__stack_pointer)
                (local.get 6))
              (call $~lib/array/Array<src/comments/SourceComment>#get:length
                (local.get 6))
              (if  ;; label = @5
                (i32.lt_s)
                (then
                  (local.get 2)
                  (local.set 6
                    (local.get 4))
                  (i32.store offset=8
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (local.set 6
                    (call $~lib/array/Array<src/comments/SourceComment>#__get
                      (local.get 6)
                      (local.get 5)))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (call $src/comments/SourceComment#get:line
                    (local.get 6))
                  (local.set 7
                    (call $src/injector/commentKey))
                  (local.set 6
                    (global.get $src/index/cMap))
                  (i32.store
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (local.get 6)
                  (local.get 7)
                  (local.set 6
                    (local.get 4))
                  (i32.store offset=16
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (local.set 6
                    (call $~lib/array/Array<src/comments/SourceComment>#__get
                      (local.get 6)
                      (local.get 5)))
                  (i32.store offset=12
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (local.set 6
                    (call $src/comments/SourceComment#get:text
                      (local.get 6)))
                  (i32.store offset=8
                    (global.get $~lib/memory/__stack_pointer)
                    (local.get 6))
                  (local.get 6)
                  (drop
                    (call $~lib/map/Map<u64_~lib/string/String>#set))
                  (local.set 5
                    (i32.add
                      (local.get 5)
                      (i32.const 1)))
                  (br 1 (;@4;))))))
          (local.set 0
            (i32.add
              (local.get 0)
              (i32.const 1)))
          (br 1 (;@1;)))))
    (local.set 6
      (global.get $src/index/watText))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (global.get $src/index/lineToOffset))
    (i32.store offset=8
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (global.get $src/index/sourceMap))
    (i32.store offset=20
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.set 6
      (call $src/sourcemap/SourceMap#get:entries
        (local.get 6)))
    (i32.store offset=12
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (local.set 6
      (global.get $src/index/cMap))
    (i32.store offset=16
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (local.get 6)
    (global.set $src/index/annotatedWat
      (call $src/injector/injectComments))
    (local.set 6
      (global.get $src/index/annotatedWat))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 6))
    (call $src/index/writeOutput
      (local.get 6))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 32))))
  (func $~lib/array/Array<~lib/string/String>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $cur i32) (local $end i32) (local $val i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (drop
      (i32.const 1))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $cur
      (call $~lib/array/Array<~lib/string/String>#get:dataStart
        (local.get 5)))
    (local.get $cur)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (i32.shl
      (call $~lib/array/Array<~lib/string/String>#get:length_
        (local.get 5))
      (i32.const 2))
    (local.set $end
      (i32.add))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $cur)
            (local.get $end))
          (then
            (local.set $val
              (i32.load
                (local.get $cur)))
            (if  ;; label = @4
              (local.get $val)
              (then
                (call $~lib/rt/itcms/__visit
                  (local.get $val)
                  (local.get $cookie))))
            (local.set $cur
              (i32.add
                (local.get $cur)
                (i32.const 4)))
            (br 1 (;@2;))))))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/rt/itcms/__visit
      (call $~lib/array/Array<~lib/string/String>#get:buffer
        (local.get 5))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<i32>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (drop
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/rt/itcms/__visit
      (call $~lib/array/Array<i32>#get:buffer
        (local.get 2))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<u8>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (drop
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/rt/itcms/__visit
      (call $~lib/array/Array<u8>#get:buffer
        (local.get 2))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<src/sourcemap/SourceMapEntry>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $cur i32) (local $end i32) (local $val i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (drop
      (i32.const 1))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $cur
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:dataStart
        (local.get 5)))
    (local.get $cur)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (i32.shl
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:length_
        (local.get 5))
      (i32.const 2))
    (local.set $end
      (i32.add))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $cur)
            (local.get $end))
          (then
            (local.set $val
              (i32.load
                (local.get $cur)))
            (if  ;; label = @4
              (local.get $val)
              (then
                (call $~lib/rt/itcms/__visit
                  (local.get $val)
                  (local.get $cookie))))
            (local.set $cur
              (i32.add
                (local.get $cur)
                (i32.const 4)))
            (br 1 (;@2;))))))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/rt/itcms/__visit
      (call $~lib/array/Array<src/sourcemap/SourceMapEntry>#get:buffer
        (local.get 5))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/function/Function<%28src/sourcemap/SourceMapEntry%2Csrc/sourcemap/SourceMapEntry%29=>i32>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/rt/itcms/__visit
      (call $~lib/function/Function<%28src/sourcemap/SourceMapEntry%2Csrc/sourcemap/SourceMapEntry%29=>i32>#get:_env
        (local.get 2))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<src/offsetmap/OffsetMapEntry>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $cur i32) (local $end i32) (local $val i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (drop
      (i32.const 1))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $cur
      (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:dataStart
        (local.get 5)))
    (local.get $cur)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (i32.shl
      (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:length_
        (local.get 5))
      (i32.const 2))
    (local.set $end
      (i32.add))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $cur)
            (local.get $end))
          (then
            (local.set $val
              (i32.load
                (local.get $cur)))
            (if  ;; label = @4
              (local.get $val)
              (then
                (call $~lib/rt/itcms/__visit
                  (local.get $val)
                  (local.get $cookie))))
            (local.set $cur
              (i32.add
                (local.get $cur)
                (i32.const 4)))
            (br 1 (;@2;))))))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/rt/itcms/__visit
      (call $~lib/array/Array<src/offsetmap/OffsetMapEntry>#get:buffer
        (local.get 5))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/map/Map<u32_u32>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $entries i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/rt/itcms/__visit
      (call $~lib/map/Map<u32_u32>#get:buckets
        (local.get 3))
      (local.get $cookie))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entries
      (call $~lib/map/Map<u32_u32>#get:entries
        (local.get 3)))
    (drop
      (i32.const 0))
    (call $~lib/rt/itcms/__visit
      (local.get $entries)
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/map/Map<u64_~lib/string/String>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $entries i32) (local $cur i32) (local $end i32) (local $entry i32) (local $val i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $~lib/rt/itcms/__visit
      (call $~lib/map/Map<u64_~lib/string/String>#get:buckets
        (local.get 7))
      (local.get $cookie))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.set $entries
      (call $~lib/map/Map<u64_~lib/string/String>#get:entries
        (local.get 7)))
    (drop
      (i32.const 1))
    (local.set $cur
      (local.get $entries))
    (local.get $cur)
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (i32.mul
      (call $~lib/map/Map<u64_~lib/string/String>#get:entriesOffset
        (local.get 7))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 16))))
    (local.set $end
      (i32.add))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $cur)
            (local.get $end))
          (then
            (local.set $entry
              (local.get $cur))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u64_~lib/string/String>#get:taggedNext
                    (local.get $entry))
                  (i32.const 1)))
              (then
                (drop
                  (i32.const 0))
                (drop
                  (i32.const 1))
                (local.set $val
                  (call $~lib/map/MapEntry<u64_~lib/string/String>#get:value
                    (local.get $entry)))
                (drop
                  (i32.const 0))
                (call $~lib/rt/itcms/__visit
                  (local.get $val)
                  (local.get $cookie))))
            (local.set $cur
              (i32.add
                (local.get $cur)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 16)))))
            (br 1 (;@2;))))))
    (call $~lib/rt/itcms/__visit
      (local.get $entries)
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<src/comments/SourceComment>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $cur i32) (local $end i32) (local $val i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (drop
      (i32.const 1))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (local.set $cur
      (call $~lib/array/Array<src/comments/SourceComment>#get:dataStart
        (local.get 5)))
    (local.get $cur)
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (i32.shl
      (call $~lib/array/Array<src/comments/SourceComment>#get:length_
        (local.get 5))
      (i32.const 2))
    (local.set $end
      (i32.add))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $cur)
            (local.get $end))
          (then
            (local.set $val
              (i32.load
                (local.get $cur)))
            (if  ;; label = @4
              (local.get $val)
              (then
                (call $~lib/rt/itcms/__visit
                  (local.get $val)
                  (local.get $cookie))))
            (local.set $cur
              (i32.add
                (local.get $cur)
                (i32.const 4)))
            (br 1 (;@2;))))))
    (local.set 5
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 5))
    (call $~lib/rt/itcms/__visit
      (call $~lib/array/Array<src/comments/SourceComment>#get:buffer
        (local.get 5))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/set/Set<u64>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $entries i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/rt/itcms/__visit
      (call $~lib/set/Set<u64>#get:buckets
        (local.get 3))
      (local.get $cookie))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entries
      (call $~lib/set/Set<u64>#get:entries
        (local.get 3)))
    (drop
      (i32.const 0))
    (call $~lib/rt/itcms/__visit
      (local.get $entries)
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<u32>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (drop
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/rt/itcms/__visit
      (call $~lib/array/Array<u32>#get:buffer
        (local.get 2))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/array/Array<u64>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (drop
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/rt/itcms/__visit
      (call $~lib/array/Array<u64>#get:buffer
        (local.get 2))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/map/Map<u32_~lib/array/Array<u64>>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $entries i32) (local $cur i32) (local $end i32) (local $entry i32) (local $val i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $~lib/rt/itcms/__visit
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:buckets
        (local.get 7))
      (local.get $cookie))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.set $entries
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entries
        (local.get 7)))
    (drop
      (i32.const 1))
    (local.set $cur
      (local.get $entries))
    (local.get $cur)
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (i32.mul
      (call $~lib/map/Map<u32_~lib/array/Array<u64>>#get:entriesOffset
        (local.get 7))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 12))))
    (local.set $end
      (i32.add))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $cur)
            (local.get $end))
          (then
            (local.set $entry
              (local.get $cur))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:taggedNext
                    (local.get $entry))
                  (i32.const 1)))
              (then
                (drop
                  (i32.const 0))
                (drop
                  (i32.const 1))
                (local.set $val
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u64>>#get:value
                    (local.get $entry)))
                (drop
                  (i32.const 0))
                (call $~lib/rt/itcms/__visit
                  (local.get $val)
                  (local.get $cookie))))
            (local.set $cur
              (i32.add
                (local.get $cur)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 12)))))
            (br 1 (;@2;))))))
    (call $~lib/rt/itcms/__visit
      (local.get $entries)
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/function/Function<%28u64%2Cu64%29=>i32>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/rt/itcms/__visit
      (call $~lib/function/Function<%28u64%2Cu64%29=>i32>#get:_env
        (local.get 2))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/set/Set<u32>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $entries i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/rt/itcms/__visit
      (call $~lib/set/Set<u32>#get:buckets
        (local.get 3))
      (local.get $cookie))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entries
      (call $~lib/set/Set<u32>#get:entries
        (local.get 3)))
    (drop
      (i32.const 0))
    (call $~lib/rt/itcms/__visit
      (local.get $entries)
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/map/Map<u64_u32>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $entries i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (call $~lib/rt/itcms/__visit
      (call $~lib/map/Map<u64_u32>#get:buckets
        (local.get 3))
      (local.get $cookie))
    (local.set 3
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 3))
    (local.set $entries
      (call $~lib/map/Map<u64_u32>#get:entries
        (local.get 3)))
    (drop
      (i32.const 0))
    (call $~lib/rt/itcms/__visit
      (local.get $entries)
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/function/Function<%28u32%2Cu32%29=>i32>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 2
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 2))
    (call $~lib/rt/itcms/__visit
      (call $~lib/function/Function<%28u32%2Cu32%29=>i32>#get:_env
        (local.get 2))
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/map/Map<u32_~lib/array/Array<u32>>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $entries i32) (local $cur i32) (local $end i32) (local $entry i32) (local $val i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $~lib/rt/itcms/__visit
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:buckets
        (local.get 7))
      (local.get $cookie))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.set $entries
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entries
        (local.get 7)))
    (drop
      (i32.const 1))
    (local.set $cur
      (local.get $entries))
    (local.get $cur)
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (i32.mul
      (call $~lib/map/Map<u32_~lib/array/Array<u32>>#get:entriesOffset
        (local.get 7))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 12))))
    (local.set $end
      (i32.add))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $cur)
            (local.get $end))
          (then
            (local.set $entry
              (local.get $cur))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:taggedNext
                    (local.get $entry))
                  (i32.const 1)))
              (then
                (drop
                  (i32.const 0))
                (drop
                  (i32.const 1))
                (local.set $val
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<u32>>#get:value
                    (local.get $entry)))
                (drop
                  (i32.const 0))
                (call $~lib/rt/itcms/__visit
                  (local.get $val)
                  (local.get $cookie))))
            (local.set $cur
              (i32.add
                (local.get $cur)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 12)))))
            (br 1 (;@2;))))))
    (call $~lib/rt/itcms/__visit
      (local.get $entries)
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#__visit (type 0) (param $this i32) (param $cookie i32)
    (local $entries i32) (local $cur i32) (local $end i32) (local $entry i32) (local $val i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (call $~lib/rt/itcms/__visit
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:buckets
        (local.get 7))
      (local.get $cookie))
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (local.set $entries
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entries
        (local.get 7)))
    (drop
      (i32.const 1))
    (local.set $cur
      (local.get $entries))
    (local.get $cur)
    (local.set 7
      (local.get $this))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.get 7))
    (i32.mul
      (call $~lib/map/Map<u32_~lib/array/Array<~lib/string/String>>#get:entriesOffset
        (local.get 7))
      (block (result i32)  ;; label = @1
        (br 0 (;@1;)
          (i32.const 12))))
    (local.set $end
      (i32.add))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $cur)
            (local.get $end))
          (then
            (local.set $entry
              (local.get $cur))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:taggedNext
                    (local.get $entry))
                  (i32.const 1)))
              (then
                (drop
                  (i32.const 0))
                (drop
                  (i32.const 1))
                (local.set $val
                  (call $~lib/map/MapEntry<u32_~lib/array/Array<~lib/string/String>>#get:value
                    (local.get $entry)))
                (drop
                  (i32.const 0))
                (call $~lib/rt/itcms/__visit
                  (local.get $val)
                  (local.get $cookie))))
            (local.set $cur
              (i32.add
                (local.get $cur)
                (block (result i32)  ;; label = @4
                  (br 0 (;@4;)
                    (i32.const 12)))))
            (br 1 (;@2;))))))
    (call $~lib/rt/itcms/__visit
      (local.get $entries)
      (local.get $cookie))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4))))
  (func $~lib/rt/__newArray (type 5) (param $length i32) (param $alignLog2 i32) (param $id i32) (param $data i32) (result i32)
    (local $bufferSize i32) (local $buffer i32) (local $array i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $bufferSize
      (i32.shl
        (local.get $length)
        (local.get $alignLog2)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $buffer
        (call $~lib/rt/__newBuffer
          (local.get $bufferSize)
          (i32.const 1)
          (local.get $data))))
    (local.set $array
      (call $~lib/rt/itcms/__new
        (i32.const 16)
        (local.get $id)))
    (i32.store
      (local.get $array)
      (local.get $buffer))
    (call $~lib/rt/itcms/__link
      (local.get $array)
      (local.get $buffer)
      (i32.const 0))
    (i32.store offset=4
      (local.get $array)
      (local.get $buffer))
    (i32.store offset=8
      (local.get $array)
      (local.get $bufferSize))
    (i32.store offset=12
      (local.get $array)
      (local.get $length))
    (local.set 7
      (local.get $array))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 7)))
  (func $~lib/arraybuffer/ArrayBuffer#constructor (type 2) (param $this i32) (param $length i32) (result i32)
    (local $buffer i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.gt_u
        (local.get $length)
        (i32.const 1073741820))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 768)
          (i32.const 816)
          (i32.const 52)
          (i32.const 43))
        (unreachable)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $buffer
        (call $~lib/rt/itcms/__new
          (local.get $length)
          (i32.const 1))))
    (drop
      (i32.ne
        (i32.const 2)
        (global.get $~lib/shared/runtime/Runtime.Incremental)))
    (local.set 3
      (local.get $buffer))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 3)))
  (func $~lib/string/String.UTF8.decodeUnsafe (type 3) (param $buf i32) (param $len i32) (param $nullTerminated i32) (result i32)
    (local $bufOff i32) (local $bufEnd i32) (local $str i32) (local $strOff i32) (local $u0 i32) (local $u1 i32) (local $u2 i32) (local $lo i32) (local $hi i32) (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (local.set $bufOff
      (local.get $buf))
    (local.set $bufEnd
      (i32.add
        (local.get $buf)
        (local.get $len)))
    (if  ;; label = @1
      (i32.eqz
        (i32.ge_u
          (local.get $bufEnd)
          (local.get $bufOff)))
      (then
        (call $~lib/wasi_internal/wasi_abort
          (i32.const 0)
          (i32.const 288)
          (i32.const 770)
          (i32.const 7))
        (unreachable)))
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (local.tee $str
        (call $~lib/rt/itcms/__new
          (i32.shl
            (local.get $len)
            (i32.const 1))
          (i32.const 2))))
    (local.set $strOff
      (local.get $str))
    (block  ;; label = @1
      (loop  ;; label = @2
        (if  ;; label = @3
          (i32.lt_u
            (local.get $bufOff)
            (local.get $bufEnd))
          (then
            (local.set $u0
              (i32.load8_u
                (local.get $bufOff)))
            (local.set $bufOff
              (i32.add
                (local.get $bufOff)
                (i32.const 1)))
            (if  ;; label = @4
              (i32.eqz
                (i32.and
                  (local.get $u0)
                  (i32.const 128)))
              (then
                (if  ;; label = @5
                  (i32.and
                    (local.get $nullTerminated)
                    (i32.eqz
                      (local.get $u0)))
                  (then
                    (br 4 (;@1;))))
                (i32.store16
                  (local.get $strOff)
                  (local.get $u0)))
              (else
                (if  ;; label = @5
                  (i32.eq
                    (local.get $bufEnd)
                    (local.get $bufOff))
                  (then
                    (br 4 (;@1;))))
                (local.set $u1
                  (i32.and
                    (i32.load8_u
                      (local.get $bufOff))
                    (i32.const 63)))
                (local.set $bufOff
                  (i32.add
                    (local.get $bufOff)
                    (i32.const 1)))
                (if  ;; label = @5
                  (i32.eq
                    (i32.and
                      (local.get $u0)
                      (i32.const 224))
                    (i32.const 192))
                  (then
                    (i32.store16
                      (local.get $strOff)
                      (i32.or
                        (i32.shl
                          (i32.and
                            (local.get $u0)
                            (i32.const 31))
                          (i32.const 6))
                        (local.get $u1))))
                  (else
                    (if  ;; label = @6
                      (i32.eq
                        (local.get $bufEnd)
                        (local.get $bufOff))
                      (then
                        (br 5 (;@1;))))
                    (local.set $u2
                      (i32.and
                        (i32.load8_u
                          (local.get $bufOff))
                        (i32.const 63)))
                    (local.set $bufOff
                      (i32.add
                        (local.get $bufOff)
                        (i32.const 1)))
                    (if  ;; label = @6
                      (i32.eq
                        (i32.and
                          (local.get $u0)
                          (i32.const 240))
                        (i32.const 224))
                      (then
                        (local.set $u0
                          (i32.or
                            (i32.or
                              (i32.shl
                                (i32.and
                                  (local.get $u0)
                                  (i32.const 15))
                                (i32.const 12))
                              (i32.shl
                                (local.get $u1)
                                (i32.const 6)))
                            (local.get $u2))))
                      (else
                        (if  ;; label = @7
                          (i32.eq
                            (local.get $bufEnd)
                            (local.get $bufOff))
                          (then
                            (br 6 (;@1;))))
                        (local.set $u0
                          (i32.or
                            (i32.or
                              (i32.or
                                (i32.shl
                                  (i32.and
                                    (local.get $u0)
                                    (i32.const 7))
                                  (i32.const 18))
                                (i32.shl
                                  (local.get $u1)
                                  (i32.const 12)))
                              (i32.shl
                                (local.get $u2)
                                (i32.const 6)))
                            (i32.and
                              (i32.load8_u
                                (local.get $bufOff))
                              (i32.const 63))))
                        (local.set $bufOff
                          (i32.add
                            (local.get $bufOff)
                            (i32.const 1)))))
                    (if  ;; label = @6
                      (i32.lt_u
                        (local.get $u0)
                        (i32.const 65536))
                      (then
                        (i32.store16
                          (local.get $strOff)
                          (local.get $u0)))
                      (else
                        (local.set $u0
                          (i32.sub
                            (local.get $u0)
                            (i32.const 65536)))
                        (local.set $lo
                          (i32.or
                            (i32.shr_u
                              (local.get $u0)
                              (i32.const 10))
                            (i32.const 55296)))
                        (local.set $hi
                          (i32.or
                            (i32.and
                              (local.get $u0)
                              (i32.const 1023))
                            (i32.const 56320)))
                        (i32.store
                          (local.get $strOff)
                          (i32.or
                            (local.get $lo)
                            (i32.shl
                              (local.get $hi)
                              (i32.const 16))))
                        (local.set $strOff
                          (i32.add
                            (local.get $strOff)
                            (i32.const 2)))))))))
            (local.set $strOff
              (i32.add
                (local.get $strOff)
                (i32.const 2)))
            (br 1 (;@2;))))))
    (local.set 12
      (call $~lib/rt/itcms/__renew
        (local.get $str)
        (i32.sub
          (local.get $strOff)
          (local.get $str))))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (return
      (local.get 12)))
  (func $~lib/object/Object#constructor (type 1) (param $this i32) (result i32)
    (local i32)
    (global.set $~lib/memory/__stack_pointer
      (i32.sub
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (call $~stack_check)
    (i32.store
      (global.get $~lib/memory/__stack_pointer)
      (i32.const 0))
    (if  ;; label = @1
      (i32.eqz
        (local.get $this))
      (then
        (i32.store
          (global.get $~lib/memory/__stack_pointer)
          (local.tee $this
            (call $~lib/rt/itcms/__new
              (i32.const 0)
              (i32.const 0))))))
    (local.set 1
      (local.get $this))
    (global.set $~lib/memory/__stack_pointer
      (i32.add
        (global.get $~lib/memory/__stack_pointer)
        (i32.const 4)))
    (local.get 1))
  (table $0 4 4 funcref)
  (memory (;0;) 1)
  (global $~lib/as-wasi/assembly/as-wasi/Time.NANOSECOND (mut i32) (i32.const 1))
  (global $~lib/as-wasi/assembly/as-wasi/Time.MILLISECOND (mut i32) (i32.const 0))
  (global $~lib/as-wasi/assembly/as-wasi/Time.SECOND (mut i32) (i32.const 0))
  (global $src/sourcemap/BASE64_CHARS i32 (i32.const 32))
  (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
  (global $~lib/shared/runtime/Runtime.Minimal i32 (i32.const 1))
  (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
  (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
  (global $~argumentsLength (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/total (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/threshold (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/state (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/visitCount (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/pinSpace (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/iter (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/toSpace (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/white (mut i32) (i32.const 0))
  (global $~lib/rt/itcms/fromSpace (mut i32) (i32.const 0))
  (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
  (global $~lib/native/ASC_LOW_MEMORY_LIMIT i32 (i32.const 0))
  (global $~lib/native/ASC_RUNTIME i32 (i32.const 2))
  (global $src/index/args (mut i32) (i32.const 0))
  (global $src/index/sourceMapPath (mut i32) (i32.const 0))
  (global $src/index/watPath (mut i32) (i32.const 0))
  (global $src/index/offsetMapPath (mut i32) (i32.const 0))
  (global $src/index/sourceMapJson (mut i32) (i32.const 0))
  (global $~lib/builtins/u32.MAX_VALUE i32 (i32.const -1))
  (global $src/index/sourceMap (mut i32) (i32.const 0))
  (global $src/index/watText (mut i32) (i32.const 0))
  (global $src/index/offsetMapJson (mut i32) (i32.const 0))
  (global $src/index/offsetEntries (mut i32) (i32.const 0))
  (global $src/index/lineToOffset (mut i32) (i32.const 0))
  (global $src/index/cMap (mut i32) (i32.const 0))
  (global $~lib/builtins/i32.MAX_VALUE i32 (i32.const 2147483647))
  (global $~lib/string/String.MAX_LENGTH i32 (i32.const 536870910))
  (global $src/index/annotatedWat (mut i32) (i32.const 0))
  (global $~lib/rt/__rtti_base i32 (i32.const 2656))
  (global $~lib/memory/__data_end i32 (i32.const 2780))
  (global $~lib/memory/__stack_pointer (mut i32) (i32.const 35548))
  (global $~lib/memory/__heap_base i32 (i32.const 35548))
  (global $~started (mut i32) (i32.const 0))
  (export "memory" (memory 0))
  (export "_start" (func $~start))
  (elem $0 (i32.const 1) func $src/sourcemap/parseMappingsComparator $src/injector/compareCommentKeys $src/injector/compareU32)
  (data (;0;) (i32.const 12) "\9c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\80\00\00\00A\00B\00C\00D\00E\00F\00G\00H\00I\00J\00K\00L\00M\00N\00O\00P\00Q\00R\00S\00T\00U\00V\00W\00X\00Y\00Z\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\000\001\002\003\004\005\006\007\008\009\00+\00/\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;1;) (i32.const 172) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;2;) (i32.const 204) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00U\00n\00p\00a\00i\00r\00e\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00\00\00\00\00\00\00\00\00")
  (data (;3;) (i32.const 268) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00~\00l\00i\00b\00/\00s\00t\00r\00i\00n\00g\00.\00t\00s\00")
  (data (;4;) (i32.const 316) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
  (data (;5;) (i32.const 380) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;6;) (i32.const 448) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;7;) (i32.const 480) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;8;) (i32.const 508) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
  (data (;9;) (i32.const 572) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
  (data (;10;) (i32.const 624) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;11;) (i32.const 652) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;12;) (i32.const 720) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;13;) (i32.const 748) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00")
  (data (;14;) (i32.const 796) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s\00\00\00\00\00\00\00")
  (data (;15;) (i32.const 860) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
  (data (;16;) (i32.const 908) "\dc\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\c2\00\00\00U\00s\00a\00g\00e\00:\00 \00w\00a\00t\00n\00o\00t\00 \00<\00s\00o\00u\00r\00c\00e\00.\00w\00a\00s\00m\00.\00m\00a\00p\00>\00 \00<\00s\00o\00u\00r\00c\00e\00.\00w\00a\00t\00>\00 \00<\00s\00o\00u\00r\00c\00e\00.\00o\00f\00f\00s\00e\00t\00s\00.\00j\00s\00o\00n\00>\00 \00<\00s\00o\00u\00r\00c\00e\001\00.\00t\00s\00>\00 \00[\00s\00o\00u\00r\00c\00e\002\00.\00t\00s\00]\00 \00.\00.\00.\00\0a\00\00\00\00\00\00\00\00\00\00\00")
  (data (;17;) (i32.const 1136) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;18;) (i32.const 1168) "\00\00\00\00\00\00\00\00")
  (data (;19;) (i32.const 1184) "\00\00\00\00\00\00\00\00")
  (data (;20;) (i32.const 1200) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;21;) (i32.const 1216) "\00\00\00\00\00\00\00\00")
  (data (;22;) (i32.const 1228) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;23;) (i32.const 1356) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00r\00\00\00\00\00\00\00\00\00\00\00")
  (data (;24;) (i32.const 1388) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00r\00+\00\00\00\00\00\00\00\00\00")
  (data (;25;) (i32.const 1420) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00w\00\00\00\00\00\00\00\00\00\00\00")
  (data (;26;) (i32.const 1452) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00w\00x\00\00\00\00\00\00\00\00\00")
  (data (;27;) (i32.const 1484) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00w\00+\00\00\00\00\00\00\00\00\00")
  (data (;28;) (i32.const 1516) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00x\00w\00+\00\00\00\00\00\00\00")
  (data (;29;) (i32.const 1552) "\00\00\00\00\00\00\00\00")
  (data (;30;) (i32.const 1564) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\008\00\00\00E\00r\00r\00o\00r\00:\00 \00c\00o\00u\00l\00d\00 \00n\00o\00t\00 \00o\00p\00e\00n\00 \00f\00i\00l\00e\00:\00 \00\00\00\00\00")
  (data (;31;) (i32.const 1644) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;32;) (i32.const 1676) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00\0a\00\00\00\00\00\00\00\00\00\00\00")
  (data (;33;) (i32.const 1712) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;34;) (i32.const 1728) "\00\00\00\00\00\00\00\00")
  (data (;35;) (i32.const 1740) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;36;) (i32.const 1772) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\008\00\00\00E\00r\00r\00o\00r\00:\00 \00c\00o\00u\00l\00d\00 \00n\00o\00t\00 \00r\00e\00a\00d\00 \00f\00i\00l\00e\00:\00 \00\00\00\00\00")
  (data (;37;) (i32.const 1852) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00s\00o\00u\00r\00c\00e\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;38;) (i32.const 1900) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00\22\00\00\00\00\00\00\00\00\00\00\00")
  (data (;39;) (i32.const 1932) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00m\00a\00p\00p\00i\00n\00g\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;40;) (i32.const 1980) "\1c\00\00\00\00\00\00\00\00\00\00\00\0c\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
  (data (;41;) (i32.const 2012) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00\22\00m\00a\00p\00p\00i\00n\00g\00s\00\22\00\00\00\00\00\00\00\00\00")
  (data (;42;) (i32.const 2060) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00w\00a\00t\00L\00i\00n\00e\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
  (data (;43;) (i32.const 2108) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00o\00f\00f\00s\00e\00t\00")
  (data (;44;) (i32.const 2140) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00.\00/\00\00\00\00\00\00\00\00\00")
  (data (;45;) (i32.const 2172) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00W\00a\00r\00n\00i\00n\00g\00:\00 \00\00\00\00\00\00\00\00\00\00\00")
  (data (;46;) (i32.const 2220) "\5c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00F\00\00\00 \00n\00o\00t\00 \00f\00o\00u\00n\00d\00 \00i\00n\00 \00s\00o\00u\00r\00c\00e\00 \00m\00a\00p\00,\00 \00s\00k\00i\00p\00p\00i\00n\00g\00\0a\00\00\00\00\00\00\00")
  (data (;47;) (i32.const 2316) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00K\00e\00y\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t\00\00\00\00\00\00\00\00\00")
  (data (;48;) (i32.const 2380) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00~\00l\00i\00b\00/\00m\00a\00p\00.\00t\00s\00\00\00\00\00\00\00")
  (data (;49;) (i32.const 2428) "\1c\00\00\00\00\00\00\00\00\00\00\00\18\00\00\00\08\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00")
  (data (;50;) (i32.const 2460) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00/\00/\00\00\00\00\00\00\00\00\00")
  (data (;51;) (i32.const 2492) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00;\00;\00\00\00\00\00\00\00\00\00")
  (data (;52;) (i32.const 2524) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00/\00*\00\00\00\00\00\00\00\00\00")
  (data (;53;) (i32.const 2556) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00*\00/\00\00\00\00\00\00\00\00\00")
  (data (;54;) (i32.const 2588) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00;\00;\00 \00\00\00\00\00\00\00")
  (data (;55;) (i32.const 2620) "\1c\00\00\00\00\00\00\00\00\00\00\00\1b\00\00\00\08\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00")
  (data (;56;) (i32.const 2656) "\1e\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\02A\00\00\00\00\00\00\02\09\00\00B\00\00\00\00\00\00\00 \00\00\00\02A\00\00 \00\00\00\00\00\00\00 \00\00\00\02A\00\00 \00\00\00\10\01\02\00\10A\04\00\00\00\00\00\02A\00\00\08\02\00\00\02\01\00\00\02\02\00\00\10A\02\00\00\00\00\00\08\01\00\00\10\01\04\00\00\00\00\00\10A\02\00\10A\02\00"))