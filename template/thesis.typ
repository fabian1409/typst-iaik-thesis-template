#import "@local/iaik-thesis:0.1.0": *

#show: thesis.with(
  title: "Title and\nSubtitle\nof the Thesis",
  author: "Firstname Lastname, BSc",
  curriculum: "Computer Science",
  supervisors: (
    "Firstname Lastname, academic degrees of first supervisor",
    "Firstname Lastname, academic degrees of next supervisor",
  ),
  acknowledgments: [
    I want to take this opportunity to thank my supervisors, especially Fabian Schmid, who answered countless questions and gave me valuable feedback during the last year.

    Furthermore, I want to thank Franco Nieddu, who inspired me to take on this topic and helped me when I was stuck with a particular problem or design choice during development.

    Finally, I want to thank everyone who supported me during my studies and while working on this thesis.
  ],
  abstract: [
    #lorem(100)

    #v(10pt)

    *Keywords.*
    #h(8pt)
    #("Broad keyword", "Keyword", "Specific keyword", "Another specific keyword").join([ $dot$ ])
  ],
  abstract_de: [   
    #lorem(100)

    #v(10pt)

    *Schlagwörter.*
    #h(8pt)
    #("Broad keyword", "Keyword", "Specific keyword", "Another specific keyword").join([ $dot$ ])
  ],
  acronyms: (
    "NN": "Neural Network",
    "OS": "Operating System",
    "BIOS": "Basic Input/Output System",
  ),
)


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
