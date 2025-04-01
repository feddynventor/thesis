// forked from "@preview/modern-unimib-thesis:0.1.1"

#let front(
  title: [Thesis title],
  candidate: (),
  supervisor: (),
  co-supervisor: (),
  department: (),
  university: (),
  course:(),
  date: (),
  logo: none,
  lang: "en",
  bib: (),
  body
) = {
  
  let tags = (
      "contents": "Indice",
      "bibliography": "Bibliografia",
      "abstract": "Abstract",
      "acknowledgments": "Ringraziamenti",
      "chapter": "Capitolo",
      "supervisor": "Relatore",
      "co-supervisor": "Correlatore",
      "candidate": "Candidato",
      "matriculation_number": "Numero di matricola",
      "academic_year": "Anno accademico"
    )

    
  // State to track the current chapter
  let current-chapter = state("current-chapter", none)

  // State to track new chapter pages
  let chapter-start-page = state("chapter-start-page", none)

  set document(title: title, author: candidate.name)
  show link: underline
  set page(numbering: "1")
  set text(size: 13pt, lang: lang)
  set math.equation(numbering: "(1)")
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): item => {
    if item.body == [#tags.contents] {
      item
      v(30pt)
    } else if item.body == [#tags.bibliography] or item.body == [#tags.acknowledgments] or item.body == [#tags.abstract] {
      []
      pagebreak()
      // Mark this page as a chapter start
      chapter-start-page.update(counter(page).get().first())
      block(width: 100%, height: 20%)[
        #set align(left + horizon)
        #set text(1.3em, weight: "bold")
        #text([#item.body])
      ]
    // Update current chapter for special sections
    current-chapter.update(item.body)
    } else {
      pagebreak()
      // Mark this page as a chapter start
      chapter-start-page.update(counter(page).get().first())
      // Update current chapter 
      current-chapter.update(item.body)
      block(width: 100%, height: 20%)[
            #set align(left + horizon)
            #set text(1.3em, weight: "bold")
            #text([#tags.chapter #counter(heading).display() \ #item.body])
          ]
    }
  }


  set page(
    header: context {
      let chapters = query(selector(heading.where(level: 1)))
              // Get the current page
        let current-page = counter(page).get().first()
            
        // Check if current page is any chapter start page
        let chapter-pages = chapters.map(c => c.location().page())
        if current-page in chapter-pages {
          return // Don't show header on chapter start pages
        }

        // Find which chapter we're currently in
        let relevant-chapters = chapters.filter(c => c.location().page() <= current-page)
        if relevant-chapters.len() > 0 {
          let current-chapter = relevant-chapters.last()
          let chapter-text = current-chapter.body
          
          if calc.odd(current-page) {
          text(upper(chapter-text), style: "italic")
          h(1fr)
          [#current-page]
          } else {
          [#current-page]
          h(1fr)
          text(upper(chapter-text), style: "italic")
          }
        }
    },
    footer: context {
      let page = counter(page).get().first()
      
      // Show centered page number in footer only for chapter start pages
      if chapter-start-page.get() == page {
        align(center, [#page])
      }
    }
  )

  show outline.entry: it => {
    if it.element.body == [#tags.acknowledgments] or it.element.body == [#tags.bibliography] {
      []
    } else {
      it
    }
  }
  
  //------------- FRONTESPIZIO
  v(20pt)
  if logo != none {
    align(center, logo)
  }

  v(20pt)
  align(center, block[
    #text(smallcaps(university), size: 2em) \
    #department \
    *#course* \
  ])

  align(center, line(length: 90%))

  v(40pt)
  align(center, text(size: 18pt, title, weight: "bold"))

  v(40pt)
  text([*#tags.supervisor*: \ #supervisor])
  v(20pt)
  if (co-supervisor != ()) {
    text([*#tags.co-supervisor*: \ #co-supervisor.map(item => [
            #item
          ]).join(linebreak())])
  }

  align(right, block[
    #text(weight: "bold", [#tags.candidate: ]) \
    #candidate.name
  ])

  align(center + bottom, block[
    #line(length: 90%) \
    #text(weight: "bold", [#tags.academic_year: #date])
  ])

  pagebreak()
  outline()
  
  body

  if bib != () {
    pagebreak()
    bib
  }
}
