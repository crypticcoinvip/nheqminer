format MS64 COFF
; format PE64 console DLL
; entry DllEntryPoint

public _ProcEhPrepare as 'EhPrepareAVX2'
public _ProcEhSolver as 'EhSolverAVX2'

include 'INCLUDE\win64a.inc'
include 'params.inc'
include 'struct_eh.inc'
include 'macro_eh.asm'

section '.text' code readable executable align 64

; proc DllEntryPoint hinstDLL,fdwReason,lpvReserved
; 	mov	eax,TRUE
; 	ret
; endp

include "proc_ehprepare_avx2.asm"
include "proc_ehsolver_avx2.asm"

section '.data' data readable writeable align 64

include "data_blake2b.asm"

; section '.edata' export data readable

;     export 'xenoncat_AVX2.dll',\
; 	   _ProcEhPrepare,'EhPrepare',\
; 	   _ProcEhSolver,'EhSolver'

; section '.reloc' fixups data readable discardable

;    if $=$$
; 		dd 0,8		; if there are no fixups, generate dummy entry
;    end if

