#import "acronyms.typ": *

// thesis template
#let thesis(
  title: "Title and\nSubtitle\nof the Thesis",
  author: "Firstname Lastname, BSc",
  degree: "Degree",
  curriculum: "Curriculum",
  supervisors: (),
  date: datetime.today(),
  acknowledgements: none,
  abstract: none,
  keywords: (),
  acronyms: none,
  body
) = {
  if type(supervisors) != array {
    panic("supervisors must be an array")
  }

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

  block(par(leading: 9pt, [
    #text(size: 12pt, weight: "bold", "MASTER'S THESIS") \
    #text("to achieve the university degree of\n" + degree) \
    #text("Master's degree programme: " + curriculum)    
  ]))

  v(1cm)

  block(text(size: 10pt, "submitted to"))
  block(text(weight: "bold", "Graz University of Technology"))
  v(1.1cm)

  block(text(size: 10pt, weight: "bold", "Supervisor" + if supervisors.len() > 1 { "s" }))
  text(size: 10pt, supervisors.join("\n"))

  block(text(size: 10pt, "Institute of Applied Information Processing and Communications"), below: 1.75cm)

  box(text(size: 8pt, [Graz, #date.display("[month repr:long] [year]")],))

  // style rules

  set align(top + left)

  set page(margin: (left: 3cm, right: 3cm, top: 3.7cm, bottom: 5.6cm))

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
      v(-.25cm)
    }
  })

  // set ref of level 1 heading to Chapter
  show heading.where(level: 1): set heading(supplement: [Chapter])

  show heading.where(level: 1): it => {
    pagebreak()
    v(1.75cm)
    let count = counter(heading).get()
    if it.body != [Bibliography] and count.first() > 0 {
      par(leading: 22pt, text(size: 20pt,  "Chapter " + counter(heading).display("1") + linebreak() + it.body))
    } else {
      text(size: 20pt, it)
    }
    v(18pt)
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

  pagebreak()

  // affidavit
  
  align(horizon)[
    #align(center, text(size: 12pt, weight: "bold", "AFFIDAVIT"))
    #v(0.5cm)

    #block(inset: (left: 1cm, right: 1cm))[
      I declare that I have authored this thesis independently, that I have not used other than the declared sources/resources, and that I have explicitly indicated all material which has been quoted either literally or by content from the sources used.
      The text document uploaded to TUGRAZonline is identical to
      the present master’s thesis.

      #v(2.5cm)

      #line(length: 100%, stroke: .5pt)
      #v(-.5cm)
      #align(center, text(size: 8pt, "Date, Signature"))
    ]
  ]

  set page(numbering: "i")

  init-acronyms(acronyms)

  // acknowledgements

  heading(level: 1, outlined: false, numbering: none, "Acknowledgements")

  acknowledgements

  // abstract 

  heading(level: 1, outlined: false, numbering: none, "Abstract")

  abstract
  
  // keywords 

  linebreak()
  linebreak()

  strong("Keywords.")
  h(8pt)
  keywords.join([ $dot$ ])

  // outline
  
  show outline.entry.where(level: 1): it => {
    if it.body != [References] {
      v(14pt, weak: true)
      link(it.element.location(), strong([#it.body #h(1fr) #it.page]))
    } else {
      it
    }
  }

  show outline.entry.where(level: 2): it => {
    link(it.element.location(), [
      #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
    ])
  }

  show outline.entry.where(level: 3): it => {
    link(it.element.location(), [
      #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
    ])
  }

  outline(indent: auto, depth: 3)

  // list of figures
  
  context if query(figure.where(kind: image)).len() > 0 {    
    show outline.entry: it => {
      link(it.element.location(), [
        #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
      ])
    }
    outline(title: "List of Figures", target: figure.where(kind: image))
  }

  // list of tables

  context if query(figure.where(kind: table)).len() > 0 {    
    show outline.entry: it => {
      link(it.element.location(), [
        #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
      ])
    }
    outline(title: "List of Tables", target: figure.where(kind: table))
  }

  // list of listings

  context if query(figure.where(kind: "listing")).len() > 0 {    
    show outline.entry: it => {
      link(it.element.location(), [
        #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
      ])
    }
    outline(title: "List of Listings", target: figure.where(kind: "listing"))
  }

  list-of-acronyms()

  set page(numbering: "1")
  counter(page).update(1)

  body
}

// abstract

#let abstract(body) = {
  // heading(level: 1, outlined: false, numbering: none, "Abstract")
  // body
}

// table of contents

#let table-of-contents() = [
  // #show outline.entry.where(level: 1): it => {
  //   if it.body != [References] {
  //     v(14pt, weak: true)
  //     link(it.element.location(), strong([#it.body #h(1fr) #it.page]))
  //   } else {
  //     it
  //   }
  // }

  // #show outline.entry.where(level: 2): it => {
  //   link(it.element.location(), [
  //     #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
  //   ])
  // }

  // #show outline.entry.where(level: 3): it => {
  //   link(it.element.location(), [
  //     #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
  //   ])
  // }

  // #outline(indent: auto, depth: 3)
]

#let list-of-figures() = context [
  // #if query(figure.where(kind: image)).len() > 0 {    
  //   show outline.entry: it => {
  //     link(it.element.location(), [
  //       #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
  //     ])
  //   }
  //   outline(title: "List of Figures", target: figure.where(kind: image))
  // }
]

#let list-of-tables() = context [
  // #if query(figure.where(kind: table)).len() > 0 {    
  //   show outline.entry: it => {
  //     link(it.element.location(), [
  //       #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
  //     ])
  //   }
  //   outline(title: "List of Tables", target: figure.where(kind: table))
  // }
]

#let list-of-listings() = context [
  // #if query(figure.where(kind: "listing")).len() > 0 {    
  //   show outline.entry: it => {
  //     link(it.element.location(), [
  //       #it.body #box(width: 1fr, inset: (right: .4cm), repeat[~.]) #it.page
  //     ])
  //   }
  //   outline(title: "List of Listings", target: figure.where(kind: "listing"))
  // }
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
  // heading(level: 1, outlined: false, numbering: none, "Acknowledgements")
  // body
}

// affidavit

#let affidavit() = [
  // #pagebreak()
  // #set align(horizon)
  // #align(center, text(size: 12pt, weight: "bold", "AFFIDAVIT"))
  // #v(0.5cm)

  // #block(inset: (left: 1cm, right: 1cm))[
  //   I declare that I have authored this thesis independently, that I have not used other than the declared sources/resources, and that I have explicitly indicated all material which has been quoted either literally or by content from the sources used.
  //   The text document uploaded to TUGRAZonline is identical to
  //   the present master’s thesis.

  //   #v(2.5cm)

  //   #line(length: 100%, stroke: .5pt)
  //   #v(-.5cm)
  //   #align(center, text(size: 8pt, "Date, Signature"))
  // ]
]

// paragraph with title

#let paragraph(title, body) = {
  strong(title + ".")
  h(8pt)
  body
}
