.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# =================================================================
argmax:
  li t0, 1
  blt a1, t0, exception    # if a1 < 1, go to exit
  addi sp, sp, -4
  sw ra, 0(sp)

start:
  li t0, 0 # counter
  lw t1, 0(a0) # max
  li t2, 0 # max index

loop:
  beq t0, a1, return

  lw t3, 0(a0) # currrent element
  blt t1, t3, update

loop_increament:
  addi t0, t0, 1
  addi a0, a0, 4
  j loop

update:
  mv t2, t0
  mv t1, t3
  j loop_increament

return:
  lw ra, 0(sp)
  addi sp, sp, 4
  mv a0, t2
  ret

exception:
  li a1 57
  call exit2
