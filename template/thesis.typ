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
    "NN": "Neural Network",
    "OS": "Operating System",
    "BIOS": "Basic Input/Output System",
  ),
)

#let listing(caption: none, label: none, body) = [
  #figure(
    box(
      align(left, [
        #show raw.line: it => {
          text(fill: gray)[#it.number]
          h(1em)
          it.body
        }
        #body
      ]), width: 100%, stroke: (left: .5pt), inset: 10pt, fill: white.darken(0%),
    ), caption: caption, kind: "listing", supplement: [Listing],
  )
  #label
]

= Introduction <introduction>

#lorem(200)

*Outline.*
#lorem(30)

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

=== Listing

#listing(
  ```rust
  fn main() {
      println!("Hello World!");
  }
  ```,
  caption: "Rust Hello World", label: <code>
)

=== Inline

This is some inline code ```rust println!("Hello World!")```.

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
