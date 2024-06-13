.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 58
# =======================================================
dot:
  li t0, 1
  blt a2, t0, exception1   # if length < 1, go to exit
  blt a3, t0, exception2
  blt a4, t0, exception2
  # Prologue
  addi sp, sp, -4
  sw ra, 0(sp)

start_loop:
  li t0, 0 # counter
  li t1, 0 # result
  li t5, 4 # word size

  mul a3, a3, t5
  mul a4, a4, t5

loop:
  beq t0, a2, return
  lw t3, 0(a0)
  lw t4, 0(a1)
  mul t2, t3, t4
  add t1, t1, t2

  # update counters
  add a0, a0, a3
  add a1, a1, a4
  addi t0, t0, 1

  j loop

return:
  lw ra, 0(sp)
  mv a0, t1
  addi sp, sp, 4
  ret

exception1:
  li a1 57
  call exit2

exception2:
  li a1 58
  call exit2
