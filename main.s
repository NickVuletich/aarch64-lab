
// TO RUN
// clang -arch arm64 main.s -o main
// ./main
// echo $?


.section __TEXT,__text
.globl _main
.p2align 2 

.extern _write
.extern _exit

_main:
    //write(1, msg, msg_len)
    mov     x0, #1                  // fd = 1 (stdout)
    adrp    x1, msg@PAGE            // x1 = &msg (page)
    add     x1, x1, msg@PAGEOFF     // x1 = &mgs (page offset)
    mov     x2, #msg_len            // count
    bl      _write                  // call write(fd, buf, len)
    
    //exit(0)
    mov     x0, #0
    bl      _exit

// C-string data (bytes)

.section __TEXT,__cstring
msg:
    .ascii "Hello from AArch64 on macOS\n"
msg_len = . - msg

// Notes 
// # means number so #1 puts that value in the register
//
// bl = branch with link  
//      Save return address in register x30 (link register)
//      Jump to _write 
//      When _write finishes → it returns to your code
// adrp = address of page 
//      adrp x1, msg@PAGE // This loads the memory page containing msg.
//      