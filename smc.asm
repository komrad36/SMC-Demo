EXTERN VirtualProtect: PROC
.CODE
TestSmc PROC
  sub rsp, 40

  ; call VirtualProtect to grant us write access to the SMC region

  ; BOOL VirtualProtect(LPVOID lpAddress, SIZE_T dwSize, DWORD flNewProtect, PDWORD lpflOldProtect)
  lea r9, [rsp+48]
  mov r8d, 64
  mov edx, (SMC_REGION_END-SMC_REGION_START)
  lea rcx, SMC_REGION_START
  call VirtualProtect

  ; replace the SMC region with "mov al, 1"
  mov word ptr [SMC_REGION_START], 001b0h

  ; on non-x86 platforms this should be followed by a call to FlushInstructionCache,
  ; but this is not necessary on x86.

  SMC_REGION_START:
  xor al, al
  SMC_REGION_END:

  add rsp, 40
  ret
TestSmc ENDP
END
