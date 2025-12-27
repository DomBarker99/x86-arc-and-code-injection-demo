.global main
# Compiled w/ gcc grocerylist.s library.s -o grocerylist.exe -g
# ./grocerylist.exe < ./Payloads/CodeInjectPayloads/InfiniteLoopPayload.bin
# ./grocerylist.exe < ./Payloads/OutputPayloads/HeaderPayload1.bin
# ./grocerylist.exe < ./Payloads/OutputPayloads/HeaderPayload2.bin
.data
    # 144 Bytes
    user_input:2
        .space  144, 0x2E

    # 65 Bytes
    user_prompt:
        .asciz  "Enter in 0-9 and then list items EX: 4 Buns Cheese Sauce Lettuce"

    # 13
    grocery_header:
        .asciz  "GROCERY LIST"

.text

main:
    pushl   $user_prompt
    call    puts
    addl    $4, %esp

    pushl   $user_input
    call    gets
    addl    $4, %esp

    call    generate_list

    ret

generate_list:
    # Prologue
    pushl   %ebp
    movl    %esp, %ebp

    movzx   user_input, %eax    # Store the first byte of input in %eax
    subl    $'0', %eax          # Convert to an integer
    sall    $4, %eax            # Multiply by 16 to get the total amount of space for new output
    subl    %eax, %esp          # Allocate space on stack for output

    # Move the global var on stack.
    pushl   %esp                # Push address of where to write to
    pushl   $user_input+2       # Push address of where to read input from
    call    move_input          # Call function to move input
    addl    $8, %esp            # Reclaim stack space

    # Convert the local var to print each item on a newline, (replace 0x20 w/ 0x0A)
    pushl   %esp
    pushl   $0x0000000A
    pushl   $0x00000020
    call    replace_all
    addl    $12, %esp

    pushl   $grocery_header
    call    puts
    addl    $4, %esp

    pushl   %esp
    call    puts
    addl    $4, %esp

    generate_list_exit:
        leave
        ret
