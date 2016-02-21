# Tree View package TypeScript Version

When using TypeScript, the compiled `.js` files messes up the whole directory.

This is my attempt to fix that problem.

Currently, ts-tree-view adds list-virtual-nest class to the generated `.js` files.

By [applying custom css](https://atom.io/docs/latest/using-atom-basic-customization#style-tweaks) to core atom stylesheets,

````
li.list-virtual-nest span{
  padding-left:17px !important;
  color: rgb(85, 85, 85);
}
````

I was able to achieve this:

![Attempt 1](./images/attempt1.png?raw=true "Title")

### Install

Clone the repo
`git clone git@github.com:your-username/tree-view.git`

Go into the directory
`cd tree-view`

Install dependencies
`apm install`

Go to workingDirectory
`atom . --dev`

OR

![Dev Mode](./images/dev mode.png?raw=true "Title")
