#import "@local/iaik-thesis:0.1.0": *

#show: thesis.with(
  title: "Title and\nSubtitle\nof the Thesis",
  author: "Firstname Lastname, BSc",
  degree: "Diplom-Ingenieur",
  curriculum: "Computer Science",
  supervisors: (
    "Firstname Lastname, academic degrees of first supervisor",
    "Firstname Lastname, academic degrees of next supervisor",
  ),
  acknowledgements: [
    #lorem(200)
  ],
  abstract: [
    #lorem(200)
  ],
  keywords: ("Broad keyword", "Keyword", "Specific keyword", "Another specific keyword"),
  acronyms: (
    "NN": ("Neural Network"),
    "OS": ("Operating System",),
    "BIOS": ("Basic Input/Output System", "Basic Input/Output Systems"),
  ),
)

= Introduction <introduction>

#lorem(200)

#paragraph("Outline")[
  #lorem(30)
]

= Background <background>

#lorem(200)

#pagebreak()

#lorem(200)

= Conclusion <conclusion>

#lorem(200)

= Showcase

This is how to cite references #cite(<doe2024dummy>).
This is how to refernce labels @introduction, @equation, @table, @code, @image
This is how to use acronyms #acr("NN").

== Code

Some examples of code blocks and inline code with highlighting.

=== Block

#code-block(caption: "Rust Hello World", label: <code>,
```rust
fn main() {
    println!("Hello World!");
}
```)

=== Inline

This is some inline code #code(```rust println!("Hello World!")```).

== Lists

Numbered list:
+ First
+ Second
+ Third

Bullet list:
- First
- Second
- Third

= Figures

#lorem(30)

== Images

#figure(image("figures/logo.svg", width: 30%), caption: "Logo") <image>

== Tables

#figure(
  table(
    columns: 2,
    [*Amount*], [*Name*],
    [360], [Foo],
    [250], [Bar Baz],
  ),
  caption: "Table example"
) <table>

== Math

$
  "sum" &= sum_(i=1)^n i \
  t_(n+1) &= t_n + 1/2 * a^2
$ <equation>


#bibliography("thesis.bib")
