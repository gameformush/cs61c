#include "ll_cycle.h"
#include <stddef.h>

int ll_has_cycle(node *head) {
  /* your code here */
  node *slow = head;
  node *fast = head;

  while (fast != NULL && fast->next != NULL) {
    slow = slow->next;
    fast = fast->next->next;

    if (fast == slow) {
      return 1;
    }
  }

  return 0;
}
