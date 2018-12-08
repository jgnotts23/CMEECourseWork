#include <stdlib.h>

struct node {
    struct node* left_desc;
    struct node* right_desc;
    struct node* ancestor;
};

struct polynode {
    struct polynode** descendants;
    struct polynode* ancestor;
    int n_descendants;
};

struct polynode* create_polynode(int numdescs)
{
    
}

void traverse_polynode(struct polynode* n)
{
    int i = 0
    for (i = 0; i < n->n_descendants; ++i) {
        if (n-> descendants[i] != NULL) {
            traverse_polynode(n->descendants[i]);
        }
    }
}

void traverse_tree(struct node* n)
{
    if (n->left_desc != NULL) {
        traverse_tree(n->left_desc);
    }
}