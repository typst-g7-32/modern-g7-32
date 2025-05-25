#let structural-heading-titles = (
  performers: [Список исполнителей],
  abstract: [Реферат],
  contents: [Содержание],
  terms: [Термины и определения],
  abbreviations: [Перечень сокращений и обозначений],
  intro: [Введение],
  conclusion: [Заключение],
  references: [Список использованных источников],
)

#let structure-heading(body) = {
  set heading(numbering: none)
  show heading: set align(center)
  show heading: upper
  heading[#body]
}

#let headings(text-size, indent, pagebreaks) = body => {
  set heading(numbering: "1.1")
  show heading: set text(size: text-size)
  show heading: set block(spacing: 2em)

  // Par-like non-structural headings.
  show heading: it => {
    if it.body in structural-heading-titles.values() { return it }
    pad(it, left: indent)
  }

  show heading.where(level: 1): it => {
    if pagebreaks { pagebreak(weak: true) }
    it
  }

  let structural-heading = selector.or(..structural-heading-titles
    .values()
    .map(name => heading.where(body: name)))

  show structural-heading: set heading(numbering: none)
  show structural-heading: set align(center)
  show structural-heading: upper

  body
}
