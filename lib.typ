#import "acronyms.typ": *

// thesis template
#let thesis(
  title: "Title and \nSubtitle\nof the Thesis",
  author: "Firstname Lastname, BSc",
  degree: "Degree",
  curriculum: "Curriculum",
  supervisors: (
    "Firstname Lastname, academic degrees of first supervisor",
    "Firstname Lastname, academic degrees of next supervisor",
  ),
  date: datetime.today(),
  body
) = {
  set document(title: title.split("\n").join(" "), author: author)

  set text(size: 11pt, font: "New Computer Modern", hyphenate: false)

  set cite(style: "alphanumeric")

  // title page

  set page(margin: (bottom: 2.75cm))

  set align(center)

  image("logo.svg", width: 20%)

  v(2cm)

  block(text(size: 14pt, author), below: 1.75cm)

  block(text(size: 16pt, weight: "bold", title))

  set align(center + bottom)
  [
    #set par(leading: 9pt)
    #text(size: 12pt, weight: "bold", "MASTER'S THESIS") \
    #text("to achieve the university degree of\n" + degree) \
    #text("Master's degree programme: " + curriculum)    
  ]

  v(1cm)

  block(text(size: 10pt, "submitted to"))
  block(text(weight: "bold", "Graz University of Technology"))
  v(1.1cm)

  if supervisors.len() > 1 {
    block(text(size: 10pt, weight: "bold", "Supervisors"))
  } else {
    block(text(size: 10pt, weight: "bold", "Supervisor"))
  }

  for supervisor in supervisors [
    #text(size: 10pt, supervisor) \
  ]

  block(text(size: 10pt, "Institute of Applied Information Processing and Communications"), below: 1.75cm)

  box(text(
    size: 8pt, [Graz, #date.display("[month repr:long] [year]")],
  ))

  // style rules

  set align(top + left)

  set page(margin: (left: 3cm, right: 3cm, top: 3.75cm, bottom: 5.5cm))

  set par(justify: true)

  set block(below: 2em)

  set math.equation(numbering: "(1.1)")

  set figure(gap: 15pt)

  set enum(indent: 1em, numbering: "1)a)i)")

  set list(indent: 1em)

  set heading(numbering: "1.1 ")

  set page(header: context {
    // find heading of level 1 on current page
    let chapter = query(heading.where(level: 1), here()).find(h => h.location().page() == here().page())
    // if not chapter begin print current chapter in header
    if chapter == none {
      let elems = query(selector(heading.where(level: 1)).before(here()))
      if elems.len() != 0 {
        align(center, text(style: "italic", "Chapter " + counter(heading.where(level: 1)).display("1") + " " + elems.last().body))
      }
    }
  })

  // set ref of level 1 heading to Chapter
  show heading.where(level: 1): set heading(supplement: [Chapter])

  show heading.where(level: 1): it => {
    pagebreak()
    v(1.75cm)
    let count = counter(heading).get()
    if it.body != [Bibliography] and count.first() > 0 {
      text(size: 20pt, "Chapter " + counter(heading).display("1"))
      v(0pt)
      text(size: 20pt, it.body)
    } else {
      text(size: 20pt, it)
    }
    v(20pt)
  }

  show heading.where(level: 2): it => {
    text(size: 14pt, it)
    v(10pt)
  }

  show heading.where(level: 3): it => {
    text(size: 12pt, it)
    v(8pt)
  }

  show heading.where(level: 4): it => {
    text(size: 11pt, it)
    v(8pt)
  }

  body
}

// abstract

#let abstract(body) = {
  heading(level: 1, outlined: false, numbering: none, "Abstract")
  body
}

// table of contents

#let table-of-contents() = [
  #let show-entry(entry, label: <modified-entry>) = {
    if entry.at("label", default: none) == label {
      entry // prevent infinite recursion
    } else {
      set text(weight: "bold") if entry.level == 1
      if entry.level == 1 { v(18pt, weak: true) }
      let fields = entry.fields()
      let fill = if entry.level != 1 { repeat[~~.] }
      fields.fill = box(width: 100% - .4cm, fill)
      [#outline.entry(..fields.values()) #label]
    }
  }
  #show outline.entry: show-entry
  #outline(indent: auto, depth: 3)
]

#let list-show-entry(entry, label: <modified-entry>) = {
  if entry.at("label", default: none) == label {
    entry // prevent infinite recursion
  } else {
    if entry.level == 1 { v(12pt, weak: true) }
    let fields = entry.fields()
    let fill = repeat[~~.]
    fields.fill = box(width: 100% - .4cm, fill)
    [#outline.entry(..fields.values()) #label]
  }
}

#let list-of-figures() = [
  #show outline.entry: list-show-entry
  #outline(title: "List of Figures", target: figure.where(kind: image))
]

#let list-of-tables() = [
  #show outline.entry: list-show-entry
  #outline(title: "List of Tables", target: figure.where(kind: table))
]

#let list-of-listings() = [
  #show outline.entry: list-show-entry
  #outline(title: "List of Listings", target: figure.where(kind: "listing"))
]

// code

#let code-block(caption: "Listing", label: none, body) = [
  #show raw.line: it => {
    text(fill: gray)[#it.number]
    h(1em)
    it.body
  }
  #figure(
    box(
      align(left, body), width: 100%, stroke: (left: .5pt), inset: 10pt, fill: white.darken(0%),
    ), caption: caption, kind: "listing", supplement: [Listing],
  ) #label
]

#let code(content) = box(content)

// acknowledgements

#let acknowledgements(body) = {
  heading(level: 1, outlined: false, numbering: none, "Acknowledgements")
  body
}

// affidavit

#let affidavit() = [
  #pagebreak()
  #set align(horizon)

  #align(center, text(weight: "bold", "AFFIDAVIT"))
  #v(0.5cm)

  #block(inset: (left: 1cm, right: 1cm))[
    I declare that I have authored this thesis independently, that I have not used other than the declared sources/resources, and that I have explicitly indicated all material which has been quoted either literally or by content from the sources used.
    The text document uploaded to TUGRAZonline is identical to
    the present master’s thesis.

    #v(2.5cm)

    #line(length: 100%, stroke: .5pt)
    #v(-.2cm)
    #align(center, text(size: 8pt, "Date, Signature"))
  ]
]
