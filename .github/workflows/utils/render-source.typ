#set page(margin: 25pt)
#show raw: set block(width: 100%)
#let current-version = sys.inputs.at("current-version", default: "0.1.0")
#show "/src/export.typ": "@preview/modern-g7-32:" + current-version // <current-version> подставляется из пайплайна 
#raw(read("/tests/documents/preview/test.typ"), lang: "typst", block: true)
