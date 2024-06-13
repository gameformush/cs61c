.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# ==============================================================================
relu:
  li t0, 1
  blt a1, t0, error # check len

  addi sp, sp, -4 # stack push
  sw ra, 0(sp)

  li t0, 0 # index
  li t1, 4 # word size

loop:
  blt t0, a1, 8 # i < len
  j return

  # array[i]
  lw t2, 0(a0)

  blt zero, t2, 8 # 0 < array[i]
  sw zero, 0(a0)

  addi t0, t0, 1 # i++
  add a0, a0, t1
  j loop

return:
 lw ra, 0(sp)
 addi sp, sp, 4
 ret

error:
  li a1, 57
  li a0, 17
  ecall
