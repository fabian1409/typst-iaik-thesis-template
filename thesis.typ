#import "template/lib.typ": *

#show: thesis.with(
  title: "Some Awesome Title",
  author: "John Doe, BSc",
  curriculum: "Computer Science",
  supervisors: (
    "Univ.-Prof. Dipl.-Ing. Dr.techn. John Doe",
    "Dipl.-Ing. John Doe",
  ),
)

#init-acronyms(
  (
    "NN": ("Neural Network"),
    "OS": ("Operating System",),
    "BIOS": ("Basic Input/Output System", "Basic Input/Output Systems"),
  )
)

#heading(level: 1, outlined: false, numbering: none, "Abstract")

#lorem(100)

#table-of-contents()

#list-of-figures()

#list-of-listings()

= One

#lorem(30)
#cite(<doe2024dummy>)

#code-block(```rust
fn main() {
    println!("Hello World!");
}
```, caption: "Rust Hello World")

== Two

#lorem(30)
#code(```rust println!("Hello World!")```)


=== Three

Numbered list:
+ First
+ Second
+ Third

Bullet list:
- First
- Second
- Third

==== Four

#lorem(30)
#acr("NN")

= Five

#lorem(30)

#figure(image("figures/logo.svg"), caption: "Logo")

#lorem(30)

== Six

#lorem(30)

Math equations:

$
  s = sum_(i=1)^n i \
$

Tables:

#figure(
  table(
    columns: 2,
    [*Amount*], [*Name*],
    [360], [Foo],
    [250], [Bar Baz],
  ),
  caption: "Table example"
)

#list-of-acronyms()

#bibliography("thesis.bib")
