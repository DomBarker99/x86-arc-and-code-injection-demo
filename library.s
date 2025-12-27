.global move_input
.global replace_all
.text
# Moves memory from target address to destination address until 0x00 is seen in target
# |PARAMS|
# 8(%ebp) target addres
# 12(%ebp) destination address
move_input:

    pushl   %ebp
    movl    %esp, %ebp

    movl    8(%ebp), %esi
    movl    12(%ebp), %edi

    move_input_loop:
        movzx   (%esi), %eax
        movb    %al, (%edi)

        incl    %esi
        incl    %edi

        cmpb    $0x00, (%esi)
        jne     move_input_loop

    # Perform final move of null terminator
    movzx   (%esi), %eax
    movb    %al, (%edi)

    leave
    ret

# Replace all target characters with the destination characters until 0x00 is seen
# |PARAMS|
# 8(%ebp) Target char
# 12(%ebp) Replacement char
# 16(%ebp) Address to read from
replace_all:

    pushl   %ebp
    movl    %esp, %ebp

    movl    16(%ebp), %esi
    movl    8(%ebp), %eax
    movl    12(%ebp), %ebx

    replace_all_loop:

        cmpb    %al, (%esi)             # Check to see if current char = target char
        jne     no_match                # Move onto next char if no match

        movb    %bl, (%esi)             # Replace char if there is a match

        no_match:
            incl    %esi                # ++i
            cmpb    $0x00, (%esi)       # Check to see if end of string has been reached
            jne     replace_all_loop    # If end hasn't been reached, keep looping

    leave
    ret




















