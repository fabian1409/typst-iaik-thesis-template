#let thesis(
  title: "Thesis Title",
  author: "Author",
  curriculum: "Curriculum",
  supervisors: (), 
  body
) = {
  set document(title: title, author: author)

  set text(size: 11pt, font: "New Computer Modern")

  set cite(style: "alphanumeric")

  // title page

  set page(margin: (bottom: 5.5cm))

  set align(center)

  let sq = box(
    width: 10pt, height: 6pt, align(center, square(size: 2.5pt, fill: black)),
  )

  grid(
    columns: (20%, 60%, 20%), align: (left, center + horizon, right + horizon), image("iaik.svg", width: 30%), text(
      size: 8pt, font: "Noto Sans", tracking: 3.5pt, [SCIENCE #sq PASSION #sq TECHNOLOGY],
    ), image("logo.svg", width: 100%),
  )


  box(text(size: 14pt, author))

  v(1.25cm)

  box(text(size: 18pt, weight: "bold", title))

  set align(center + bottom)

  block(text(size: 14pt, weight: "bold", "PROJECT"))

  block(text(size: 12pt, "Master's degree programme: " + curriculum))

  v(1.25cm)

  block(text(size: 12pt, weight: "bold", "Supervisors"))

  for supervisor in supervisors [
    #supervisor \
  ]

  block(text(
    "Institute of Applied Information Processing and Communications\nGraz University of Technology"
  ))

  v(1.5cm)

  box(text(
    size: 10pt, [Graz, #datetime.today().display("[month repr:long] [year]")],
  ))

  set align(top + left)

  set page(
    margin: (left: 3cm, right: 3cm, top: 5.5cm, bottom: 5.5cm), numbering: "1",
  )

  // doc rules
  set math.equation(numbering: "(1.1)")
  set figure(gap: 20pt)
  show figure: it => {
    pad(top: 1em, bottom: 1em, it)
  }

  set enum(indent: 1em, numbering: "1)a)i)")
  set list(indent: 1em)

  set heading(numbering: (..n) => {
    if n.pos().len() < 4 {
      numbering("1.1", ..n)
    }
  })

  show heading.where(level: 1): it => {
    pagebreak()
    text(size: 18pt, it)
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
    text(size: 12pt, it)
    v(8pt)
  }

  body
}

// table of contents

#let table-of-contents() = [
  #let show-entry(entry, label: <modified-entry>) = {
    if entry.at("label", default: none) == label {
      entry // prevent infinite recursion
    } else {
      set text(weight: "bold") if entry.level == 1
      if entry.level == 1 { v(12pt, weak: true) }
      let fields = entry.fields()
      let fill = if entry.level != 1 { repeat[~~.] }
      fields.fill = box(width: 100% - .4cm, fill)
      [#outline.entry(..fields.values()) #label]
    }
  }
  #show outline.entry: show-entry
  #outline(indent: auto, depth: 3)
]

// list of tables/fiures

#let list-of-figures() = [
  #let show-entry(entry, label: <modified-entry>) = {
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
  #show outline.entry: show-entry
  #outline(title: "List of Figures", target: figure.where(kind: image).or(figure.where(kind: table)))
]

// list of code listings

#let list-of-listings() = [
  #let show-entry(entry, label: <modified-entry>) = {
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
  #show outline.entry: show-entry
  #outline(title: "List of Listings", target: figure.where(kind: "listing"))
]

// code

#let code-block(body, caption: "Listing") = [
  #show raw.line: it => {
    text(fill: gray)[#it.number]
    h(1em)
    it.body
  }
  #figure(
    box(
      align(left, body), width: 100%, stroke: (left: .5pt), inset: 10pt, fill: white.darken(0%),
    ), caption: caption, kind: "listing", supplement: [Listing],
  )
]

#let code(content) = box(content)

// aronyms

#let prefix = "acronym-state-"
#let acros = state("acronyms", none)
#let init-acronyms(acronyms) = {
  acros.update(acronyms)
}

// Display acronym as clickable link
#let display-link(acr, text) = {
  link(label(acr), text)
}

// Display acronym
#let display(acr, text, link: true) = {
  if link { display-link(acr, text) } else { text }
}

// Display acronym in short form.
#let acrs(acr, plural: false, link: true) = {
  if plural { display(acr, acr + "s", link: link) } else { display(acr, acr, link: link) }
}
// Display acronym in short plural form
#let acrspl(acr, link: true) = { acrs(acr, plural: true, link: link) }

// Display acronym in long form.
#let acrl(acr, plural: false, link: true) = {
  acros.display(
    acronyms => {
      let defs = acronyms.at(acr)
      if type(defs) == "string" {
        if plural {
          display(acr, defs + "s", link: link)
        } else {
          display(acr, defs, link: link)
        }
      } else if type(defs) == "array" {
        if defs.len() == 0 {
          panic(
            "No definitions found for acronym " + acr + ". Make sure it is defined in the dictionary passed to #init-acronyms(dict)",
          )
        }
        if plural {
          if defs.len() == 1 {
            display(acr, defs.at(0) + "s", link: link)
          } else if defs.len() == 2 {
            display(acr, defs.at(1), link: link)
          } else {
            panic(
              "Definitions should be arrays of one or two strings. Definition of " + acr + " is: " + type(defs),
            )
          }
        } else {
          display(acr, defs.at(0), link: link)
        }
      }
    },
  )
}
// Display acronym in long plural form.
#let acrlpl(acr, link: true) = { acrl(acr, plural: true, link: link) }

// Display acronym for the first time.
#let acrf(acr, plural: false, link: true) = {
  if plural {
    display(acr, [#acrlpl(acr) (#acr\s)], link: link)
  } else {
    display(acr, [#acrl(acr) (#acr)], link: link)
  }
  state(prefix + acr, false).update(true)
}

// Display acronym in plural form for the first time.
#let acrfpl(acr, link: true) = { acrf(acr, plural: true, link: link) }

// Display acronym. Expands it if used for the first time.
#let acr(acr, plural: false, link: true) = {
  state(prefix + acr, false).display(seen => {
    if seen {
      if plural { acrspl(acr, link: link) } else { acrs(acr, link: link) }
    } else {
      if plural { acrfpl(acr, link: link) } else { acrf(acr, link: link) }
    }
  })
}

// Display acronym in the plural form. Expands it if used for the first time.
#let acrpl(acronym, link: true) = { acr(acronym, plural: true, link: link) }

// Print an index of all the acronyms and their definitions.
#let list-of-acronyms(
  title: "List of Acronyms", sorted: "up", delimiter: ":", acr-col-size: 20%, level: 1, outlined: false,
) = {
  assert(
    sorted in ("keep", "up", "down"), message: "Sorted must be a string either \"keep\", \"up\" or \"down\"",
  )
  heading(level: level, outlined: outlined, numbering: none)[#title]
  acros.display(
    acronyms=>{
      let acr-list = acronyms.keys()
      if sorted == "up" {
        acr-list = acr-list.sorted()
      } else if sorted == "down" {
        acr-list = acr-list.sorted().rev()
      }
      for acr in acr-list{
        table(
          columns: (acr-col-size, 100% - acr-col-size), stroke: none, inset: 0pt, [*#acr#label(acr)#delimiter*], [#acrl(acr, link: false)],
        )
      }
    },
  )
}
