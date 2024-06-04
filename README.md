# typst-iaik-thesis-template

This is a Typst template for a Master's Thesis at IAIK TU Graz

## Usage

You can use this template by using the `typst` command to init a new project based on this template.
For this to work, clone the this repo into `~/.local/share/typst/packages/local/iaik-thesis/0.1.0`

```bash
typst init @local/iaik-thesis:0.1.0
```

Typst will create a new directory with all the files needed to get you started.

## Configuration

The template will initialize your package with a sample call to the `thesis` function in a show rule.

```typ
#import "@local/iaik-thesis:0.1.0": *

#show: thesis.with(
  title: "Title and \nSubtitle\nof the Thesis",
  author: "Firstname Lastname, BSc",
  degree: "Diplom-Ingenieur",
  curriculum: "Computer Science",
  supervisors: (
    "Firstname Lastname, academic degrees of first supervisor",
    "Firstname Lastname, academic degrees of next supervisor",
  ),
)

// Your content goes below.
```
