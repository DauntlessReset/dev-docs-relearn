---
title: Git Tips
description: Tips and advice for using Git
---


### **Keep commits focused on a discrete task**

To aid development and to ensure that commit messages are concise, it is strongly recommended that each commit is contained to a single issue, such as fixing a bug or implementing something distinct. Refer to the commit message conventions for further information. 

### **Merging in collaborative projects should be done in Github via pull**

When merging changes into main/master, you should do this via Github instead of merging remotely and pushing the commit to remote. This is so your colleagues have a chance to examine your changes, provide any feedback and catch and issues that may exist. 

***Please note that while this is normal practice, due to our small team, we do not follow this convention.***

### **Fetch early and often**

Use **git fetch -p** or **git fetch --prune** to update your remote tracking branches often to ensure you know what's in remote and whether to delete any unnecessary local branches. This helps prevent merge hell later on. 

### **File naming conventions**

To avoid issues arising from conflicting systems and their sensitivities surrounding lowercase vs uppercase (Windows and Mac/Linux systems handle this differently) it is best to simply avoid using capital letters in file names. Additionally, avoid spaces, instead using hyphens in their stead, e.g. "my-git-repository/the-git-page.md". 

### **Good Commit Messages**

- Invoke the ```git commit``` command with no flags. This will bring up your default editor so you can make a longer, more meaningful commit message with the benefits of formatting. 
- Focus on the *why* of the change, not the *how* or the *what*. 

**Header**

- Always use the imperative mood e.g. "update documentation", "fix intermittent bug when logging in"
- All in lowercase except for acronyms and proper nouns 
- Example format:

| TYPE  | COMMIT MESSAGE                          | TICKET #|
|:-----:|:---------------------------------------:|:--------|
| feat: | update CSS style names to be consistent | (#6174) |

**feat**: use this when introducing a new feature or enhancement

**fix**: use this when fixing a bug

**docs**: use this to describe a documentation change

**chore**: use this when you make a change that affects tooling, like Git (e.g. modifying the .gitignore file)

**test**: use this when you introduce or modify tests

**Body**

- Add a blank line separating the header from the body. 
- Each list item is prefixed with a hyphen. 
- Each line item is a sentence with a capital letter, and punctuation if necessary

