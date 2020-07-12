struct seq 
{ 
    int num; 
    struct seq *then; 
}; 


// ReturnType:      struct seq *
// ArgumentList:    const char *

struct seq a[] = { f2("Du kannst das!") };

// RetunType:       struct seq 
// ArgumentList:    struct seq 
struct seq * b = f3(a[0]).then;