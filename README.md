# Tree View package TypeScript Version [![Build Status](https://travis-ci.org/atom/tree-view.svg?branch=master)](https://travis-ci.org/atom/tree-view)

When using TypeScript, the compiled `.js` files messes up the whole directory.

This is my attempt to fix that problem.

Currently, ts-tree-vew adds list-virtual-nest class to the generated `.js` files.

By [applying custom css](https://atom.io/docs/latest/using-atom-basic-customization#style-tweaks) to core atom stylesheets,

````
li.list-virtual-nest span{
  padding-left:17px !important;
  color: rgb(85, 85, 85);
}
````

I was able to achieve this:

![Attempt 1](./images/attempt1.png?raw=true "Title")
